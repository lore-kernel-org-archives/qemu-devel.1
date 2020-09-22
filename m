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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E21AC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55AE2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVvUKxE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55AE2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKflr-00032H-Ph
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kKfgi-00044n-En; Tue, 22 Sep 2020 06:38:20 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kKfgg-0007A8-KS; Tue, 22 Sep 2020 06:38:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id m12so15190930otr.0;
 Tue, 22 Sep 2020 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SQqrWuAXlbyebW/YQIMKZgdLC1umQ4Sb3emjeKMw1zA=;
 b=GVvUKxE/lX6wS/c3V4d9+vtLu7w/2ncDK7JlPoNk+svCjNurr0yqTLmWA3GSNEuf5c
 pbm6BWpECGdRbVoRKgzT5n+W9aFqbFmnfwf9WoRfVomIyAY1gX/dFoshIe5PpDMJQ1Yv
 JeoMXuwNV1bPZtF3E7id2qYovGKxxCqdILhLiXS+kT9R9fY6IRvSYIqq+qu/9Qifx8p+
 hDTbz8PRGnouCI4Ar1gJJhKp657mddy/CQFjWhKBbkEIp/lJrkZ8L0HsFMHO5dX9oGzk
 bWThmaJWYoKRNGSeN75mQ9OM8EAXAlNDrkLlrLz+nP5IYxeSbGc6XclUlgQpNRtgJ7j5
 bIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SQqrWuAXlbyebW/YQIMKZgdLC1umQ4Sb3emjeKMw1zA=;
 b=ThW2dFHuadVSLgqZMeW9x/T/dwmLL9Uy3ddignsbWtC2PPorzJwyg7ZE0Wq6dMDAdg
 IxoLVwvA1y0XuyGcJHALwnsqHK7E0EhI3GsJEbko6k6C6keWyOWrH8U5K8t5jZPK766o
 GBMkR6/OQ1xBc399oQM1wchL6HzVABKVwoEi3Os6VYdRxyxXyIrlQi4FpeTYAelcxrMh
 4Hr5RtND5j8qk+4Dk+L39gkd8p/5DGWad/nihZ8pdTnkMLT61g9BhcHO5UpMYwz+iwqU
 pvma7bpWHq3Ro3qZiFAWLxfSPd7UxarR+QJ8NYy1B3EswCx3saQvfsIDfDptyVCEBokd
 wO8w==
X-Gm-Message-State: AOAM533YQVsNJkUnUshb+bvRiYqCVpGq6v4Wmt2DbGEhzHIYr6HJdItV
 76SpD0M1voJcBCYhdT5WVyHkeOwXy80j/L7DgPg=
X-Google-Smtp-Source: ABdhPJxuUr40PGhC3dbJm7MJ01J2k6KNRKiogwRJdy+yJYZhzkgtyXoMud0tkyGNf5/xbqVaVjWuvl+jDjZlbmdAMIM=
X-Received: by 2002:a05:6830:1187:: with SMTP id
 u7mr1612749otq.181.1600771097043; 
 Tue, 22 Sep 2020 03:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200815072052.73228-1-liq3ea@163.com>
 <20200922013411.auucs5t2hhw4romx@mozz.bu.edu>
 <8dcc2e29-6bd8-92d5-eaa6-9331aafe752a@redhat.com>
In-Reply-To: <8dcc2e29-6bd8-92d5-eaa6-9331aafe752a@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 22 Sep 2020 18:37:41 +0800
Message-ID: <CAKXe6S+r2W-jM2kp-Rhai_14STkZP2mVEDYDTn3=tVECgE8bAw@mail.gmail.com>
Subject: Re: [PATCH] hw: ide: check the pointer before do dma memory unmap
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
Cc: John Snow <jsnow@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=8822=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:19=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On 9/22/20 3:34 AM, Alexander Bulekov wrote:
> > On 200815 0020, Li Qiang wrote:
> >> In 'map_page' we need to check the return value of
> >> 'dma_memory_map' to ensure the we actully maped something.
> >> Otherwise, we will hit an assert in 'address_space_unmap'.
> >> This is because we can't find the MR with the NULL buffer.
> >> This is the LP#1884693:
> >>
> >> -->https://bugs.launchpad.net/qemu/+bug/1884693
> >>
> >> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> >> Signed-off-by: Li Qiang <liq3ea@163.com>
> >
> > I'm not very familiar with the IDE code, but this seems like a simple
> > null-ptr check, and Li has not received a response in over a month.
>
> Yeah well it is not an easy bug... I spent few hours but at some
> point it became too AHCI specific. I wanted to understand the bug
> to answer the "Why do we get there?" "Can we get there with real
> hardware?" questions, to be able to discern if this patch is OK,
> or if it is hiding bugs and what we really use here is an assert().

Hi Philippe,
I think you have complicated this issue. The root cause is that
'dma_memory_map' maybe fail.
The gpa is from guest and can be any value so this is expected.
It can return NULL pointer (no map) or it can be do partially
mapped(len < wanted).
Though in most situation the map result is 'ret =3D=3D NULL and len <
wanted'. It may also has '
ret !=3D NULL and len < wanted' I think.

The assert is come from that we pass NULL to 'dma_memory_unmap'.

So the standard usage of 'dma_memory_map' I think is first check if
the return value to ensure it is not NULL.
Then check whether it mapped the len as the caller expected.

There are several places in the code base that doesn't following this
usage which I think it is wrong.

Thanks,
Li Qiang

>
> >
> > Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
> >
> >> ---
> >>  hw/ide/ahci.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> >> index 009120f88b..63e9fccdbe 100644
> >> --- a/hw/ide/ahci.c
> >> +++ b/hw/ide/ahci.c
> >> @@ -250,6 +250,11 @@ static void map_page(AddressSpace *as, uint8_t **=
ptr, uint64_t addr,
> >>      }
> >>
> >>      *ptr =3D dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE=
);
> >> +
> >> +    if (!*ptr) {
> >> +        return;
> >> +    }
> >> +
> >>      if (len < wanted) {
> >>          dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, le=
n);
> >>          *ptr =3D NULL;
> >> --
> >> 2.17.1
> >>
> >
>

