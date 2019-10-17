Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C96ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409C12089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1h462zt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409C12089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9KP-0005lO-Vn
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL8b0-0000zk-EN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL8az-00087K-9l
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:25:50 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL8ay-00086W-MF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:25:48 -0400
Received: by mail-pf1-x441.google.com with SMTP id a2so1967961pfo.10
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=smULLT7TyxlhzX4ZtJnRUwU2qmeieBXZe/LElz40Lyg=;
 b=x1h462zt10sUkZCVm1tdai+8qg6p067K6XaqU/3ua38NzApnIt/2Llv0inkto2S8Uk
 5v855v0lQjBURhX9smhZPGqRMU/M+0FX5PtFRbfm03gLefMGm80ix2yOKILT10cFqbLH
 +Vm01CiITICDvt5k9wyKyF696YhASgF51t0Ril41Z8xMLS4FnebVV5svIhSKQFMivP4N
 oTDHVqDkwt806kz9vCGgp2qDdGAANHbMDuY8ibR3rJhEM1JA4biby4VWNaqSGpBa2XU1
 I3mHOab7WjABzui+tom+QLrrEtei0rzqleLmngs7LxK8YJ5P2FXvcaMSSvyzTXCpIUSR
 sz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=smULLT7TyxlhzX4ZtJnRUwU2qmeieBXZe/LElz40Lyg=;
 b=bxNmrRe5xOpkyk+teYPlyWhbbZ/UBdoLU0UPqXjb0ejALOTaGfMsg7uh0qjXy2nG2v
 MSJGAUuiz7umydGxYyTkBEUjaHR/ILFOsfGRZMMlaa6vHRy+Mtm9355WjPLneAGHyCtN
 /QjBRp5/jdpNi9fLugcSONEeaiJ2sW5pdx62f9Gux22rMQrwpNxoam2L67+Kdr/QsJku
 yXFVAx0vOQPTasVm174bQwQ3Vd2Ke0Z1MZAj3EALUkCt5zVJUP7R6PxCfl/mrNR94fWn
 V17teDI3sxy+IXRVc3vhxNqjIPO4CFnGu0VHXKwSADXCROzpCHccxVNXXDy4CnHun8om
 Doww==
X-Gm-Message-State: APjAAAUAhlQygdDnEdbh6PvzOc9RQKCzWD4w03wYomLRiNK8ieK9rw3F
 rLsTrrusW6z8TceZ7A5TY+lYaA==
X-Google-Smtp-Source: APXvYqyGU7phO/JdgXNL7kv5/jCPM9fGF3ZcFD3Y7Ns8sX8Hfg9elL2A5i5bRJ8n9Af4SiGpzp6eJw==
X-Received: by 2002:aa7:93de:: with SMTP id y30mr1174157pff.27.1571329547121; 
 Thu, 17 Oct 2019 09:25:47 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t125sm4394149pfc.80.2019.10.17.09.25.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 09:25:46 -0700 (PDT)
Subject: Re: [PATCH v6 00/20] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <CAFEAcA_fmQKOk8k=Mo7MvuKvAq9Zb90xtQ0RdaxyMdLGZUwY0Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a130df8a-5804-09a6-966c-2760b50a84c2@linaro.org>
Date: Thu, 17 Oct 2019 09:25:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_fmQKOk8k=Mo7MvuKvAq9Zb90xtQ0RdaxyMdLGZUwY0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 8:26 AM, Peter Maydell wrote:
> Don't we also need to do something to rebuild the hflags
> for M-profile writes to the memory mapped system registers?
> For instance rebuild_hflags_m32() bakes in state which
> cares about env->v7m.ccr, which is set via nvic_writel(),
> but I don't see anything whereby the write to the NVIC
> register triggers a rebuild of the hflags value. Maybe I
> missed it?

How do you end the TB after nvic_writel(), so that the new behaviour can be
noticed right now?  We can call arm_rebuild_hflags() within nvic_writel(), but
it still needs to be recognized somehow.  I would expect to place one rebuild
in the place you end the TB...


r~

