Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D265C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B01A21775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YR57xhAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B01A21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0R3E-0005Hf-BG
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 09:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j0R2L-0004eS-Mj
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j0R2D-0005Lb-Ac
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:24:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35467
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j0R2D-0005K6-6P
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581171876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBO5dumlobr9dKlDmIUguM3YpSwoEvq2Mo6Y8prXmyE=;
 b=YR57xhAO2YUDLLzSlEdtnBK44Iq/inexXmWu9rYyZfIPq5oNe9ICY3O23hJMJIcNIiIOQ+
 +7zfem3aX51UkhOn8NOzYryhwnsGd/pSrC2PfP/Nd/Pty75tNkvA8vm1CxPvTBJ/dIicDp
 OgPxBjv7vcv9KHSAoqLFuGDGB4epPfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-xl9IKK5lMbeYHhZWi7jieA-1; Sat, 08 Feb 2020 09:24:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A1CE1922960;
 Sat,  8 Feb 2020 14:24:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE6A226FB8;
 Sat,  8 Feb 2020 14:24:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8175B11386A7; Sat,  8 Feb 2020 15:24:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 18/29] qapi/migration.json: Replace _this_ with *this*
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-19-peter.maydell@linaro.org>
 <87a75unxrm.fsf@dusky.pond.sub.org>
 <CAFEAcA_ncWPsFyywKCM9sWt+ZP+hYqYbMOL07EinQbkVHgBfbA@mail.gmail.com>
Date: Sat, 08 Feb 2020 15:24:26 +0100
In-Reply-To: <CAFEAcA_ncWPsFyywKCM9sWt+ZP+hYqYbMOL07EinQbkVHgBfbA@mail.gmail.com>
 (Peter Maydell's message of "Fri, 7 Feb 2020 17:00:07 +0000")
Message-ID: <877e0xjgx1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xl9IKK5lMbeYHhZWi7jieA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Feb 2020 at 16:54, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > The MigrationInfo::setup-time documentation is the only place where
>> > we use _this_ inline markup to mean italics.
>>
>> Nitpick: _this_ does not mean italics, it means emphasis.  See
>> qapi-code-gen.txt section "Documentation markup".  doc.py maps it to
>> @emph{this}, which Texinfo commonly renders in italics when the output
>> format supports that.
>
> Yeah, I know. But to my mind nobody actually cares about "is this
> 'emphasis' or 'strong'", because those are pretty meaningless
> and are not very easy to distinguish semantically. What people
> actually care about is "how does this render", because bold and
> italics look noticeably different and if you're writing you
> might care about which you get. At that point 'strong' is just
> a confusing synonym for 'bold' and 'emphasis' is a confusing
> synonym for 'italics'. But maybe I'm out on a limb here.
>
> Anyway, I'm happy to tweak the commit message.

What about this:

    qapi/migration.json: Replace _this_ with *this*

    The MigrationInfo::setup-time documentation is the only place where
    we use _this_ inline markup for emphasis, commonly rendered in
    italics.  rST doesn't recognize that markup and emits literal
    underscores.

    Switch to *this* instead.  Changes markup to strong emphasis with
    Texinfo, commonly rendered as bold.  With rST, it will go right back
    to emphasis / italics.

I tried to cater both for semantic markup wonks and happy visual
ignorants ;)


