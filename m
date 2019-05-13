Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A712C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2341320879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WB+Nhl7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2341320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59376 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQD5V-0002cN-FB
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 11:42:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQD4b-000276-8n
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQD4a-0004cH-6V
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:41:05 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQD4a-0004bb-0U
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:41:04 -0400
Received: by mail-ot1-x343.google.com with SMTP id g8so12164505otl.8
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2WtiAmLbnppF5wdYRwwdYOHNgP4UsBxqvFA32h2u9G8=;
	b=WB+Nhl7c68MSZAYYp+dtLDMiI3zkm0/8X7dMzFpOJXTpHShrn/G5jDLTTmScVCwkyl
	Fpp/gs5r4yqPOsT8nT4kaD1kUy3mD/g/TheRs04VzR656nnEFo5o9NowQqJ4/5iqXwBw
	3fAN2zo685RLbUd6ALXlIYPGlwv1agUqC66gZNcsI+xGksSJMUTjrNf4PhNb1z3vyHVA
	86ZT6g27aCD1NCEN5PC5nnO2UPmFLJpXeCTDEA1d8+/Yut3C+MBudza6xWy3v6bPtYL0
	EsY9IynoQUHszdjXy9vy2AZa7n8MGHNU6ACTZ86GzpP2cslSqSHeq+X8sEzmg+acSdTL
	zgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2WtiAmLbnppF5wdYRwwdYOHNgP4UsBxqvFA32h2u9G8=;
	b=YSG43wQ/AHh0dn5NEj7MwAXKDNQehvq19OgOjK3etma4vuptAgf9X4sXwKOSKCl1ui
	nzIU5FmTdW/mmR+cRh5elnWjdQPitnyQMolHft1lD5pS/bTI7x3lnfTNHeoCYYSXi7Zi
	XCTm6Gu3es5pyt0Hecj3+b5ycuLOGjFHLY/ybBUaszG1tvY85KziwYs4DW7uiE5JAUjv
	IytQ/W3XIA1kRp3sCHnWdRVni/gIzNDgg6o5MJsUD9Zm92Ayts2aPLj21YyIVFeODnDu
	Q6Ee73rpaB0ZI5IP2bAgmHZCWWPldwp71rPTeVpxNlJWSWOQA4IN0YuoUYJNITLPEtGM
	cCXQ==
X-Gm-Message-State: APjAAAV0ov7iAaAsdjmBZWufeHl0G090ODK8rfhmBJLbDVdUPBKoy4qG
	av8Wlm20Cr+E7KYRRSiTIvw494haybveWAcvUbciJg==
X-Google-Smtp-Source: APXvYqwH/5qZu17agIjGYc0FSyUggL70xbuawBciikn7GtT3GCIIQJbuX9X6C6rfbeSNldIVuRLpUqf1ioT1A1omw1U=
X-Received: by 2002:a9d:404:: with SMTP id 4mr7099927otc.352.1557762063062;
	Mon, 13 May 2019 08:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-6-drjones@redhat.com>
	<20190513123110.GE28398@e103592.cambridge.arm.com>
	<20190513135501.ztggqdac57qbpuft@kamzik.brq.redhat.com>
	<20190513153116.GL28398@e103592.cambridge.arm.com>
In-Reply-To: <20190513153116.GL28398@e103592.cambridge.arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 16:40:52 +0100
Message-ID: <CAFEAcA95LbXZOJNUAYuYoVDkM0auj-RGACXPp9Qe9ANp_b3C=w@mail.gmail.com>
To: Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 05/13] target/arm/kvm: Add
 kvm_arch_get/put_sve
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"abologna@redhat.com" <abologna@redhat.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 at 16:31, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, May 13, 2019 at 02:55:01PM +0100, Andrew Jones wrote:
> > QEMU keeps its 128-bit and larger words in the same order (least
> > significant word first) for both host endian types. We need to
> > do word swapping every time we set/get them to/from KVM.
>
> I'm not sure whether this is appropriate here, though it depends on
> what QEMU does with the data.

The layout is optimised for TCG emulation to be able
to work with it, I think (rth would have the definite
reason, though).

> Something non-obvious to be aware of:
>
> As exposed through the signal frame and the KVM ABI, the memory
> representation of an SVE reg is invariant with respect to the
> endianness.

Yes; we handle this conversion as we write out the signal frame:
https://github.com/qemu/qemu/blob/master/linux-user/aarch64/signal.c#L184

thanks
-- PMM

