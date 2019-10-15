Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B416ECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 22:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5787120873
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 22:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+o7Flo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5787120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKUwA-0006kS-CH
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 18:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKUvQ-0006EI-IK
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 18:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKUvP-00008E-7I
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 18:04:16 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:47010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKUvO-00007y-W2
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 18:04:15 -0400
Received: by mail-pl1-x641.google.com with SMTP id q24so10217234plr.13
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 15:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WlM9qJ26FVCtq2jMelepxWIYCn2U4CiSRTZw+YpUCb8=;
 b=e+o7Flo/RQIdkm3zHprASXlgV+xKalpnNuUy66Cg4pWH2jsaB12eTKbyOX1XHcS2RW
 aglfuAnOOkt2Izir/zLe5YrkGtMeLQd0K6LjUBMnwW2lWDPOwtyOhXStbVpJInUVHubz
 UzRH8F/z3uL6Ml1nqWUAe5sSYdk8qwr3gY3fSkGCmYFx/LzlTI4KskfJzgWOZ7QxHbx+
 pyBIrziISb8v/QfN8zTxKdxtNYH563nJkGhDr9N8HAeHV/dCotuNcsQ51vEi6BDkIBvQ
 5/e9+arnYRUOGoXS89fvKEqcF0caGde7VzBbMwA2JsP9O1KpBdn4nFW3P59zv1KZg6E3
 VXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WlM9qJ26FVCtq2jMelepxWIYCn2U4CiSRTZw+YpUCb8=;
 b=c0vCG6OmozeukhAgjrdJ4eQOjdwbBLqBXrVz+LGWpHj6/5IBhUH5CRes+b0tYBG77j
 HuIfBXXs9dhFbfK4lUcPnXmDzZiV4tr9KTeVH21xV34T5o+j/Yc8rL4XUH5le1Xb0W0Z
 oG4braQ8cO0dLcvDP5lflcB+zct0+nUqUnb9HIFVii5Tb8Me/mY4pTfXSne2kmwFCZeh
 KDWdwuARHHITl2VjVHoOaS2qgIJJ3USoFfHMR0uqpkzoidD+G3ArMfmqT3mIlmQvVDM5
 j4z1Q2vNxMa5kiSJnvyf70Xx/YU7M1Ky7IoPUPt3zdXVfU2ei4MseETZifMEizK/oqC6
 ZmgQ==
X-Gm-Message-State: APjAAAW5gsS97GRD91e6ekdtq/CDATBDkkOKELO69IvujlpcuEFPB4DV
 yzFfBjAjEXFy7+kXCXd0uXao8g==
X-Google-Smtp-Source: APXvYqxC6LVo6IFjID5M2Or1B3+YgMiYotmEW1topciVqqIoIlkKxMgd+YuiU72TbGBuJIy1kLlreA==
X-Received: by 2002:a17:902:bd47:: with SMTP id
 b7mr3491572plx.124.1571177053361; 
 Tue, 15 Oct 2019 15:04:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a13sm33727661pfg.10.2019.10.15.15.04.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Oct 2019 15:04:12 -0700 (PDT)
Subject: Re: [PATCH v5 00/22] target/arm: Implement ARMv8.5-MemTag, system mode
To: Evgenii Stepanov <eugeni.stepanov@gmail.com>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <CABMLtrhb2n3WbpROs0Qa9hFBObom0Qm60t2nioOyWTtgbpu7HA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3d53c538-9725-18a8-079f-de490ed586a5@linaro.org>
Date: Tue, 15 Oct 2019 15:04:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABMLtrhb2n3WbpROs0Qa9hFBObom0Qm60t2nioOyWTtgbpu7HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 1:39 PM, Evgenii Stepanov wrote:
> Hi,
> 
> please find attached three random fixes for instruction translation
> and one for syscall emulation.

Thanks for the patches.

> @@ -2763,7 +2763,8 @@ static void disas_ldst_pair
>          return;
>      }
>  
> -    offset <<= size;
> +    // STGP offset is 16-scaled.
> +    offset <<= (size + set_tag);

Right.  I'll fix this with

    offset <<= (set_tag ? LOG2_TAG_GRANULE : size);

which I think is a bit clearer.

> @@ -3611,7 +3611,7 @@ static void disas_ldst_tag
>      int rt = extract32(insn, 0, 5);
>      int rn = extract32(insn, 5, 5);
>      uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
> -    int op2 = extract32(insn, 10, 3);
> +    int op2 = extract32(insn, 10, 2);

Yep.

> @@ -3679,7 +3679,7 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
>      }
>  
>      dirty_addr = read_cpu_reg_sp(s, rn, true);
> -    if (index <= 0) {
> +    if (index >= 0) {
>          /* pre-index or signed offset */
>          tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
>      }
> @@ -3726,7 +3726,7 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
>  
>      if (index != 0) {
>          /* pre-index or post-index */
> -        if (index > 0) {
> +        if (index < 0) {
>              /* post-index */
>              tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
>          }

Yep.

Ideally there'd be a kernel patch for MTE that works well enough to run RISU on
the fast model, and I'd be able to compare results.  I suppose in the meantime
more unit testing will have to do.

> +++ b/linux-user/qemu.h
> @@ -456,8 +456,16 @@ extern unsigned long guest_stack_size;
>  #define VERIFY_READ 0
>  #define VERIFY_WRITE 1 /* implies read access */
>  
> +static inline abi_ulong untagged_addr(abi_ulong addr) {
> +#if TARGET_ABI_BITS == 64
> +    addr &= (((abi_ulong)-1) >> 8);
> +#endif
> +    return addr;
> +}

At minimum this needs TARGET_AARCH64, because this kernel feature doesn't apply
to other targets.  But I'll see if I can do this such that it doesn't put
target-specific stuff in linux-user/qemu.h.


r~

