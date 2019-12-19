Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84266C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6F12467E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tk0jFzI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6F12467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii2ZQ-0004p6-HR
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 15:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ii2Yo-0004NX-Vn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ii2Yn-0003ap-FV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:38:14 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ii2Yn-0003VT-3m
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:38:13 -0500
Received: by mail-pg1-x541.google.com with SMTP id k3so3757112pgc.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A4X261kL1pxjFezTDPUGRNqYKWpewts9JKz+Fm4h7ns=;
 b=Tk0jFzI/ODozqjN+t57rwqYugOyzjJ3y2GYKb3HzBU24ea8/U6ssdsR0cwAqNFJ9Uh
 lqTYywnfVXQ6pHlND8gFksJFR5gD5rkV9MPzIAXxG8wzT2qDq6/ZFKpBYF7ffYt1HoKa
 2vefiyxLzs/olK9xBaqbU6zstxqszp2l+JEf6A0f6NRHcSHsQu8aaEtwJTzegCo2Sz8N
 ixjS+06z533GOOLl+SxUWX/3Sa2xfKgipEY8I/d3LI0WDPLW9IPhxZAgU3i8ZUqUDicP
 xi9yt+J1R0rUlIIB5kTeS1Pz0PHnqZTqR1dqdfB0ykIBndVSI6RZwfpBwlBgKRnqS8ay
 zueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A4X261kL1pxjFezTDPUGRNqYKWpewts9JKz+Fm4h7ns=;
 b=hoXAbH1sj3nvaoOKd2izPv5gOeKYjfvc+smkid3wXw1YhLY+iV1JBl5zk5K7W3InMC
 IzYvjPb8KVw+CSCxW2gJuNZT1v3vONYYT0W7UZnZKZqtwdRrPhuSdNkfDHGITxG7bP5h
 Im610CYP1a7IWQEAMiDmaEWtSbT9zwCoxbESIaiGJ8HWq66+b/63uiWPff/jIpaFflcv
 pJr0RvlBSE211cxOqoLlQL2rkovuS2OftYb8cMo2UTKICFLl+rsFTwPDFB0Pw1+BGX9B
 Mkyz5pe82yJnltYJOabuBUtNiPi6set3OsnfRVOCiyWMmX3ftlVtVV3d9tH/wtPyFB0a
 SjwQ==
X-Gm-Message-State: APjAAAWJce6uiQPlCk5Yjn/u7Aa3wTBQBICZXxWnZzzFUg1q7udnOfPk
 WdYIxTzUZd/svQPg03zu5MltJA==
X-Google-Smtp-Source: APXvYqyuFQ2yVmSKJwwbOL+mpYYQicVRYbdZlo2tXTZ3ep0OQGPLvSR4z3z6PncxK7afVKyitvrrnA==
X-Received: by 2002:a63:6602:: with SMTP id a2mr10396368pgc.403.1576787891753; 
 Thu, 19 Dec 2019 12:38:11 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:9de9:bce2:6ae3:53c4?
 ([2605:e000:c74f:dc00:9de9:bce2:6ae3:53c4])
 by smtp.gmail.com with ESMTPSA id f81sm9666456pfa.118.2019.12.19.12.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 12:38:11 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <ba8c7451-b0a7-0405-f881-0c6d0d8574fb@linaro.org>
 <1b1826c3-50e4-2481-56a2-4ebb01e04498@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fe1a210e-e4cf-f62a-a39f-2818358d53c9@linaro.org>
Date: Thu, 19 Dec 2019 10:38:07 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1b1826c3-50e4-2481-56a2-4ebb01e04498@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Chih-Min Chao <chihmin.chao@sifive.com>, palmer@sifive.com,
 Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 11:11 PM, LIU Zhiwei wrote:
> I'm sorry that it's really hard to absorb your opinion. I don't know why clang
> will fail
> 
> when index beyond the end of vreg[n] into vreg[n+1].

I thought sure one of the address sanitizer checks would detect array bounds
overrun.  But it becomes irrelevant

> As Chih-Min Chao said in another part of PATCH V2 thread,  VLEN will be a
> property which can be
> 
> specified from command line.  So the sub-struct maybe defined as
> 
> struct {
>     union{
>         uint64_t *u64 ;
>         int64_t  *s64;
>         uint32_t *u32;
>         int32_t  *s32;
>         uint16_t *u16;
>         int16_t  *s16;
>         uint8_t  *u8;
>         int8_t   *s8;
>     } mem;
>     target_ulong vxrm;
>     target_ulong vxsat;
>     target_ulong vl;
>     target_ulong vstart;
>     target_ulong vtype;
> } vext;
> 
> Will that be OK?

Pointers have consequences.  It can be done, but I don't think it is ideal.

> The (ill, lmul, sew ) of vtype  will be placed within tb_flags, also the bit of
> (VSTART == 0 && VL == VLMAX).
> 
> So it will take 8 bits of tb flags for vector extension at least.

Good.

> However, I have one problem to support both command line VLEN and vreg_ofs.
> 
> As in SVE,  vreg ofs is the offset from cpu_env. If the structure of vector
> extension (to support command line VLEN） is
> 
> struct {
>     union{
>         uint64_t *u64 ;
>         int64_t  *s64;
>         uint32_t *u32;
>         int32_t  *s32;
>         uint16_t *u16;
>         int16_t  *s16;
>         uint8_t  *u8;
>         int8_t   *s8;
>     } mem;
>     target_ulong vxrm;
>     target_ulong vxsat;
>     target_ulong vl;
>     target_ulong vstart;
>     target_ulong vtype;
> } vext
> 
> I can't find the way to get the direct offset of vreg from cpu_env.
> 
> Maybe I should specify a max VLEN like the way of SVE?

I think a maximum vlen is best.  A command-line option to adjust vlen is all
well and good, but there's no reason to have to support vlen=(1<<29).

Oh, and you probably need a minimum vlen of 16 bytes as well, otherwise you
will run afoul of the assert in tcg-op-gvec.c that requires gvec operations to
be aligned mod 16.

I think that all you need is

    uint64_t vreg[32 * MAX_VLEN / 8] QEMU_ALIGNED(16);

which gives us

uint32_t vreg_ofs(DisasContext *ctx, int reg)
{
    return offsetof(CPURISCVState, vreg) + reg * ctx->vlen;
}

I don't see the point of a union for vreg.  I don't think you'll find that you
actually use it at all.

You do need to document the element ordering that you're going to use for vreg.
 I.e. the mapping between the architectural vector register state and the
emulation state.  You have two choices:

(1) all bytes in host endianness (e.g. target/ppc)
(2) bytes within each uint64_t in host endianness,
    but each uint64_t is little-endian (e.g. target/arm).

Both require some fixup when running on a big-endian host.


r~

