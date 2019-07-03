Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2243BC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40B72189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TU4/I6n4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40B72189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiOH-0003RX-JX
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hihrK-0006Pk-Qx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hihrH-0002it-Lq
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:11:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hihrF-0002ZX-UF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:11:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id x4so3467075wrt.6
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ja8X9o8TZK7VI/HAyJqWieWnjSf1kwpgGfQElS+bbKM=;
 b=TU4/I6n434thCemGvN8vd2ySzkXslEAvU0RoVZW8hhqoH1FOMYWZD1FUbnOIP2PDBU
 kNAFvABVKPjXI38z5WCcgzOXN8IpCVgzbDWScc68i4Eo/ava7hIMNpmHZ8wAQVbzYUck
 +Cl2l2ZFubipcCYHfTYfnromNuaiXibEWnoo1aUgrXncCtQWWVcY8EZ2Qyp1TE+hGBma
 JvFGBwIF1wyW2TOVzp7I9WFjW4pXH2OUiXj7YOy2zSNnpG3pSCMPV1+wNeyKtq5ly4KS
 H7yiKG6GVjS/pPoEo4gq6/esU9ZQjq0bBbHddLjmc89L1ajSILYE5x9kYW637Tz4wl/u
 clyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ja8X9o8TZK7VI/HAyJqWieWnjSf1kwpgGfQElS+bbKM=;
 b=A20SKkm5vnCbp8/C1/OTJL6ecDCUkVUy39MmABYlMiyZ2bB1mlxi9sYmUk7No45biD
 jWcKXanqrOlkhsz1mMIuNZQDBcYl71L01M6tNvfSOACi6ZGbJCNCkvR4/cSuZoW3H6KJ
 8/nUCrJH8PzlZHUyvMl2estP8/RmsLCfRCYV3vJakGCccE0KR13iZQIQAs/kopWXd/kB
 7+pB46Ma+MOHLO6LcHbMZGTG6LDNL+LssXIEsxvzuVicDWTj1tZoUB3akG7CkdNFQ+Wj
 u8JeMYdD5CFBHpIOzRawsRmpzVJ3J2iwt0Ts3K0PHiMe+VCnj4rZxdYHnbUK7CW1/1Ux
 7XUw==
X-Gm-Message-State: APjAAAWEfsHlvP81xuorAFrIswPHNYUrqKIfMNejWmyRUINdIIIiiVXQ
 QSpwlRbpiaby55ongQGQE3Hcdw==
X-Google-Smtp-Source: APXvYqzv1kjUTfLSHQTMJXAmgk9inC42PZulnccxqA2P+fvgddx+FBjDIkixE2syg9EM2CaEmIzNUg==
X-Received: by 2002:adf:f28a:: with SMTP id k10mr31256203wro.343.1562170286989; 
 Wed, 03 Jul 2019 09:11:26 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id k63sm3263661wmb.2.2019.07.03.09.11.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 09:11:26 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-5-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <67fbe51c-ab7c-11e9-ecbc-aa72ff430911@linaro.org>
Date: Wed, 3 Jul 2019 18:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190701043536.26019-5-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 04/14] risugen_x86: add module
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 6:35 AM, Jan Bobek wrote:
> +sub write_mov_rr($$)
> +{
> +    my ($r1, $r2) = @_;
> +
> +    my %insn = (opcode => X86OP_MOV,
> +                modrm => {mod => MOD_DIRECT,
> +                          reg => ($r1 & 0x7),
> +                          rm => ($r2 & 0x7)});
> +
> +    $insn{rex}{w} = 1 if $is_x86_64;
> +    $insn{rex}{r} = 1 if $r1 >= 8;
> +    $insn{rex}{b} = 1 if $r2 >= 8;

This is where maybe it's better to leave rex.[rb] to risugen_x86_asm, and just
leave $modrm{reg} and $modrm{rm} as 4-bit quantities.

> +sub write_mov_reg_imm($$)
> +{
> +    my ($reg, $imm) = @_;
> +    my %insn;
> +
> +    if (0 <= $imm && $imm <= 0xffffffff) {

Should include !$is_x86_64 here,

> +        %insn = (opcode => {value => 0xB8 | ($reg & 0x7), len => 1},
> +                 imm => {value => $imm, len => 4});
> +    } elsif (-0x80000000 <= $imm && $imm <= 0x7fffffff) {
> +        %insn = (opcode => {value => 0xC7, len => 1},
> +                 modrm => {mod => MOD_DIRECT,
> +                           reg => 0, rm => ($reg & 0x7)},
> +                 imm => {value => $imm, len => 4});
> +
> +        $insn{rex}{w} = 1 if $is_x86_64;

making this unconditional.

> +sub write_random_ymmdata()
> +{
> +    my $ymm_cnt = $is_x86_64 ? 16 : 8;
> +    my $ymm_len = 32;
> +    my $datalen = $ymm_cnt * $ymm_len;
> +
> +    # Generate random data blob
> +    write_random_datablock($datalen);
> +
> +    # Load the random data into YMM regs.
> +    for (my $ymm_reg = 0; $ymm_reg < $ymm_cnt; $ymm_reg++) {
> +        write_insn(vex => {l => VEX_L_256, p => VEX_P_DATA16,
> +                           r => !($ymm_reg >= 8)},

Again, vex.r should be handled in vex_encode.

> +                   opcode => X86OP_VMOVAPS,
> +                   modrm => {mod => MOD_INDIRECT_DISP32,
> +                             reg => ($ymm_reg & 0x7),
> +                             rm => REG_EAX},
> +                   disp => {value => $ymm_reg * $ymm_len,
> +                            len => 4});
> +    }

So... this now generates code that cannot run without AVX2.

Which is probably fine for testing right now, since we do
want to be able to notice effects of SSE/AVX insns on the
high bits of the registers.

But we'll probably need to have the same --xsave=foo
command-line option that we have for risu itself.

That would let you initialize only 16-bytes here, or
for avx512 initialize 64-bytes, plus the k-registers.


r~

