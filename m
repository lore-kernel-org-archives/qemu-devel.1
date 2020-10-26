Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958E3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D66220829
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRb1uXnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D66220829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX865-0007SN-Vp
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kX857-0006aO-06
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:23:01 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kX854-0000RT-Rv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:23:00 -0400
Received: by mail-pg1-x543.google.com with SMTP id l18so6635821pgg.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uqzoGeUiZyZ6lEYosQvqiZdWcrM0DYFKJVTGGrzKMQI=;
 b=wRb1uXnDB3B43Rad3kX5VqprVPRYTdwN7XTb4VwvQxlmeEOsYeVRCr1QTHwMyk30Td
 ueeSe7nMoprd3KVQtWqobif9tOS4qaK9iXNzlgey7AOduPagwyzALRkBJdwf/2Ui0Hac
 6E5zHNxZJeAeCqU47iIrnYA2AvacFt6YPDI23ea3Sjn2Qx75CpZlpG5Hcu/j4KHjhhOL
 auiDSsYgfruonoIclahZpmzKc+pdIR4RULCHyIpDsg0S3bgDV33U6B6Qyx6P5ZNGbP0j
 D+qWuL9y/gPVxgl+gUHD5aoodY1xWWWPRzJR71wIzIVUlUm8znMcszROoNB2pZ/OSMPM
 CjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uqzoGeUiZyZ6lEYosQvqiZdWcrM0DYFKJVTGGrzKMQI=;
 b=tcV5RPa3dukZAYT1HDVF88Pm0EEiGNQbIhQJ5rvh3dOfVbJ7z1SPcEQKWGByR8SvdC
 cb51op92on6Dj9FvPRTw88QlGHPmZriwIxk0AC0TEeqKmpjfca+VTvm9TfHKahoV7bfx
 xbOKe6BOQUBKW8V0FbsZ9u8qcbD7DOZ32XCmkCDBRYtcpVRFdfTGy2d7gl4G3zBtw8W9
 yp7gC66zoLVyZKjZkGwG86FaOoLExzUFzvSPijFhI8Fpc5m6aZp/Wl7Ubv6xL8cy2yTp
 0BA7qdaWTdr+H0Ek/Kcq6BpHmq26Ogp5ovjIMbrJqt9q/4bYmVL7Mrc/28zVQdM7Oy86
 lk9Q==
X-Gm-Message-State: AOAM533wjIh5qPsKAsoMR2Cmd9E7gSx/J/WvfsN9iuUmDb2jVayW4GlI
 zR5+MyZtCEzEFLJSUUbDido+uw==
X-Google-Smtp-Source: ABdhPJwI9cmnbHNgeNxy5j91vddDTsf2YfcevExrkpztfMl9OMwFgRIhBYstoQHRoAw1nceyX8gC2w==
X-Received: by 2002:a63:1357:: with SMTP id 23mr14808602pgt.13.1603740177435; 
 Mon, 26 Oct 2020 12:22:57 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i22sm2099722pfq.160.2020.10.26.12.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 12:22:56 -0700 (PDT)
Subject: Re: [PATCH] riscv: Add semihosting support [v8]
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
References: <20201023214940.917885-1-keithp@keithp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4faf9e1f-45bd-9f47-8a5f-be7b6fcdf540@linaro.org>
Date: Mon, 26 Oct 2020 12:22:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023214940.917885-1-keithp@keithp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 2:49 PM, Keith Packard via wrote:
>  static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
>  {
> -    generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
> +    uint32_t pre    = opcode_at(&ctx->base, ctx->base.pc_next - 4);
> +    uint32_t ebreak = opcode_at(&ctx->base, ctx->base.pc_next);
> +    uint32_t post   = opcode_at(&ctx->base, ctx->base.pc_next + 4);

Alistair asked if this approach is ok.  I think it is.  There are other places
in which we scan forward (usually only forward, not backward, but this is a
special nop, so it doesn't matter).

However:

(1) No need to re-read the current ebreak insn.  That is how we arrived here,
after all.

(2) You need to check for page boundaries before reading pre and post.
Otherwise you could wind up with SIGSEGV (or the equivalent internal qemu
exception) when you shouldn't.


r~

