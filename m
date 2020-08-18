Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA1AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477762067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru4YzcwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477762067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k85AK-0001xf-Ff
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 13:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k859T-0001Rj-D7; Tue, 18 Aug 2020 13:11:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k859R-0003WX-Ej; Tue, 18 Aug 2020 13:11:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id p20so18996045wrf.0;
 Tue, 18 Aug 2020 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=89Ya1G82ttHBMxT+sgvboULy8nqJ5rraDTldpVrBBJs=;
 b=Ru4YzcwOcEq1BiCsGSu8Eo8Zs9GhtB/XdLtcNLY3CehQO9UIjRV5l+1BMIevMkQnqf
 L+y4GzuE2qVjMfh5q2NJwRQmLlgliZpaQAztx46R0exsHZ4jIj72DgBi+VvW7w8C8DpG
 b4HVYvGtXdKzzhFnYnUTVLvD7oyAJ4iBEtqatLwVbMLqVSWPIFzJlbU4yaRtSl6i4CwA
 /ecRCUUR9OaqyyMLY5baRCLvVY302Ky674Js1vYw4kyDyn2j3C2DGBqj9PqsFVT09KVc
 daqA1fotmhmetc7iq/3+Svg22LQEg9pPZkN/wXzTr5JDEXrousYsgMYed3m+olj+qgGm
 1Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=89Ya1G82ttHBMxT+sgvboULy8nqJ5rraDTldpVrBBJs=;
 b=nq8GTJDCa4jj0bqHW353lE8X6qysDT6rI1xHooEmZ3TmKuiK44mOVhhZ7pUm+Nynvv
 3DKhlB4O8dV0K+Vh30Bf2G2IRmu4+K6vUkwRyzmQrhspB9q11fQUoMunCb4zzhBek5w7
 SpOgVnKn9/IjAFhxtquDsSnaZ7Zy2a0ietFD27uGS6aNW3N1EbAQbY70+bfODldxDTMX
 2Vcg95tdzS1q6bz59yxM5UIGYJvYk+So35413AIDmA0exX6401CtsUnpeDgX9CSH9Qj6
 xnVON2MQaTgFwfsGE4qNVyP1+zIMKNpcousxF0AQrp5Bz/r2vMdxh17EGfahrsGSe293
 O99g==
X-Gm-Message-State: AOAM531P6Zc2zM8hUHOi72KX0qb0ue78ZXuFv1dGPbRATUcmLRX4aci5
 xHTR4LH8H2scwtP6o5g0gaM=
X-Google-Smtp-Source: ABdhPJxclsoz/XiaFvK1HrVkMMCY2G/nrkqvrEiKdO/m0lo2t7JLW6aHaircmDiEPgwSamhN7L3nTA==
X-Received: by 2002:a05:6000:124c:: with SMTP id
 j12mr230633wrx.83.1597770715380; 
 Tue, 18 Aug 2020 10:11:55 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o2sm724296wmh.5.2020.08.18.10.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 10:11:54 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] hw/sd: Add Cadence SDHCI emulation
To: Bin Meng <bmeng.cn@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
References: <1597658722-12922-1-git-send-email-bin.meng@windriver.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6c5689ac-46b5-dd07-0365-61fa149faad4@amsat.org>
Date: Tue, 18 Aug 2020 19:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597658722-12922-1-git-send-email-bin.meng@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Sai Pavan for patches 1 and 2.

On 8/17/20 12:05 PM, Bin Meng wrote:
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

