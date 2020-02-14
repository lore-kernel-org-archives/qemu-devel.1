Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F6AC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2056B206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEcY1Ocd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2056B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2bw6-0001cF-9X
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2bv2-00013X-Dq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2bv1-0005jj-Fu
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:26:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2bv1-0005ic-CP
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581690370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rLq2UJbkOu4Ln/9c4JPQzAKwqWA25rrOKpXwYWm6p4=;
 b=LEcY1OcdppHHHj57cHDX+yiBGyejOHGXfRkQ6moXM3q5aTRog2pxxYY7m7r+6g6Kck/biu
 HpmZOiDrY1h+8ucQZQSlBUsVYP0cRFe7Rp/tlAf68dzM9MlWCQPa4GGKZEn4+Ypn8JZF7C
 YL5WvjbTPRwwT+4yDseOQ99g4NJ1eAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-QidrFvRVOyytJBuekSRKQg-1; Fri, 14 Feb 2020 09:26:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A355D800D4E;
 Fri, 14 Feb 2020 14:26:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5D3E60BE1;
 Fri, 14 Feb 2020 14:26:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D03D11385C9; Fri, 14 Feb 2020 15:26:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 05/30] qga/qapi-schema.json: Fix indent level on doc
 comments
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-6-peter.maydell@linaro.org>
 <874kvtxs4k.fsf@dusky.pond.sub.org>
 <CAFEAcA-xXauthaN9yxrQztg7v7Z3ru8GXouAQ+Y7hviEL3F7Lg@mail.gmail.com>
Date: Fri, 14 Feb 2020 15:26:03 +0100
In-Reply-To: <CAFEAcA-xXauthaN9yxrQztg7v7Z3ru8GXouAQ+Y7hviEL3F7Lg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 14 Feb 2020 12:40:49 +0000")
Message-ID: <87sgjdtfd0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QidrFvRVOyytJBuekSRKQg-1
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

> On Fri, 14 Feb 2020 at 12:36, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > The texinfo doc generation doesn't care much about indentation
>>
>> Let's spell Texinfo with a capital T.
>>
>> > levels, but we would like to add a rST backend, and rST does care
>> > about indentation.
>>
>> Nitpick: an rST *backend* should not care about the doc generator's
>> *input* format.  We actually intend to change the input format into a
>> domain-specific dialect of rST, as you state in your cover letter: "This
>> series switches all our QAPI doc comments over from texinfo format to
>> rST."
>>
>> Perhaps:
>>
>>   The current doc generation doesn't care much about indentation levels,
>>   but we would like to switch to an rST format, and rST does care about
>>   indentation.
>
> Works for me. Let me know if you're OK just making this kind
> of commit message tweak/minor fixup and sending a pull, or
> if you want me to roll a v3.

I'm happy to tweak commit messages myself.  As always in such cases,
I'll appreciate an eye-over before the merge.


