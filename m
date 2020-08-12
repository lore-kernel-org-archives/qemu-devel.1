Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E3DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C0520774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C0520774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uaD-0001Od-Q2
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1k5uZH-0000qZ-J8; Wed, 12 Aug 2020 13:29:39 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:37775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1k5uZF-0002GT-Hw; Wed, 12 Aug 2020 13:29:39 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M7auL-1k2uQ81ncj-0085NJ; Wed, 12 Aug 2020 19:29:29 +0200
Subject: Re: [PATCH v2 2/2] spapr/nvram: Error out if NVRAM cannot contain all
 -prom-env data
To: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>
References: <159725212173.104309.6136813383848717434.stgit@bahia.lan>
 <159725213748.104309.14834084670144632611.stgit@bahia.lan>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a3b37d03-b8e5-fc1c-7988-4f71cb19c090@vivier.eu>
Date: Wed, 12 Aug 2020 19:29:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159725213748.104309.14834084670144632611.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ppYln+lQJLwjJ9DhXeJbhC2jN50NLOGoy0x7nnyyftv+9dfd/79
 m3o4Yogvz4uqjXv3K2cTZdKr1YVWTf7d+N0I5GW4xqZLFNRx3l47S+SVMpBbdHWISdi8eQF
 L7nMw+Tv+Exo+0HaQkgnZZYj2GK0hAqawviatVZPXFt0V1OchXhTULpDpBKZm/ONxmMVfyw
 amo+kva1Scpo/WaFJXK4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RwsuK8n4pZc=:SW6stiKTn5KhJ8wXoNyUXD
 QdK6xl9uFyTAfwlMtEMmgYnesYSHz83v7sYJHLYCAEgFoJCkAfVze82mrzqxTh7JjFNzh79Pq
 AThGYR7CkvmMTOERMWhlN3YwJiJHlwZ5HBNdwlRNw5NZvO0KROD4uEjf1YNy7ytufyLRUR/En
 w5sRxwwtvesc+har4xi3/LOwkiEM5t4Mos0vdRwDVhnXQkgBEE7CxXlxVka0WXfnYgyJo7Mq4
 4jct9kGlZ524gVbBUhM9koqx85z1xiPsnXgP48ylxVCSDj58B27S6tVimhAI4GgCKnEy6bhKC
 tbxgf8VubFZNg1UO7uw+2UB01VFv7tjJdxpDaXALwjEKp/54BscfFLC9m8CPO7SvLZ6LBxxJd
 DvGbl+jDfmAQcK5Xi+LYrLgyHNG31bUwCYiBzUEwi1KEaP0YpXuCAlcG2dOIVG5+8SZ8PogPY
 lqzXnwwUTTE4ijqCQqZ2COcQh7ital/kWTTH/YUVC50DuE9MpiUL0cDJ4JcDUQfNIXi6aQ38u
 NZAU5pwVKznXV52kiGtkIEJ03mZFwuFuYjD+i8KdgguP3/IrURGGo5TPBqfdfuNgjsxlkX0bu
 04quizg1j6LFMkUtkINZ1iHEyyIEZIkooptdz2SUUArfRml9laa/poICRPNKstMusfleTXWEE
 QZRK7pxDrzt8OawsAtw1scQIpFpcAyDNBrEW1InA0kLsPoc1GPXUddIfJrXwra+Gfsd56Ron8
 0DWWoQksOng9ZxBwih6m/yZK8/bPb70nUtw4ycPZgWAKO7nSDt+gbcKSqE7riEORNEckTVC/1
 iByqveWdwdrbnxVOwtdUJ6gtAQZKl5932hYH4eecivBFg+SA5UIMgjy57TNIFH8Ck1Al5lH
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 13:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/08/2020 à 19:08, Greg Kurz a écrit :
> Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
> support the -prom-env parameter"), pseries machines can pre-initialize
> the "system" partition in the NVRAM with the data passed to all -prom-env
> parameters on the QEMU command line.
> 
> In this cases it is assumed that all the data fits in 64 KiB, but the user
> can easily pass more and crash QEMU:
> 
> $ qemu-system-ppc64 -M pseries $(for ((x=0;x<128;x++)); do \
>   echo -n " -prom-env "$(for ((y=0;y<1024;y++)); do echo -n x ; done) ; \
>   done) # this requires ~128 Kib
> malloc(): corrupted top size
> Aborted (core dumped)
> 
> Call chrp_nvram_create_system_partition() first, with its recently added
> parameter dry_run set to true, in order to know the required size and fail
> gracefully if it's too small.

Why do you need the dry_run parameter?
Can't you fail on the normal case?

Thanks,
Laurent

> 
> Reported-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/nvram/spapr_nvram.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> index 992b818d34e7..c29d797ae1f0 100644
> --- a/hw/nvram/spapr_nvram.c
> +++ b/hw/nvram/spapr_nvram.c
> @@ -145,6 +145,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, SpaprMachineState *spapr,
>  
>  static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      SpaprNvram *nvram = VIO_SPAPR_NVRAM(dev);
>      int ret;
>  
> @@ -187,6 +188,20 @@ static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
>              return;
>          }
>      } else if (nb_prom_envs > 0) {
> +        int len = chrp_nvram_create_system_partition(nvram->buf,
> +                                                     MIN_NVRAM_SIZE / 4,
> +                                                     true);
> +
> +        /* Check the partition is large enough for all the -prom-env data */
> +        if (nvram->size < len) {
> +            error_setg(errp, "-prom-env data requires %d bytes but spapr-nvram "
> +                       "is only %d bytes in size", len, nvram->size);
> +            error_append_hint(errp,
> +                              "Try to pass %d less bytes to -prom-env.\n",
> +                              len - nvram->size);
> +            return;
> +        }
> +
>          /* Create a system partition to pass the -prom-env variables */
>          chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZE / 4,
>                                             false);
> 
> 


