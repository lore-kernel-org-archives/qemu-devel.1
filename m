Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CE5C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB7A20651
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMq/XEN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB7A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFx5U-0007QJ-Qy
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 04:35:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFx4X-000738-Kd
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFx4W-0004L3-QF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:34:37 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:34571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hFx4W-0004JQ-Is
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:34:36 -0400
Received: by mail-oi1-x232.google.com with SMTP id v10so13073186oib.1
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=TuUca3hUw8C2EF45NztL9SJGg+Xg2+IwmjG5gTf7Ez4=;
	b=DMq/XEN6fpWkcO3EhrRYmBVh8LV2iCPAPCcvbxS+L5bDzrRXoS8d4ZPeI8n/ZQ5EQM
	j/uFq1hApiq+gWPy8Xk8+6wXIdFnFk0WPL3JVByKdadc/VEHwMzRcYETLkf/XUlaSJsd
	shZM/E0za+kB23pSQilXv7HgR8EqF4d6FSte22viFDvAt4qp6rrjbpu7JY+QpVz8/NNr
	K4icPpKxeJ2+oTFYJbrGQZgs0Sl82Q9Je20SGp+V+AstplDFyXRKKsM+ywsYUeag934V
	xmVsa2iTb/AtUkbMEBYUnhnjzjsHwm+fWEqg3HBCVsgTU3rCYRuFB2cFuFS1/IHHNi9h
	JwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=TuUca3hUw8C2EF45NztL9SJGg+Xg2+IwmjG5gTf7Ez4=;
	b=oCOnisimBbOrlhdKNpXIJeM3L10RsgC/5bvuwcpI03x8fo1FKBhLriEBaWw/FmD3cI
	495C1FYh9JYJ8NDdxCAfG6jo/dm0MFXWoSjOFKL8u2g+cHfgOR70wBVrmAfhn7SCmhVW
	0CwbP6NtlmjrUH+pvDnG3rJqrFCBEFJJaErAKPTDWakq02neaxAW2t2mVeaTXBGXSvvB
	GEKbyZZtP1scc7yrba3+qxCAEhRuX7zy8pYe5FiEk60ZXHO4q0ns027m89cD/rQciaql
	vzp1sL+cjCe5M7WvAXyNxtBtJU0u6TV6oPZGC24Mfb6pnKGx0abxlQum+YzWsLhoYtSK
	J2sQ==
X-Gm-Message-State: APjAAAV3YCWyrDqr1zNMP4bOBNSf2U+4CE3lj7ix9mDRvIKDuak21uDf
	1bhHbH6PluxIHxXCS70JyfQS3dY9am2HZyKIXZ/atrQwYHk=
X-Google-Smtp-Source: APXvYqwZLvbiI/c8Am0Ktm0mG7sXvnS8BjY8b3Mcr3I2plqjhs3Hu4ScK04nIAyvWkvrveCdhY0DShHkxP54yu3N7sQ=
X-Received: by 2002:aca:e054:: with SMTP id x81mr18146241oig.146.1555317275751;
	Mon, 15 Apr 2019 01:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190411153942.4533-1-peter.maydell@linaro.org>
	<53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
	<CAFEAcA-dbGvhgTrBKEtx-CPS7f2NJO5X+dj=mdcm+NrkF=uynQ@mail.gmail.com>
	<0ee4fdc6-c782-d5f5-ec40-9e25c1c9dd1f@linaro.org>
In-Reply-To: <0ee4fdc6-c782-d5f5-ec40-9e25c1c9dd1f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2019 09:34:24 +0100
Message-ID:
 <CAFEAcA-0oCc+9=LnpMJ9HmhsiSCTM9wA_prNS9MdNp6_157y6g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of
 floating point
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415083424.5TxbiDOGyqt9SOhZTXdniiDLGXvOmvak8D33y7H64Gs@z>

On Sun, 14 Apr 2019 at 20:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/14/19 8:02 AM, Peter Maydell wrote:
> > There's similar wording for the effect of NSACR on CPACR, so
> > again I think we need to actually make the bits RAZ/WI
> > regardless of their underlying value, not just force them
> > to 0.
>
> I don't see that language for CPACR, just "the corresponding bits in the CPACR
> ignore writes and read as 0b00".  I'm willing to believe the manual is sloppy
> on this point though, and the "correct" language appears only once, somewhere.

It's in the documentation of CPACR cp10/cp11.

thanks
-- PMM

