Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA229C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737AC22203
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDJn1H96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737AC22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIVZ-0000w7-MT
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jvIUr-00006C-2R
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:49:13 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jvIUp-0003Ek-EF
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:49:12 -0400
Received: by mail-ot1-x342.google.com with SMTP id g37so12691796otb.9
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 03:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q8Q+enUYQbCfJx0XxqvHHurzsMz4GYIaJ4v4CYkeVHg=;
 b=JDJn1H96L4koYcSOvKwsHQu2OURo1DIbRc0jlHqJorhtlyP1Cm3UW279CDW2nz6h0G
 pa9SkHg3XGCmJLam9gaQgU0DpVf1FTzkPkL3u2G2bDTIfyZ832RCNwEjRM/ZfL7DhWIa
 EYbBpjy4d95ps1Cyy89NUOEvnma5r41dQRk+fLcpuK3jpxIvAfq9GgM8jtPEJxg2Vjur
 nruqJcK7uahDV7c9bL9SUQ+7YIggXm4vHH0Jq1Vj4d6bl3oFsxeHgJE+pnGaVs+Qewqu
 sL9bofJ1qMHkfODCSrU74DWhKt8ijde5qBavNn0iacPqeYYIj5V6jeIvnTC5sgnuN5m2
 GVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q8Q+enUYQbCfJx0XxqvHHurzsMz4GYIaJ4v4CYkeVHg=;
 b=sXkJhC3hv9H99NRdfzDrcbkPa5LGE2x0/07YYWQHCYgiBKtSzhAvmVHO9gbluAmOry
 TGHTSNijLFPxaclMIPzOJt7/hNVftHyPLvOVaIb2hP5bZYQFOxEgOY+vnfhe3yhKwq9o
 E1eTvwBLy84wbFAEKI7jWGFhH9TnshY0nmWr5P1rS83uFk7m0rIMcvt9Y6fgwJq6OvYh
 s6i6WJh7lzsP2Q5b+Rx93z85HJCj1t+aCtUH8zakyxxNr1xCc+Bx/QHQMh/LENh9T060
 snSFYM7AB1H72md6UdIB32xsvWaDPXXaXtDw95+zlLkRBY+qpEYK3vuste10EtOUsqha
 5zFw==
X-Gm-Message-State: AOAM531JEmtDnWevt1fBP1+TXmIow7BMk+9XBVfPjabgbHTqAD+FTuVB
 9NQCwemr7nNR6Wyp+cl4c4ZE3bw4oWNiw6pKEhw=
X-Google-Smtp-Source: ABdhPJweHm8jHEqJ3GA0QS09b0WriVHlFDP6LvyPjjekKHwKAPtB+i8c0v3sRAt+AwviBLlSzGKiT5z3b71ksh4l0E4=
X-Received: by 2002:a05:6830:15c3:: with SMTP id
 j3mr3239929otr.353.1594723749822; 
 Tue, 14 Jul 2020 03:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
 <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
 <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
 <e4a34525-dbd1-1f85-475b-b5004885215b@redhat.com>
In-Reply-To: <e4a34525-dbd1-1f85-475b-b5004885215b@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 14 Jul 2020 18:48:33 +0800
Message-ID: <CAKXe6SJb=1YLLGF+TP1fMd95k_WzZd73JeUJv5Sn4EE4m2zP4w@mail.gmail.com>
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x342.google.com
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
 Bug 1886362 <1886362@bugs.launchpad.net>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:56=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 2020/7/10 =E4=B8=8B=E5=8D=886:37, Li Qiang wrote:
> > Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:36=E5=86=99=E9=81=93=EF=BC=
=9A
> >> On 09/07/20 17:51, Li Qiang wrote:
> >>> Maybe we should check whether the address is a RAM address in 'dma_me=
mory_rw'?
> >>> But it is a hot path. I'm not sure it is right. Hope more discussion.
> >> Half of the purpose of dma-helpers.c (as opposed to address_space_*
> >> functions in exec.c) is exactly to support writes to MMIO.  This is
> > Hi Paolo,
> >
> > Could you please explain more about this(to support writes to MMIO).
> > I can just see the dma helpers with sg DMA, not related with MMIO.
>
>
> Please refer doc/devel/memory.rst.
>
> The motivation of memory API is to allow support modeling different
> memory regions. DMA to MMIO is allowed in hardware so Qemu should
> emulate this behaviour.
>

I just read the code again.
So the dma_blk_io is used for some device that will need DMA to
MMIO(may be related with
device spec).  But for most of the devices(networking card for
example) there is no need this DMA to MMIO.
So we just use dma_memory_rw.  Is this understanding right?

Then another question.
Though the dma helpers uses a bouncing buffer, it finally write to the
device addressspace in 'address_space_unmap'.
Is there any posibility that we can again write to the MMIO like this issue=
?


>
> >
> >
> >> especially true of dma_blk_io, which takes care of doing the DMA via a
> >> bounce buffer, possibly in multiple steps and even blocking due to
> >> cpu_register_map_client.
> >>
> >> For dma_memory_rw this is not needed, so it only needs to handle
> >> QEMUSGList, but I think the design should be the same.
> >>
> >> However, this is indeed a nightmare for re-entrancy.  The easiest
> >> solution is to delay processing of descriptors to a bottom half whenev=
er
> >> MMIO is doing something complicated.  This is also better for latency
> >> because it will free the vCPU thread more quickly and leave the work t=
o
> >> the I/O thread.
> > Do you mean we define a per-e1000e bottom half. And in the MMIO write
> > or packet send
> > trigger this bh?
>
>
> Probably a TX bh.
>

I will try to write this tx bh to strength my understanding in this part.
Maybe reference the virtio-net implementation I think.



Thanks,
Li Qiang

>
> > So even if we again trigger the MMIO write, then
> > second bh will not be executed?
>
>
> Bh is serialized so no re-entrancy issue.
>
> Thanks
>
>
> >
> >
> > Thanks,
> > Li Qiang
> >
> >> Paolo
> >>
>

