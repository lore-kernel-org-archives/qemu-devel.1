Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E2EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF97720716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QodRu51m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF97720716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtrf-0008MC-Nx
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDtr1-0007vy-Ee; Thu, 03 Sep 2020 14:20:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDtqy-0001bh-Kd; Thu, 03 Sep 2020 14:20:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id e11so5904935wme.0;
 Thu, 03 Sep 2020 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2IurPWJRGogVaUiwwBhDm6X+NXoSppkLM0Gq+vhKp+o=;
 b=QodRu51mMbS8UHMQobXSIPF+ZR9JbCPryaLKiwQi+GCQu46J6VFxjZkERZHL8zOm9u
 x1Z1bPd1ZbGTQ3pPK/rYWJoGPnucfJORfg9Fvv6tBpRRk+lEwFfbGn/mo6UhioQnULkQ
 4uBMUtNCeTHnir0+99xVJrxyLrD19U4zI99LJPQ0Exxu7XFTPbuaJhZ1q9OSNqrQ2G7H
 HjNXTnKo38xRtuVjAA3f24ayDyTw4rXxNxCGbD4hiPh94Q7ZG4Op4PKDmMqYvTAzgtFF
 AbQgDIQh75uF1csaJYjrny9NrmQ4T9tbK0Hm4bCZ38Dts/e9Hh/qgCG+iMVpZUF0Hejq
 B+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2IurPWJRGogVaUiwwBhDm6X+NXoSppkLM0Gq+vhKp+o=;
 b=DKJatJkWjDLMnQn437rTlviw7rUhOJQ/XbvZhFO3wjscLKEV95wlmF5G3Mc3XcvFZg
 5BL+PY2YQ8s5mmhS/YbPyQAyYlOadQTyBdUcB24KnNNTC5okoE7NaKsfGM6t8Nqj0uEU
 41L+UGT/zlSvFyyHzPTSUJRh8h+HN4LanB6RjWzTsFqBcYD2X8c3SpswPlOzy4ob53AH
 6uFsLDC2dZAtfR/goAOjaS3ID4hOpaD2ZDyG3A07L5s6AaXM3stktZsx6izKbqTwMVVJ
 XLwom1dYGCvimCEag8vgeykei4RhmRaEBQZK1jqV+Dhlasv6NKDyZkvpCRgVmUNrckG5
 6qNw==
X-Gm-Message-State: AOAM530CClAUTGzhoHuDthY2U8dPtjFwCRfP22XR6DRIoCFWhhYCyc6L
 KIJRnsN5H4AXxYt1zoTCaCU=
X-Google-Smtp-Source: ABdhPJyVTsVZRLsJw2blURiyySD1R/9p+ACz4bzAtXSZ1TluTenQUUf2qHbMLf+hKfMrKCPqSgStUA==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr3989520wmh.133.1599157254594; 
 Thu, 03 Sep 2020 11:20:54 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id n4sm5716109wrp.61.2020.09.03.11.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 11:20:53 -0700 (PDT)
Subject: Re: [PATCH v8 00/14] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200825001711.1340443-1-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <735e93cd-223c-c8e3-5ebe-bad619cd94c0@amsat.org>
Date: Thu, 3 Sep 2020 20:20:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825001711.1340443-1-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 2:16 AM, Havard Skinnemoen via wrote:
> I also pushed this and the previous patchsets to my qemu fork on github.
> The branches are named npcm7xx-v[1-8].
> 
>   https://github.com/hskinnemoen/qemu
> 
> This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs to boot
> an OpenBMC image built for quanta-gsj. This includes device models for:
> 
>   - Global Configuration Registers
>   - Clock Control
>   - Timers
>   - Fuses
>   - Memory Controller
>   - Flash Controller
> 
> These modules, along with the existing Cortex A9 CPU cores and built-in
> peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in turn form
> the foundation for the quanta-gsj and npcm750-evb machines, respectively. The
> two SoCs are very similar; the only difference is that NPCM730 is missing some
> peripherals that NPCM750 has, and which are not considered essential for
> datacenter use (e.g. graphics controllers). For more information, see
> 
> https://www.nuvoton.com/products/cloud-computing/ibmc/
> 
> Both quanta-gsj and npcm750-evb correspond to real boards supported by OpenBMC.
> At the end of the series, qemu can boot an OpenBMC image built for one of these
> boards with some minor modifications.
> 
> The patches in this series were developed by Google and reviewed by Nuvoton. We
> will be maintaining the machine and peripheral support together.
> 
> The data sheet for these SoCs is not generally available. Please let me know if
> more comments are needed to understand the device behavior.

Series:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

