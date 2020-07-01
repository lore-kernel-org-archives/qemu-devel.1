Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14295C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0CA2073E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0CA2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqbAj-0001Fq-4U
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 07:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqbA1-0000mf-St; Wed, 01 Jul 2020 07:44:17 -0400
Received: from charlie.dont.surf ([128.199.63.193]:49636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqb9y-0001qE-7l; Wed, 01 Jul 2020 07:44:17 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id E2C74BF64B;
 Wed,  1 Jul 2020 11:44:11 +0000 (UTC)
Date: Wed, 1 Jul 2020 13:44:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 14/18] hw/block/nvme: Generate zone AENs
Message-ID: <20200701114408.zzgnjduvxopto5wj@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-15-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617213415.22417-15-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 07:44:12
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
> Added an optional Boolean "zone_async_events" property to the driver.
> Once it's turned on, the namespace will be sending "Zone Descriptor
> Changed" asynchronous events to the host in particular situations
> defined by the protocol. In order to clear these AENs, the host needs
> to read the newly added Changed Zones Log.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

This was a tough review ;)


  * I don't like the monkey patching of the completion queue path to
    handle AERs and it took me way too much time to figure out what was
    going on with the extra timer_mod's on the cq->timer.

    Please consider taking a look at

      https://github.com/birkelund/qemu/commit/928a6ead98ba3b0a293d90496c3fa54d51a052a5

    which is already reviewed and gets AERs right I think. But if my
    v1.3 series are merged, that will be in-tree anyway.

  * Handling the RRL and FRL delays and limits can be handled using a
    single timer like I'm doing here in my version of the ZNS
    emulation:

      https://github.com/birkelund/qemu/blob/for-master/nvme/hw/block/nvme-ns.c#L52

    This is infinitely more efficient since it removes the need for
    continuously kicking the event loop every 10ms. And this patch
    *really* needs to get get rid of that polling ;)


More comments inline.


> ---
>  hw/block/nvme.c      | 300 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/block/nvme.h      |  13 +-
>  include/block/nvme.h |  23 +++-
>  3 files changed, 328 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index c3898448c7..b9135a6b1f 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -201,12 +201,66 @@ static inline void nvme_aor_dec_active(NvmeCtrl *n, NvmeNamespace *ns)
>      assert(ns->nr_active_zones >= 0);
>  }
>  
> +static bool nvme_complete_async_req(NvmeCtrl *n, NvmeNamespace *ns,
> +    enum NvmeAsyncEventType type, uint8_t info)
> +{
> +    NvmeAsyncEvent *ae;
> +    uint32_t nsid = 0;
> +    uint8_t log_page = 0;
> +
> +    switch (type) {
> +    case NVME_AER_TYPE_ERROR:
> +    case NVME_AER_TYPE_SMART:
> +        break;
> +    case NVME_AER_TYPE_NOTICE:
> +        switch (info) {
> +        case NVME_AER_NOTICE_ZONE_DESCR_CHANGED:
> +            log_page = NVME_LOG_ZONE_CHANGED_LIST;
> +            nsid = ns->nsid;
> +            if (!(n->ae_cfg & NVME_AEN_CFG_ZONE_DESCR_CHNGD_NOTICES)) {
> +                trace_pci_nvme_zone_ae_not_enabled(info, log_page, nsid);
> +                return false;
> +            }
> +            if (ns->aen_pending) {
> +                trace_pci_nvme_zone_ae_not_cleared(info, log_page, nsid);
> +                return false;
> +            }
> +            ns->aen_pending = true;
> +        }
> +        break;
> +    case NVME_AER_TYPE_CMDSET_SPECIFIC:
> +    case NVME_AER_TYPE_VENDOR_SPECIFIC:
> +        break;
> +    }
> +
> +    ae = g_malloc0(sizeof(*ae));
> +    ae->res = type;
> +    ae->res |= (info << 8) & 0xff00;
> +    ae->res |= (log_page << 16) & 0xff0000;
> +    ae->nsid = nsid;
> +
> +    QTAILQ_INSERT_TAIL(&n->async_reqs, ae, entry);
> +    timer_mod(n->admin_cq.timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> +    return true;
> +}
> +
> +static inline void nvme_notify_zone_changed(NvmeCtrl *n, NvmeNamespace *ns,
> +    NvmeZone *zone)
> +{
> +    if (n->ae_cfg) {
> +        zone->flags |= NVME_ZFLAGS_AEN_PEND;
> +        nvme_complete_async_req(n, ns, NVME_AER_TYPE_NOTICE,
> +                                NVME_AER_NOTICE_ZONE_DESCR_CHANGED);
> +    }
> +}
> +
>  static void nvme_set_rzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
>  {
>      assert(zone->flags & NVME_ZFLAGS_SET_RZR);
>      zone->tstamp = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      zone->flags &= ~NVME_ZFLAGS_TS_DELAY;
>      zone->d.za |= NVME_ZA_RESET_RECOMMENDED;
> +    nvme_notify_zone_changed(n, ns, zone);
>      zone->flags &= ~NVME_ZFLAGS_SET_RZR;
>      trace_pci_nvme_zone_reset_recommended(zone->d.zslba);
>  }
> @@ -215,10 +269,14 @@ static void nvme_clear_rzr(NvmeCtrl *n, NvmeNamespace *ns,
>      NvmeZone *zone, bool notify)
>  {
>      if (n->params.rrl_usec) {
> -        zone->flags &= ~(NVME_ZFLAGS_SET_RZR | NVME_ZFLAGS_TS_DELAY);
> +        zone->flags &= ~(NVME_ZFLAGS_SET_RZR | NVME_ZFLAGS_TS_DELAY |
> +                         NVME_ZFLAGS_AEN_PEND);
>          notify = notify && (zone->d.za & NVME_ZA_RESET_RECOMMENDED);
>          zone->d.za &= ~NVME_ZA_RESET_RECOMMENDED;
>          zone->tstamp = 0;
> +        if (notify) {
> +            nvme_notify_zone_changed(n, ns, zone);
> +        }
>      }
>  }
>  
> @@ -228,6 +286,7 @@ static void nvme_set_fzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
>      zone->tstamp = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      zone->flags &= ~NVME_ZFLAGS_TS_DELAY;
>      zone->d.za |= NVME_ZA_FINISH_RECOMMENDED;
> +    nvme_notify_zone_changed(n, ns, zone);
>      zone->flags &= ~NVME_ZFLAGS_SET_FZR;
>      trace_pci_nvme_zone_finish_recommended(zone->d.zslba);
>  }
> @@ -236,13 +295,61 @@ static void nvme_clear_fzr(NvmeCtrl *n, NvmeNamespace *ns,
>      NvmeZone *zone, bool notify)
>  {
>      if (n->params.frl_usec) {
> -        zone->flags &= ~(NVME_ZFLAGS_SET_FZR | NVME_ZFLAGS_TS_DELAY);
> +        zone->flags &= ~(NVME_ZFLAGS_SET_FZR | NVME_ZFLAGS_TS_DELAY |
> +                         NVME_ZFLAGS_AEN_PEND);
>          notify = notify && (zone->d.za & NVME_ZA_FINISH_RECOMMENDED);
>          zone->d.za &= ~NVME_ZA_FINISH_RECOMMENDED;
>          zone->tstamp = 0;
> +        if (notify) {
> +            nvme_notify_zone_changed(n, ns, zone);
> +        }
>      }
>  }
>  
> +static bool nvme_process_rrl(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
> +{
> +    if (zone->flags & NVME_ZFLAGS_SET_RZR) {
> +        if (zone->flags & NVME_ZFLAGS_TS_DELAY) {
> +            assert(!(zone->d.za & NVME_ZA_RESET_RECOMMENDED));
> +            if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - zone->tstamp >=
> +                n->params.rzr_delay_usec) {
> +                nvme_set_rzr(n, ns, zone);
> +                return true;
> +            }
> +        } else if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - zone->tstamp >=
> +                   n->params.rrl_usec) {
> +            assert(zone->d.za & NVME_ZA_RESET_RECOMMENDED);
> +            nvme_clear_rzr(n, ns, zone, true);
> +            trace_pci_nvme_zone_reset_internal_op(zone->d.zslba);
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static bool nvme_process_frl(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
> +{
> +    if (zone->flags & NVME_ZFLAGS_SET_FZR) {
> +        if (zone->flags & NVME_ZFLAGS_TS_DELAY) {
> +            assert(!(zone->d.za & NVME_ZA_FINISH_RECOMMENDED));
> +            if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - zone->tstamp >=
> +                n->params.fzr_delay_usec) {
> +                nvme_set_fzr(n, ns, zone);
> +                return true;
> +            }
> +        } else if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - zone->tstamp >=
> +                   n->params.frl_usec) {
> +            assert(zone->d.za & NVME_ZA_FINISH_RECOMMENDED);
> +            nvme_clear_fzr(n, ns, zone, true);
> +            trace_pci_nvme_zone_finish_internal_op(zone->d.zslba);
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>  static void nvme_schedule_rzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
>  {
>      if (n->params.frl_usec) {
> @@ -279,6 +386,48 @@ static void nvme_schedule_fzr(NvmeCtrl *n, NvmeNamespace *ns, NvmeZone *zone)
>      }
>  }
>  
> +static void nvme_observe_ns_zone_time_limits(NvmeCtrl *n, NvmeNamespace *ns)
> +{
> +    NvmeZone *zone;
> +
> +    if (n->params.frl_usec) {
> +        for (zone = nvme_peek_zone_head(ns, ns->closed_zones);
> +             zone;
> +             zone = nvme_next_zone_in_list(ns, zone, ns->closed_zones)) {
> +            nvme_process_frl(n, ns, zone);
> +        }
> +
> +        for (zone = nvme_peek_zone_head(ns, ns->imp_open_zones);
> +             zone;
> +             zone = nvme_next_zone_in_list(ns, zone, ns->imp_open_zones)) {
> +            nvme_process_frl(n, ns, zone);
> +        }
> +
> +        for (zone = nvme_peek_zone_head(ns, ns->exp_open_zones);
> +             zone;
> +             zone = nvme_next_zone_in_list(ns, zone, ns->exp_open_zones)) {
> +            nvme_process_frl(n, ns, zone);
> +        }
> +    }
> +
> +    if (n->params.rrl_usec) {
> +        for (zone = nvme_peek_zone_head(ns, ns->full_zones);
> +             zone;
> +             zone = nvme_next_zone_in_list(ns, zone, ns->full_zones)) {
> +            nvme_process_rrl(n, ns, zone);
> +        }
> +    }
> +}
> +
> +static void nvme_observe_zone_time_limits(NvmeCtrl *n)
> +{
> +    int i;
> +
> +    for (i = 0; i < n->num_namespaces; i++) {
> +        nvme_observe_ns_zone_time_limits(n, &n->namespaces[i]);
> +    }
> +}
> +
>  static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
>      NvmeZone *zone, uint8_t state)
>  {
> @@ -563,6 +712,7 @@ static void nvme_post_cqes(void *opaque)
>      NvmeCQueue *cq = opaque;
>      NvmeCtrl *n = cq->ctrl;
>      NvmeRequest *req, *next;
> +    NvmeAsyncEvent *ae;
>  
>      QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
>          NvmeSQueue *sq;
> @@ -572,8 +722,26 @@ static void nvme_post_cqes(void *opaque)
>              break;
>          }
>  
> +        ae = NULL;
> +        if (req->flags & NVME_REQ_FLG_AER) {
> +            if (likely(QTAILQ_EMPTY(&n->async_reqs))) {
> +                continue;
> +            } else {
> +                ae = QTAILQ_FIRST(&n->async_reqs);
> +                QTAILQ_REMOVE(&n->async_reqs, ae, entry);
> +            }
> +        }

Since AERs are kept in the completion queue req_list, they simply linger
there if there is nothing to complete and we have to iterate over them
on every invocation of nvme_post_cqes. And since you are kicking the
timer every 10ms, this is a lot of doing for doing mostly nothing.

> +
>          QTAILQ_REMOVE(&cq->req_list, req, entry);
>          sq = req->sq;
> +        if (unlikely(ae)) {
> +            assert(!sq->sqid);
> +            req->cqe.ae.info = cpu_to_le32(ae->res);
> +            req->cqe.ae.nsid = cpu_to_le32(ae->nsid);
> +            g_free(ae);
> +            assert(n->nr_aers);
> +            n->nr_aers--;
> +        }
>  
>          req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
>          req->cqe.sq_id = cpu_to_le16(sq->sqid);
> @@ -587,6 +755,15 @@ static void nvme_post_cqes(void *opaque)
>      if (cq->tail != cq->head) {
>          nvme_irq_assert(n, cq);
>      }
> +
> +    if (cq == &n->admin_cq &&
> +        n->params.zoned && n->params.zone_async_events) {
> +        nvme_observe_zone_time_limits(n);
> +        if (timer_expired(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL))) {
> +            timer_mod(cq->timer,
> +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 10 * SCALE_MS);
> +        }
> +    }

I don't like this polling on the admin queue to check the limits.

>  }
>  
>  static void nvme_fill_data(QEMUSGList *qsg, QEMUIOVector *iov,
> @@ -618,7 +795,9 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>      assert(cq->cqid == req->sq->cqid);
>      QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
>      QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
> -    timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> +    if (!(req->flags & NVME_REQ_FLG_AER)) {
> +        timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> +    }
>  }
>  
>  static void nvme_auto_transition_zone(NvmeCtrl *n, NvmeNamespace *ns,
> @@ -643,6 +822,7 @@ static void nvme_auto_transition_zone(NvmeCtrl *n, NvmeNamespace *ns,
>              zone->d.za |= NVME_ZA_FINISHED_BY_CTLR;
>              zone->flags = 0;
>              zone->tstamp = 0;
> +            nvme_notify_zone_changed(n, ns, zone);
>              trace_pci_nvme_zone_finished_by_controller(zone->d.zslba);
>          }
>      }
> @@ -1978,6 +2158,10 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_get_feature_timestamp(n, cmd);
> +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> +        result = cpu_to_le32(n->ae_cfg);
> +        trace_pci_nvme_getfeat_aen_cfg(result);
> +        break;
>      case NVME_COMMAND_SET_PROFILE:
>          result = 0;
>          break;
> @@ -2029,6 +2213,19 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_set_feature_timestamp(n, cmd);
>          break;
>  
> +    case NVME_ASYNCHRONOUS_EVENT_CONF:
> +        if (dw11 & NVME_AEN_CFG_ZONE_DESCR_CHNGD_NOTICES) {
> +            if (!(n->ae_cfg & NVME_AEN_CFG_ZONE_DESCR_CHNGD_NOTICES)) {
> +                trace_pci_nvme_zone_aen_not_requested(dw11);
> +            } else {
> +                trace_pci_nvme_setfeat_zone_info_aer_on();
> +            }
> +        } else if (n->ae_cfg & NVME_AEN_CFG_ZONE_DESCR_CHNGD_NOTICES) {
> +            trace_pci_nvme_setfeat_zone_info_aer_off();
> +            n->ae_cfg &= ~NVME_AEN_CFG_ZONE_DESCR_CHNGD_NOTICES;
> +        }
> +        break;
> +
>      case NVME_COMMAND_SET_PROFILE:
>          if (dw11 & 0x1ff) {
>              trace_pci_nvme_err_invalid_iocsci(dw11 & 0x1ff);
> @@ -2043,6 +2240,18 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>  
> +static uint16_t nvme_async_req(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    if (n->nr_aers >= NVME_MAX_ASYNC_EVENTS) {
> +        return NVME_AER_LIMIT_EXCEEDED | NVME_DNR;
> +    }
> +
> +    assert(!(req->flags & NVME_REQ_FLG_AER));
> +    req->flags |= NVME_REQ_FLG_AER;
> +    n->nr_aers++;
> +    return NVME_SUCCESS;

Yuck. Don't return NVME_SUCCESS and monkey patch the completion path
like you do above; it feel hacky. Just queue up the request in a list
and return NVME_NO_COMPLETE. Then, when you have an AEN to issue, just
dequeue the oldest AER and call nvme_enqueue_req_completion.

> +}
> +
>  static uint16_t nvme_handle_cmd_effects(NvmeCtrl *n, NvmeCmd *cmd,
>      uint64_t prp1, uint64_t prp2, uint64_t ofs, uint32_t len, uint8_t csi)
>  {
> @@ -2068,6 +2277,7 @@ static uint16_t nvme_handle_cmd_effects(NvmeCtrl *n, NvmeCmd *cmd,
>      iocs[NVME_ADM_CMD_SET_FEATURES] = NVME_CMD_EFFECTS_CSUPP;
>      iocs[NVME_ADM_CMD_GET_FEATURES] = NVME_CMD_EFFECTS_CSUPP;
>      iocs[NVME_ADM_CMD_GET_LOG_PAGE] = NVME_CMD_EFFECTS_CSUPP;
> +    iocs[NVME_ADM_CMD_ASYNC_EV_REQ] = NVME_CMD_EFFECTS_CSUPP;
>  
>      if (NVME_CC_CSS(n->bar.cc) != CSS_ADMIN_ONLY) {
>          iocs[NVME_CMD_FLUSH] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
> @@ -2086,6 +2296,67 @@ static uint16_t nvme_handle_cmd_effects(NvmeCtrl *n, NvmeCmd *cmd,
>      return nvme_dma_read_prp(n, (uint8_t *)&cmd_eff_log, len, prp1, prp2);
>  }
>  
> +static uint16_t nvme_handle_changed_zone_log(NvmeCtrl *n, NvmeCmd *cmd,
> +    uint64_t prp1, uint64_t prp2, uint16_t nsid, uint64_t ofs, uint32_t len,
> +    uint8_t csi, bool rae)
> +{
> +    NvmeNamespace *ns;
> +    NvmeChangedZoneLog zc_log = {};
> +    NvmeZone *zone;
> +    uint64_t *zid_ptr = &zc_log.zone_ids[0];
> +    uint64_t *zid_end = zid_ptr + ARRAY_SIZE(zc_log.zone_ids);
> +    int i, nids = 0, num_aen_zones = 0;
> +
> +    trace_pci_nvme_changed_zone_log_read(nsid);
> +
> +    if (!n->params.zoned || !n->params.zone_async_events) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> +        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
> +        return NVME_INVALID_FIELD | NVME_DNR;

This should be NVME_INVALID_NSID.

> +    }
> +    ns = &n->namespaces[nsid - 1];
> +    if (csi != ns->csi) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }

I don't think the TP 4056 requires CSI to be set. It's only used for the
effects log page.

> +
> +    if (ofs != 0) {
> +        trace_pci_nvme_err_invalid_changed_zone_list_offset(ofs);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }

It might be weird that the host reads at an offset on this dynamic log
page, but its not invalid. The offset should not be larger than the size
of the log page though.

> +    if (len != sizeof(zc_log)) {
> +        trace_pci_nvme_err_invalid_changed_zone_list_len(len);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }

"The host *should* read the entire page ..". Again, it might be stupid,
but it is not invalid to read more or less.

> +
> +    zone = ns->zone_array;
> +    for (i = 0; i < n->num_zones && zid_ptr < zid_end; i++, zone++) {
> +        if (!(zone->flags & NVME_ZFLAGS_AEN_PEND)) {
> +            continue;
> +        }
> +        num_aen_zones++;
> +        if (zone->d.za) {
> +            trace_pci_nvme_reporting_changed_zone(zone->d.zslba, zone->d.za);
> +            *zid_ptr++ = cpu_to_le64(zone->d.zslba);
> +            nids++;
> +        }

Hmm. So a zone is only included if it has an attribute set? What about
when the controller has cleared the RZR attribute? That also should also
be reflected here.

> +        if (!rae) {
> +            zone->flags &= ~NVME_ZFLAGS_AEN_PEND;
> +        }

I'm not sure the semantics around RAE is correct here. It doesnt really
have anything to do with the individual zone flags. Even though
multiple zones has changed state and may cause multiple Zone Descriptor
Change events to be generated internally, only one should result in an
AER being completed. The event is then masked until the associated log
page is read with RAE set to zero.

> +    }
> +
> +    if (num_aen_zones && !nids) {
> +        trace_pci_nvme_empty_changed_zone_list();
> +        nids = 0xffff;
> +    }

It doesn't look like the case of more than 511 changed zones is handled?
In that case the remainder of the list *shall* be zero filled.

> +    zc_log.nr_zone_ids = cpu_to_le16(nids);
> +    ns->aen_pending = false;
> +
> +    return nvme_dma_read_prp(n, (uint8_t *)&zc_log, len, prp1, prp2);
> +}
> +
>  static uint16_t nvme_get_log_page(NvmeCtrl *n, NvmeCmd *cmd)
>  {
>      uint64_t prp1 = le64_to_cpu(cmd->prp1);
> @@ -2095,9 +2366,11 @@ static uint16_t nvme_get_log_page(NvmeCtrl *n, NvmeCmd *cmd)
>      uint64_t dw12 = le32_to_cpu(cmd->cdw12);
>      uint64_t dw13 = le32_to_cpu(cmd->cdw13);
>      uint64_t ofs = (dw13 << 32) | dw12;
> +    uint32_t nsid = le32_to_cpu(cmd->nsid);
>      uint32_t numdl, numdu, len;
>      uint16_t lid = dw10 & 0xff;
>      uint8_t csi = le32_to_cpu(cmd->cdw14) >> 24;
> +    bool rae = !!(dw10 & (1 << 15));
>  
>      numdl = dw10 >> 16;
>      numdu = dw11 & 0xffff;
> @@ -2106,6 +2379,9 @@ static uint16_t nvme_get_log_page(NvmeCtrl *n, NvmeCmd *cmd)
>      switch (lid) {
>      case NVME_LOG_CMD_EFFECTS:
>          return nvme_handle_cmd_effects(n, cmd, prp1, prp2, ofs, len, csi);
> +    case NVME_LOG_ZONE_CHANGED_LIST:
> +        return nvme_handle_changed_zone_log(n, cmd, prp1, prp2, nsid,
> +                                            ofs, len, csi, rae);
>       }
>  
>      trace_pci_nvme_unsupported_log_page(lid);
> @@ -2131,6 +2407,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_get_feature(n, cmd, req);
>      case NVME_ADM_CMD_GET_LOG_PAGE:
>          return nvme_get_log_page(n, cmd);
> +    case NVME_ADM_CMD_ASYNC_EV_REQ:
> +        return nvme_async_req(n, cmd, req);
>      default:
>          trace_pci_nvme_err_invalid_admin_opc(cmd->opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
> @@ -2171,6 +2449,7 @@ static void nvme_process_sq(void *opaque)
>  
>  static void nvme_clear_ctrl(NvmeCtrl *n)
>  {
> +    NvmeAsyncEvent *ae_entry, *next;
>      int i;
>  
>      blk_drain(n->conf.blk);
> @@ -2186,6 +2465,11 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>          }
>      }
>  
> +    QTAILQ_FOREACH_SAFE(ae_entry, &n->async_reqs, entry, next) {
> +        g_free(ae_entry);
> +    }
> +    n->nr_aers = 0;
> +
>      blk_flush(n->conf.blk);
>      n->bar.cc = 0;
>  }
> @@ -2290,6 +2574,9 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>  
>      nvme_set_timestamp(n, 0ULL);
>  
> +    QTAILQ_INIT(&n->async_reqs);
> +    n->nr_aers = 0;
> +
>      return 0;
>  }
>  
> @@ -2724,6 +3011,10 @@ static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
>          n->params.max_active_zones = nz;
>      }
>  
> +    if (n->params.zone_async_events) {
> +        n->ae_cfg |= NVME_AEN_CFG_ZONE_DESCR_CHNGD_NOTICES;
> +    }
> +
>      return;
>  }
>  
> @@ -2993,6 +3284,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      id->ieee[1] = 0x02;
>      id->ieee[2] = 0xb3;
>      id->oacs = cpu_to_le16(0);
> +    id->oaes = cpu_to_le32(n->ae_cfg);

I don't see why this can't always be supported. The host still has to
request it with the AEC feature for it to become active (assuming a
default of 0 for the AEC feature).

>      id->frmw = 7 << 1;
>      id->lpa = 1 << 1;
>      id->sqes = (0x6 << 4) | 0x6;
> @@ -3111,6 +3403,8 @@ static Property nvme_props[] = {
>      DEFINE_PROP_UINT64("finish_rcmnd_delay", NvmeCtrl,
>                         params.fzr_delay_usec, 0),
>      DEFINE_PROP_UINT64("finish_rcmnd_limit", NvmeCtrl, params.frl_usec, 0),
> +    DEFINE_PROP_BOOL("zone_async_events", NvmeCtrl, params.zone_async_events,
> +                     true),
>      DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
>      DEFINE_PROP_BOOL("active_excursions", NvmeCtrl, params.active_excursions,
>                       false),
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index be1920f1ef..e63f7736d7 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -3,6 +3,7 @@
>  
>  #include "block/nvme.h"
>  
> +#define NVME_MAX_ASYNC_EVENTS    16
>  #define NVME_DEFAULT_ZONE_SIZE   128 /* MiB */
>  #define NVME_DEFAULT_MAX_ZA_SIZE 128 /* KiB */
>  
> @@ -15,6 +16,7 @@ typedef struct NvmeParams {
>  
>      bool        zoned;
>      bool        cross_zone_read;
> +    bool        zone_async_events;
>      bool        active_excursions;
>      uint8_t     fill_pattern;
>      uint32_t    zamds_bs;
> @@ -29,13 +31,16 @@ typedef struct NvmeParams {
>  } NvmeParams;
>  
>  typedef struct NvmeAsyncEvent {
> -    QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
> +    QTAILQ_ENTRY(NvmeAsyncEvent) entry;
> +    uint32_t                     res;
> +    uint32_t                     nsid;
>  } NvmeAsyncEvent;
>  
>  enum NvmeRequestFlags {
>      NVME_REQ_FLG_HAS_SG   = 1 << 0,
>      NVME_REQ_FLG_FILL     = 1 << 1,
>      NVME_REQ_FLG_APPEND   = 1 << 2,
> +    NVME_REQ_FLG_AER      = 1 << 3,
>  };
>  
>  typedef struct NvmeRequest {
> @@ -85,6 +90,7 @@ enum NvmeZoneFlags {
>      NVME_ZFLAGS_TS_DELAY = 1 << 0,
>      NVME_ZFLAGS_SET_RZR  = 1 << 1,
>      NVME_ZFLAGS_SET_FZR  = 1 << 2,
> +    NVME_ZFLAGS_AEN_PEND = 1 << 3,
>  };
>  
>  typedef struct NvmeZone {
> @@ -119,6 +125,7 @@ typedef struct NvmeNamespace {
>      NvmeZoneList    *full_zones;
>      int32_t         nr_open_zones;
>      int32_t         nr_active_zones;
> +    bool            aen_pending;
>  } NvmeNamespace;
>  
>  static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
> @@ -173,6 +180,10 @@ typedef struct NvmeCtrl {
>      NvmeSQueue      admin_sq;
>      NvmeCQueue      admin_cq;
>      NvmeIdCtrl      id_ctrl;
> +
> +    QTAILQ_HEAD(, NvmeAsyncEvent) async_reqs;
> +    uint32_t        nr_aers;
> +    uint32_t        ae_cfg;
>  } NvmeCtrl;
>  
>  /* calculate the number of LBAs that the namespace can accomodate */
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 596c39162b..e06fb97337 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -633,16 +633,22 @@ enum NvmeAsyncErrorInfo {
>  
>  enum NvmeAsyncNoticeInfo {
>      NVME_AER_NOTICE_NS_CHANGED              = 0x00,
> +    NVME_AER_NOTICE_ZONE_DESCR_CHANGED      = 0xef,
>  };
>  
>  enum NvmeAsyncEventCfg {
>      NVME_AEN_CFG_NS_ATTR                    = 1 << 8,
> +    NVME_AEN_CFG_ZONE_DESCR_CHNGD_NOTICES   = 1 << 27,
>  };
>  
>  typedef struct NvmeCqe {
>      union {
>          uint64_t     result64;
>          uint32_t     result32;
> +        struct {
> +            uint32_t info;
> +            uint32_t nsid;
> +        } ae;
>      };
>      uint16_t    sq_head;
>      uint16_t    sq_id;
> @@ -778,11 +784,19 @@ enum {
>     NVME_CMD_EFFECTS_UUID_SEL          = 1 << 19,
>  };
>  
> +typedef struct NvmeChangedZoneLog {
> +    uint16_t    nr_zone_ids;
> +    uint8_t     rsvd2[6];
> +    uint64_t    zone_ids[511];
> +} NvmeChangedZoneLog;
> +
>  enum LogIdentifier {
> -    NVME_LOG_ERROR_INFO     = 0x01,
> -    NVME_LOG_SMART_INFO     = 0x02,
> -    NVME_LOG_FW_SLOT_INFO   = 0x03,
> -    NVME_LOG_CMD_EFFECTS    = 0x05,
> +    NVME_LOG_ERROR_INFO               = 0x01,
> +    NVME_LOG_SMART_INFO               = 0x02,
> +    NVME_LOG_FW_SLOT_INFO             = 0x03,
> +    NVME_LOG_CHANGED_NS_LIST          = 0x04,
> +    NVME_LOG_CMD_EFFECTS              = 0x05,
> +    NVME_LOG_ZONE_CHANGED_LIST        = 0xbf,
>  };
>  
>  typedef struct NvmePSD {
> @@ -1097,6 +1111,7 @@ static inline void _nvme_check_size(void)
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZoned) != 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeChangedZoneLog) != 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeZoneDescr) != 64);
>  }
>  #endif
> -- 
> 2.21.0
> 
> 

