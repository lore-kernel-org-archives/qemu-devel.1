Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10822C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F3A21901
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C943aWnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F3A21901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpd3d-0003XY-6j
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 14:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41761)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hpd3S-00037k-LE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hpd3R-0003xU-EY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:28:58 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:34267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hpd3R-0003vC-60; Mon, 22 Jul 2019 14:28:57 -0400
Received: by mail-lj1-x243.google.com with SMTP id p17so38571086ljg.1;
 Mon, 22 Jul 2019 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2LYN+HFAN3Zc26Yb2l/eqxmbblx0Wue9MrZcplQeh9M=;
 b=C943aWnDRMK/pMo1SSozct3k9NNFGbx1UeooojLj7Zv65PuVHG0piXmy3LFWoyBPXK
 xEoMtCZceAIUJfZ1lvR2oZxvrf3nhXuLv4CrJiDl/VN0Y3TuI6V7LcJihtrF2QrBNAFf
 i4zMrHdf3Wj5pz5k6SMNoLOuQXfD9cgwJo7+AsZim1fTteefU0hwHWHlAUgH1z5BWy+X
 8WvpcTFs/ezKAbLZQuiN4yYRtiJBdcaBnZeD9PPKQXoI/470dOjqhWQ5+/bV5eQqG3QN
 vOQ+w3n9PJV0uik/BJDrgdJQaTO/gRnjHYuT61j4v+dE1Y/9LVNwD9pSIOsYz+l1VJ60
 KGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2LYN+HFAN3Zc26Yb2l/eqxmbblx0Wue9MrZcplQeh9M=;
 b=Dtml+TtQuPJqPklhBM33BbFUYl1S0HUBpqwo1upmnsJIlzJu7Eh5r8i1OqFVF2VWVr
 pK54jiSH92JMsT0FekaJoqM7Yer/57GtKPFjFW4oitWH2opkQAw0o964byqFgZS/32EN
 EVisB+ahIjWo96ur9sSAr1AouGdUGr/9aDzQDTf1fD0oLsk6gJsD+eylAJkKRv/mCz0I
 zpXyntKySk7XNNwncSAAnDmYL3N++AD6iFfIwSDwC/52rpth+9wXaKiTRKaZAv5UCVcV
 wANcAK0uUGkdWLD3ywWKuVa+PNaWrXVF18QZ94P95q45vsho/UKlIV+StdurOsQalLUp
 kf3Q==
X-Gm-Message-State: APjAAAUfHI+1jbOGLBcPq7xsMJ4ZKejxAQ0baSb2wsEL5XOG6D60EFsm
 iEYgny9i1miSu20d3XbgeNCkekhZNe46lc0eIcA=
X-Google-Smtp-Source: APXvYqwi7lJZ8qG4CPNKvyXxAlnY27eWY3r1CldSl9WtdA1dgowbssGjxw/U/xuiksQP0GsBIfcoOIagKvGz7oLm2Tc=
X-Received: by 2002:a2e:9158:: with SMTP id q24mr37496552ljg.119.1563820134933; 
 Mon, 22 Jul 2019 11:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <1563603512-5914-1-git-send-email-frederic.konrad@adacore.com>
 <70060fbc-b79f-6385-2b1e-0cebb45ca03e@redhat.com>
 <1f427dc9-deb9-f900-470a-84b79ab32a2a@redhat.com>
 <8d86172a-b37f-5445-928a-46ec7f225b18@adacore.com>
In-Reply-To: <8d86172a-b37f-5445-928a-46ec7f225b18@adacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jul 2019 11:25:23 -0700
Message-ID: <CAKmqyKMnrEcw5ED7YcKu2akmzmH0ydjx=U6Sx=dmX+vhD5m7-Q@mail.gmail.com>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] riscv: htif: use qemu_log_mask instead of
 qemu_log
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 22, 2019 at 2:29 AM KONRAD Frederic
<frederic.konrad@adacore.com> wrote:
>
> Hi Philippe,
>
> Le 7/20/19 =C3=A0 11:50 AM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit :
> > Cc'ing Stefan
> >
> > On 7/20/19 11:44 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >> Hi Frederic,
> >>
> >> On 7/20/19 8:18 AM, KONRAD Frederic wrote:
> >>> There are some debug trace appearing when using GDB with the HTIF map=
ped @0:
> >>>   Invalid htif read: address 0000000000000002
> >>>   Invalid htif read: address 0000000000000006
> >>>   Invalid htif read: address 000000000000000a
> >>>   Invalid htif read: address 000000000000000e
> >>>
> >>> So don't show them unconditionally.
> >>>
> >>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> >>> ---
> >>>   hw/riscv/riscv_htif.c | 21 ++++++++++++---------
> >>>   1 file changed, 12 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
> >>> index 4f7b11d..6a8f0c2 100644
> >>> --- a/hw/riscv/riscv_htif.c
> >>> +++ b/hw/riscv/riscv_htif.c
> >>> @@ -119,7 +119,8 @@ static void htif_handle_tohost_write(HTIFState *h=
tifstate, uint64_t val_written)
> >>>       int resp =3D 0;
> >>>
> >>>       HTIF_DEBUG("mtohost write: device: %d cmd: %d what: %02" PRIx64
> >>> -        " -payload: %016" PRIx64 "\n", device, cmd, payload & 0xFF, =
payload);
> >>> +               " -payload: %016" PRIx64 "\n", device, cmd, payload &=
 0xFF,
> >>> +               payload);
> >>>
> >>>       /*
> >>>        * Currently, there is a fixed mapping of devices:
> >>> @@ -137,7 +138,7 @@ static void htif_handle_tohost_write(HTIFState *h=
tifstate, uint64_t val_written)
> >>>                   qemu_log_mask(LOG_UNIMP, "pk syscall proxy not supp=
orted\n");
> >>>               }
> >>>           } else {
> >>> -            qemu_log("HTIF device %d: unknown command\n", device);
> >>> +            HTIF_DEBUG("HTIF device %d: unknown command\n", device);
> >>
> >> Generally, please don't go back to using DPRINTF() but use trace-event=
s
> >> instead.
> >
> > Oh, now I see that HTIF_DEBUG() is just an obscure way to report
> > crippled log trace-events, not portable to all trace backends.
> >
> > It is only used in 2 files:
> >
> > - hw/riscv/riscv_htif.c
> > - target/riscv/pmp.c as PMP_DEBUG()
> >
> > I'd rather remove these macros and use trace-events the same way the
> > rest of the codebase use them, usable by all backends.
> >
>
> Ok why not.. If the RISC-V maintainers are happy with your suggestion I c=
an do
> a patch.

Yes please!

Most of these look like qemu_log_mask(LOG_GUEST_ERROR) cases so that's
probably the best bet. The others should probably be converted to
traces.

Alistair

>
> Cheers,
> Fred
>
> >> However in this calls it seems using qemu_log_mask(LOG_UNIMP) or
> >> qemu_log_mask(LOG_GUEST_ERROR) is appropriate.
> >>
> >>>           }
> >>>       } else if (likely(device =3D=3D 0x1)) {
> >>>           /* HTIF Console */
> >>> @@ -150,12 +151,13 @@ static void htif_handle_tohost_write(HTIFState =
*htifstate, uint64_t val_written)
> >>>               qemu_chr_fe_write(&htifstate->chr, (uint8_t *)&payload,=
 1);
> >>>               resp =3D 0x100 | (uint8_t)payload;
> >>>           } else {
> >>> -            qemu_log("HTIF device %d: unknown command\n", device);
> >>> +            HTIF_DEBUG("HTIF device %d: unknown command\n", device);
> >>>           }
> >>>       } else {
> >>> -        qemu_log("HTIF unknown device or command\n");
> >>> +        HTIF_DEBUG("HTIF unknown device or command\n");
> >>>           HTIF_DEBUG("device: %d cmd: %d what: %02" PRIx64
> >>> -            " payload: %016" PRIx64, device, cmd, payload & 0xFF, pa=
yload);
> >>> +                   " payload: %016" PRIx64, device, cmd, payload & 0=
xFF,
> >>> +                   payload);
> >>>       }
> >>>       /*
> >>>        * - latest bbl does not set fromhost to 0 if there is a value =
in tohost
> >>> @@ -180,6 +182,7 @@ static void htif_handle_tohost_write(HTIFState *h=
tifstate, uint64_t val_written)
> >>>   static uint64_t htif_mm_read(void *opaque, hwaddr addr, unsigned si=
ze)
> >>>   {
> >>>       HTIFState *htifstate =3D opaque;
> >>> +
> >>>       if (addr =3D=3D TOHOST_OFFSET1) {
> >>>           return htifstate->env->mtohost & 0xFFFFFFFF;
> >>>       } else if (addr =3D=3D TOHOST_OFFSET2) {
> >>> @@ -189,8 +192,8 @@ static uint64_t htif_mm_read(void *opaque, hwaddr=
 addr, unsigned size)
> >>>       } else if (addr =3D=3D FROMHOST_OFFSET2) {
> >>>           return (htifstate->env->mfromhost >> 32) & 0xFFFFFFFF;
> >>>       } else {
> >>> -        qemu_log("Invalid htif read: address %016" PRIx64 "\n",
> >>> -            (uint64_t)addr);
> >>> +        HTIF_DEBUG("Invalid htif read: address %016" PRIx64 "\n",
> >>> +                   (uint64_t)addr);
> >>>           return 0;
> >>>       }
> >>>   }
> >>> @@ -219,8 +222,8 @@ static void htif_mm_write(void *opaque, hwaddr ad=
dr,
> >>>           htifstate->env->mfromhost |=3D value << 32;
> >>>           htifstate->fromhost_inprogress =3D 0;
> >>>       } else {
> >>> -        qemu_log("Invalid htif write: address %016" PRIx64 "\n",
> >>> -            (uint64_t)addr);
> >>> +        HTIF_DEBUG("Invalid htif write: address %016" PRIx64 "\n",
> >>> +                   (uint64_t)addr);
> >>>       }
> >>>   }
> >>>
> >>>
>

