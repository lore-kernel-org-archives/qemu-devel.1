Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8CEC3B1A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A2F206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ag89PkLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A2F206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2eVW-0006Ur-Fu
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2eUz-00060u-44
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2eUx-0007dM-Jy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:11:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2eUx-0007bz-EB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581700285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pExTd8+SrVVgolSLVQunk1exYCtoSJuk/mcDXWzFgiE=;
 b=ag89PkLNHp7Rp4XutNn2akrQx6ExTRL9vMVYLHA/pMyDQF6RyCzSFU7eYGxJUDX4j4Eug8
 8SINGHdHrKlcfHiAvMuoLPHNhhfDe1P7b32jeplLX/aSrZyTZ3+Tf/urd1jJArfVM1e0za
 DXU8fzfBXg5V1eemOgh12Uvzm8FNcYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-h5jXKI9aMbKdGXMApXvdqA-1; Fri, 14 Feb 2020 12:11:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC6DE1005513;
 Fri, 14 Feb 2020 17:11:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4739A8AC46;
 Fri, 14 Feb 2020 17:11:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C213711385C9; Fri, 14 Feb 2020 18:11:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 16/30] qapi: Add blank lines before bulleted lists
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-17-peter.maydell@linaro.org>
 <878sl5tf01.fsf@dusky.pond.sub.org>
 <87wo8pqhqv.fsf@dusky.pond.sub.org>
 <CAFEAcA86Ux9aiagyudmUJC63VvwY79HdGpn23nKDWtCz0S-zXg@mail.gmail.com>
Date: Fri, 14 Feb 2020 18:11:16 +0100
In-Reply-To: <CAFEAcA86Ux9aiagyudmUJC63VvwY79HdGpn23nKDWtCz0S-zXg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 14 Feb 2020 16:16:33 +0000")
Message-ID: <87h7ztqekr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: h5jXKI9aMbKdGXMApXvdqA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

> On Fri, 14 Feb 2020 at 16:02, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>> > Peter Maydell <peter.maydell@linaro.org> writes:
>> >
>> >> rST insists on a blank line before and after a bulleted list,
>> >> but our texinfo doc generator did not. Add some extra blank
>> >> lines in the doc comments so they're acceptable rST input.
>> >>
>> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> >
>> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>> Hmm, PATCH 06 appears to do the same, among other things.  Sure you want
>> this separate?
>
> Patch 6 is qga/; this is qapi/.

D'oh!

> This is again a product of my general preference for more
> smaller patches rather than larger patches that touch more
> files at once.

Makes sense, thanks!


