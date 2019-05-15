Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF87C04AB4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 00:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFF720862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 00:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hy1Twv3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFF720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQhnf-0004uR-Uv
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 20:29:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQhml-0004WP-Uq
	for qemu-devel@nongnu.org; Tue, 14 May 2019 20:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQhmj-0001Es-J8
	for qemu-devel@nongnu.org; Tue, 14 May 2019 20:28:43 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQhmj-0001Dn-BO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 20:28:41 -0400
Received: by mail-pg1-x543.google.com with SMTP id t187so375842pgb.13
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 17:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=HkNkmk1PYcKfZ7q6Q5Zk+iOC8uHM0JdXdY0ktCOKu0Q=;
	b=hy1Twv3iV54o93iBxgHpz2rYIE6SJPULvJae9oRD0DQiQl84LwZrNjHHV71jvcwb0N
	m8rgEEvnhEd1f38NozhP/j9LWozIu5f0NNLOLAiLFkw4r4gKEEZuLRX81bqLG/LGbGJB
	eF/s5UtxfIoIiOc9mkmjTyA6RM5762J2ebROxFDqToSlXfFKzVoMqdXxxuDQ1XqvMW5O
	0xrH7HJsRdcl/k/vjZp4uv4XlhXI0/r4GmYuRTYDAeLFLC2+i8krpo21dswVybU1xXkQ
	N9muCUyKv6OGUHacx6MelQg5J5rLUVE/0FHCyj7Xl//yL+XWj6s3XIWmgDzQnOeDsRKw
	hoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=HkNkmk1PYcKfZ7q6Q5Zk+iOC8uHM0JdXdY0ktCOKu0Q=;
	b=jZdNGQRPwkkDp/szNGIuQDId4XbbcaHozgPLpkg57faFBJQN7l0tKie1w61lew/m51
	7hdOpfUkYKIopiwP9FXLlmuKq9kQZZu/aXpXIyh+pr45N1NJFlFnsJrM/lJs+eqwT6aX
	ZfX6p8l9IwXgM54T1wmaTva1EgblVsVPOFyMj15aCYu3Y1u3qVermhtLrsu+PLWAZJuC
	YuGAcf5g8e+qSgUT/nrGjie1E55ZHj5JktU+YlBPQKho/epBuxR8nKH6iG9PdM2jPmuQ
	AZntTun1a695zgUTl3k6eeck191TL9sM1ShsxVKmKh47WDdeX+HobtMIDAkxATaVq4ZL
	/62Q==
X-Gm-Message-State: APjAAAUzOzfJPeqjh+AZiBJEY1OLDpBHXCe4FYmRO8mOdp/Hpl2TC+Pe
	xC0M6Kc0LWi6jgKz8iOwx5+/iA==
X-Google-Smtp-Source: APXvYqyT/3J8OL5catwm9UmH+wohfsHA1yCfzRzDZsSvlKAOm3bv7KUPcjvIiGx8A3Dxw+7347i5LQ==
X-Received: by 2002:a65:62d2:: with SMTP id m18mr40864043pgv.122.1557880119552;
	Tue, 14 May 2019 17:28:39 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	w125sm354825pfw.69.2019.05.14.17.28.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 17:28:38 -0700 (PDT)
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1ac3d11b-a011-015a-b506-e34b41d04d66@linaro.org>
Date: Tue, 14 May 2019 17:28:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v2 1/1] target/arm: Fix vector operation
 segfault
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:21 PM, Alistair Francis wrote:
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index dd053c80d6..298c262825 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -6598,13 +6598,13 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>              tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
>                             rn_ofs, rm_ofs, vec_size, vec_size,
>                             (u ? uqadd_op : sqadd_op) + size);
> -            break;
> +            return 0;
>  
>          case NEON_3R_VQSUB:
>              tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
>                             rn_ofs, rm_ofs, vec_size, vec_size,
>                             (u ? uqsub_op : sqsub_op) + size);
> -            break;
> +            return 0;
>  
>          case NEON_3R_VMUL: /* VMUL */
>              if (u) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

