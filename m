Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5373CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 06:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CAC2074D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 06:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CAC2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqVzo-0002wV-Bg
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 02:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqVzA-0002R9-TB; Wed, 01 Jul 2020 02:12:44 -0400
Received: from charlie.dont.surf ([128.199.63.193]:49196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqVz8-0008JV-He; Wed, 01 Jul 2020 02:12:44 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 6A1B3BF5E4;
 Wed,  1 Jul 2020 06:12:39 +0000 (UTC)
Date: Wed, 1 Jul 2020 08:12:36 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 12/18] hw/block/nvme: Simulate Zone Active excursions
Message-ID: <20200701061236.mc7d2jq2fqai7hz7@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-13-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-13-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 02:12:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 18 06:34, Dmitry Fomichev wrote:
> Added a Boolean flag to turn on simulation of Zone Active Excursions.
> If the flag, "active_excursions", is set to true, the driver will try
> to finish one of the currently open zone if max active zones limit is
> going to get exceeded.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c | 24 +++++++++++++++++++++++-
>  hw/block/nvme.h |  1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 05a7cbcfcc..a29cbfcc96 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -540,6 +540,26 @@ static void nvme_auto_transition_zone(NvmeCtrl *n, NvmeNamespace *ns,
>  {
>      NvmeZone *zone;
>  
> +    if (n->params.active_excursions && adding_active &&
> +        n->params.max_active_zones &&
> +        ns->nr_active_zones == n->params.max_active_zones) {
> +        zone = nvme_peek_zone_head(ns, ns->closed_zones);
> +        if (zone) {
> +            /*
> +             * The namespace is at the limit of active zones.
> +             * Try to finish one of the currently active zones
> +             * to make the needed active zone resource available.
> +             */
> +            nvme_aor_dec_active(n, ns);
> +            nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_FULL);
> +            zone->d.za &= ~(NVME_ZA_FINISH_RECOMMENDED |
> +                            NVME_ZA_RESET_RECOMMENDED);
> +            zone->d.za |= NVME_ZA_FINISHED_BY_CTLR;
> +            zone->tstamp = 0;
> +            trace_pci_nvme_zone_finished_by_controller(zone->d.zslba);
> +        }
> +    }

Open Zones should also be considered for excursions.

> +
>      if (implicit && n->params.max_open_zones &&
>          ns->nr_open_zones == n->params.max_open_zones) {
>          zone = nvme_remove_zone_head(n, ns, ns->imp_open_zones);
> @@ -2631,7 +2651,7 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
>      /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
>      ns->id_ns_zoned->mar = cpu_to_le32(n->params.max_active_zones - 1);
>      ns->id_ns_zoned->mor = cpu_to_le32(n->params.max_open_zones - 1);
> -    ns->id_ns_zoned->zoc = 0;
> +    ns->id_ns_zoned->zoc = cpu_to_le16(n->params.active_excursions ? 0x2 : 0);
>      ns->id_ns_zoned->ozcs = n->params.cross_zone_read ? 0x01 : 0x00;
>  
>      ns->id_ns_zoned->lbafe[lba_index].zsze = cpu_to_le64(n->params.zone_size);
> @@ -2993,6 +3013,8 @@ static Property nvme_props[] = {
>      DEFINE_PROP_INT32("max_active", NvmeCtrl, params.max_active_zones, 0),
>      DEFINE_PROP_INT32("max_open", NvmeCtrl, params.max_open_zones, 0),
>      DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
> +    DEFINE_PROP_BOOL("active_excursions", NvmeCtrl, params.active_excursions,
> +                     false),
>      DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index f5a4679702..8a0aaeb09a 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -15,6 +15,7 @@ typedef struct NvmeParams {
>  
>      bool        zoned;
>      bool        cross_zone_read;
> +    bool        active_excursions;
>      uint8_t     fill_pattern;
>      uint32_t    zamds_bs;
>      uint64_t    zone_size;
> -- 
> 2.21.0
> 
> 

