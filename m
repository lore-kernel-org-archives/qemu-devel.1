Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA56C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 02:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94ECA20714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 02:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI6/qTd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94ECA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHerY-0004yV-Or
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 22:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1jHeqo-0004Yj-4z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1jHeqk-0004z0-Ib
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:36:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36819)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1jHeqk-0004wZ-7N
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 22:35:58 -0400
Received: by mail-ot1-x343.google.com with SMTP id l23so8284632otf.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 19:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Em1G0PCxtqDgGzRavAXB2K5dqGgA00hylZapFCR/9N4=;
 b=CI6/qTd9SB7DA1ea0Sq4aeIkP7tsmmbbcftqhPa5dPIVrjjNA8cKlrAMQ0rTbfzOFL
 wBOoP6/Tzl3sdDFkYQMYICxUWnNm5vnSRYk+Oq/sL44LDoENuFLbSDtt8b3dBmn6xiMh
 i+Hn6Wf8Kh4f+FD6ohyefeILnmFJBHVY7SXhMN4k5rZnV/aCmcv//CYpnkFX2BUv2Eeq
 91R2t0a85vwUTwasV9OY9aNuEvj2O4lmkG9DsBJM3YPYFxeKkHfs5KCA9G4tF1+2LmoZ
 0N4/1u80FjhN8evMoipMAzzR0lpJuMCQcKt8JbDPpLj/V3nC9sw8Sb+GPT1EAWBvJ658
 9uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Em1G0PCxtqDgGzRavAXB2K5dqGgA00hylZapFCR/9N4=;
 b=fbHpOn1YQcNnoTCC3gdFlLu8B0QVYJKv4JLGDFl66iNBBGM4RQOfYXb/BKikJhPXXu
 xbBey9JGO3aoKArbN9uCfofjnNdg3s0D1zL185G3LkW9VKY2CxbndKCbUHAJaoJRJyeF
 5eaWXshNlD4DXmUR7CzAkwc022VIvPBhb6WKNcaUWGrZ3YxHx9GC1GJn0Rwg10ZWlL1K
 SKZWWJWJjioBm1FpXZRdUCPv60Gz/Bi/of2IvkjNsnsBLSOgI9yLgV3uxKR14lIf6gnZ
 5o+8zVe/DSBE34GMUXK4tUo2FYLNNAj8P9jO/Y6uWri8K3tI+Urbpjv4oUtQrLDn/PjK
 l1VA==
X-Gm-Message-State: ANhLgQ3xP7iY0iFvZcPl9yk4UXUfn7zTwElNAeO7W6ljHkw17wwwD/hT
 icpkaulfRVBK2QKzfd+PpGgqUcibOW9RpapemnU=
X-Google-Smtp-Source: ADFU+vss4C3IdnMOcS+a90u/mPKuedwWoMUCdJfdO7Bcl/lCWGPDhAkykjAp1jb2VLVFSqIQeAQZiEoa+fp9W4epxWs=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr2141157otq.181.1585276556642; 
 Thu, 26 Mar 2020 19:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200323122100.893417-1-ppandit@redhat.com>
 <20200323122100.893417-2-ppandit@redhat.com>
 <CAKXe6SKtuk7qr1dFVJoHm3LZ40OG8Nfhanj1zqdBVzAQ+Smc0w@mail.gmail.com>
 <a72da97b-dc0f-99d4-1d59-aba9da2760c9@redhat.com>
 <CAKXe6SJMc0jinC-aWqhSp=ZH3Es0rHLbV-nwq1p0_hPY_vBTDA@mail.gmail.com>
 <9f126c07-91f0-47b8-81c4-aafb9aee66ca@redhat.com>
In-Reply-To: <9f126c07-91f0-47b8-81c4-aafb9aee66ca@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 27 Mar 2020 10:35:20 +0800
Message-ID: <CAKXe6SKHRq8_bHmHnLfWkpfnyMvyW_54NPGhKp0yaXWqJ_O8Pw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] net: tulip: check frame size and r/w data length
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000007ab0e05a1ccf6dd"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Li Qiang <pangpei.lq@antfin.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000007ab0e05a1ccf6dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8810:09=E5=86=99=E9=81=93=EF=BC=9A

>
> On 2020/3/24 =E4=B8=8B=E5=8D=8810:54, Li Qiang wrote:
> >
> >
> > Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>
> > =E4=BA=8E2020=E5=B9=B43=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=
=E5=8D=881:45=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> >     On 2020/3/24 =E4=B8=8A=E5=8D=889:29, Li Qiang wrote:
> >     >
> >     >
> >     > P J P <ppandit@redhat.com <mailto:ppandit@redhat.com>
> >     <mailto:ppandit@redhat.com <mailto:ppandit@redhat.com>>>
> >     =E4=BA=8E2020=E5=B9=B43=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=80
> >     > =E4=B8=8B=E5=8D=888:24=E5=86=99=E9=81=93=EF=BC=9A
> >     >
> >     >     From: Prasad J Pandit <pjp@fedoraproject.org
> >     <mailto:pjp@fedoraproject.org>
> >     >     <mailto:pjp@fedoraproject.org <mailto:pjp@fedoraproject.org>>=
>
> >     >
> >     >     Tulip network driver while copying tx/rx buffers does not che=
ck
> >     >     frame size against r/w data length. This may lead to OOB buff=
er
> >     >     access. Add check to avoid it.
> >     >
> >     >     Limit iterations over descriptors to avoid potential infinite
> >     >     loop issue in tulip_xmit_list_update.
> >     >
> >     >     Reported-by: Li Qiang <pangpei.lq@antfin.com
> >     <mailto:pangpei.lq@antfin.com>
> >     >     <mailto:pangpei.lq@antfin.com <mailto:pangpei.lq@antfin.com>>=
>
> >     >     Reported-by: Ziming Zhang <ezrakiez@gmail.com
> >     <mailto:ezrakiez@gmail.com>
> >     >     <mailto:ezrakiez@gmail.com <mailto:ezrakiez@gmail.com>>>
> >     >     Reported-by: Jason Wang <jasowang@redhat.com
> >     <mailto:jasowang@redhat.com>
> >     >     <mailto:jasowang@redhat.com <mailto:jasowang@redhat.com>>>
> >     >     Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org
> >     <mailto:pjp@fedoraproject.org>
> >     >     <mailto:pjp@fedoraproject.org <mailto:pjp@fedoraproject.org>>=
>
> >     >
> >     >
> >     >
> >     > Tested-by: Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>
> >     <mailto:liq3ea@gmail.com <mailto:liq3ea@gmail.com>>>
> >     > But I have a minor question....
> >     >
> >     >     ---
> >     >      hw/net/tulip.c | 36 +++++++++++++++++++++++++++---------
> >     >      1 file changed, 27 insertions(+), 9 deletions(-)
> >     >
> >     >     Update v3: return a value from tulip_copy_tx_buffers() and
> avoid
> >     >     infinite loop
> >     >       ->
> >     >
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
> >     >
> >     >     diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> >     >     index cfac2719d3..fbe40095da 100644
> >     >     --- a/hw/net/tulip.c
> >     >     +++ b/hw/net/tulip.c
> >     >     @@ -170,6 +170,10 @@ static void tulip_copy_rx_bytes(TULIPSta=
te
> >     >     *s, struct tulip_descriptor *desc)
> >     >              } else {
> >     >                  len =3D s->rx_frame_len;
> >     >              }
> >     >     +
> >     >     +        if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) =
{
> >     >     +            return;
> >     >     +        }
> >     >
> >     >
> >     >
> >     > Why here is '>=3D' instead of '>'.
> >     > IIUC the total sending length can reach to sizeof(s->rx_frame).
> >     > Same in the other place in this patch.
> >
> >
> >     Yes, this need to be fixed.
> >
> >
> >     >
> >     > PS: I have planned to write a qtest case. But my personal qemu de=
v
> >     > environment is broken.
> >     > I will try to write it tonight or tomorrow night.
> >
> >
> >     Cool, good to know this.
> >
> >
> > Hi all,
> > I have countered an interesting issue. Let's look at the definition of
> > TULIPState.
> >
> >   21 typedef struct TULIPState {
> >   22     PCIDevice dev;
> >   23     MemoryRegion io;
> >   24     MemoryRegion memory;
> >   25     NICConf c;
> >   26     qemu_irq irq;
> >   27     NICState *nic;
> >   28     eeprom_t *eeprom;
> >   29     uint32_t csr[16];
> >   30
> >   31     /* state for MII */
> >   32     uint32_t old_csr9;
> >   33     uint32_t mii_word;
> >   34     uint32_t mii_bitcnt;
> >   35
> >   36     hwaddr current_rx_desc;
> >   37     hwaddr current_tx_desc;
> >   38
> >   39     uint8_t rx_frame[2048];
> >   40     uint8_t tx_frame[2048];
> >   41     uint16_t tx_frame_len;
> >   42     uint16_t rx_frame_len;
> >   43     uint16_t rx_frame_size;
> >   44
> >   45     uint32_t rx_status;
> >   46     uint8_t filter[16][6];
> >   47 } TULIPState;
> >
> > Here we can see the overflow is occured after 'tx_frame'.
> > In my quest, I have see the overflow(the s->tx_frame_len is big).
> > However here doesn't cause SEGV in qtest.
> > In real case, the qemu process will access the data after TULIPState
> > in heap and trigger segv.
> > However in qtest mode I don't know how to trigger this.
>
>
> If it's just the mangling of tx_frame_len, it won't hit SIGSEV.
>
> I wonder maybe, somehow that large tx_frame_len is used for buffer
> copying or other stuffs that can lead the crash.
>

This is because in real qemu process, the OOB copy corrupts the head data
after 'TULIPState' struct.
And maybe later(other thread) access the corrupted data thus leading crash.
However in qtest mode, I don't remember the core code of qtest. But seems
it's not a really VM? just a interface emulation.

In my case, it's backtrace is as this:
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffbdb7fe700 (LWP 60813)]
0x0000000000000000 in ?? ()
...
(gdb) bt
#0  0x0000000000000000 in  ()
#1  0x0000555555a7dfa3 in qemu_set_irq (irq=3D0x5555579e0710, level=3D1) at
hw/core/irq.c:44
#2  0x0000555555b2b87a in tulip_update_int (s=3D0x5555579da7c0) at
hw/net/tulip.c:121
#3  0x0000555555b2cdd9 in tulip_xmit_list_update (s=3D0x5555579da7c0) at
hw/net/tulip.c:667
#4  0x0000555555b2d19d in tulip_write (opaque=3D0x5555579da7c0, addr=3D32,
data=3D931909632, size=3D4) at hw/net/tulip.c:759
#5  0x000055555587eed1 in memory_region_write_accessor (mr=3D0x5555579db0b0=
,
addr=3D32, value=3D0x7ffbdb7fd6a8, size=3D4, shift=3D0, mask=3D4294967295, =
attrs=3D...)
at /xxx/qemu/memory.c:483
#6  0x000055555587f0da in access_with_adjusted_size (addr=3D32,
value=3D0x7ffbdb7fd6a8, size=3D4, access_size_min=3D4, access_size_max=3D4,
access_fn=3D0x55555587edf2 <memory_region_write_accessor>, mr=3D0x5555579db=
0b0,
attrs=3D...)
    at /xxx/qemu/memory.c:544
#7  0x000055555588213b in memory_region_dispatch_write (mr=3D0x5555579db0b0=
,
addr=3D32, data=3D931909632, op=3DMO_32, attrs=3D...) at /xxx/qemu/memory.c=
:1476
#8  0x000055555581fe9c in flatview_write_continue (fv=3D0x7ffbb001eae0,
addr=3D49184, attrs=3D..., ptr=3D0x7ffff7e13000, len=3D4, addr1=3D32, l=3D4=
,
mr=3D0x5555579db0b0) at /xxx/qemu/exec.c:3125
#9  0x000055555581fff4 in flatview_write (fv=3D0x7ffbb001eae0, addr=3D49184=
,
attrs=3D..., buf=3D0x7ffff7e13000, len=3D4) at /xxx/qemu/exec.c:3165
#10 0x0000555555820368 in address_space_write (as=3D0x555556762560
<address_space_io>, addr=3D49184, attrs=3D..., buf=3D0x7ffff7e13000, len=3D=
4) at
/xxx/qemu/exec.c:3256
#11 0x00005555558203da in address_space_rw (as=3D0x555556762560
<address_space_io>, addr=3D49184, attrs=3D..., buf=3D0x7ffff7e13000, len=3D=
4,
is_write=3Dtrue) at /xxx/qemu/exec.c:3266
#12 0x000055555589723b in kvm_handle_io (port=3D49184, attrs=3D...,
data=3D0x7ffff7e13000, direction=3D1, size=3D4, count=3D1) at
/xxx/qemu/accel/kvm/kvm-all.c:2140
#13 0x00005555558979d6 in kvm_cpu_exec (cpu=3D0x555556b1e220) at
/xxx/qemu/accel/kvm/kvm-all.c:2386
#14 0x00005555558701c5 in qemu_kvm_cpu_thread_fn (arg=3D0x555556b1e220) at
/xxx/qemu/cpus.c:1246
#15 0x0000555555de3ce4 in qemu_thread_start (args=3D0x555556b44040) at
util/qemu-thread-posix.c:519
#16 0x00007ffff5bb0e25 in start_thread () at /lib64/libpthread.so.0
#17 0x00007ffff58d8f1d in clone () at /lib64/libc.so.6

I will try to dig into the qtest code and hope find a way to trigger a segv
in qtest.

Thanks,
Li Qiang



>
> Thanks
>
>
> >
> > The core code like this:
> >
> >  qpci_device_enable(dev);
> > bar =3D qpci_iomap(dev, 0, NULL);
> >     context_pa =3D guest_alloc(alloc, sizeof(context));
> >     guest_pa =3D guest_alloc(alloc, 4096);
> > memset(guest_data, 'A', sizeof(guest_data));
> >     context[0].status =3D 1 << 31;
> > context[0].control =3D 0x7ff << 11 | 0x7ff;
> > context[0].buf_addr2 =3D context_pa + sizeof(struct tulip_descriptor);
> > context[0].buf_addr1 =3D guest_pa;
> >     for (i =3D 1; i < ARRAY_SIZE(context); ++i) {
> >         context_pa +=3D sizeof(struct tulip_descriptor);
> >         context[i].status =3D 1 << 31;
> > context[i].control =3D 0x7ff << 11 | 0x7ff;
> > context[i].buf_addr2 =3D context_pa + sizeof(struct tulip_descriptor);
> > context[i].buf_addr1 =3D guest_pa;
> > }
> >
> > qtest_memwrite(dev->bus->qts, context_pa, context, sizeof(context));
> > qtest_memwrite(dev->bus->qts, guest_pa, guest_data, sizeof(guest_data))=
;
> > qpci_io_writel(dev, bar, 0x20, context_pa);
> > qpci_io_writel(dev, bar, 0x30, 1 << 13);
> >
> > Paolo may give some hints?
> >
> > Thanks,
> > Li Qiang
> >
> >     Thanks
> >
> >
> >     >
> >     > Thanks,
> >     > Li Qiang
> >     >
> >     >
> >     >
> >     >
> >     >              pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame =
+
> >     >                  (s->rx_frame_size - s->rx_frame_len), len);
> >     >              s->rx_frame_len -=3D len;
> >     >     @@ -181,6 +185,10 @@ static void tulip_copy_rx_bytes(TULIPSta=
te
> >     >     *s, struct tulip_descriptor *desc)
> >     >              } else {
> >     >                  len =3D s->rx_frame_len;
> >     >              }
> >     >     +
> >     >     +        if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) =
{
> >     >     +            return;
> >     >     +        }
> >     >              pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame =
+
> >     >                  (s->rx_frame_size - s->rx_frame_len), len);
> >     >              s->rx_frame_len -=3D len;
> >     >     @@ -227,7 +235,8 @@ static ssize_t tulip_receive(TULIPState *=
s,
> >     >     const uint8_t *buf, size_t size)
> >     >
> >     >          trace_tulip_receive(buf, size);
> >     >
> >     >     -    if (size < 14 || size > 2048 || s->rx_frame_len ||
> >     >     tulip_rx_stopped(s)) {
> >     >     +    if (size < 14 || size > sizeof(s->rx_frame) - 4
> >     >     +        || s->rx_frame_len || tulip_rx_stopped(s)) {
> >     >              return 0;
> >     >          }
> >     >
> >     >     @@ -275,7 +284,6 @@ static ssize_t
> >     tulip_receive_nc(NetClientState
> >     >     *nc,
> >     >          return tulip_receive(qemu_get_nic_opaque(nc), buf, size)=
;
> >     >      }
> >     >
> >     >     -
> >     >      static NetClientInfo net_tulip_info =3D {
> >     >          .type =3D NET_CLIENT_DRIVER_NIC,
> >     >          .size =3D sizeof(NICState),
> >     >     @@ -558,7 +566,7 @@ static void tulip_tx(TULIPState *s, struc=
t
> >     >     tulip_descriptor *desc)
> >     >              if ((s->csr[6] >> CSR6_OM_SHIFT) & CSR6_OM_MASK) {
> >     >                  /* Internal or external Loopback */
> >     >                  tulip_receive(s, s->tx_frame, s->tx_frame_len);
> >     >     -        } else {
> >     >     +        } else if (s->tx_frame_len <=3D sizeof(s->tx_frame))=
 {
> >     >  qemu_send_packet(qemu_get_queue(s->nic),
> >     >                      s->tx_frame, s->tx_frame_len);
> >     >              }
> >     >     @@ -570,23 +578,31 @@ static void tulip_tx(TULIPState *s,
> struct
> >     >     tulip_descriptor *desc)
> >     >          }
> >     >      }
> >     >
> >     >     -static void tulip_copy_tx_buffers(TULIPState *s, struct
> >     >     tulip_descriptor *desc)
> >     >     +static int tulip_copy_tx_buffers(TULIPState *s, struct
> >     >     tulip_descriptor *desc)
> >     >      {
> >     >          int len1 =3D (desc->control >> TDES1_BUF1_SIZE_SHIFT) &
> >     >     TDES1_BUF1_SIZE_MASK;
> >     >          int len2 =3D (desc->control >> TDES1_BUF2_SIZE_SHIFT) &
> >     >     TDES1_BUF2_SIZE_MASK;
> >     >
> >     >     +    if (s->tx_frame_len + len1 >=3D sizeof(s->tx_frame)) {
> >     >     +        return -1;
> >     >     +    }
> >     >          if (len1) {
> >     >              pci_dma_read(&s->dev, desc->buf_addr1,
> >     >                  s->tx_frame + s->tx_frame_len, len1);
> >     >              s->tx_frame_len +=3D len1;
> >     >          }
> >     >
> >     >     +    if (s->tx_frame_len + len2 >=3D sizeof(s->tx_frame)) {
> >     >     +        return -1;
> >     >     +    }
> >     >          if (len2) {
> >     >              pci_dma_read(&s->dev, desc->buf_addr2,
> >     >                  s->tx_frame + s->tx_frame_len, len2);
> >     >              s->tx_frame_len +=3D len2;
> >     >          }
> >     >          desc->status =3D (len1 + len2) ? 0 : 0x7fffffff;
> >     >     +
> >     >     +    return 0;
> >     >      }
> >     >
> >     >      static void tulip_setup_filter_addr(TULIPState *s, uint8_t
> >     *buf,
> >     >     int n)
> >     >     @@ -651,13 +667,15 @@ static uint32_t tulip_ts(TULIPState *s)
> >     >
> >     >      static void tulip_xmit_list_update(TULIPState *s)
> >     >      {
> >     >     +#define TULIP_DESC_MAX 128
> >     >     +    uint8_t i =3D 0;
> >     >          struct tulip_descriptor desc;
> >     >
> >     >          if (tulip_ts(s) !=3D CSR5_TS_SUSPENDED) {
> >     >              return;
> >     >          }
> >     >
> >     >     -    for (;;) {
> >     >     +    for (i =3D 0; i < TULIP_DESC_MAX; i++) {
> >     >              tulip_desc_read(s, s->current_tx_desc, &desc);
> >     >              tulip_dump_tx_descriptor(s, &desc);
> >     >
> >     >     @@ -675,10 +693,10 @@ static void
> >     >     tulip_xmit_list_update(TULIPState *s)
> >     >                      s->tx_frame_len =3D 0;
> >     >                  }
> >     >
> >     >     -            tulip_copy_tx_buffers(s, &desc);
> >     >     -
> >     >     -            if (desc.control & TDES1_LS) {
> >     >     -                tulip_tx(s, &desc);
> >     >     +            if (!tulip_copy_tx_buffers(s, &desc)) {
> >     >     +                if (desc.control & TDES1_LS) {
> >     >     +                    tulip_tx(s, &desc);
> >     >     +                }
> >     >                  }
> >     >              }
> >     >              tulip_desc_write(s, s->current_tx_desc, &desc);
> >     >     --
> >     >     2.25.1
> >     >
> >     >
> >
>
>

--00000000000007ab0e05a1ccf6dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Jason Wang &lt;<a href=3D"mailto:jaso=
wang@redhat.com">jasowang@redhat.com</a>&gt; =E4=BA=8E2020=E5=B9=B43=E6=9C=
=8827=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8810:09=E5=86=99=E9=81=93=
=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/3/24 =E4=B8=8B=E5=8D=8810:54, Li Qiang wrote:<br>
&gt;<br>
&gt;<br>
&gt; Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank=
">jasowang@redhat.com</a> &lt;mailto:<a href=3D"mailto:jasowang@redhat.com"=
 target=3D"_blank">jasowang@redhat.com</a>&gt;&gt; <br>
&gt; =E4=BA=8E2020=E5=B9=B43=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=
=8B=E5=8D=881:45=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2020/3/24 =E4=B8=8A=E5=8D=889:29, Li Qiang wrote=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; P J P &lt;<a href=3D"mailto:ppandit@redhat.com=
" target=3D"_blank">ppandit@redhat.com</a> &lt;mailto:<a href=3D"mailto:ppa=
ndit@redhat.com" target=3D"_blank">ppandit@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:ppandit@redhat.com" ta=
rget=3D"_blank">ppandit@redhat.com</a> &lt;mailto:<a href=3D"mailto:ppandit=
@redhat.com" target=3D"_blank">ppandit@redhat.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=E4=BA=8E2020=E5=B9=B43=E6=9C=8823=E6=97=A5=E5=91=
=A8=E4=B8=80<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =E4=B8=8B=E5=8D=888:24=E5=86=99=E9=81=93=EF=BC=
=9A<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0From: Prasad J Pandit &lt;<=
a href=3D"mailto:pjp@fedoraproject.org" target=3D"_blank">pjp@fedoraproject=
.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pjp@fedoraproject.org"=
 target=3D"_blank">pjp@fedoraproject.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailt=
o:pjp@fedoraproject.org" target=3D"_blank">pjp@fedoraproject.org</a> &lt;ma=
ilto:<a href=3D"mailto:pjp@fedoraproject.org" target=3D"_blank">pjp@fedorap=
roject.org</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Tulip network driver while =
copying tx/rx buffers does not check<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0frame size against r/w data=
 length. This may lead to OOB buffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0access. Add check to avoid =
it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Limit iterations over descr=
iptors to avoid potential infinite<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0loop issue in tulip_xmit_li=
st_update.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Reported-by: Li Qiang &lt;<=
a href=3D"mailto:pangpei.lq@antfin.com" target=3D"_blank">pangpei.lq@antfin=
.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pangpei.lq@antfin.com"=
 target=3D"_blank">pangpei.lq@antfin.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailt=
o:pangpei.lq@antfin.com" target=3D"_blank">pangpei.lq@antfin.com</a> &lt;ma=
ilto:<a href=3D"mailto:pangpei.lq@antfin.com" target=3D"_blank">pangpei.lq@=
antfin.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Reported-by: Ziming Zhang &=
lt;<a href=3D"mailto:ezrakiez@gmail.com" target=3D"_blank">ezrakiez@gmail.c=
om</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:ezrakiez@gmail.com" ta=
rget=3D"_blank">ezrakiez@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailt=
o:ezrakiez@gmail.com" target=3D"_blank">ezrakiez@gmail.com</a> &lt;mailto:<=
a href=3D"mailto:ezrakiez@gmail.com" target=3D"_blank">ezrakiez@gmail.com</=
a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Reported-by: Jason Wang &lt=
;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.c=
om</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jasowang@redhat.com" t=
arget=3D"_blank">jasowang@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailt=
o:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a> &lt;mailto=
:<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.c=
om</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Prasad J Pan=
dit &lt;<a href=3D"mailto:pjp@fedoraproject.org" target=3D"_blank">pjp@fedo=
raproject.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pjp@fedoraproject.org"=
 target=3D"_blank">pjp@fedoraproject.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailt=
o:pjp@fedoraproject.org" target=3D"_blank">pjp@fedoraproject.org</a> &lt;ma=
ilto:<a href=3D"mailto:pjp@fedoraproject.org" target=3D"_blank">pjp@fedorap=
roject.org</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Tested-by: Li Qiang &lt;<a href=3D"mailto:liq3=
ea@gmail.com" target=3D"_blank">liq3ea@gmail.com</a> &lt;mailto:<a href=3D"=
mailto:liq3ea@gmail.com" target=3D"_blank">liq3ea@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:liq3ea@gmail.com" targ=
et=3D"_blank">liq3ea@gmail.com</a> &lt;mailto:<a href=3D"mailto:liq3ea@gmai=
l.com" target=3D"_blank">liq3ea@gmail.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; But I have a minor question....<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0hw/net/tulip.c | 36 +=
++++++++++++++++++++++++++---------<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 27 in=
sertions(+), 9 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Update v3: return a value f=
rom tulip_copy_tx_buffers() and avoid<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0infinite loop<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 -&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"https://lists.gnu.org/archive/html/=
qemu-devel/2020-02/msg06275.html" rel=3D"noreferrer" target=3D"_blank">http=
s://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/hw/net/tulip.c=
 b/hw/net/tulip.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0index cfac2719d3..fbe40095d=
a 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--- a/hw/net/tulip.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+++ b/hw/net/tulip.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -170,6 +170,10 @@ static=
 void tulip_copy_rx_bytes(TULIPState<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0*s, struct tulip_descriptor=
 *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0len =3D s-&gt;rx_frame_len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (s-&gt;rx_frame_len + len &gt;=3D sizeof(s-&gt;rx_frame)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Why here is &#39;&gt;=3D&#39; instead of &#39;=
&gt;&#39;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; IIUC the total sending length can reach to siz=
eof(s-&gt;rx_frame).<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Same in the other place in this patch.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes, this need to be fixed.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; PS: I have planned to write a qtest case. But =
my personal qemu dev<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; environment is broken.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I will try to write it tonight or=C2=A0tomorro=
w night.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cool, good to know this.<br>
&gt;<br>
&gt;<br>
&gt; Hi all,<br>
&gt; I have countered an interesting issue. Let&#39;s look at the definitio=
n of <br>
&gt; TULIPState.<br>
&gt;<br>
&gt; =C2=A0 21 typedef struct TULIPState {<br>
&gt; =C2=A0 22 =C2=A0 =C2=A0 PCIDevice dev;<br>
&gt; =C2=A0 23 =C2=A0 =C2=A0 MemoryRegion io;<br>
&gt; =C2=A0 24 =C2=A0 =C2=A0 MemoryRegion memory;<br>
&gt; =C2=A0 25 =C2=A0 =C2=A0 NICConf c;<br>
&gt; =C2=A0 26 =C2=A0 =C2=A0 qemu_irq irq;<br>
&gt; =C2=A0 27 =C2=A0 =C2=A0 NICState *nic;<br>
&gt; =C2=A0 28 =C2=A0 =C2=A0 eeprom_t *eeprom;<br>
&gt; =C2=A0 29 =C2=A0 =C2=A0 uint32_t csr[16];<br>
&gt; =C2=A0 30<br>
&gt; =C2=A0 31 =C2=A0 =C2=A0 /* state for MII */<br>
&gt; =C2=A0 32 =C2=A0 =C2=A0 uint32_t old_csr9;<br>
&gt; =C2=A0 33 =C2=A0 =C2=A0 uint32_t mii_word;<br>
&gt; =C2=A0 34 =C2=A0 =C2=A0 uint32_t mii_bitcnt;<br>
&gt; =C2=A0 35<br>
&gt; =C2=A0 36 =C2=A0 =C2=A0 hwaddr current_rx_desc;<br>
&gt; =C2=A0 37 =C2=A0 =C2=A0 hwaddr current_tx_desc;<br>
&gt; =C2=A0 38<br>
&gt; =C2=A0 39 =C2=A0 =C2=A0 uint8_t rx_frame[2048];<br>
&gt; =C2=A0 40 =C2=A0 =C2=A0 uint8_t tx_frame[2048];<br>
&gt; =C2=A0 41 =C2=A0 =C2=A0 uint16_t tx_frame_len;<br>
&gt; =C2=A0 42 =C2=A0 =C2=A0 uint16_t rx_frame_len;<br>
&gt; =C2=A0 43 =C2=A0 =C2=A0 uint16_t rx_frame_size;<br>
&gt; =C2=A0 44<br>
&gt; =C2=A0 45 =C2=A0 =C2=A0 uint32_t rx_status;<br>
&gt; =C2=A0 46 =C2=A0 =C2=A0 uint8_t filter[16][6];<br>
&gt; =C2=A0 47 } TULIPState;<br>
&gt;<br>
&gt; Here we can see the overflow is occured after &#39;tx_frame&#39;.<br>
&gt; In my quest, I have see the overflow(the s-&gt;tx_frame_len is big).<b=
r>
&gt; However here doesn&#39;t cause SEGV in qtest.<br>
&gt; In real case, the qemu process will access the data after TULIPState <=
br>
&gt; in heap and trigger segv.<br>
&gt; However in qtest mode I don&#39;t know how to trigger this.<br>
<br>
<br>
If it&#39;s just the mangling of tx_frame_len, it won&#39;t hit SIGSEV.<br>
<br>
I wonder maybe, somehow that large tx_frame_len is used for buffer <br>
copying or other stuffs that can lead the crash.<br></blockquote><div><br><=
/div><div>This is because in real qemu process, the OOB copy corrupts the h=
ead data after &#39;TULIPState&#39; struct.</div><div>And maybe later(other=
 thread) access the corrupted data thus leading crash.</div><div>However in=
 qtest mode, I don&#39;t remember the core code of qtest. But seems it&#39;=
s not a really VM? just a interface=C2=A0emulation.</div><div>=C2=A0</div><=
div>In my case, it&#39;s backtrace is as this:</div><div>Program received s=
ignal SIGSEGV, Segmentation fault.<br>[Switching to Thread 0x7ffbdb7fe700 (=
LWP 60813)]<br>0x0000000000000000 in ?? ()</div><div>...<br>(gdb) bt<br>#0 =
=C2=A00x0000000000000000 in =C2=A0()<br>#1 =C2=A00x0000555555a7dfa3 in qemu=
_set_irq (irq=3D0x5555579e0710, level=3D1) at hw/core/irq.c:44<br>#2 =C2=A0=
0x0000555555b2b87a in tulip_update_int (s=3D0x5555579da7c0) at hw/net/tulip=
.c:121<br>#3 =C2=A00x0000555555b2cdd9 in tulip_xmit_list_update (s=3D0x5555=
579da7c0) at hw/net/tulip.c:667<br>#4 =C2=A00x0000555555b2d19d in tulip_wri=
te (opaque=3D0x5555579da7c0, addr=3D32, data=3D931909632, size=3D4) at hw/n=
et/tulip.c:759<br>#5 =C2=A00x000055555587eed1 in memory_region_write_access=
or (mr=3D0x5555579db0b0, addr=3D32, value=3D0x7ffbdb7fd6a8, size=3D4, shift=
=3D0, mask=3D4294967295, attrs=3D...) at /xxx/qemu/memory.c:483<br>#6 =C2=
=A00x000055555587f0da in access_with_adjusted_size (addr=3D32, value=3D0x7f=
fbdb7fd6a8, size=3D4, access_size_min=3D4, access_size_max=3D4, access_fn=
=3D0x55555587edf2 &lt;memory_region_write_accessor&gt;, mr=3D0x5555579db0b0=
, attrs=3D...)<br>=C2=A0 =C2=A0 at /xxx/qemu/memory.c:544<br>#7 =C2=A00x000=
055555588213b in memory_region_dispatch_write (mr=3D0x5555579db0b0, addr=3D=
32, data=3D931909632, op=3DMO_32, attrs=3D...) at /xxx/qemu/memory.c:1476<b=
r>#8 =C2=A00x000055555581fe9c in flatview_write_continue (fv=3D0x7ffbb001ea=
e0, addr=3D49184, attrs=3D..., ptr=3D0x7ffff7e13000, len=3D4, addr1=3D32, l=
=3D4, mr=3D0x5555579db0b0) at /xxx/qemu/exec.c:3125<br>#9 =C2=A00x000055555=
581fff4 in flatview_write (fv=3D0x7ffbb001eae0, addr=3D49184, attrs=3D..., =
buf=3D0x7ffff7e13000, len=3D4) at /xxx/qemu/exec.c:3165<br>#10 0x0000555555=
820368 in address_space_write (as=3D0x555556762560 &lt;address_space_io&gt;=
, addr=3D49184, attrs=3D..., buf=3D0x7ffff7e13000, len=3D4) at /xxx/qemu/ex=
ec.c:3256<br>#11 0x00005555558203da in address_space_rw (as=3D0x55555676256=
0 &lt;address_space_io&gt;, addr=3D49184, attrs=3D..., buf=3D0x7ffff7e13000=
, len=3D4, is_write=3Dtrue) at /xxx/qemu/exec.c:3266<br>#12 0x0000555555897=
23b in kvm_handle_io (port=3D49184, attrs=3D..., data=3D0x7ffff7e13000, dir=
ection=3D1, size=3D4, count=3D1) at /xxx/qemu/accel/kvm/kvm-all.c:2140<br>#=
13 0x00005555558979d6 in kvm_cpu_exec (cpu=3D0x555556b1e220) at /xxx/qemu/a=
ccel/kvm/kvm-all.c:2386<br>#14 0x00005555558701c5 in qemu_kvm_cpu_thread_fn=
 (arg=3D0x555556b1e220) at /xxx/qemu/cpus.c:1246<br>#15 0x0000555555de3ce4 =
in qemu_thread_start (args=3D0x555556b44040) at util/qemu-thread-posix.c:51=
9<br>#16 0x00007ffff5bb0e25 in start_thread () at /lib64/libpthread.so.0<br=
>#17 0x00007ffff58d8f1d in clone () at /lib64/libc.so.6<br></div><div><br><=
/div><div>I will try to dig into the qtest code and hope find a way to trig=
ger a segv in qtest.</div><div><br></div><div>Thanks,</div><div>Li Qiang</d=
iv><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Thanks<br>
<br>
<br>
&gt;<br>
&gt; The core code like this:<br>
&gt;<br>
&gt; =C2=A0qpci_device_enable(dev);<br>
&gt; bar =3D qpci_iomap(dev, 0, NULL);<br>
&gt; =C2=A0 =C2=A0 context_pa =3D guest_alloc(alloc, sizeof(context));<br>
&gt; =C2=A0 =C2=A0 guest_pa =3D guest_alloc(alloc, 4096);<br>
&gt; memset(guest_data, &#39;A&#39;, sizeof(guest_data));<br>
&gt; =C2=A0 =C2=A0 context[0].status =3D 1 &lt;&lt; 31;<br>
&gt; context[0].control =3D 0x7ff &lt;&lt; 11 | 0x7ff;<br>
&gt; context[0].buf_addr2 =3D context_pa + sizeof(struct tulip_descriptor);=
<br>
&gt; context[0].buf_addr1 =3D guest_pa;<br>
&gt; =C2=A0 =C2=A0 for (i =3D 1; i &lt; ARRAY_SIZE(context); ++i) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 context_pa +=3D sizeof(struct tulip_descri=
ptor);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 context[i].status =3D 1 &lt;&lt; 31;<br>
&gt; context[i].control =3D 0x7ff &lt;&lt; 11 | 0x7ff;<br>
&gt; context[i].buf_addr2 =3D context_pa + sizeof(struct tulip_descriptor);=
<br>
&gt; context[i].buf_addr1 =3D guest_pa;<br>
&gt; }<br>
&gt;<br>
&gt; qtest_memwrite(dev-&gt;bus-&gt;qts, context_pa, context, sizeof(contex=
t));<br>
&gt; qtest_memwrite(dev-&gt;bus-&gt;qts, guest_pa, guest_data, sizeof(guest=
_data));<br>
&gt; qpci_io_writel(dev, bar, 0x20, context_pa);<br>
&gt; qpci_io_writel(dev, bar, 0x30, 1 &lt;&lt; 13);<br>
&gt;<br>
&gt; Paolo may give some hints?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Li Qiang<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Li Qiang<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pci_dma_write(&amp;s-&gt;dev, desc-&gt;buf_addr1, s-&gt;rx_frame +<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(s-&gt;rx_frame_size - s-&gt;rx_frame_len), len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s-&gt;rx_frame_len -=3D len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -181,6 +185,10 @@ static=
 void tulip_copy_rx_bytes(TULIPState<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0*s, struct tulip_descriptor=
 *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0len =3D s-&gt;rx_frame_len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (s-&gt;rx_frame_len + len &gt;=3D sizeof(s-&gt;rx_frame)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pci_dma_write(&amp;s-&gt;dev, desc-&gt;buf_addr2, s-&gt;rx_frame +<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(s-&gt;rx_frame_size - s-&gt;rx_frame_len), len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s-&gt;rx_frame_len -=3D len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -227,7 +235,8 @@ static =
ssize_t tulip_receive(TULIPState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0const uint8_t *buf, size_t =
size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0trace_t=
ulip_receive(buf, size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (size &lt=
; 14 || size &gt; 2048 || s-&gt;rx_frame_len ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0tulip_rx_stopped(s)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (size &lt=
; 14 || size &gt; sizeof(s-&gt;rx_frame) - 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 || s-&gt;rx_frame_len || tulip_rx_stopped(s)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -275,7 +284,6 @@ static =
ssize_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0tulip_receive_nc(NetClientState<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0*nc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0return =
tulip_receive(qemu_get_nic_opaque(nc), buf, size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0static NetClientInfo =
net_tulip_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0.type =
=3D NET_CLIENT_DRIVER_NIC,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0.size =
=3D sizeof(NICState),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -558,7 +566,7 @@ static =
void tulip_tx(TULIPState *s, struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if ((s-&gt;csr[6] &gt;&gt; CSR6_OM_SHIFT) &amp; CSR6_OM_MASK) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0/* Internal or external Loopback */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0tulip_receive(s, s-&gt;tx_frame, s-&gt;tx_frame_len);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } else if (s-&gt;tx_frame_len &lt;=3D sizeof(s-&gt;tx_frame)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0qemu_send_packet(qemu_get_queue(s-&gt;ni=
c),<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_frame, s-&gt;tx_frame_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -570,23 +578,31 @@ stati=
c void tulip_tx(TULIPState *s, struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-static void tulip_copy_tx_=
buffers(TULIPState *s, struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+static int tulip_copy_tx_b=
uffers(TULIPState *s, struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int len=
1 =3D (desc-&gt;control &gt;&gt; TDES1_BUF1_SIZE_SHIFT) &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0TDES1_BUF1_SIZE_MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int len=
2 =3D (desc-&gt;control &gt;&gt; TDES1_BUF2_SIZE_SHIFT) &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0TDES1_BUF2_SIZE_MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s-&gt;tx=
_frame_len + len1 &gt;=3D sizeof(s-&gt;tx_frame)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (len=
1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pci_dma_read(&amp;s-&gt;dev, desc-&gt;buf_addr1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_frame + s-&gt;tx_frame_len, len1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s-&gt;tx_frame_len +=3D len1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s-&gt;tx=
_frame_len + len2 &gt;=3D sizeof(s-&gt;tx_frame)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (len=
2) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pci_dma_read(&amp;s-&gt;dev, desc-&gt;buf_addr2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_frame + s-&gt;tx_frame_len, len2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s-&gt;tx_frame_len +=3D len2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0desc-&g=
t;status =3D (len1 + len2) ? 0 : 0x7fffffff;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 return 0;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0static void tulip_set=
up_filter_addr(TULIPState *s, uint8_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0*buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0int n)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -651,13 +667,15 @@ stati=
c uint32_t tulip_ts(TULIPState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0static void tulip_xmi=
t_list_update(TULIPState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+#define TULIP_DESC_MAX 128=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 uint8_t i =
=3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0struct =
tulip_descriptor desc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (tul=
ip_ts(s) !=3D CSR5_TS_SUSPENDED) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 for (;;) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 for (i =3D 0=
; i &lt; TULIP_DESC_MAX; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tulip_desc_read(s, s-&gt;current_tx_desc, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tulip_dump_tx_descriptor(s, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -675,10 +693,10 @@ stati=
c void<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0tulip_xmit_list_update(TULI=
PState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_frame_len =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tulip_copy_tx_buffers(s, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (desc.control &amp; TDES1_LS) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tulip_tx(s, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (!tulip_copy_tx_buffers(s, &amp;desc)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc.control &amp; TDES1_LS) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tulip_tx(s, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tulip_desc_write(s, s-&gt;current_tx_desc, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A02.25.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;<br>
<br>
</blockquote></div></div>

--00000000000007ab0e05a1ccf6dd--

