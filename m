Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CA5C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0ACE206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HaJLcDIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0ACE206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMcJg-0004om-Rx
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+347305.be9e4a-qemu-devel=nongnu.org@mg.codeaurora.org>)
 id 1jMcIy-0004CC-AU
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+347305.be9e4a-qemu-devel=nongnu.org@mg.codeaurora.org>)
 id 1jMcIw-0003AE-Ux
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:53:35 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:43214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+347305.be9e4a-qemu-devel=nongnu.org@mg.codeaurora.org>)
 id 1jMcIs-00038y-Uq
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:53:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1586458414; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=+fX/Jt3dORws/u2PQTPifRK9AmPx8ihEQA9JT1bOKZc=;
 b=HaJLcDIa1OV/Hu2qi6hRGiUW41hR8GHsvMGelgi+Bk2Gw52slzmEr830zJzdI6ygxaNLba/k
 1pIqmLOyCpo6rBguB++xLtxNhX7gDoLVZIOCiTnBHgJvU/s6JP2q8Q4U9S4RP6WsB7IAaQ10
 MI1Cd85W/8F+m6lHwtRhbLKzshI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIxNGFmMSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8f6f1d.7f231fcfb4c8-smtp-out-n04;
 Thu, 09 Apr 2020 18:53:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id ADE6DC43636; Thu,  9 Apr 2020 18:53:16 +0000 (UTC)
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net
 [104.54.226.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: bcain)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 1110CC433D2;
 Thu,  9 Apr 2020 18:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1110CC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=bcain@codeaurora.org
From: "Brian Cain" <bcain@codeaurora.org>
To: "'Taylor Simpson'" <tsimpson@quicinc.com>,
	<qemu-devel@nongnu.org>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
 <1582908244-304-21-git-send-email-tsimpson@quicinc.com>
In-Reply-To: <1582908244-304-21-git-send-email-tsimpson@quicinc.com>
Subject: RE: [RFC PATCH v2 20/67] Hexagon instruction utility functions
Date: Thu, 9 Apr 2020 13:53:13 -0500
Message-ID: <094101d60ea0$204c0ee0$60e42ca0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJgtZ7g3UB8eJn6k76/Xfeqryq/RADn8twSp1SDK5A=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 104.130.122.27
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
Reply-To: bcain@codeaurora.org
Cc: philmd@redhat.com, riku.voipio@iki.fi, richard.henderson@linaro.org,
 laurent@vivier.eu, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Qemu-devel <qemu-devel-
> bounces+bcain=3Dcodeaurora.org@nongnu.org> On Behalf Of Taylor Simpson
> Sent: Friday, February 28, 2020 10:43 AM
> To: qemu-devel@nongnu.org
> Cc: riku.voipio@iki.fi; richard.henderson@linaro.org; =
laurent@vivier.eu;
> Taylor Simpson <tsimpson@quicinc.com>; philmd@redhat.com;
> aleksandar.m.mail@gmail.com
> Subject: [RFC PATCH v2 20/67] Hexagon instruction utility functions
...
> +int arch_sf_invsqrt_common(size4s_t *Rs, size4s_t *Rd, int *adjust)
> +{
...
> +    } else if (r_class =3D=3D FP_INFINITE) {
> +        /* EJP: or put Inf in num fixup? */
> +        RsV =3D fSFINFVAL(-1);
> +        RdV =3D fSFINFVAL(-1);
> +    } else if (r_class =3D=3D FP_ZERO) {
> +        /* EJP: or put zero in num fixup? */
> +        RsV =3D RsV;
> +        RdV =3D fSFONEVAL(0);
...

This "RsV =3D RsV" looks like a logic error?  Presumably it's safe to =
remove -- unless there's some other field that should get initialized =
here?  PeV maybe?

