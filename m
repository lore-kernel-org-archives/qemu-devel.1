Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C6AC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 14:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075F020717
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 14:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPGYvQGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075F020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i99WZ-0001wd-4p
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 10:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i99VQ-0001Mx-D7
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i99VO-0002nc-OS
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 10:58:32 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:39036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i99VL-0002mx-UT
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 10:58:28 -0400
Received: by mail-ed1-x544.google.com with SMTP id g12so3760914eds.6
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=67HGyMnQM7GK05ivqI9LXfSmXBWdhCMlLcVpI3Z2rqc=;
 b=kPGYvQGAFplxtIO8sr7CSnL2R+B0AydDR3u9D22zXGEXg9+01Kilbb9XhXvZnzYFJW
 dS6lwaoMas3Krj9031ji/6HdeIZysOrhxJT8BJhwFOUy/uyJ2DritNYmGcdd8grOyM1x
 7TfaHnYUTIhkSc8+8d46bX9DHLfMr2rdC+FfL5Z5BimXnCeQi01aVMCgHcH5bbo34Kc7
 3IS3Xq0LiJyIlVaYdRj7/yoq+AuBUr1jFBVT6LRdSmpfH9CFPpjxuIRzd5bgq12DqnT/
 FLG7dQjhhfyo2kYBqEVmgXL7bdAP7EvXNnwW28bs90dqQeN3pI53K9raLuvzvNn2Vm4i
 DOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=67HGyMnQM7GK05ivqI9LXfSmXBWdhCMlLcVpI3Z2rqc=;
 b=YgZlxTa5gnb2znvnhifRxCQaVCbPJTioz9QL/G537PgyuPEQ+dwo77Swjk6MvNstkD
 PM2W+TZ/pkH2q4Kz947E0BjmG/Y7H2zZsZA23j6eZlyfXjkn96jO1gAOnfptrPoqYpM6
 Eu7S7rL5UH1Y5CYyHXF6KLectiYrdU16NAsCkpzDZH8rhdkW0P6qnS+xF+DY7x2GrnU/
 2Z5DRz2BdepsFQ6G0feiQhB3hpVpuohhK/My2Kqgs99zQ9bijjsAOHm96E4lhfICh9RV
 U72tzbAN8juYBFEVVlebetCZ7hsWo6VUWNikSmGMEwIkqIPbWidt+AnQm2iJQc17Xn+J
 scnw==
X-Gm-Message-State: APjAAAUMQ/EPwExCTDKkrHKv5sv4r3Dh/gTrs9GwDAfF4ajkCI8WGzEG
 5C78wvgccmi3ZS+sxlYgZM/pAQ==
X-Google-Smtp-Source: APXvYqynauCPY/oce9+lD35p2JWv0Oq2HqBsq1GsyIvFrDi8iuxuhbs3kPZKn8JjUEv0vWyazstqvQ==
X-Received: by 2002:a17:906:7f91:: with SMTP id
 f17mr43238426ejr.125.1568473106432; 
 Sat, 14 Sep 2019 07:58:26 -0700 (PDT)
Received: from [192.168.44.107] ([185.81.138.18])
 by smtp.gmail.com with ESMTPSA id fy1sm342629ejb.34.2019.09.14.07.58.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2019 07:58:25 -0700 (PDT)
To: "Paul A. Clarke" <pc@us.ibm.com>, qemu-devel@nongnu.org
References: <1568292860-4928-1-git-send-email-pc@us.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5778f6fc-f9bd-13e1-b09f-0f24ac8ec404@linaro.org>
Date: Sat, 14 Sep 2019 10:58:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568292860-4928-1-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v2] ppc: Add support for 'mffscrn',
 'mffscrni' instructions
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/19 8:54 AM, Paul A. Clarke wrote:
> +static void gen_helper_mffscrn(DisasContext *ctx, TCGv_i64 t1)
> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    TCGv_i32 mask = tcg_const_i32(0x0001);
> +
> +    gen_reset_fpstatus();
> +    tcg_gen_extu_tl_i64(t0, cpu_fpscr);
> +    tcg_gen_andi_i64(t0, t0, FP_MODE | FP_ENABLES);

Missing the decimal rounding mode (DRN) field at 29:31.

Otherwise,

