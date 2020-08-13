Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7354AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C64B20781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pl8HTqnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C64B20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6FXk-0001KM-Fv
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 11:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6FXA-0000rC-Rm
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 11:52:52 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6FX7-00050z-2W
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 11:52:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id v15so3018497pgh.6
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WklLjhrK4drp0xRZmPRh6kdz36FUhluTGwFzcvWObQA=;
 b=Pl8HTqnUsuIzNwZE/W5mtmF19FQB5lN/3+PvfiqhEJXY/tVWx53i4ZYpxgS3x9GlTd
 Y4ILOfJJpWiFexo5CYlhHcckMaQLzkN/b5s8qSrRxT+hyabEROyNJ21tjWwNsqnazCuq
 nH77fbjLaOFnVemUcGk/Cnady9EO9Uj/IH2x0+8EGcM+xUDewHKbT3b5y/rtQn8yozqY
 bTJto898H9zvnydsvJv5XbOF6JEOq5+cIqxwYZf+TIeEaInvQwzHHlFDj3hG8ZiGeOIX
 LAu6bhZruiLFBKuT7FYG7Ih9GczwT+SbXhtQQT8mv2UF17PAIpbNZkgWZ+4V30TY3E0Q
 j2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WklLjhrK4drp0xRZmPRh6kdz36FUhluTGwFzcvWObQA=;
 b=G/30vYjLT3mA38Kj07CTcCy2oRwbPQ7T2yWZbakCvGAHHHY2B+IEAR1DgHGUXjBKdP
 WiFjEqEz5WUOugFoghZOwXyw2TbFVwET4QyEQb3odj7aHvSwM/0dQNEymP4CJESW3DK8
 DH8zh4+FzuQqG4g/uu5TsF4ig2wu6TZCMP8NRZHeS+uHOSIf/OBdeE6PrkXMgY03GUTu
 gs0vjUtMyTy17jSIDJqo0pBSxxLlYZhVTXFj9GdBLTp2AZbOHkWC5L5txWR0hpCNP2vF
 tvh9A4gKwt48HbW5EJ+Q+OQyp3OA4EnXcuPy8FqIp13hABVW8yQgUBx5kiFjs1pbTNH+
 ImqA==
X-Gm-Message-State: AOAM530y89RiOk1kPNCgBn4PsjbROFbw9capHJ7H4a29O06Wg25pVYlj
 jT67rUUHHg4B4F/ya5wT6VQpjQ==
X-Google-Smtp-Source: ABdhPJy+1iQZ/e3qLYKw8rFGg3boHO8efYvj355YTE1z4TXekPJoJ6w+nBjaBgv/He3+zvFvNd6wYg==
X-Received: by 2002:a63:ef46:: with SMTP id c6mr4223122pgk.96.1597333967039;
 Thu, 13 Aug 2020 08:52:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o192sm6774426pfg.81.2020.08.13.08.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 08:52:46 -0700 (PDT)
Subject: Re: [PATCH 3/3] target/riscv: Update MTINST/HTINST CSR in
 riscv_cpu_do_interrupt()
To: Alistair Francis <alistair23@gmail.com>, Anup Patel <anup.patel@wdc.com>
References: <20200729112801.108985-1-anup.patel@wdc.com>
 <20200729112801.108985-4-anup.patel@wdc.com>
 <CAKmqyKMCYutR5TNvbJ3nA0rAu4W0xFVsZRm66W7Fi_Nw3joiBw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c2624d4f-41f9-8a84-9694-7897cd80c2d0@linaro.org>
Date: Thu, 13 Aug 2020 08:52:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMCYutR5TNvbJ3nA0rAu4W0xFVsZRm66W7Fi_Nw3joiBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 4:16 PM, Alistair Francis wrote:
> I don't like that we have to manually decode the instructions. As it's
> only a handful it's not the end of the world, but it seems like
> duplication that could grow. Could we not use decode_insn16() instead?
> That way we can share the well tested TCG decoder.

Certainly.  Compare how the decoder can be re-purposed for disassembly -- e.g.
target/openrisc/disas.c.

Perhaps something like

typedef uint32_t DisasContext;

#include "decode_insn16.inc.c"

/*
 * This function is supposed to be called for an instruction
 * that has already executed, and thus is known to be valid.
 * That said, return 0 for an invalid instruction.
 */
uint32_t riscv_expand_rvc_to_rvi(uint16_t insn16)
{
    uint32_t insn32 = 0; /* illegal instruction */
    decode_insn16(&insn32, insn16);
    return insn32;
}

static bool expand_i(DisasContext *ctx, arg_immi *a,
                     uint32_t insn32)
{
    insn32 = SET_RD(insn32, a->rd);
    insn32 = SET_RS1(insn32, a->rs1);
    insn32 = SET_I_IMM(insn32, a->imm);
    *ctx = insn32;
    return true;
}

static bool trans_addi(DisasContext *ctx, arg_immi *a)
{
    return expand_i(ctx, a, OPC_RISC_ADDI);
}

etc.  All placed in a new file, so that the myriad symbols don't conflict with
anything else.


r~

