Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D37C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A216321E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCDveTpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A216321E6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIpo-0001FQ-Qr
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvIpH-0000o9-Px
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvIpG-0007BR-RG
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:05:47 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvIpG-0007B9-LP; Wed, 07 Aug 2019 06:05:46 -0400
Received: by mail-ed1-x543.google.com with SMTP id k21so85672487edq.3;
 Wed, 07 Aug 2019 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EK6Rh/I3lTgtcbuIP5EJ9VrJzOcs6vUB56wPkBHaY9E=;
 b=QCDveTpi9C6+tZHxa0fDRwCD6VYAq82vbKXfZeeHTLaZW+a2zJkY7RBXeVQ7mVfjuP
 ohUeDbC4o1OTmt8t3/Hp4XVFaE0C0mlRlKE1TXmNrd77x08VlkZMkHPuLXGo/kuwuJ5d
 IBitaXP0IyDZhv/Etz90EzpclAG5Ap1gxSurSagPMdrRStzAeGzXkEI5/35TiXsdsOUq
 4JRiKkpfkdgdTXGuTzrO14lg6R1m5VQllhPYeCCzXqcis1gqtJ+lqghhrmeOoyRfuPtd
 Z6HGKkVV82IxxHZsmGleaxFemZ/dXVxVgmAroNoR9ak7wUhYg2MaBYF1pYGtfWXV7nvz
 Fy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EK6Rh/I3lTgtcbuIP5EJ9VrJzOcs6vUB56wPkBHaY9E=;
 b=MCrJI7Aw2kkR5dGpYS88mEtlQRpJj5EUcpoHC3u8NkWHIEP5WF/wVvz8s9ATO1Lgdd
 MrlZ7AXVD546SByL6m/d1M9ZbzZ4Dh6Su0WdR92dXXqrx8noSNB1amQFuu+9OMjr9Tq7
 5HfffX4mWrUEhAvYPRLCp9GaPR4Fhhb4/EX0ZWR0KXaiRNczfh+bIaa8FyNlT2h7JxB6
 dp+ZzipnvO+K6Ohr96ZPata/3KiUS7Gbx6QUn8DAXcDKJC+CcUEFjL12eEPVL/QSA1Sb
 W3sYMzHEG1LyurpEaXJz0a8hCD2wqmZVPv/JGAcKB2V4S57wwL+WRji5PyvdwyUpQ0qg
 zPAw==
X-Gm-Message-State: APjAAAWuUV6OPUFtxvS0NYtJe3hAjoaw2JgGOeB+MOvS/Y8fu7raP6NE
 T909G/G3c4elf8i/r7R7ERNiNoOW4z/z2bx2lhs=
X-Google-Smtp-Source: APXvYqzdod/oCMeJIqf9VERTg/mJ8/t92IT+y2mx6TTjfQRqE2EscOyDmZWP/zBn1nNIgFUkbbyPkEfQJNdq1LuY6ag=
X-Received: by 2002:a17:906:499a:: with SMTP id
 p26mr7544472eju.308.1565172345578; 
 Wed, 07 Aug 2019 03:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-8-git-send-email-bmeng.cn@gmail.com>
 <9ed12581-f73e-af09-0a0e-7bce3b69d998@redhat.com>
In-Reply-To: <9ed12581-f73e-af09-0a0e-7bce3b69d998@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 7 Aug 2019 18:05:33 +0800
Message-ID: <CAEUhbmU+3zFOGb2J6S78z2Gx9guOvL5aqwSYcxL1JV_Ejh-B3w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v2 07/28] riscv: sifive_u: Set the minimum
 number of cpus to 2
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
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 5:46 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 8/7/19 9:45 AM, Bin Meng wrote:
> > It is not useful if we only have one management CPU.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >
> > ---
> >
> > Changes in v2:
> > - update the file header to indicate at least 2 harts are created
> >
> >  hw/riscv/sifive_u.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index 821f1d5..91f3c76 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -10,8 +10,8 @@
> >   * 1) CLINT (Core Level Interruptor)
> >   * 2) PLIC (Platform Level Interrupt Controller)
> >   *
> > - * This board currently generates devicetree dynamically that indicate=
s at most
> > - * five harts.
> > + * This board currently generates devicetree dynamically that indicate=
s at least
> > + * two harts and up to five harts.
> >   *
> >   * This program is free software; you can redistribute it and/or modif=
y it
> >   * under the terms and conditions of the GNU General Public License,
> > @@ -429,6 +429,8 @@ static void riscv_sifive_u_machine_init(MachineClas=
s *mc)
> >       * management CPU.
> >       */
> >      mc->max_cpus =3D 5;
>
> I'm confuse this patch does not apply on top of v4.1.0-rc4.
>

I suspect you need apply the whole series, not this single one due to
patch dependencies in this series?

> Using #define makes these comments redundant, something like:
>
> #define MANAGEMENT_CPU_COUNT 1
> #define COMPUTE_CPU_COUNT 4
>
> then you could use
>
>   max_cpus =3D MANAGEMENT_CPU_COUNT + COMPUTE_CPU_COUNT
>
> and
>
>   min_cpus =3D MANAGEMENT_CPU_COUNT + 1.
>

Good idea! I will change that in the next version. Thanks!

Regards,
Bin

