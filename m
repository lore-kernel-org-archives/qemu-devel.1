Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B081AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6899820771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJ27qlaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6899820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCH6-00018F-M9
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 06:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jyCGT-0000hA-Oj
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 06:46:22 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:33172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jyCGP-0002QH-PM
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 06:46:21 -0400
Received: by mail-oo1-xc41.google.com with SMTP id d125so325216oob.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=libaZi4WxHehJvGDkym76dzSD0a0z+o7f+iJ+HJg6CQ=;
 b=rJ27qlaj7t9nNYNLjXNjPjTL3XO40Pwh0v1/DTX8X4FAtOfrirP/W3fNo5IMXiBi+s
 GlAZWP1//S2y2CvjedAr6zfVxRBKdyNecjM8BWfV+sj9kkqkQmJGQNZSbn8QgK3io/Sp
 C0Q8BB7lBqiViVuAOLobcMSDCVmmRq1lAlSd0wv7lZUOhD4XkjqWXx9ncApJ3+Ptj56L
 rRaxzUWlZoY0cFsEN41xawkAJVhNTUD3rtX/H//ZeHRe7O6feEMOIroskhnxylVeZcGH
 AgDisOlwAuea0pMgIxgrWL1kG8AXwG5o4rcGGUmPbWp0+4wtXg0xFnVXh2Kerc75TLu4
 bpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=libaZi4WxHehJvGDkym76dzSD0a0z+o7f+iJ+HJg6CQ=;
 b=QGgdmyL8ZVuvItQGgU8noqZu2v7dH+GFcnflN61RYyp8JIWUdlBTi9uPIzlwrXwC5c
 B3LxQtQPmNJRYGPDQi2JPR8YUF2pONVEGdYXPn53qEGgTAUUCx6YXYJgy6CO6AQPXxUe
 EDRNgJYaDQ5e6sJERiNMpuQ6pfpa1m4v8lLTzZnQ9S+VhmfKGuLGsOZgoNkms9rfNHqt
 KV6WvuxI0CeDUrPqjlldmzDg6VH2WhHC3MIc0qYEOyIb2TJiZm2BuNrpu09DCUL8y2vj
 ZobYN3OTdywiX6kQOPXzDavcqj7b/hPfrobpfPwcxRQSI1DVN74RCqm0HaN+Dt6tFdQK
 Zj+w==
X-Gm-Message-State: AOAM531AfqV3rBofhn6HjwBT2UBuxjIL+xtJQOfbLAJgTZbNFSc8XQK0
 Y93fuZxRqRfp9tz7/dKf3oKYvooDa3Qpq1Kuna8=
X-Google-Smtp-Source: ABdhPJyC1fPrdpdQLUce7rTD/h/vaX+HAdBIsqY687beQsD1aAxTcyhGJPM1R6oUqrpZW8jTHWr3R+sffln6hf1DHhI=
X-Received: by 2002:a4a:ea83:: with SMTP id r3mr27812922ooh.22.1595414776034; 
 Wed, 22 Jul 2020 03:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200721151728.112395-1-liq3ea@163.com>
 <307795f9-70bb-b83b-6110-da2c923e4dc2@redhat.com>
 <CAKXe6SL4bscJXYe3ybCvP2p9C+M4KcE8g8u36iShXNm_BqV-2w@mail.gmail.com>
 <d13466c3-f1f1-49bc-8583-fc85afd0be4a@redhat.com>
In-Reply-To: <d13466c3-f1f1-49bc-8583-fc85afd0be4a@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 22 Jul 2020 18:45:40 +0800
Message-ID: <CAKXe6S+T_FXBHja1wH3Ai3RHtU7KkrZBY-goZs8=VyddNp3p9w@mail.gmail.com>
Subject: Re: [PATCH v3] e1000e: using bottom half to send packets
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=881:49=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 2020/7/22 =E4=B8=8B=E5=8D=8812:47, Li Qiang wrote:
> > Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8811:32=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2020/7/21 =E4=B8=8B=E5=8D=8811:17, Li Qiang wrote:
> >>> Alexander Bulekov reported a UAF bug related e1000e packets send.
> >>>
> >>> -->https://bugs.launchpad.net/qemu/+bug/1886362
> >>>
> >>> This is because the guest trigger a e1000e packet send and set the
> >>> data's address to e1000e's MMIO address. So when the e1000e do DMA
> >>> it will write the MMIO again and trigger re-entrancy and finally
> >>> causes this UAF.
> >>>
> >>> Paolo suggested to use a bottom half whenever MMIO is doing complicat=
e
> >>> things in here:
> >>> -->https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg03342.=
html
> >>>
> >>> Reference here:
> >>> 'The easiest solution is to delay processing of descriptors to a bott=
om
> >>> half whenever MMIO is doing something complicated.  This is also bett=
er
> >>> for latency because it will free the vCPU thread more quickly and lea=
ve
> >>> the work to the I/O thread.'
> >>>
> >>> This patch fixes this UAF.
> >>>
> >>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> >>> Signed-off-by: Li Qiang <liq3ea@163.com>
> >>> ---
> >>> Change since v2:
> >>> 1. Add comments for the tx bh schdule when VM resumes
> >>> 2. Leave the set ics code in 'e1000e_start_xmit'
> >>> 3. Cancel the tx bh and reset tx_waiting in e1000e_core_reset
> >>
> >> So based on our discussion this is probably not sufficient. It solves
> >> the issue TX re-entrancy but not RX (e.g RX DMA to RDT?) Or is e1000e'=
s
> >> RX is reentrant?
> >>
> > It seems the RX has no reentrant issue if we address the TX reentrant i=
ssue.
>
>
> Just to make sure I understand.
>
> Did you mean
>
> 1) RX code is reentrant
>
> or
>
> 2) the following can't happen
>
> e1000_receive()
>      e1000e_write_packet_to_guest()
>          e1000e_write_to_rx_buffers()
>              pci_dma_write()
>                  ...
>                      e1000e_set_rdt()
>                          qemu_flush_queued_packets()
>                              e1000e_receive()
>
> ?
>

Once I don't think there is a such path. But just RX->TX->RX(loopback).
Then in my last email I think if we solve TX reentry issue there will
be no RX reentry issue.
But it is not the case.
Anyway seems your new patch is more elegant.

Thanks,
Li Qiang


>
> > Though we can write the RX-related DMA register, then when we receive
> > packets, we write to the MMIO with any data.
> > However this is not different between the guest write any data to MMIO.
> >
> > I think we can hold on this patch and discuss more about this MMIO
> > reentrant issue then make
> > the decision.
>
>
> Right, and we need start to think of how to do the test, e.g qtest?
>
> Thanks
>
>
> >
> > Thanks,
> > Li Qiang
> >
> >
> >> Thanks
> >>
> >>
> >>> Change since v1:
> >>> Per Jason's review here:
> >>> -- https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05368.=
html
> >>> 1. Cancel and schedule the tx bh when VM is stopped or resume
> >>> 2. Add a tx_burst for e1000e configuration to throttle the bh executi=
on
> >>> 3. Add a tx_waiting to record whether the bh is pending or not
> >>> Don't use BQL in the tx_bh handler as when tx_bh is executed, the BQL=
 is
> >>> acquired.
> >>>
> >>>    hw/net/e1000e.c      |   6 +++
> >>>    hw/net/e1000e_core.c | 107 +++++++++++++++++++++++++++++++++++----=
----
> >>>    hw/net/e1000e_core.h |   8 ++++
> >>>    3 files changed, 101 insertions(+), 20 deletions(-)
> >>>
> >>> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> >>> index fda34518c9..24e35a78bf 100644
> >>> --- a/hw/net/e1000e.c
> >>> +++ b/hw/net/e1000e.c
> >>> @@ -77,10 +77,14 @@ typedef struct E1000EState {
> >>>
> >>>        bool disable_vnet;
> >>>
> >>> +    int32_t tx_burst;
> >>> +
> >>>        E1000ECore core;
> >>>
> >>>    } E1000EState;
> >>>
> >>> +#define TX_BURST 256
> >>> +
> >>>    #define E1000E_MMIO_IDX     0
> >>>    #define E1000E_FLASH_IDX    1
> >>>    #define E1000E_IO_IDX       2
> >>> @@ -263,6 +267,7 @@ static void e1000e_core_realize(E1000EState *s)
> >>>    {
> >>>        s->core.owner =3D &s->parent_obj;
> >>>        s->core.owner_nic =3D s->nic;
> >>> +    s->core.tx_burst =3D s->tx_burst;
> >>>    }
> >>>
> >>>    static void
> >>> @@ -665,6 +670,7 @@ static Property e1000e_properties[] =3D {
> >>>                            e1000e_prop_subsys_ven, uint16_t),
> >>>        DEFINE_PROP_SIGNED("subsys", E1000EState, subsys, 0,
> >>>                            e1000e_prop_subsys, uint16_t),
> >>> +    DEFINE_PROP_INT32("x-txburst", E1000EState, tx_burst, TX_BURST),
> >>>        DEFINE_PROP_END_OF_LIST(),
> >>>    };
> >>>
> >>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> >>> index bcd186cac5..2fdfc23204 100644
> >>> --- a/hw/net/e1000e_core.c
> >>> +++ b/hw/net/e1000e_core.c
> >>> @@ -910,18 +910,17 @@ e1000e_rx_ring_init(E1000ECore *core, E1000E_Rx=
Ring *rxr, int idx)
> >>>    }
> >>>
> >>>    static void
> >>> -e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
> >>> +e1000e_start_xmit(struct e1000e_tx *q)
> >>>    {
> >>> +    E1000ECore *core =3D q->core;
> >>>        dma_addr_t base;
> >>>        struct e1000_tx_desc desc;
> >>> -    bool ide =3D false;
> >>> -    const E1000E_RingInfo *txi =3D txr->i;
> >>> -    uint32_t cause =3D E1000_ICS_TXQE;
> >>> +    const E1000E_RingInfo *txi;
> >>> +    E1000E_TxRing txr;
> >>> +    int32_t num_packets =3D 0;
> >>>
> >>> -    if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
> >>> -        trace_e1000e_tx_disabled();
> >>> -        return;
> >>> -    }
> >>> +    e1000e_tx_ring_init(core, &txr, q - &core->tx[0]);
> >>> +    txi =3D txr.i;
> >>>
> >>>        while (!e1000e_ring_empty(core, txi)) {
> >>>            base =3D e1000e_ring_head_descr(core, txi);
> >>> @@ -931,14 +930,24 @@ e1000e_start_xmit(E1000ECore *core, const E1000=
E_TxRing *txr)
> >>>            trace_e1000e_tx_descr((void *)(intptr_t)desc.buffer_addr,
> >>>                                  desc.lower.data, desc.upper.data);
> >>>
> >>> -        e1000e_process_tx_desc(core, txr->tx, &desc, txi->idx);
> >>> -        cause |=3D e1000e_txdesc_writeback(core, base, &desc, &ide, =
txi->idx);
> >>> +        e1000e_process_tx_desc(core, txr.tx, &desc, txi->idx);
> >>> +        q->cause |=3D e1000e_txdesc_writeback(core, base, &desc,
> >>> +                                            &q->ide, txi->idx);
> >>>
> >>>            e1000e_ring_advance(core, txi, 1);
> >>> +        if (++num_packets >=3D core->tx_burst) {
> >>> +            break;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    if (num_packets >=3D core->tx_burst) {
> >>> +        qemu_bh_schedule(q->tx_bh);
> >>> +        q->tx_waiting =3D 1;
> >>> +        return;
> >>>        }
> >>>
> >>> -    if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
> >>> -        e1000e_set_interrupt_cause(core, cause);
> >>> +    if (!q->ide || !e1000e_intrmgr_delay_tx_causes(core, &q->cause))=
 {
> >>> +        e1000e_set_interrupt_cause(core, q->cause);
> >>>        }
> >>>    }
> >>>
> >>> @@ -2423,32 +2432,41 @@ e1000e_set_dbal(E1000ECore *core, int index, =
uint32_t val)
> >>>    static void
> >>>    e1000e_set_tctl(E1000ECore *core, int index, uint32_t val)
> >>>    {
> >>> -    E1000E_TxRing txr;
> >>>        core->mac[index] =3D val;
> >>>
> >>>        if (core->mac[TARC0] & E1000_TARC_ENABLE) {
> >>> -        e1000e_tx_ring_init(core, &txr, 0);
> >>> -        e1000e_start_xmit(core, &txr);
> >>> +        if (core->tx[0].tx_waiting) {
> >>> +            return;
> >>> +        }
> >>> +        core->tx[0].tx_waiting =3D 1;
> >>> +        if (!core->vm_running) {
> >>> +            return;
> >>> +        }
> >>> +        qemu_bh_schedule(core->tx[0].tx_bh);
> >>>        }
> >>>
> >>>        if (core->mac[TARC1] & E1000_TARC_ENABLE) {
> >>> -        e1000e_tx_ring_init(core, &txr, 1);
> >>> -        e1000e_start_xmit(core, &txr);
> >>> +        if (core->tx[1].tx_waiting) {
> >>> +            return;
> >>> +        }
> >>> +        core->tx[1].tx_waiting =3D 1;
> >>> +        if (!core->vm_running) {
> >>> +            return;
> >>> +        }
> >>> +        qemu_bh_schedule(core->tx[1].tx_bh);
> >>>        }
> >>>    }
> >>>
> >>>    static void
> >>>    e1000e_set_tdt(E1000ECore *core, int index, uint32_t val)
> >>>    {
> >>> -    E1000E_TxRing txr;
> >>>        int qidx =3D e1000e_mq_queue_idx(TDT, index);
> >>>        uint32_t tarc_reg =3D (qidx =3D=3D 0) ? TARC0 : TARC1;
> >>>
> >>>        core->mac[index] =3D val & 0xffff;
> >>>
> >>>        if (core->mac[tarc_reg] & E1000_TARC_ENABLE) {
> >>> -        e1000e_tx_ring_init(core, &txr, qidx);
> >>> -        e1000e_start_xmit(core, &txr);
> >>> +        qemu_bh_schedule(core->tx[qidx].tx_bh);
> >>>        }
> >>>    }
> >>>
> >>> @@ -3315,11 +3333,52 @@ e1000e_vm_state_change(void *opaque, int runn=
ing, RunState state)
> >>>            trace_e1000e_vm_state_running();
> >>>            e1000e_intrmgr_resume(core);
> >>>            e1000e_autoneg_resume(core);
> >>> +        core->vm_running =3D 1;
> >>> +
> >>> +        for (int i =3D 0; i < E1000E_NUM_QUEUES; i++) {
> >>> +            /*
> >>> +             * Schedule tx bh unconditionally to make sure
> >>> +             * tx work after live migration since we don't
> >>> +             * migrate tx_waiting.
> >>> +             */
> >>> +            qemu_bh_schedule(core->tx[i].tx_bh);
> >>> +        }
> >>> +
> >>>        } else {
> >>>            trace_e1000e_vm_state_stopped();
> >>> +
> >>> +        for (int i =3D 0; i < E1000E_NUM_QUEUES; i++) {
> >>> +            qemu_bh_cancel(core->tx[i].tx_bh);
> >>> +        }
> >>> +
> >>>            e1000e_autoneg_pause(core);
> >>>            e1000e_intrmgr_pause(core);
> >>> +        core->vm_running =3D 0;
> >>> +    }
> >>> +}
> >>> +
> >>> +
> >>> +static void e1000e_core_tx_bh(void *opaque)
> >>> +{
> >>> +    struct e1000e_tx *q =3D opaque;
> >>> +    E1000ECore *core =3D q->core;
> >>> +
> >>> +    if (!core->vm_running) {
> >>> +        assert(q->tx_waiting);
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    q->tx_waiting =3D 0;
> >>> +
> >>> +    if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
> >>> +        trace_e1000e_tx_disabled();
> >>> +        return;
> >>>        }
> >>> +
> >>> +    q->cause =3D E1000_ICS_TXQE;
> >>> +    q->ide =3D false;
> >>> +
> >>> +    e1000e_start_xmit(q);
> >>>    }
> >>>
> >>>    void
> >>> @@ -3334,12 +3393,15 @@ e1000e_core_pci_realize(E1000ECore     *core,
> >>>                                           e1000e_autoneg_timer, core)=
;
> >>>        e1000e_intrmgr_pci_realize(core);
> >>>
> >>> +    core->vm_running =3D runstate_is_running();
> >>>        core->vmstate =3D
> >>>            qemu_add_vm_change_state_handler(e1000e_vm_state_change, c=
ore);
> >>>
> >>>        for (i =3D 0; i < E1000E_NUM_QUEUES; i++) {
> >>>            net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
> >>>                            E1000E_MAX_TX_FRAGS, core->has_vnet);
> >>> +        core->tx[i].core =3D core;
> >>> +        core->tx[i].tx_bh =3D qemu_bh_new(e1000e_core_tx_bh, &core->=
tx[i]);
> >>>        }
> >>>
> >>>        net_rx_pkt_init(&core->rx_pkt, core->has_vnet);
> >>> @@ -3367,6 +3429,9 @@ e1000e_core_pci_uninit(E1000ECore *core)
> >>>        for (i =3D 0; i < E1000E_NUM_QUEUES; i++) {
> >>>            net_tx_pkt_reset(core->tx[i].tx_pkt);
> >>>            net_tx_pkt_uninit(core->tx[i].tx_pkt);
> >>> +        qemu_bh_cancel(core->tx[i].tx_bh);
> >>> +        qemu_bh_delete(core->tx[i].tx_bh);
> >>> +        core->tx[i].tx_bh =3D NULL;
> >>>        }
> >>>
> >>>        net_rx_pkt_uninit(core->rx_pkt);
> >>> @@ -3480,6 +3545,8 @@ e1000e_core_reset(E1000ECore *core)
> >>>            net_tx_pkt_reset(core->tx[i].tx_pkt);
> >>>            memset(&core->tx[i].props, 0, sizeof(core->tx[i].props));
> >>>            core->tx[i].skip_cp =3D false;
> >>> +        qemu_bh_cancel(core->tx[i].tx_bh);
> >>> +        core->tx[i].tx_waiting =3D 0;
> >>>        }
> >>>    }
> >>>
> >>> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
> >>> index aee32f7e48..0c16dce3a6 100644
> >>> --- a/hw/net/e1000e_core.h
> >>> +++ b/hw/net/e1000e_core.h
> >>> @@ -77,10 +77,18 @@ struct E1000Core {
> >>>            unsigned char sum_needed;
> >>>            bool cptse;
> >>>            struct NetTxPkt *tx_pkt;
> >>> +        QEMUBH *tx_bh;
> >>> +        uint32_t tx_waiting;
> >>> +        uint32_t cause;
> >>> +        bool ide;
> >>> +        E1000ECore *core;
> >>>        } tx[E1000E_NUM_QUEUES];
> >>>
> >>>        struct NetRxPkt *rx_pkt;
> >>>
> >>> +    int32_t tx_burst;
> >>> +
> >>> +    bool vm_running;
> >>>        bool has_vnet;
> >>>        int max_queue_num;
> >>>
>

