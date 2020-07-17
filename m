Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BA1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 04:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E05120759
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 04:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHdTXXHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E05120759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwII3-00041q-Sf
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 00:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jwIHP-0003Ja-6L
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 00:47:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jwIHN-00084U-A6
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 00:47:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id k6so6992059oij.11
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 21:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0/foZzYkMGzDzriQ1t2QMrr1pQ8f72oFP6E6FFnsXVQ=;
 b=QHdTXXHVa8Y3OBK0stLe/yDb5cLaZGplwblMpo0uxQXb/B2LJgrKPe6ehbGZkviBlz
 GgNMOj6cPdUz3nq8oPe4TT3D0a7Ef2YSmIFvNxpAWGc4XK0gpbQDdq6hN1Jvt9kOMt/+
 1ItAvW2yOz9Uoq5M9wVwDs6bRQTsN3CdwYKGj3LLpufzsap3Ck2Cx6roY2ujqVkW9Rmb
 cZvKXM9/bBiXXMY8mqcotiO+bt8FGJ3uRzER01zgPk4ZpEOs+hhp1GfoDBm6/fskghsl
 BhgktKdbSBjvRt+gNKZlUtz0b0UiomVkrhSeZ/BtPhywMg1ch54/2EIqDbpm5C7Q4OG6
 wdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0/foZzYkMGzDzriQ1t2QMrr1pQ8f72oFP6E6FFnsXVQ=;
 b=oGk8jfaKCLKpi3hqF2uRQa1jmU2tfYhSHz+RZJ0zpqwzyiwSxYbEf/JuW4FFqNaAHX
 aorrPzxuHewvjuGQ51rje1BUnF0HQLBX1vx+sUj6FJ2ofR5kPGipQd2aefkWQEKy6BHs
 qjyU1eCYNUApj2PB34nMvuN1E/jQIdoTVmeILx7Ju+gc+D0/uZS39qIt0GyLrouEm4Dq
 C7HqYNXdI4Gj+lLVo6hEDvZ/Uub6MR5ou3n4eNLLR7k7JKcStsr44uE3/5NFlsBAtNLz
 F8g4WmSCpiK49Djx7WBxot5rbkR62YqI8kJnQD6XK7VkekNmYVtOe98VUz39uUAjiC0N
 EVCg==
X-Gm-Message-State: AOAM532QjpvwgNKPs2ozEpZVh2gmVcA5hMiqrXNLG2G9ySaUf1dlsQUR
 eo8X/AmUw8+i+FTV2fn2l8DUwNYVtJ8YE6MazhE=
X-Google-Smtp-Source: ABdhPJyMqAyaoo0jzePpb7zaYSYgXMWMuKbj9R4D+VlPyiuL/Mt3pEJoxGfhxxtJFP3AKiH5NOs+Cd6qJioicbLoIkU=
X-Received: by 2002:a05:6808:486:: with SMTP id
 z6mr6580640oid.56.1594961244006; 
 Thu, 16 Jul 2020 21:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200716161453.61295-1-liq3ea@163.com>
 <281e3c85-b8eb-0c3e-afc3-41011861b8ea@redhat.com>
In-Reply-To: <281e3c85-b8eb-0c3e-afc3-41011861b8ea@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 17 Jul 2020 12:46:48 +0800
Message-ID: <CAKXe6SLe_ZRqQQMi2hPFBkauWnbaOPKN27fwrdaTOymb-fTrFg@mail.gmail.com>
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

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8811:10=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 2020/7/17 =E4=B8=8A=E5=8D=8812:14, Li Qiang wrote:
> > Alexander Bulekov reported a UAF bug related e1000e packets send.
> >
> > -->https://bugs.launchpad.net/qemu/+bug/1886362
> >
> > This is because the guest trigger a e1000e packet send and set the
> > data's address to e1000e's MMIO address. So when the e1000e do DMA
> > it will write the MMIO again and trigger re-entrancy and finally
> > causes this UAF.
> >
> > Paolo suggested to use a bottom half whenever MMIO is doing complicate
> > things in here:
> > -->https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg03342.ht=
ml
> >
> > Reference here:
> > 'The easiest solution is to delay processing of descriptors to a bottom
> > half whenever MMIO is doing something complicated.  This is also better
> > for latency because it will free the vCPU thread more quickly and leave
> > the work to the I/O thread.'
>
>
> I think several things were missed in this patch (take virtio-net as a
> reference), do we need the following things:
>

Thanks Jason,
In fact I know this, I'm scared for touching this but I want to try.
Thanks for your advice.

> - Cancel the bh when VM is stopped.

Ok. I think add a vm state change notifier for e1000e can address this.

> - A throttle to prevent bh from executing too much timer?

Ok, I think add a config timeout and add a timer in e1000e can address this=
.

> - A flag to record whether or not this a pending tx (and migrate it?)

Is just a flag enough? Could you explain more about the idea behind
processing the virtio-net/e1000e using bh like this?
For example, if the guest trigger a lot of packets send and if the bh
is scheduled in IO thread. So will we lost packets?
How we avoid this in virtio-net.

Thanks,
Li Qiang



>
> Thanks
>
>
> >
> > This patch fixes this UAF.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >   hw/net/e1000e_core.c | 25 +++++++++++++++++--------
> >   hw/net/e1000e_core.h |  2 ++
> >   2 files changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> > index bcd186cac5..6165b04b68 100644
> > --- a/hw/net/e1000e_core.c
> > +++ b/hw/net/e1000e_core.c
> > @@ -2423,32 +2423,27 @@ e1000e_set_dbal(E1000ECore *core, int index, ui=
nt32_t val)
> >   static void
> >   e1000e_set_tctl(E1000ECore *core, int index, uint32_t val)
> >   {
> > -    E1000E_TxRing txr;
> >       core->mac[index] =3D val;
> >
> >       if (core->mac[TARC0] & E1000_TARC_ENABLE) {
> > -        e1000e_tx_ring_init(core, &txr, 0);
> > -        e1000e_start_xmit(core, &txr);
> > +        qemu_bh_schedule(core->tx[0].tx_bh);
> >       }
> >
> >       if (core->mac[TARC1] & E1000_TARC_ENABLE) {
> > -        e1000e_tx_ring_init(core, &txr, 1);
> > -        e1000e_start_xmit(core, &txr);
> > +        qemu_bh_schedule(core->tx[1].tx_bh);
> >       }
> >   }
> >
> >   static void
> >   e1000e_set_tdt(E1000ECore *core, int index, uint32_t val)
> >   {
> > -    E1000E_TxRing txr;
> >       int qidx =3D e1000e_mq_queue_idx(TDT, index);
> >       uint32_t tarc_reg =3D (qidx =3D=3D 0) ? TARC0 : TARC1;
> >
> >       core->mac[index] =3D val & 0xffff;
> >
> >       if (core->mac[tarc_reg] & E1000_TARC_ENABLE) {
> > -        e1000e_tx_ring_init(core, &txr, qidx);
> > -        e1000e_start_xmit(core, &txr);
> > +        qemu_bh_schedule(core->tx[qidx].tx_bh);
> >       }
> >   }
> >
> > @@ -3322,6 +3317,16 @@ e1000e_vm_state_change(void *opaque, int running=
, RunState state)
> >       }
> >   }
> >
> > +static void e1000e_core_tx_bh(void *opaque)
> > +{
> > +    struct e1000e_tx *tx =3D opaque;
> > +    E1000ECore *core =3D tx->core;
> > +    E1000E_TxRing txr;
> > +
> > +    e1000e_tx_ring_init(core, &txr, tx - &core->tx[0]);
> > +    e1000e_start_xmit(core, &txr);
> > +}
> > +
> >   void
> >   e1000e_core_pci_realize(E1000ECore     *core,
> >                           const uint16_t *eeprom_templ,
> > @@ -3340,6 +3345,8 @@ e1000e_core_pci_realize(E1000ECore     *core,
> >       for (i =3D 0; i < E1000E_NUM_QUEUES; i++) {
> >           net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
> >                           E1000E_MAX_TX_FRAGS, core->has_vnet);
> > +        core->tx[i].core =3D core;
> > +        core->tx[i].tx_bh =3D qemu_bh_new(e1000e_core_tx_bh, &core->tx=
[i]);
> >       }
> >
> >       net_rx_pkt_init(&core->rx_pkt, core->has_vnet);
> > @@ -3367,6 +3374,8 @@ e1000e_core_pci_uninit(E1000ECore *core)
> >       for (i =3D 0; i < E1000E_NUM_QUEUES; i++) {
> >           net_tx_pkt_reset(core->tx[i].tx_pkt);
> >           net_tx_pkt_uninit(core->tx[i].tx_pkt);
> > +        qemu_bh_delete(core->tx[i].tx_bh);
> > +        core->tx[i].tx_bh =3D NULL;
> >       }
> >
> >       net_rx_pkt_uninit(core->rx_pkt);
> > diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
> > index aee32f7e48..94ddc6afc2 100644
> > --- a/hw/net/e1000e_core.h
> > +++ b/hw/net/e1000e_core.h
> > @@ -77,6 +77,8 @@ struct E1000Core {
> >           unsigned char sum_needed;
> >           bool cptse;
> >           struct NetTxPkt *tx_pkt;
> > +        QEMUBH *tx_bh;
> > +        E1000ECore *core;
> >       } tx[E1000E_NUM_QUEUES];
> >
> >       struct NetRxPkt *rx_pkt;
>

