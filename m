Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E3C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAA2206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vn4SzqSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAA2206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Oki-00036I-6y
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k0Ojq-0002Ph-Ij; Tue, 28 Jul 2020 08:29:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k0Ojp-0001Ja-1D; Tue, 28 Jul 2020 08:29:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so18062911wrj.13;
 Tue, 28 Jul 2020 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Sh13qteGxNk/+YTEg4Jt3fxwUcvVSdSZGbREo+9eVTg=;
 b=Vn4SzqSywkB1QxQADgHZbYorccCfGa4oIJyn0gq7YWMdSL5i0LAR2V4s/tuIq7SPoo
 UQgB2qA1GEB+hXOW3FLeL/m5XYhz+VwSVDHuqAPYu+Pk26umJuyKJGlgUldti5q914wj
 /N7PF8SZxIYh3W5jHOZqIK3o1zx/YBR+cRaPJgrM4RYCHKM3LLKZvmFR7pWZWykzky96
 ZiBLtJmn3LdDs8+fyfxQ0StRmSEaNM5j6zuul9NP7x80njhX1b4vEyaMUtL0nFZEcPBs
 oC3EmBEtX1m7zUKGE9T0ToNcx5E+Gf0CVM1azgcvXPmTwzWWvO2/zq+O0CdoPoFCg2e7
 xoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sh13qteGxNk/+YTEg4Jt3fxwUcvVSdSZGbREo+9eVTg=;
 b=G0bpcuQXrSRLzAe74mE57yPvCol7aBGXXuUYf3nBnJQNgjGqp/+a5U3qE60G1EZdnK
 X6/iqNqhPECfHB+OpGFUgQN7RmD1zd/yA0RLhBBn+zpDSJhyV38SptMXBGFEkXn7p8IB
 zqRWmUNFDjKFUX0dXTvEzWFlv2yTbmlIdjrTz0hTwsUFeCTaJUrSnVgZuOHiI70ONgOy
 /CVxHiLlQAVPDdPVz8dWu9MmpLaKG7kRJc3lJSKj6QuUC3IpwFi52hDku+nqeSJk3z6N
 JUMxum8Oi43u583L5rocbFAOlKapBz1/ksrQUNBcpyXkMoY1+QN0M/m29lKfzcstFefJ
 opYQ==
X-Gm-Message-State: AOAM531xojmS63TzBuXLIUnzZ+vddQP631xlmKJkP8xn/kvBAu0Jo5BF
 0d+yggvTLgTH9pUKoiemK8QT9hGj
X-Google-Smtp-Source: ABdhPJyRp3c7NGG9Ckemyhnu6lL09WvdMEM97R36/JSGaeAAE2PiEQoB9DvXNkvRkP3sFpshfhaZyA==
X-Received: by 2002:adf:de08:: with SMTP id b8mr23433973wrm.4.1595939383101;
 Tue, 28 Jul 2020 05:29:43 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id r16sm17458842wrr.13.2020.07.28.05.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 05:29:42 -0700 (PDT)
Subject: Re: [PATCH for-5.1? 0/3] Fix AIRCR.SYSRESETREQ for most M-profile
 boards
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200728103744.6909-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <47817541-68e3-12f8-27b4-552af8389907@amsat.org>
Date: Tue, 28 Jul 2020 14:29:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200728103744.6909-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/28/20 12:37 PM, Peter Maydell wrote:
> QEMU's NVIC device provides an outbound qemu_irq "SYSRESETREQ" which
> it signals when the guest sets the SYSRESETREQ bit in the AIRCR
> register.  This matches the hardware design (where the CPU has a
> signal of this name and it is up to the SoC to connect that up to an
> actual reset mechanism), but in QEMU it mostly results in duplicated
> code in SoC objects and bugs where SoC model implementors forget to
> wire up the SYSRESETREQ line.
> 
> This patchseries provides a default behaviour for the case where
> SYSRESETREQ is not actually connected to anything: use
> qemu_system_reset_request() to perform a system reset. This is a
> much more plausible default than "do nothing". It allows us to
> allow us to remove the implementations of SYSRESETREQ handling from
> the boards which currently hook up a reset function that just
> does that (stellaris, emcraft-sf2), and also fixes the bugs
> in these board models which forgot to wire up the signal:
> 
>  * microbit
>  * mps2-an385
>  * mps2-an505
>  * mps2-an511
>  * mps2-an521
>  * musca-a
>  * musca-b1
>  * netduino
>  * netduinoplus2
> 
> [I admit that I have not specifically checked for datasheets
> and errata notes for all these boards to confirm that AIRCR.SYSRESETREQ
> really does reset the system or to look for more complex
> reset-control logic... As an example, though, the SSE-200 used in
> the mps2-an521 and the musca boards has a RESET_MASK register in the
> system control block that allows a guest to suppress reset requests from
> one or both CPUs. Since we don't model that register, "always reset"
> is still closer to reasonable behaviour than "do nothing".]
> 
> We still allow the board to wire up the signal if it needs to, in case
> we need to model more complicated reset controller logic (eg if we
> wanted to get that SSE-200 corner case right in future) or to model
> buggy SoC hardware which forgot to wire up the line itself. But
> defaulting to "reset the system" is going to be correct much more
> often than "do nothing".
> 
> Patch 1 introduces a new API for "check whether my qemu_irq is
> actually connected to anything" (the test is trivial but the
> encapsulation seems worthwhile); patch 2 provides the new default
> and patch 3 removes the now-unnecessary SYSRESETREQ handlers in
> board/SoC code.

Good cleanup!

Series:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

