Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DC7C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D355720936
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pM6WwYBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D355720936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBEX-0008CZ-TM
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kIBB1-0005Vw-6l; Tue, 15 Sep 2020 09:39:23 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kIBAz-0003a5-A3; Tue, 15 Sep 2020 09:39:18 -0400
Received: by mail-oi1-x241.google.com with SMTP id x69so3856911oia.8;
 Tue, 15 Sep 2020 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ReJBSgR0MBfNmaORKGPRNsYUCnnVMyzb4+glv2ZsKnw=;
 b=pM6WwYBaf8AkkEvmXYHoq141dWAR4xmz1alixsNvCndm2tt/NMWLrmenv5fUxEUuYz
 9XWM2lX+wFBunmPYvJsKaxVe9Ru7tbsMoFBe9K7dG2OEmsmw79eVr9U/bYsIsJzuW+d6
 OCUF+dnR153EWMYEr7+VWHSB7fTky1thdaJDkSX47e8Ycp9mZDvtAQmtXVA7tzhdGzB3
 P1ccV/hVdFY80Ct/tTAtqm3BsgSUUbf4mAY6JRXHSInzBXjPkveAXFGTtPEkTu6zSu96
 mj4RY70UZC3xaSXQaO1Rz21wTJeccpFhBCo8ZGvt7CK8NBjxX/MuPbPlL1UtkZMLFpbf
 w/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ReJBSgR0MBfNmaORKGPRNsYUCnnVMyzb4+glv2ZsKnw=;
 b=ZAvg2cms6mju7vChd39f+EVCgXmJtsWH5C/nrtiLvJuBj0fuMOoi7vAfSHGNgQSi4i
 m/cneWeCpU0jGIaUfgmvv2jpxIbPNkyr4eUb4jO604zwNfMxFAagl/CHxmEFqCfYELO1
 lmmRSD5DatiaWnT5e97hFCjRcjrU5VwyuWOpvhG/9Qa5D0TQZHb8HrXzN5POof2eis6r
 gHq7IjyZii0SnS8yOsKDNa8qdak/tvQRI0RMy1INQrtkX82WgDT/G8tf3GoPi9pHLMkw
 EToMxE9pgEhjxZuAEBaVCrwl5TWftnbu8GJda+Tc1yZATXmfGtDPx7a1eVqI54imTMNK
 KJUw==
X-Gm-Message-State: AOAM530/jozl1WngACjPOwA973NWyWS3Gg/yqbROf/X8gMZk8xOS/s9x
 +I+vRe6bKuop5USZG3MwJaDn19rdCDyGGpKCY4c=
X-Google-Smtp-Source: ABdhPJxSQsov/qvtrK62WO1tyQ6AHqk0qghi7qHyc02c8TMyUcVS5ZaDOFABFPnlUjQCntdHNzajxT3tIZduPYvNM8w=
X-Received: by 2002:aca:bf82:: with SMTP id p124mr3147098oif.133.1600177155481; 
 Tue, 15 Sep 2020 06:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200815072052.73228-1-liq3ea@163.com>
 <CAKXe6SJkqaeDBpDC__N6-RYgOMdTRO8NcJ0jkaFvAheEkfqbbw@mail.gmail.com>
 <CAKXe6S+Qq+GN6JYJa69+s0UHUd=2EKRAwJAjUKVt3+jPqdWeCQ@mail.gmail.com>
In-Reply-To: <CAKXe6S+Qq+GN6JYJa69+s0UHUd=2EKRAwJAjUKVt3+jPqdWeCQ@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 15 Sep 2020 21:38:39 +0800
Message-ID: <CAKXe6SJdkgYsenYLKrsWZSBya531dp-+rz2WRZuFLyC+NxR7Zg@mail.gmail.com>
Subject: Re: [PATCH] hw: ide: check the pointer before do dma memory unmap
To: Li Qiang <liq3ea@163.com>
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping!!

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=887=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=889:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Ping!
>
> Li Qiang <liq3ea@gmail.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=881=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:34=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Ping.
> >
> > Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8815=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=883:21=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > In 'map_page' we need to check the return value of
> > > 'dma_memory_map' to ensure the we actully maped something.
> > > Otherwise, we will hit an assert in 'address_space_unmap'.
> > > This is because we can't find the MR with the NULL buffer.
> > > This is the LP#1884693:
> > >
> > > -->https://bugs.launchpad.net/qemu/+bug/1884693
> > >
> > > Reported-by: Alexander Bulekov <alxndr@bu.edu>
> > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > ---
> > >  hw/ide/ahci.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> > > index 009120f88b..63e9fccdbe 100644
> > > --- a/hw/ide/ahci.c
> > > +++ b/hw/ide/ahci.c
> > > @@ -250,6 +250,11 @@ static void map_page(AddressSpace *as, uint8_t *=
*ptr, uint64_t addr,
> > >      }
> > >
> > >      *ptr =3D dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVIC=
E);
> > > +
> > > +    if (!*ptr) {
> > > +        return;
> > > +    }
> > > +
> > >      if (len < wanted) {
> > >          dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, l=
en);
> > >          *ptr =3D NULL;
> > > --
> > > 2.17.1
> > >

