Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C389C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1446320758
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMFpZnnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1446320758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ow7-0005jZ-1l
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8ovS-0005FK-PO; Thu, 20 Aug 2020 14:04:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8ovQ-0006md-Sk; Thu, 20 Aug 2020 14:04:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id 9so2512594wmj.5;
 Thu, 20 Aug 2020 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WJ3qcV357N/eYozDtF6/HSPKNKpo/fz9ueYEXIqvI84=;
 b=vMFpZnnz2yVsklpdcCXHFJDhe2LYR+q8exXwRBxX2UsFzPo4N7cXVFPUs0WGBtzkX1
 ygiPx0BeYxB49O78h94gon9TxwmE8pU7eZyx7df11RzWVf24MA3NmIaJQbNO8dqif0OY
 BrWrAoD/5WVbeo4lLyy2bPd2pMvHrCg3Ink1ZdCEGr4HSevGfbqq+zPP5Aih1DujvhVp
 z9YSJOQvkv3ty6JHl1QtVr6Gli7rGePzKtRC8aLxmn62HE1R+iHMZTzbSLFqYSQb+4TS
 G1Th03jPmLBVZA+9th6N8fWORliu3/Jr30MUnCLM2sd63Nf5eXPIGQ9W6aVpOWFQPsbr
 cteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WJ3qcV357N/eYozDtF6/HSPKNKpo/fz9ueYEXIqvI84=;
 b=cW0lZzjQsQB1rHuu6QsM8J8cGcHRQ6ClLbRQDWMNexpe6+jEguMUIZwQpolU1XitRm
 D2NlhYqXQmyGW5zDha3fULZUVd1rP339JmH0vCxfi+eArxOwZiYao/QCO4yr6i+koM9M
 zRteIWpbkjLeTloGfZw7iVJN6Uubt1zhy1BNNVPckcbtESBuiE579XABY2Emot7WIk5f
 qS5CvBIlrfgSIGJDOFxMNemD50+5N8jCCwAtQ4qrrLP8l/R7w535qSWsgd1T4lgkf1m2
 s84Drnz3AIgX5qBhBerMe+DzyHvbJYyrB6DgmHydKk52fQeE5r1hCyu25rglBwHKft2T
 AEkQ==
X-Gm-Message-State: AOAM5308VJONi7PFlOvwoOg6Y6byDYZ8Qkhdzk81Hyxzp58paXSviATq
 7wyydroHEeBT13yrqShGCkHpsGLC53Y=
X-Google-Smtp-Source: ABdhPJzTVGjS7Hiu8vrrwplYo4Bnj4yL7MnPrs1g3tmwHCdtd/3I5RoEDEfGHEnECKwawYRLzAunpw==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr38628wme.46.1597946670792;
 Thu, 20 Aug 2020 11:04:30 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b129sm5403909wmb.29.2020.08.20.11.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 11:04:29 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] hw/sd: Add Cadence SDHCI emulation
To: qemu-devel@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
References: <1597658633-12802-1-git-send-email-bin.meng@windriver.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d57faf7d-3cfa-55ac-649b-59ca06dd11a8@amsat.org>
Date: Thu, 20 Aug 2020 20:04:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597658633-12802-1-git-send-email-bin.meng@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sai Pavan, you said you were interested to test the first 2
patches. FYI I plan to queue them and send the pull request tomorrow
or Saturday the latest.

On 8/17/20 12:03 PM, Bin Meng wrote:
> This series is spun off from the following series as it is hw/sd
> centric, so that it can be picked up separately by Philippe.
> 
> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=195648
> 
> This series fixed 2 SD card issues, and added a new model for
> Cadence SDHCI controller.
> 
> Patch "[09/18] hw/sd: sdhci: Make sdhci_poweron_reset() internal visible"
> in this series per the review comments.
> 
> Changes in v2:
> - remove the pointless zero initialization
> - fix SDSC size check in sd_set_csd() too
> - use 's' for the model state
> - call device_cold_reset() in cadence_sdhci_reset()
> - add .impl in cadence_sdhci_ops
> - move Cadence specific register defines to cadence_sdhci.c
> - use 'sdhci' instead of 'slot' to represent SDHCIState
> - use sysbus_mmio_get_region() to access SDHCI model's memory region
> - initialize TYPE_SYSBUS_SDHCI in the instance_init() so that users
>   of Cadence SDHCI do not have to do that themselves
> - propergate irq and 'sd-bus' from generic-sdhci
> 
> Bin Meng (3):
>   hw/sd: sd: Fix incorrect populated function switch status data
>     structure
>   hw/sd: sd: Correct the maximum size of a Standard Capacity SD Memory
>     Card
>   hw/sd: Add Cadence SDHCI emulation
> 
>  hw/sd/Kconfig                 |   4 +
>  hw/sd/Makefile.objs           |   1 +
>  hw/sd/cadence_sdhci.c         | 200 ++++++++++++++++++++++++++++++++++++++++++
>  hw/sd/sd.c                    |   9 +-
>  include/hw/sd/cadence_sdhci.h |  46 ++++++++++
>  5 files changed, 257 insertions(+), 3 deletions(-)
>  create mode 100644 hw/sd/cadence_sdhci.c
>  create mode 100644 include/hw/sd/cadence_sdhci.h
> 

