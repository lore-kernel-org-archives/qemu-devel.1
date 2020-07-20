Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC11C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 04:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FD7207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 04:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCsLmkpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FD7207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxNdY-000852-QH
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 00:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jxNcl-0007M3-9B
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 00:41:59 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jxNcj-0007Il-28
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 00:41:58 -0400
Received: by mail-oi1-x241.google.com with SMTP id x83so13421645oif.10
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2020 21:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NBvBd3fkfw6rUX5zfpXaQLY3z0PoFDPXHg2uIoR+5Ec=;
 b=sCsLmkpWwJU7XFiRBnNqqS+cqCos0b2mPOl3irC0YPo1yHl5l9NGonNl4sFNPIMaHC
 P0KVj27M9A9D9ivpCpQEjioqsECkgzHo5Hh2n3WHn0qHZ9kdT6ecQoi7Q5PdRXWi0VT0
 Icimm9BoOl3MIR0t5egChJfAu87Sd6PdzX4sh9GZMxVLgAJZgct4Q7KLS2ohCpIJnTa7
 Y7kPTsss9YL4EKkJSeLP4wQHx5uYGoCNVcmp9Vz5YJA9CUCG8EEBeN7Iu9zpiplpWIr9
 VM5jOUV++vwsbvECdPH9pjiElsjydBHsmdzXubjVsip+UMTTT5JyPAzmzyBDaymY0ZWg
 s8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NBvBd3fkfw6rUX5zfpXaQLY3z0PoFDPXHg2uIoR+5Ec=;
 b=EvM0Q28M8S6D11jVblIUcRHuGSXN9CILcHeIkv1FjLjpFvLzaZ+MPP80+il25LdfXK
 +xXxbNMgAXvQAAw6OxvoRgkdf4Ax0b8BbYttpeZMRcB/mXr/d+D8R3ysS8Jo0iBPg0hZ
 iPph2wDV8iKZqWJkhl6GbNp0G0i5xvmtfmKP6vd3v8+JJy/gIQS0gBvboGdmNARd5SVg
 3YSeY2Okt/jUZjxXRanvHhb8efSdFIMWAu3vga2RJskxOr7ZYH4FzSk7Bm+GycrBMzuP
 vXy+8LumeBWU/iXIeTB451xsBHLD1T8mS+IoKYhL8vx/ijglrQ274sW2IZok+BNyg/RA
 orrA==
X-Gm-Message-State: AOAM530kV6VR+Y8jGwu1URjiBLL3izmVn7JjJLNgLGD4jLo1PnKeHavi
 0gpbZl3Vnb4lYZ5FJpDfCfBmA3BT3F4APmIohqQ=
X-Google-Smtp-Source: ABdhPJyfURXECHZB8LzYMSAk8ueqBf+z14XVj9WKWl6yyfy4N8kiKPQDcQzu5L54WQvuCt4kixwrM096A7B3CkCbzPs=
X-Received: by 2002:aca:494d:: with SMTP id w74mr16821162oia.97.1595220115021; 
 Sun, 19 Jul 2020 21:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200716161453.61295-1-liq3ea@163.com>
 <281e3c85-b8eb-0c3e-afc3-41011861b8ea@redhat.com>
 <CAKXe6SLe_ZRqQQMi2hPFBkauWnbaOPKN27fwrdaTOymb-fTrFg@mail.gmail.com>
 <d9c249a1-5f63-7497-3783-3a3e8cf7b2da@redhat.com>
 <CAKXe6S+HAcWFEE5ZyLaRkoi+j-v4OE3DCM9aL=6sF1B_2d5-ag@mail.gmail.com>
 <9cc9842a-975d-417f-de80-d0a57619b94f@redhat.com>
In-Reply-To: <9cc9842a-975d-417f-de80-d0a57619b94f@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 20 Jul 2020 12:41:19 +0800
Message-ID: <CAKXe6S+BtnrcCfcr-kGFByu5iocC816c1nNVh+4O_e6AhE8Apw@mail.gmail.com>
Subject: Re: [PATCH] e1000e: using bottom half to send packets
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8812:00=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 2020/7/17 =E4=B8=8B=E5=8D=8811:46, Li Qiang wrote:
> > Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=881:39=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2020/7/17 =E4=B8=8B=E5=8D=8812:46, Li Qiang wrote:
> >>> Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8811:10=E5=86=99=E9=81=93=EF=BC=
=9A
> >>>> On 2020/7/17 =E4=B8=8A=E5=8D=8812:14, Li Qiang wrote:
> >>>>> Alexander Bulekov reported a UAF bug related e1000e packets send.
> >>>>>
> >>>>> -->https://bugs.launchpad.net/qemu/+bug/1886362
> >>>>>
> >>>>> This is because the guest trigger a e1000e packet send and set the
> >>>>> data's address to e1000e's MMIO address. So when the e1000e do DMA
> >>>>> it will write the MMIO again and trigger re-entrancy and finally
> >>>>> causes this UAF.
> >>>>>
> >>>>> Paolo suggested to use a bottom half whenever MMIO is doing complic=
ate
> >>>>> things in here:
> >>>>> -->https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg0334=
2.html
> >>>>>
> >>>>> Reference here:
> >>>>> 'The easiest solution is to delay processing of descriptors to a bo=
ttom
> >>>>> half whenever MMIO is doing something complicated.  This is also be=
tter
> >>>>> for latency because it will free the vCPU thread more quickly and l=
eave
> >>>>> the work to the I/O thread.'
> >>>> I think several things were missed in this patch (take virtio-net as=
 a
> >>>> reference), do we need the following things:
> >>>>
> >>> Thanks Jason,
> >>> In fact I know this, I'm scared for touching this but I want to try.
> >>> Thanks for your advice.
> >>>
> >>>> - Cancel the bh when VM is stopped.
> >>> Ok. I think add a vm state change notifier for e1000e can address thi=
s.
> >>>
> >>>> - A throttle to prevent bh from executing too much timer?
> >>> Ok, I think add a config timeout and add a timer in e1000e can addres=
s this.
> >>
> >> Sorry, a typo. I meant we probably need a tx_burst as what virtio-net =
did.
> >>
> >>
> >>>> - A flag to record whether or not this a pending tx (and migrate it?=
)
> >>> Is just a flag enough? Could you explain more about the idea behind
> >>> processing the virtio-net/e1000e using bh like this?
> >>
> >> Virtio-net use a tx_waiting variable to record whether or not there's =
a
> >> pending bh. (E.g bh is cancelled due to vmstop, we need reschedule it
> >> after vmresume). Maybe we can do something simpler by just schecule bh
> >> unconditionally during vm resuming.
> >>
> >>
> >>> For example, if the guest trigger a lot of packets send and if the bh
> >>> is scheduled in IO thread. So will we lost packets?
> >>
> >> We don't since we don't populate virtqueue which means packets are
> >> queued there.
> >>
> > This remind of me a question:
> > If we use tx_burst like in virtion-net. For detail:
> > If we sent out  'tx_burst' packets per bh. Then we set 'tx_waiting' and
> > then schedule another bh. However if between two bh schedule, the guest=
 change
> > the e1000e register such 'r->dh' 'r->dlen'. The data is fully corrupted=
.
> > In fact this issue does exist in my origin patch.  That's
> > What if following happend:
> >
> > vcpu thread: guest write e1000e MMIO to trigger packets send
> > vcpu thread: schedule a bh
> > vcpu thread: return
> > IO thread: begin to run the bh and start send packets
> > vcpu thread: write register again such as  'r->dh' 'r->dlen'..
> >
> > So here the IO thread and vcpu thread will race the register?
> >
> > If I remember correctly, the virtio net has no such problem because it
> > uses ring buffer
> > and the backedn(virtio device) uses the shadow index to index the ring
> > buffer data.
> >
> > What's your idea here?
>
>
> I think we serialize them through bql? (qemu_mutex_lock_iothread())
>

Ok I will try to cook a patch tonight based our discussion.

Thanks,
Li Qiang

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
> >>> How we avoid this in virtio-net.
> >>>
> >>> Thanks,
> >>> Li Qiang
> >>>
> >>>
> >>>
> >>>> Thanks
> >>>>
> >>>>
> >>>>> This patch fixes this UAF.
> >>>>>
> >>>>> Signed-off-by: Li Qiang <liq3ea@163.com>
> >>>>> ---
> >>>>>     hw/net/e1000e_core.c | 25 +++++++++++++++++--------
> >>>>>     hw/net/e1000e_core.h |  2 ++
> >>>>>     2 files changed, 19 insertions(+), 8 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> >>>>> index bcd186cac5..6165b04b68 100644
> >>>>> --- a/hw/net/e1000e_core.c
> >>>>> +++ b/hw/net/e1000e_core.c
> >>>>> @@ -2423,32 +2423,27 @@ e1000e_set_dbal(E1000ECore *core, int index=
, uint32_t val)
> >>>>>     static void
> >>>>>     e1000e_set_tctl(E1000ECore *core, int index, uint32_t val)
> >>>>>     {
> >>>>> -    E1000E_TxRing txr;
> >>>>>         core->mac[index] =3D val;
> >>>>>
> >>>>>         if (core->mac[TARC0] & E1000_TARC_ENABLE) {
> >>>>> -        e1000e_tx_ring_init(core, &txr, 0);
> >>>>> -        e1000e_start_xmit(core, &txr);
> >>>>> +        qemu_bh_schedule(core->tx[0].tx_bh);
> >>>>>         }
> >>>>>
> >>>>>         if (core->mac[TARC1] & E1000_TARC_ENABLE) {
> >>>>> -        e1000e_tx_ring_init(core, &txr, 1);
> >>>>> -        e1000e_start_xmit(core, &txr);
> >>>>> +        qemu_bh_schedule(core->tx[1].tx_bh);
> >>>>>         }
> >>>>>     }
> >>>>>
> >>>>>     static void
> >>>>>     e1000e_set_tdt(E1000ECore *core, int index, uint32_t val)
> >>>>>     {
> >>>>> -    E1000E_TxRing txr;
> >>>>>         int qidx =3D e1000e_mq_queue_idx(TDT, index);
> >>>>>         uint32_t tarc_reg =3D (qidx =3D=3D 0) ? TARC0 : TARC1;
> >>>>>
> >>>>>         core->mac[index] =3D val & 0xffff;
> >>>>>
> >>>>>         if (core->mac[tarc_reg] & E1000_TARC_ENABLE) {
> >>>>> -        e1000e_tx_ring_init(core, &txr, qidx);
> >>>>> -        e1000e_start_xmit(core, &txr);
> >>>>> +        qemu_bh_schedule(core->tx[qidx].tx_bh);
> >>>>>         }
> >>>>>     }
> >>>>>
> >>>>> @@ -3322,6 +3317,16 @@ e1000e_vm_state_change(void *opaque, int run=
ning, RunState state)
> >>>>>         }
> >>>>>     }
> >>>>>
> >>>>> +static void e1000e_core_tx_bh(void *opaque)
> >>>>> +{
> >>>>> +    struct e1000e_tx *tx =3D opaque;
> >>>>> +    E1000ECore *core =3D tx->core;
> >>>>> +    E1000E_TxRing txr;
> >>>>> +
> >>>>> +    e1000e_tx_ring_init(core, &txr, tx - &core->tx[0]);
> >>>>> +    e1000e_start_xmit(core, &txr);
> >>>>> +}
> >>>>> +
> >>>>>     void
> >>>>>     e1000e_core_pci_realize(E1000ECore     *core,
> >>>>>                             const uint16_t *eeprom_templ,
> >>>>> @@ -3340,6 +3345,8 @@ e1000e_core_pci_realize(E1000ECore     *core,
> >>>>>         for (i =3D 0; i < E1000E_NUM_QUEUES; i++) {
> >>>>>             net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
> >>>>>                             E1000E_MAX_TX_FRAGS, core->has_vnet);
> >>>>> +        core->tx[i].core =3D core;
> >>>>> +        core->tx[i].tx_bh =3D qemu_bh_new(e1000e_core_tx_bh, &core=
->tx[i]);
> >>>>>         }
> >>>>>
> >>>>>         net_rx_pkt_init(&core->rx_pkt, core->has_vnet);
> >>>>> @@ -3367,6 +3374,8 @@ e1000e_core_pci_uninit(E1000ECore *core)
> >>>>>         for (i =3D 0; i < E1000E_NUM_QUEUES; i++) {
> >>>>>             net_tx_pkt_reset(core->tx[i].tx_pkt);
> >>>>>             net_tx_pkt_uninit(core->tx[i].tx_pkt);
> >>>>> +        qemu_bh_delete(core->tx[i].tx_bh);
> >>>>> +        core->tx[i].tx_bh =3D NULL;
> >>>>>         }
> >>>>>
> >>>>>         net_rx_pkt_uninit(core->rx_pkt);
> >>>>> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
> >>>>> index aee32f7e48..94ddc6afc2 100644
> >>>>> --- a/hw/net/e1000e_core.h
> >>>>> +++ b/hw/net/e1000e_core.h
> >>>>> @@ -77,6 +77,8 @@ struct E1000Core {
> >>>>>             unsigned char sum_needed;
> >>>>>             bool cptse;
> >>>>>             struct NetTxPkt *tx_pkt;
> >>>>> +        QEMUBH *tx_bh;
> >>>>> +        E1000ECore *core;
> >>>>>         } tx[E1000E_NUM_QUEUES];
> >>>>>
> >>>>>         struct NetRxPkt *rx_pkt;
>

