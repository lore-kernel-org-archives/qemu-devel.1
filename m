Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A11C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681FA2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyICyi5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681FA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLS5G-0003cA-7p
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:42:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLS4D-00038B-9B
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLS4C-0006AB-2f
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:41:01 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLS4B-00069d-SM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:41:00 -0400
Received: by mail-ot1-x341.google.com with SMTP id b18so2734598otq.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=PbvWrLM+f0aXRYDrJv/gSIHjbRs/mKVoLfhOQfZeF7o=;
	b=iyICyi5N6NYLYe7LDYtJhDaqbnjbITQAlGpMZLdgnzAVA8dK8uEDW5rURvkWlWXwYS
	emP8OyQteOBiZ1D41l+KloV4b6q7pr/qMO6+4iOEk5keoX7nDBVUfwQZeV9A4kCf5ZCS
	R1X3paEAcw1IlXyz7gK7+lDP1g/In9KWu0I0fDnUjXtBsuLfjGXzzxnuzrp6fqoNWfWX
	YpggcdIwIl10XH7FUH1D+xpl8tM9xnXzQ/Bv+avIVo3XPYJoAXxoPOECpNXYiaE4fndX
	j8Swbbn9A/MLTou4nVWGHGujAMfJLTRqcNNiVAitpVARQvZn5IuYD/+TQDhlKxrQVRvE
	UeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=PbvWrLM+f0aXRYDrJv/gSIHjbRs/mKVoLfhOQfZeF7o=;
	b=MbGmDf6KLZI2VrVaTpKoVNm/RpJWxLXpShAPocp1EOL6e36/KR3hD0PZoFAhKqGG4p
	rNxEqBzcEMSlL2MSjuvTprcKDT2Sy46B79oO0Eg/jaw4xIazKxlOK1N7aqaVZ/YpGLWw
	2NdsrqycvVBAKjb/pHZlhCMAFvlMYdKHqeETQbM87MP2oD795YXZef+Tlbs7CkOoJTb5
	ux7FWzLfXrH46edVx6bB5AY96L7fHRlKJh8otMjSxqtnyla1HszK0IC08bOia1agmSel
	4hAb3CvbasI1saBryoGArE3mb0IO8aD9JHUWnO/Jno/PUmqO25WUatv55GxF16b0CZq8
	OIvg==
X-Gm-Message-State: APjAAAWr1WnQ88Gu1vE1Ie10HWL1NrdjBzM0RL2sw8lOH4UbziT+uGM9
	RqT1gxEPfX9w9sT2QTOKIJcFvNysVf90k8z95gC5Vg==
X-Google-Smtp-Source: APXvYqyYHyzRqAr767QtVz+9RFIp3Xyo7JftZ+DaNN3lbb6OahPOtWMo4cuFrQ9GqQZFX+11t1nTuvhSh1VJZHcQ/Kk=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr4775943otk.316.1556628058779; 
	Tue, 30 Apr 2019 05:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190223023957.18865-1-richard.henderson@linaro.org>
	<20190223023957.18865-6-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:40:47 +0100
Message-ID:
 <CAFEAcA_60sosZCU8VNg6dd1toZON6D5sC8xgZU1tWpaspu=gHA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [RFC 5/6] target/arm: Conditionalize DBGDIDR vs
 ID_AA64DFR0_EL1 assert
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
Message-ID: <20190430124047.CVYkJUU0IHL7PLK_TiTx-qYoH20_IOz1WRNifrty2NI@z>

On Sat, 23 Feb 2019 at 02:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Only perform the assert when both registers exist.
> Extract the variables from ID_AA64DFR0_EL1 for AArch64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +    if (have_aa32) {
> +        ARMCPRegInfo dbgdidr = {
> +            .name = "DBGDIDR", .cp = 14, .crn = 0, .crm = 0,
> +            .opc1 = 0, .opc2 = 0, .access = PL0_R, .accessfn = access_tda,
> +            .type = ARM_CP_CONST, .resetvalue = cpu->dbgdidr,
> +        };
> +        define_one_arm_cp_reg(cpu, &dbgdidr);
> +    }

So if only EL0 has AArch32 it doesn't architecturally require
that this AArch32 system register doesn't exist, because the
register is still readable from EL0. The Arm ARM says that
"implementation of this register is optional and deprecated".
I would suggest that we should probably go with "implement the
register if cpu->dbgdidr is non-zero", since at least bit 15
must be set so zero isn't a valid real value for it.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

