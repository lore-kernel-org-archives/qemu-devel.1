Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80449C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37571207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLxS0yN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37571207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyBC-0001WS-Ah
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kAyAN-0000jd-6U
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:20:51 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:35988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kAyAK-0006Ja-Rg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:20:50 -0400
Received: by mail-lf1-x142.google.com with SMTP id c15so1311958lfi.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=No0bFHMH3HKSRz4C+Q+7k9RCKgG8VVVXOOF+eBDk9pc=;
 b=cLxS0yN8mpT7TSRlYJQwMsL0IdrpEl06bu4d7HLDPkRfvI9PhJJbDgI85NVLgANfPw
 Q4oH5X69O6p5wyLzOyagPzxoymcNABgC1SIWt0NeQ2ODNalKieDaZSA92MOGLh8sKj1v
 V97geDhDzMqemO0l6jLc3LG5XBxUefAakxZuLF6wtSte3Q0tqpymIF1MQVvWbX9H6d6B
 /1H/p0HwTkfvc8iUzx/gB6y9S4aM38hxnNiImjjDjJpEVj3Yp8Utga6lQIdlnoQyOdKu
 4llHlLQ9LOZ1cHTZbubyFfpIEMx9juJsie0Mhs2YXLFyE2eXSf2ERHj1Mfv5yTs7wNBR
 X5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=No0bFHMH3HKSRz4C+Q+7k9RCKgG8VVVXOOF+eBDk9pc=;
 b=o8/8s/kcRHXjMwwyFPYO/XoOgBxr7qiPTXXwa/+qWTaNanj/XAwkyoNiMTsNvYveQU
 P+fbH6VEGSgEBM8Q0cJD5baJfaSssm7B+QobEqjhGmtqZ0p7ZeOWWI4bfMNUs4SBb6iO
 8fzOS/tn1UU5TonG4/DPF3omJ10N0x1KQ2b2Q/ALdvkynDa2GAmxfAXwXa9m8zlrRh8T
 PdzFMAr9bIWi/J5fcw3OfcPWa3VZvxRj1o4NWVglNhlrBhy63TcQDZ2kkvEhndbgo1aO
 tl37OYZFimsqiTm2l6ba9v4vWPqrdj8uNxk1MjEPiWwgVqxaXsnp9eunG7Y37m6QVJHX
 INYQ==
X-Gm-Message-State: AOAM533TpGhuyUt/U7USNXWigW9CXqqhR1s2rWjLUkYXa/b8v4yqo44M
 q/DAgnQBUP2Ew0C0LL9NvTI=
X-Google-Smtp-Source: ABdhPJz1Gje7f6EKDZv9XjKY2h+XqUEnE8paPGuKIshYZq/B0uYSViSUZurpB/h+Ff9uCS163AVRtg==
X-Received: by 2002:a05:6512:2010:: with SMTP id
 a16mr7577554lfb.196.1598458846593; 
 Wed, 26 Aug 2020 09:20:46 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id u16sm665773lff.71.2020.08.26.09.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 09:20:45 -0700 (PDT)
Date: Wed, 26 Aug 2020 18:20:45 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 01/77] tests/tcg: Add microblaze to arches filter
Message-ID: <20200826162045.GF2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200825205950.730499-2-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.066, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 01:58:34PM -0700, Richard Henderson wrote:
> Not attempting to use a single cross-compiler for both
> big-endian and little-endian at this time.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  tests/tcg/configure.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 7d714f902a..598a50cd4f 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -94,7 +94,7 @@ for target in $target_list; do
>      xtensa|xtensaeb)
>        arches=xtensa
>        ;;
> -    alpha|cris|hppa|i386|lm32|m68k|openrisc|riscv64|s390x|sh4|sparc64)
> +    alpha|cris|hppa|i386|lm32|microblaze|microblazeel|m68k|openrisc|riscv64|s390x|sh4|sparc64)
>        arches=$target
>        ;;
>      *)
> -- 
> 2.25.1
> 

