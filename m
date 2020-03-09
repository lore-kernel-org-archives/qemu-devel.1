Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29C3C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A759820675
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A759820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHx6-0000FC-Tp
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBHvj-0006iP-0m
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBHvd-0004pd-TN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:54:46 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45627)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBHva-0004h8-C4; Mon, 09 Mar 2020 08:54:38 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MfqGN-1jrTQT3c4X-00gLK7; Mon, 09 Mar 2020 13:54:21 +0100
Subject: Re: [PATCH v3 07/12] display/exynos4210_fimd: Remove redundant
 statement in exynos4210_fimd_update()
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
 <20200302130715.29440-9-kuhn.chenqun@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c9ecbec0-981b-2a57-690f-3c8d8150fc49@vivier.eu>
Date: Mon, 9 Mar 2020 13:54:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302130715.29440-9-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eeOWQ4eBNfEWXijBCegNKXvqQZoMQytCQ7p0ooIqDonFTm0pNHm
 Sc4lnKyQaCtL7hO0S2KLK/e8R0wUhWpaNTqqxMBHT63dQ8uyzg86bDO+2Y48/6/qYiEyxuL
 jug4zPy1bCUQNcRMyaQt3j+s3YBF43A78EomUOoOtW7em8ApPgL0jBpWLHIaH0hjlFlsiKH
 B9oMk1eRrm0a+vSTd5+Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2QmUTetGIc0=:DG/UkHPtUkEXEjDa19HgfC
 8P9SA1l4uba9SI1kEz5AdZzcA1x47JilHbu+ZZwGhLbbVAF7a16YxxFcAwr/19TadqDcAQzjs
 Gy/zcm7MLdnDEAOsez4kHqZsfyLmLQXfKmFoF0Zftr6ptzTUVosQ5LvEVM3XQgN2xOvz+20U8
 6FLC6lv0dZC7heBwN7iaRN/OFGUqgz3wU6iq15VrNlE8GonoDC6I7KuD6P6hZwPx4acdTARh5
 WiaOcMalcZCAQjc9rgNtLZpYktdAjy5l5DnMc+cozyOeM3jAvcoebWw9mnoi4LcSTXw68F5Hd
 wTwzSqGmGvXiRBxSUG0362efH3TCKNqWc/61MOBCglf4TaoD5wlA4vaAI3HP1kgFyatRTDNxD
 DmOdr61l0a6e5KRyWZfMxdkdMaeV0YY7elGUsg06wlZ5ug0xHI3LNzvoXm/ml9MPG+dempOtm
 YA9wh1uZ1iYinz6ukP+jXDU7ayasYRx/gkZhfCkm4Gl4jwZXcb2TaCBNa+Ld/zU+WpVujniTE
 Z8s69dC68UG1yBYIxBBm3wBeUU+dUl1yw0fYKMTuTbz6yBgOVI8FRBIa97nbgqcunuePVAQM1
 gGhE3CCXGP5iGj/+jC7J9LNLatFf4+Xq+rACA+jys8dl9LgCp0s4sWamrNAHWMzH58A2rSwmY
 0WnSHPLpiidGLVu8t1BEixBXyOSfdt2DXj2Oo0BiUwbixJez7Jm6okYKDYBqiT+LELEhGoyS2
 1mLvkmlpLW/wiTOtIgZyS7rj2bIaEhWBufRG4CxbKIhat0xh+3WcGb1bnDERAt50ejf8n55SQ
 U76xlD2H0hbYPZxhFu/KLoiW2W9bliW/XgBa2O1hlbE6V4kGRG/gtOMsgGtQDplTkMDxPFO
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, peter.maydell@linaro.org,
 zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/03/2020 à 14:07, Chen Qun a écrit :
> Clang static code analyzer show warning:
> hw/display/exynos4210_fimd.c:1313:17: warning: Value stored to 'is_dirty' is never read
>                 is_dirty = false;
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/display/exynos4210_fimd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
> index c1071ecd46..05d3265b76 100644
> --- a/hw/display/exynos4210_fimd.c
> +++ b/hw/display/exynos4210_fimd.c
> @@ -1310,7 +1310,6 @@ static void exynos4210_fimd_update(void *opaque)
>                  }
>                  host_fb_addr += inc_size;
>                  fb_line_addr += inc_size;
> -                is_dirty = false;
>              }
>              g_free(snap);
>              blend = true;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

