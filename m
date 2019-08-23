Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F42C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1474B21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IN3MtHT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1474B21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54277 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i185g-0000Cl-BY
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 07:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i184n-0007fl-C5
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i184m-0004lf-7X
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:49:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i184m-0004lM-2F
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:49:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id z17so8433606otk.13
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=17GbqNkvn9kVUqQ/GFMX9z2K9mZuN/tNdVtqhH2SHxg=;
 b=IN3MtHT73qtntKcVAMS2bO58t/AtNHuY+BCiZ2T1XCx5gvVJnHEte8H4ODIzzGahWI
 SF3fXOoSRPzZxc9zNKeKjlQtP23ceNbhg0TzVaF7VYOZOMfk9fX7I2VcRskBj22d1i3f
 bWIdk+TxDcfxqQEc4HQG3nCmC9aHgQOxsrN47nHJHdLmxRT3i8Q5Xx1bxLE0tD4+EqDa
 VZUNm20HwXllGbNXfXpw6GwY6pOlxyJbLAsvdc4Z5kYbgfV029Z+iM1C6MXizYbTPZTa
 vvIAcCqIIFxuMzQ7hWS8nen1mCEa3zmjxONh7qjBA7/+5SVhKBmDw88eY89rx5bfLSIu
 FpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=17GbqNkvn9kVUqQ/GFMX9z2K9mZuN/tNdVtqhH2SHxg=;
 b=Xh/ygIoX4ytSl9JPv9PRin9+8m4G5okqErlOJBybH1H8iy6pTx2V9VtprbLa3q8X9B
 HdS9k0FDuRfUiHi0VCbWnCefSPPXiAfQmLcanF27eJdbrvNy/PPfUus2D63zxJyyWbKf
 CeTRzA8COtY6MnqaS/QLw/Tkn3qfHcOepxaOSOHeY08OmfW+Bn5yOa/oj5IsPz0qiqKe
 DRg61xjJLIliilT+GEbpkfazKfwPxMEL2e7sFi7cHIldolWu5i+qfB6aXK0ElgWFMEd0
 X/9Npzf47EE37lhZeAp3aFWHCbMxQqNJbvtL05Zjr+JfGqwQfgIUwq71UzItLpf20uzO
 14iA==
X-Gm-Message-State: APjAAAUBJxoKDssyr15dAKCqSpXp65sLWPGbzSlEOsPQtun1x5FZpeBV
 pA1m49uARMUsA99wXKwYhdO2fy0OEIqs7eaDnI/8gw==
X-Google-Smtp-Source: APXvYqyETwT+r97qvr7Jr3LLgAMy6e/HVFS/3PRgHcfrkf2YAYUtZA/rpO3wVkYMyePVwoE/WJy+nRr8FAySy2tea8M=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr3936938otp.232.1566560991181; 
 Fri, 23 Aug 2019 04:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-16-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 12:49:40 +0100
Message-ID: <CAFEAcA9r3LvFAfu5WWD71ETyhEOzWmsZTUjid2nfGEMu1tOnTg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 15/68] target/arm: Convert BX, BXJ,
 BLX (register)
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 78 ++++++++++++++++++++----------------------
>  target/arm/a32.decode  |  7 ++++
>  target/arm/t32.decode  |  2 ++
>  3 files changed, 47 insertions(+), 40 deletions(-)

> @@ -195,8 +196,14 @@ CRC32CW          .... 0001 0100 .... .... 0010 0100 ....      @rndm
>
>  %sysm            8:1 16:4
>
> +@rm              ---- .... .... .... .... .... .... rm:4      &r
> +
>  MRS_bank         ---- 0001 0 r:1 00 .... rd:4 001. 0000 0000  &mrs_bank %sysm
>  MSR_bank         ---- 0001 0 r:1 10 .... 1111 001. 0000 rn:4  &msr_bank %sysm
>
>  MRS_reg          ---- 0001 0 r:1 00 1111   rd:4 0000 0000 0000  &mrs_reg
>  MSR_reg          ---- 0001 0 r:1 10 mask:4 1111 0000 0000 rn:4  &msr_reg
> +
> +BX               .... 0001 0010 1111 1111 1111 0001 ....      @rm
> +BXJ              .... 0001 0010 1111 1111 1111 0010 ....      @rm
> +BLX_r            .... 0001 0010 1111 1111 1111 0011 ....      @rm

Why do the decode patterns for these use '....' in the cond field
rather than '----' like the other patterns ?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

