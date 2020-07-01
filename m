Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B11AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0136220760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0136220760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfY2-0000XH-A9
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqfWA-0006ZA-SN; Wed, 01 Jul 2020 12:23:26 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqfW7-0000DO-P3; Wed, 01 Jul 2020 12:23:26 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id AFD00BF64B;
 Wed,  1 Jul 2020 16:23:20 +0000 (UTC)
Date: Wed, 1 Jul 2020 18:23:17 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 13/18] hw/block/nvme: Set Finish/Reset Zone
 Recommended attributes
Message-ID: <20200701162317.ayl5a3ipraiu7nfo@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-14-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-14-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 12:11:05
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
> Added logic to set and reset FZR and RZR zone attributes. Four new
> driver properties are added to control the timing of setting and
> resetting these attributes. FZR/RZR delay lasts from the zone
> operation and until when the corresponding zone attribute is set.
> FZR/RZR limits set the time period between setting FZR or RZR
> attribute and resetting it simulating the internal controller action
> on that zone.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Please correct me if I am wrong here, but I want to raise a question
about the use of QEMU_CLOCK_REALTIME here. I agree that it makes sense
that the limits are "absolute", but does this hold for emulation? In my
view, when emulation is stopped, the world is stopped. Should we emulate
the need for background operations in this case? I don't think so.

> ---
>  hw/block/nvme.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/block/nvme.h | 13 ++++++-
>  2 files changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index a29cbfcc96..c3898448c7 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -201,6 +201,84 @@ static inline void nvme_aor_dec_active(NvmeCtrl *n, NvmeNamespace *ns)
>      assert(ns->nr_active_zones >= 0);
>  }
>  
> +static void nvme_set_rzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
> +{
> +    assert(zone->flags & NVME_ZFLAGS_SET_RZR);
> +    zone->tstamp = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +    zone->flags &= ~NVME_ZFLAGS_TS_DELAY;
> +    zone->d.za |= NVME_ZA_RESET_RECOMMENDED;
> +    zone->flags &= ~NVME_ZFLAGS_SET_RZR;
> +    trace_pci_nvme_zone_reset_recommended(zone->d.zslba);
> +}
> +
> +static void nvme_clear_rzr(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, bool notify)
> +{
> +    if (n->params.rrl_usec) {
> +        zone->flags &= ~(NVME_ZFLAGS_SET_RZR | NVME_ZFLAGS_TS_DELAY);
> +        notify = notify && (zone->d.za & NVME_ZA_RESET_RECOMMENDED);
> +        zone->d.za &= ~NVME_ZA_RESET_RECOMMENDED;
> +        zone->tstamp = 0;
> +    }
> +}
> +
> +static void nvme_set_fzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
> +{
> +    assert(zone->flags & NVME_ZFLAGS_SET_FZR);
> +    zone->tstamp = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +    zone->flags &= ~NVME_ZFLAGS_TS_DELAY;
> +    zone->d.za |= NVME_ZA_FINISH_RECOMMENDED;
> +    zone->flags &= ~NVME_ZFLAGS_SET_FZR;
> +    trace_pci_nvme_zone_finish_recommended(zone->d.zslba);
> +}
> +
> +static void nvme_clear_fzr(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone, bool notify)
> +{
> +    if (n->params.frl_usec) {
> +        zone->flags &= ~(NVME_ZFLAGS_SET_FZR | NVME_ZFLAGS_TS_DELAY);
> +        notify = notify && (zone->d.za & NVME_ZA_FINISH_RECOMMENDED);
> +        zone->d.za &= ~NVME_ZA_FINISH_RECOMMENDED;
> +        zone->tstamp = 0;
> +    }
> +}
> +
> +static void nvme_schedule_rzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
> +{
> +    if (n->params.frl_usec) {
> +        zone->flags &= ~(NVME_ZFLAGS_SET_FZR | NVME_ZFLAGS_TS_DELAY);
> +        zone->d.za &= ~NVME_ZA_FINISH_RECOMMENDED;
> +        zone->tstamp = 0;
> +    }
> +    if (n->params.rrl_usec) {
> +        zone->flags |= NVME_ZFLAGS_SET_RZR;
> +        if (n->params.rzr_delay_usec) {
> +            zone->tstamp = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +            zone->flags |= NVME_ZFLAGS_TS_DELAY;
> +        } else {
> +            nvme_set_rzr(n, ns, zone);
> +        }
> +    }
> +}
> +
> +static void nvme_schedule_fzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
> +{
> +    if (n->params.rrl_usec) {
> +        zone->flags &= ~(NVME_ZFLAGS_SET_RZR | NVME_ZFLAGS_TS_DELAY);
> +        zone->d.za &= ~NVME_ZA_RESET_RECOMMENDED;
> +        zone->tstamp = 0;
> +    }
> +    if (n->params.frl_usec) {
> +        zone->flags |= NVME_ZFLAGS_SET_FZR;
> +        if (n->params.fzr_delay_usec) {
> +            zone->tstamp = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +            zone->flags |= NVME_ZFLAGS_TS_DELAY;
> +        } else {
> +            nvme_set_fzr(n, ns, zone);
> +        }
> +    }
> +}
> +
>  static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
>      NvmeZone *zone, uint8_t state)
>  {
> @@ -208,15 +286,19 @@ static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
>          switch (nvme_get_zone_state(zone)) {
>          case NVME_ZONE_STATE_EXPLICITLY_OPEN:
>              nvme_remove_zone(n, ns, ns->exp_open_zones, zone);
> +            nvme_clear_fzr(n, ns, zone, false);
>              break;
>          case NVME_ZONE_STATE_IMPLICITLY_OPEN:
>              nvme_remove_zone(n, ns, ns->imp_open_zones, zone);
> +            nvme_clear_fzr(n, ns, zone, false);
>              break;
>          case NVME_ZONE_STATE_CLOSED:
>              nvme_remove_zone(n, ns, ns->closed_zones, zone);
> +            nvme_clear_fzr(n, ns, zone, false);
>              break;
>          case NVME_ZONE_STATE_FULL:
>              nvme_remove_zone(n, ns, ns->full_zones, zone);
> +            nvme_clear_rzr(n, ns, zone, false);
>          }
>     }
>  
> @@ -225,15 +307,19 @@ static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
>      switch (state) {
>      case NVME_ZONE_STATE_EXPLICITLY_OPEN:
>          nvme_add_zone_tail(n, ns, ns->exp_open_zones, zone);
> +        nvme_schedule_fzr(n, ns, zone);
>          break;
>      case NVME_ZONE_STATE_IMPLICITLY_OPEN:
>          nvme_add_zone_tail(n, ns, ns->imp_open_zones, zone);
> +        nvme_schedule_fzr(n, ns, zone);
>          break;
>      case NVME_ZONE_STATE_CLOSED:
>          nvme_add_zone_tail(n, ns, ns->closed_zones, zone);
> +        nvme_schedule_fzr(n, ns, zone);
>          break;
>      case NVME_ZONE_STATE_FULL:
>          nvme_add_zone_tail(n, ns, ns->full_zones, zone);
> +        nvme_schedule_rzr(n, ns, zone);
>          break;
>      default:
>          zone->d.za = 0;
> @@ -555,6 +641,7 @@ static void nvme_auto_transition_zone(NvmeCtrl *n, NvmeNamespace *ns,
>              zone->d.za &= ~(NVME_ZA_FINISH_RECOMMENDED |
>                              NVME_ZA_RESET_RECOMMENDED);
>              zone->d.za |= NVME_ZA_FINISHED_BY_CTLR;
> +            zone->flags = 0;
>              zone->tstamp = 0;
>              trace_pci_nvme_zone_finished_by_controller(zone->d.zslba);
>          }
> @@ -2624,6 +2711,11 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
>      n->num_zones = nz;
>      n->zone_array_size = sizeof(NvmeZone) * nz;
>  
> +    n->params.rzr_delay_usec *= SCALE_MS;
> +    n->params.rrl_usec *= SCALE_MS;
> +    n->params.fzr_delay_usec *= SCALE_MS;
> +    n->params.frl_usec *= SCALE_MS;
> +

I would prefer that user-given parameters are not changed like this.
Setting defaults for various reasons are OK, but when the meaning of the
parameter changes (like the scale), its confusing. I would suggest that
the namespace gets the set of *_usec members and the parameters are name
without the usec.

>      /* Make sure that the values of all Zoned Command Set properties are sane */
>      if (n->params.max_open_zones > nz) {
>          n->params.max_open_zones = nz;
> @@ -2651,6 +2743,8 @@ static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
>      /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
>      ns->id_ns_zoned->mar = cpu_to_le32(n->params.max_active_zones - 1);
>      ns->id_ns_zoned->mor = cpu_to_le32(n->params.max_open_zones - 1);
> +    ns->id_ns_zoned->rrl = cpu_to_le32(n->params.rrl_usec / (1000 * SCALE_MS));
> +    ns->id_ns_zoned->frl = cpu_to_le32(n->params.frl_usec / (1000 * SCALE_MS));
>      ns->id_ns_zoned->zoc = cpu_to_le16(n->params.active_excursions ? 0x2 : 0);
>      ns->id_ns_zoned->ozcs = n->params.cross_zone_read ? 0x01 : 0x00;
>  
> @@ -3012,6 +3106,11 @@ static Property nvme_props[] = {
>      DEFINE_PROP_UINT32("zone_append_max_size", NvmeCtrl, params.zamds_bs, 0),
>      DEFINE_PROP_INT32("max_active", NvmeCtrl, params.max_active_zones, 0),
>      DEFINE_PROP_INT32("max_open", NvmeCtrl, params.max_open_zones, 0),
> +    DEFINE_PROP_UINT64("reset_rcmnd_delay", NvmeCtrl, params.rzr_delay_usec, 0),
> +    DEFINE_PROP_UINT64("reset_rcmnd_limit", NvmeCtrl, params.rrl_usec, 0),
> +    DEFINE_PROP_UINT64("finish_rcmnd_delay", NvmeCtrl,
> +                       params.fzr_delay_usec, 0),
> +    DEFINE_PROP_UINT64("finish_rcmnd_limit", NvmeCtrl, params.frl_usec, 0),
>      DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
>      DEFINE_PROP_BOOL("active_excursions", NvmeCtrl, params.active_excursions,
>                       false),
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 8a0aaeb09a..be1920f1ef 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -22,6 +22,10 @@ typedef struct NvmeParams {
>      uint64_t    zone_capacity;
>      int32_t     max_active_zones;
>      int32_t     max_open_zones;
> +    uint64_t    rzr_delay_usec;
> +    uint64_t    rrl_usec;
> +    uint64_t    fzr_delay_usec;
> +    uint64_t    frl_usec;
>  } NvmeParams;
>  
>  typedef struct NvmeAsyncEvent {
> @@ -77,12 +81,19 @@ typedef struct NvmeCQueue {
>      QTAILQ_HEAD(, NvmeRequest) req_list;
>  } NvmeCQueue;
>  
> +enum NvmeZoneFlags {
> +    NVME_ZFLAGS_TS_DELAY = 1 << 0,
> +    NVME_ZFLAGS_SET_RZR  = 1 << 1,
> +    NVME_ZFLAGS_SET_FZR  = 1 << 2,
> +};
> +
>  typedef struct NvmeZone {
>      NvmeZoneDescr   d;
>      uint64_t        tstamp;
> +    uint32_t        flags;
>      uint32_t        next;
>      uint32_t        prev;
> -    uint8_t         rsvd80[8];
> +    uint8_t         rsvd84[4];
>  } NvmeZone;
>  
>  #define NVME_ZONE_LIST_NIL    UINT_MAX
> -- 
> 2.21.0
> 
> 

