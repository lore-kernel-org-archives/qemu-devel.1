Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8550C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775C920828
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXeIfnvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775C920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgRhn-0005Td-8c
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 06:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49845)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgRej-0004Ok-0b
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgRec-0005qc-SU
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:29:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgReZ-0005lu-Lw
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:29:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id k11so1944679wrl.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pEOZABMb7EaSaRwQTPa+LRLUciq6jP/yqSDWRjtHd9g=;
 b=kXeIfnvIMMhj1vKtLJDtfwEjM5S8upMS/+oHLmZ7iloXNM0Nu3wcGDtobR3uQhb+lQ
 atD1onG80SZl9L1tgdu1jkF73JuKjDILChwx6K1EPuE5AeGmek78bEmxCg97L0eh7UpY
 KVE3Py/TB/zn2cJgh7vLP/6LCgct/ZPopEH5e3VXMbq5lXcaQW9kv78LbAanNFCNaUxI
 CfxUKzOo4HDzjzj3ZQ5Ii9NknnMfXWugtc2eolM3ZyYOv5ps7jLsR0yf6jWi/uauKxZu
 HgMrbm+M+bBMVP7LLFX1hePDLp8WuLOclVjK3Ala7q3hV+QffpAapkS36NU6TFYy1T3g
 OQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pEOZABMb7EaSaRwQTPa+LRLUciq6jP/yqSDWRjtHd9g=;
 b=q/wmkAikcTdu1EtLWostHchoa/TZZFkTnAqC2tUYEap+IDxi2pKRvaoV3V1Hs//OCS
 +0y6V1mfiD/c/djzJljDHugs+OajKeZS33k6Y/klR/fCBhj5t/hpX5GtWtoisAqbdsc4
 hUWstmvKCupJZc3bkqVHKZZKi7sZJGdhDknfpvcQSAVcO5rnnsMAX65PWDZQA88RfQa/
 105Y/E+qh+ZlJRk++8kyxQkl5wyn8sLw5HOxSdiqXJKfg+Ua0nac/Ve40Z9CNkjTDVNG
 DzXYtjwt3neCvs2p/HV3Yb1woMqTFNIo02mc65YpF4y3t9eaOE+Q8cpvbxF7jTWzti6g
 htyw==
X-Gm-Message-State: APjAAAUP6qwTgu6MVWxurwtsIX5FvOkpv3EEOlG6+XbEk7lMfouD1GPd
 dUW6cZpNaWaUi2I5tr23wtABvg==
X-Google-Smtp-Source: APXvYqwOIhWHTmOqVx3fqAC5bdjjn30efiYHmZzosQDpGPLdrxwDX9pzG5aMfSLPz+EdncVdoAjqbA==
X-Received: by 2002:adf:f34b:: with SMTP id e11mr2788679wrp.230.1561631355903; 
 Thu, 27 Jun 2019 03:29:15 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id o24sm1714783wmh.2.2019.06.27.03.29.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 03:29:15 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190619050447.22201-1-jan.bobek@gmail.com>
 <20190619050447.22201-5-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f00e9c29-592e-06b2-04cd-b3c3c28b4cc0@linaro.org>
Date: Thu, 27 Jun 2019 12:29:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619050447.22201-5-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RISU RFC PATCH v1 4/7] risugen_x86: add module
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

On 6/19/19 7:04 AM, Jan Bobek wrote:
> +    --x86_64     : generate 64-bit (rather than 32-bit) x86 code.

Better is to use

	.mode	x86.64
vs
	.mode	x86.32

or some such, like we do for aarch64.

> +sub write_mov_reg_imm($$)
> +{
> +    my ($reg, $imm) = @_;
> +
> +    my %insn = (opcode => {value => 0xB8 | ($reg & 0x7), len => 1},
> +                imm => {value => $imm, len => $is_x86_64 ? 8 : 4});
> +
> +    $insn{rex}{w} = 1 if $is_x86_64;
> +    $insn{rex}{b} = 1 if $reg >= 8;
> +
> +    write_insn(%insn);
> +}

There are 3 different insns that x86_64 can use for different ranges of
immediates; you are always using the full 10 byte version.

Using 0xb8 without REX.W may be used for any unsigned 32-bit value.
Using 0xc7 with REX.W may be used for any signed 32-bit value.
Using 0xb8 with REX.W of course allows any 64-bit value.

It's not terribly important, but the code size does get large.

> +sub rand_insn_modrm($$)
> +{
> +    my ($opts, $insn) = @_;
> +    my $modrm;
> +
> +    while (1) {
> +        $modrm = rand_fill({mod => {bitlen => 2},
> +                            reg => {bitlen => 3},
> +                            rm => {bitlen => 3}},
> +                           $opts);
> +
> +        if ($modrm->{mod} != MOD_DIRECT) {
> +            # Displacement only; we cannot use this since we
> +            # don't know absolute address of the memblock.
> +            next if $modrm->{mod} == MOD_INDIRECT && $modrm->{rm} == REG_EBP;
...
> +sub rand_insn_rex($$)
> +{
> +    my ($opts, $insn) = @_;
> +
> +    $opts->{w} = 0 unless defined $opts->{w};
> +    $opts->{x} = 0 unless defined $opts->{x} || defined $insn->{sib};
> +
> +    my $rex = rand_fill({w => {bitlen => 1},
> +                         r => {bitlen => 1},
> +                         b => {bitlen => 1},
> +                         x => {bitlen => 1}},
> +                        $opts);

I don't think it's a good idea to generate reg/rm/sib.index separate from
rex.r/b/x.  In particular, all of your tests vs EBP and ESP are not quite
right, since the final insn may be referencing R12 or R13.

What is your plan for handling the unary insns for which modrm.r is opcode and
not a register?  This doesn't seem to allow for those.  How about insns for
which modrm.mod must be 3 (register) or must be != 3 (memory/address)?  Is this
simply going to fall into "testing of illegal encodings"?


r~

