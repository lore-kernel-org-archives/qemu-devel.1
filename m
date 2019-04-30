Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B6C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417D120652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKQn6oi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417D120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46832 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLSGQ-0002uO-IF
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:53:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSFW-0002Uz-Gc
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSFV-0005bt-CR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:52:42 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSFV-0005bc-6y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:52:41 -0400
Received: by mail-ot1-x343.google.com with SMTP id r20so10627824otg.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/z4FYOauOx+1rhxhHrmgtCtM5nNlISo2IT2bTzxO60I=;
	b=nKQn6oi/9pQzIRPSRgbG4/EUjfFYstRZepi9wyA+5DXEafOAnOJdEPYwg1EqXiniQi
	C0VWFEkRs1TMJWYKpoxtwAQBBIqx9aChnb0fOt5ERSNah4rynRSBh311CtKw+PqtnWCk
	SOchNv5ZZHCeODN1Hhd6f3IcOuZqHGrqYFSxD0GfvIc2jjCJTD8wA0xgIptzBDMrQG5P
	OCVXru5PtsMU5zqWE181HIqYpijfSQyVxVn8o7RYE/DurfGDDcMVFrDiz3qiO8kan1JZ
	ekP0ZlY41a8liqN0LMVW94yEF3J+1YurQe1alH8BR9DavlHQHGFecVjhuBYj34ibi7j/
	CZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/z4FYOauOx+1rhxhHrmgtCtM5nNlISo2IT2bTzxO60I=;
	b=q4IN68eJivDJnaI+ZtgAagRr0R30xLBxgM7sI3IXO7kf1Ozolc2XhnvmaqSzKPoL83
	37/PS/hrtbvgM+uZZNQObBywtZ37zQldmSzP7NuapvBjGRdzDC33wjyPFdKhCqE7aasY
	5RzaOyi7+KN7aYnf6jwvGoxrOkiEzKExmBtZfc4F9LJdA7T7s9KstguzXS3m4kse4BW4
	A9KjzsAUWrN0xUGT82HCNmpBB8bMep50MCyG9iOmvPHaXOtQOGxk+5evw3+tsf4TrQMv
	SR56uEaG4Cqp3iu2u1cQSPkDPpIRz3cCUVGKxuGOgmPXy8KOtyfZ3qOm7nX7NSrs6Emc
	G/Qg==
X-Gm-Message-State: APjAAAWcPh8BXoDrvh9Re9d6qYsLh4FHS1LQjmhiBCoHRoMHPfYC/nB8
	HrcS53F44zwCfwosOARo2RtZaGyzexLuC/NnkpYDFg==
X-Google-Smtp-Source: APXvYqzprXtS+2ALZ+V5uHY0pTH4KLOYJ/6lc/1VQ+1JH0JB4gF2YSGzgvAVH3CeNI57Os91Kn+aViVHund1Gp6lmeM=
X-Received: by 2002:a9d:57c4:: with SMTP id q4mr7556807oti.151.1556628760188; 
	Tue, 30 Apr 2019 05:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190223023957.18865-1-richard.henderson@linaro.org>
	<20190223023957.18865-5-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:52:29 +0100
Message-ID:
 <CAFEAcA8ReupPYke_F48WhCHttGD7T-yV2GiwmGVCVAa+S+7tuA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [RFC 4/6] target/arm: Define cortex-a75
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430125229.CcTFRB65ROWF5TH9gkIIotwhANIL5hBI4vmTk_lEmZ0@z>

On Sat, 23 Feb 2019 at 02:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/arm/virt.c      |  1 +
>  target/arm/cpu64.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index c69a734878..06a155724c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -174,6 +174,7 @@ static const char *valid_cpus[] = {
>      ARM_CPU_TYPE_NAME("cortex-a57"),
>      ARM_CPU_TYPE_NAME("cortex-a72"),
>      ARM_CPU_TYPE_NAME("cortex-a73"),
> +    ARM_CPU_TYPE_NAME("cortex-a75"),
>      ARM_CPU_TYPE_NAME("host"),
>      ARM_CPU_TYPE_NAME("max"),
>  };
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index d34aa3af75..325e0ecf17 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -312,6 +312,63 @@ static void aarch64_a73_initfn(Object *obj)
>      define_arm_cp_regs(cpu, cortex_aXX_cp_reginfo);
>  }
>
> +static void aarch64_a75_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
>


> +    cpu->reset_sctlr = 0x00c50838; /* ??? can't find it in a75 trm */

There are a couple of things interacting here.
Firstly, I think that architecturally the reset values
(and how much is actually a defined value rather than
UNKNOWN) can differ between SCTLR_EL1/2/3, plus the 32-bit
vs 64-bit have different values for a few bits, but we try
to just shoehorn everything into a single reset_sctlr field
(see https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01559.html
and surrounding messages in that thread for discussion).

Secondly, for the cortex-a75,
https://developer.arm.com/docs/100403/latest/part-b-register-descriptions/aarch64-system-registers/sctlr_el3-system-control-register-el3

does specify the reset value for SCTLR_EL3:
bit 25 is controlled by an external signal (aka a
QOM property for us), bits 12 2 and 0 are specified
to reset to 0, and every other bit resets to an
UNKNOWN value. I would suggest that we make the
RES0 bits 0, the RES1 bits 1, and use 0 for all the
other UNKNOWN bits.

SCTLR_EL1 is similar (if resetting into EL1)
https://developer.arm.com/docs/100403/latest/part-b-register-descriptions/aarch64-system-registers/sctlr_el1-system-control-register-el1
with the slight wrinkle that you need to also check
the architectural spec for some bits, eg bit 0 has
no reset value listed in the TRM but architecturally
is required to reset to 0 if resetting into EL1.

thanks
-- PMM

