Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CA1C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB0623A79
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxwJIHQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB0623A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKWxY-0003xK-TU
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 21:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kKWwu-0003Su-1Q; Mon, 21 Sep 2020 21:18:28 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kKWws-0005L3-Ca; Mon, 21 Sep 2020 21:18:27 -0400
Received: by mail-ot1-x341.google.com with SMTP id y5so14162619otg.5;
 Mon, 21 Sep 2020 18:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GnCsAYztQqgczgLc++weGUcUC37O51w4WulNLHvkge0=;
 b=rxwJIHQLOE5qxIp8vnC9+EypD5DY1H5zxMamXuP7lWwtNtBQfYdsDAI5M8VF8z51wX
 pa0wXbH3kx4Vwh1ILsN4Et5lx/x4haJ+mpvbBV91H8C7XYTvFzsKBo+xGZ3QWgfKgEGZ
 4Vz+6Brm2A9ihBRKfUbN4kB8brskhKWJ3jqc4YUxc02OzOqoZKBFU59AxlnjA2fsQUYj
 giNxj+lgz+rH7Wdm9di71acTsBmfv3977n7VcIGCEeWwM7FLYCw2okUK213NuYLDlblz
 TMeVCZVbsrxSRtVRWFti9WLgPlCRgg3mcp/l0CVuO+TVjK/58DD6nDTOgQBJtnYRXJpo
 OI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GnCsAYztQqgczgLc++weGUcUC37O51w4WulNLHvkge0=;
 b=H9mqP+YB13gNbNdD4+nn5GxPQ5TetZCh0cJdquDoNowGhNtUfsqbvEEhDucg6XIY8+
 H9rLvChKemrfZVbjN8feKWyF8ZOR/zIgRiLuL73CzsGH0uI/7D6ZD+NVP4K5xjLVuGoP
 JjhibP8ab0WFvblT94bFkciX6Us9o4L8Sqw6rJQTOJY/9dzGetPX2AeALAthEMRTyPVb
 F8r3qy54pRhD0UPpuT4QjysFOPb7NcpCHgNFCAdbwfT5tAqfAYvhvVPs3iUCvHAzElab
 wdl2YYNgF6+x4XjFQ7QzskfZGGd2sp8eiUKKHU6JO79/n23DaHKaMqEcN6fFAt7S9jaJ
 Hl8A==
X-Gm-Message-State: AOAM533ybfHslsmEC8x1QOfk5oyYwOruKyurHoYyqxx3pkD/uSfBbRoG
 BYdexSW/B0Z8N49xXdqk0f+OuLSg9T70DF1MK7c=
X-Google-Smtp-Source: ABdhPJyNGJXyiG7juIwA2Rtg9VoZBozCrWpc9HUXmn2640IzPvV3KuUYyU4adIr1cislDZLX1DWj1QsP2GUhSZN+sY4=
X-Received: by 2002:a05:6830:1187:: with SMTP id
 u7mr666951otq.181.1600737504681; 
 Mon, 21 Sep 2020 18:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200815072052.73228-1-liq3ea@163.com>
 <CAKXe6SJkqaeDBpDC__N6-RYgOMdTRO8NcJ0jkaFvAheEkfqbbw@mail.gmail.com>
 <CAKXe6S+Qq+GN6JYJa69+s0UHUd=2EKRAwJAjUKVt3+jPqdWeCQ@mail.gmail.com>
 <CAKXe6SJdkgYsenYLKrsWZSBya531dp-+rz2WRZuFLyC+NxR7Zg@mail.gmail.com>
In-Reply-To: <CAKXe6SJdkgYsenYLKrsWZSBya531dp-+rz2WRZuFLyC+NxR7Zg@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 22 Sep 2020 09:17:48 +0800
Message-ID: <CAKXe6S+SHCYT=iF=6Nsij3AAY7R4H2DFaiAb=tFHj9H+71ReeQ@mail.gmail.com>
Subject: Re: [PATCH] hw: ide: check the pointer before do dma memory unmap
To: Li Qiang <liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping!!

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8815=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:38=E5=86=99=E9=81=93=EF=BC=9A
>
> ping!!
>
> Li Qiang <liq3ea@gmail.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=887=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=889:39=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Ping!
> >
> > Li Qiang <liq3ea@gmail.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=881=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:34=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Ping.
> > >
> > > Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8815=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=883:21=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > In 'map_page' we need to check the return value of
> > > > 'dma_memory_map' to ensure the we actully maped something.
> > > > Otherwise, we will hit an assert in 'address_space_unmap'.
> > > > This is because we can't find the MR with the NULL buffer.
> > > > This is the LP#1884693:
> > > >
> > > > -->https://bugs.launchpad.net/qemu/+bug/1884693
> > > >
> > > > Reported-by: Alexander Bulekov <alxndr@bu.edu>
> > > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > > ---
> > > >  hw/ide/ahci.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> > > > index 009120f88b..63e9fccdbe 100644
> > > > --- a/hw/ide/ahci.c
> > > > +++ b/hw/ide/ahci.c
> > > > @@ -250,6 +250,11 @@ static void map_page(AddressSpace *as, uint8_t=
 **ptr, uint64_t addr,
> > > >      }
> > > >
> > > >      *ptr =3D dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEV=
ICE);
> > > > +
> > > > +    if (!*ptr) {
> > > > +        return;
> > > > +    }
> > > > +
> > > >      if (len < wanted) {
> > > >          dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE,=
 len);
> > > >          *ptr =3D NULL;
> > > > --
> > > > 2.17.1
> > > >

