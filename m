Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6E7C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398332171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="L3lfeq0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398332171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAD12-0001q4-AY
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iACy6-0000dK-Ap
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iACy4-0003rD-VE
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:52:30 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:45054)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iACy1-0003pB-P1; Tue, 17 Sep 2019 08:52:26 -0400
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id D092E96F50;
 Tue, 17 Sep 2019 12:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1568724743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82KG3T8RmQqxzA6umtmQhxyhHb4oDgZYrD7nSRrpadM=;
 b=L3lfeq0dgDhj9ITGpVYuiruOwAC3akojCewImp0v/48r94bfO1nICDQgCrPnETNloOp7/s
 ELwksHGIzxDhF221JN7yJL4DB+h0MeYBeAhZdyFcTJ25a1lWAF8CW7Fhg3zQRcaTV1P3Zt
 xJy4w1/cB+F6HNEwjpu7C3pMq58AUtI=
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190912110103.1417887-1-luc.michel@greensocs.com>
 <CAFEAcA-WO=O5zwRDQoNz2zT4sx61j8Jy5px0uFPiWgF_JUpa+A@mail.gmail.com>
 <204007b1-1c1e-432b-399f-b3784f812710@greensocs.com>
 <c3a22836-0435-e09b-6fe0-eff85124c0ca@greensocs.com>
 <CAFEAcA8b1XUpwq-NefVL+BD0bNfDu6Rhxygbb3mfyV1t17NZUQ@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <10f1309a-f788-7164-bc9e-51f5ecc7e841@greensocs.com>
Date: Tue, 17 Sep 2019 14:52:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8b1XUpwq-NefVL+BD0bNfDu6Rhxygbb3mfyV1t17NZUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1568724744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82KG3T8RmQqxzA6umtmQhxyhHb4oDgZYrD7nSRrpadM=;
 b=I2yT6SLoa0Hm14BB+NXHq2dAmcNmzvzTF7nPXo9IHsiuLvInH9Kaikl5Muo//bZajEpT8k
 aj+XbL0GH2P/nHJ0ctVCVuMnqCa1YKW39K6TV8fAfmZmdybAMTEfbUZOpUSF1+/Amxvt+p
 X9CnkDDc93sSYQuc4m0Fufrq0WU1tsA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1568724744; a=rsa-sha256; cv=none;
 b=KEIk5SOVjne0j1fH6pW1tCQh5dukDCFhNnwfTBr1sFLKB7cfUaxptYuGcaV4pxuXAPPscP
 tmJUujcgcXH89r/lQBWt7t0PpRRNnqKAUj3ZbKxRYPr/1B0Wlwjmi7vzjqk898I6KK0G5Q
 pxNuNYVvQHeoYtQfZBMV6fZM2djk5ps=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH] target/arm: fix CBAR register for AArch64
 CPUs
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/17/19 12:56 PM, Peter Maydell wrote:
> On Tue, 17 Sep 2019 at 09:43, Luc Michel <luc.michel@greensocs.com> wrote:
>>
>> On 9/13/19 9:26 AM, Luc Michel wrote:
>>> Hi Peter,
>>>
>>> On 9/12/19 6:03 PM, Peter Maydell wrote:
>>>> I think we need to check through the TRMs to confirm which CPUs use
>>>> which format for the CBAR, and have a different feature bit for the
>>>> newer format/sysreg encoding, so we can provide the right sysregs for
>>>> the right cores.
>>> I checked all the AArch64 Cortex's TRMs, for those having a PERIPHBASE
>>> signal and CBAR register (namely Cortex-A53, 57, 72, 73), they all match
>>> the mapping I put in this patch, so I think we don't need to split the
>>> CBAR feature further. I believe more recent Cortex's address the GIC
>>> using coprocessor registers, and CBAR does not exist in those ones.
>>
>> Hi Peter,
>>
>> Do you want me to re-roll this patch with some modifications?
> 
> No, that's OK. Thanks for checking the TRMs. I think what I'll
> do is squash in this comment to the patch:
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 755aa18a2dc..bc1130d989d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6733,6 +6733,19 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      }
> 
>      if (arm_feature(env, ARM_FEATURE_CBAR)) {
> +        /*
> +         * CBAR is IMPDEF, but common on Arm Cortex-A implementations.
> +         * There are two flavours:
> +         *  (1) older 32-bit only cores have a simple 32-bit CBAR
> +         *  (2) 64-bit cores have a 64-bit CBAR visible to AArch64, plus a
> +         *      32-bit register visible to AArch32 at a different encoding
> +         *      to the "flavour 1" register and with the bits rearranged to
> +         *      be able to squash a 64-bit address into the 32-bit view.
> +         * We distinguish the two via the ARM_FEATURE_AARCH64 flag, but
> +         * in future if we support AArch32-only configs of some of the
> +         * AArch64 cores we might need to add a specific feature flag
> +         * to indicate cores with "flavour 2" CBAR.
> +         */
>          if (arm_feature(env, ARM_FEATURE_AARCH64)) {
>              /* 32 bit view is [31:18] 0...0 [43:32]. */
>              uint32_t cbar32 = (extract64(cpu->reset_cbar, 18, 14) << 18)
> 
> 
> and apply it to target-arm.next, if that's OK with you.
Yes sure!

Thanks.

-- 
Luc

> 
> thanks
> -- PMM
> 

