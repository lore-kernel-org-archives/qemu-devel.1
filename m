Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB7FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3526C206DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3526C206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUmF-0006H3-DL
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jsUbv-0000Se-LO; Mon, 06 Jul 2020 13:08:55 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jsUbt-0007Wq-Ph; Mon, 06 Jul 2020 13:08:55 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MVrXh-1kJgfw17YL-00RppO; Mon, 06 Jul 2020 19:08:45 +0200
Subject: Re: [PATCH 2/2] hw/sd/pxa2xx_mmci: Trivial simplification
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200705213350.24725-1-f4bug@amsat.org>
 <20200705213350.24725-3-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c711e521-9810-051c-685a-4dc9ebb0e762@vivier.eu>
Date: Mon, 6 Jul 2020 19:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200705213350.24725-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LN1cSYce+q3esnVBtfcXPwIY85FVC+jrhwOLtVmGU7ZVe8rZUzF
 wntzhU38qx54l6bXjk/munWVe1bF+Xfpy73dSerAR3eRaLa3YDDvDny6a1EuoWHra5HGKLj
 rkO4PfY4P5DiEfgFH67V1zPJSG+6Seidko7auLQFHeEhwkg8NAKeO+Ayss+Prrgi925bxl8
 ExOX5LNcG2Fph5c8q+LCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1kQ3JPU3D8k=:Mf05seMfgZbAUswsuo745s
 RF1q5dqWQ214116pe/5QHCeJbss2hFmn8NkKtiA6KkDpnOy7x5Pq7qQ6WWjCc5lL0nkA9zZQt
 y7RC/Z3nyrST1UbkhgYSAOTpxI4XLkrKI802iuWrmlVfWgXeQhOP5R/1Y0r/RhSx8bK1Yv3kO
 SMyetxRCqf9h6WeT2NcXcAKnkQGwhIlZx77p1chaSuf7UiEBz2qZCv026uNNB5qQn7orzZEv2
 cdr4H8i1c8DjGYgxW/woQZgm/mJTYB1bou7exjsQXuriF5ewfJzR3Kkw+BItqyQONbPWMn7xt
 5xp8QtoGSwppwd4X8yplHrBCowXYkBq+lAuVShvUMvyyT0YiLIxP1splb1IWp3AtGcrLi+ZCr
 i345hKRBq4kBtVjsUMjTo+tu0cUTmrz82mFOBLgls7QEDE0PFVLSSJOlaADWC7wcoMTBf/M0J
 1BvAPtiC6GstKq6Sc/rxXvyLBbyU+WMo0jUFnAWz0lSrHgasrb1qg6kyCuyQK7cUL2WDVSj5V
 isNND3urkZXZtz3vpJBMtJLaxcu1DEImpSifgaw2oq7iGmtGHD5rj15cZcnzIli3tG6DvHPD8
 F41Z6/ybEzw3+RelD990+lLQfMWyKdyDptLms4/wjYEib2Pu9I3cHZiYpAzCuSEh0+a4dCKiP
 I7/Tdfr/0xLdVPAPvnbiPKJ8O+zmI4oC5Wp6IbxfdccwY8x9Ab32Vt0wZhl0458Y3iD3e2Wl5
 idfu2tlglil3pPDY1y0Wbi9qt2n4o7xhSnkvcSOjug6UysiQ2/yabgYN79oasYZe96brS9rur
 +ZmaqNiBI5LUX2HJLh/x+2TgSLbTuKLUdlaYwkr552ssjZ+CDmgoVIALy0V3gOVqVeOqwvA
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:31:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 05/07/2020 à 23:33, Philippe Mathieu-Daudé a écrit :
> Avoid declaring PXA2xxMMCIState local variable, return it directly.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/sd/pxa2xx_mmci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
> index 9482b9212d..2996a2ef17 100644
> --- a/hw/sd/pxa2xx_mmci.c
> +++ b/hw/sd/pxa2xx_mmci.c
> @@ -480,10 +480,8 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
>  {
>      DeviceState *dev;
>      SysBusDevice *sbd;
> -    PXA2xxMMCIState *s;
>  
>      dev = qdev_new(TYPE_PXA2XX_MMCI);
> -    s = PXA2XX_MMCI(dev);
>      sbd = SYS_BUS_DEVICE(dev);
>      sysbus_mmio_map(sbd, 0, base);
>      sysbus_connect_irq(sbd, 0, irq);
> @@ -491,7 +489,7 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
>      qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
>      sysbus_realize_and_unref(sbd, &error_fatal);
>  
> -    return s;
> +    return PXA2XX_MMCI(dev);
>  }
>  
>  static void pxa2xx_mmci_set_inserted(DeviceState *dev, bool inserted)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

