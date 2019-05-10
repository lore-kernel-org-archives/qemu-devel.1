Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44601C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103A22173B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnWoM83C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103A22173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40361 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP2Gg-0005lF-E3
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:56:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP2FS-0004dI-58
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP2FQ-0001Jd-VP
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:55:26 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP2FQ-0001HZ-PP
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:55:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id u199so4104670oie.5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=d4hkzUnPrAUDfEs1lvZJFmyKt2aBL6Qbgr1y2Q5UyE0=;
	b=fnWoM83C109HoD85qUOKyRRT2WgU+ys8Cr0WrnjLYFsMo+dXVT2jH+Iv6sjchixUvF
	JesyhAgRt7Z4+91MWc/DJ7IZ7V4SfXMLVZzVN25bSb8oTJV97WegRWMreTA2kzI6Vse+
	sekdOEo0PVfK290OszQCm0udz+ejcE4/AeGQzyQPVUwFIYhc6RFtGIyXY7zNFFPVyhXW
	83cA/uXKQj2lYhd53fmFgK1xvdElaA7/9gREAmFm1NLxpoXpClMlN1umAgUTeGztYrxb
	eBB4GSd/e+AaJFEtM33qZVUImxIhsa2MTVRgqfAjuBtC/al6yXG/nsO19mP+Y8WJHm2a
	djOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=d4hkzUnPrAUDfEs1lvZJFmyKt2aBL6Qbgr1y2Q5UyE0=;
	b=fP7QqyuB5mOWdW/xNDFvlCgsch4UclC9DrTA327uaqq+TrgDoLAIQEFzYqsUCGuIg/
	9Km/ZpW73TB0o5iu0FiBdn47FLqLXhBqwJRN6e7whB83KM4kNUYDrHSf85UwaK5kLl35
	8J/xgijUDaCX3Vf0TfPgHg93aG8gSO1KoCHAgLUPK5q49LPCEkPqHkV4EiBVGGmy/Alc
	myDXAh07sW9PCVmW4AYhoSdxkmtJBABLEpo12RybkBbWoPpKIAWE1Eh8fkKYf3f5S7Ke
	DD7N0BHbnZKmnIACuQ633gS27yw7wpsLSj4EVk6tS/1VpSoy/nhTvhXK+DrJ5FkTL7la
	13yA==
X-Gm-Message-State: APjAAAVuPO3vI1nDopsXxu1fzblGQaEkPTH092lTaio5BR5vuI0hUrju
	aFFvYZCHtiU/FoGGBUSEVq1omgJGjQaBNSn3vcCXhA==
X-Google-Smtp-Source: APXvYqwzkjL4L5STvjjay73tFBlOWvS5LiwH9ubwYPUNYPS68ptGSI95/ZnmqHhifcGOAeU3crw4YeYv/XVlHaSoksI=
X-Received: by 2002:aca:b783:: with SMTP id h125mr4555547oif.146.1557482123537;
	Fri, 10 May 2019 02:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190509222631.14271-1-richard.henderson@linaro.org>
	<20190509222631.14271-21-richard.henderson@linaro.org>
In-Reply-To: <20190509222631.14271-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 10:55:12 +0100
Message-ID: <CAFEAcA-pGmH0VOhRnmcBGGM_bfmF8pBobJg2u4s=XKwV6HnFxA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v3 20/27] target/sparc: Convert to
 CPUClass::tlb_fill
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 at 23:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Keep user-only, sparc32, and sparc64 tlb_fill separate.
> v3: Assert !probe for sparc32.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

