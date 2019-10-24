Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9501CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0662166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0662166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbWJ-0000sw-38
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iNb38-0003OS-6R
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iNb36-0001SP-RC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:13:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iNb36-0001Ry-JJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:13:00 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C7E9B4E919
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:12:59 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id m7so13034447otc.11
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 04:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IVJGlbjmC8YxXRv3XhIhG4IkKHi+YOzThhNUpLQ4XfM=;
 b=dud2RSdBvJ8ak4lj4OZtvWAaErfZX+jZ2TxQOtyT1yGLjpaDzkdMAcJXJYjsT5KxpR
 87B1fiOcnjQ2fX7ac6T/A3rroBXQkhRHCDSA4Rw4UkJydSBivUt3Z8nW9dXJBzkOdUFj
 yJA0TB66BS27tByccK/klHkMz4AQhYQrPlMGVS4Tyu717SWnKdDG7HBzpXKglyhN9HWw
 YM5ShgjuOVuwFpO1jhs/KPriL8u3Mpnf4k9EbACp5a9JJRHcFfHzOL4v7iXeyQ8+K3Hm
 px5jypEsuex0tdkUWMsamqeQpweaPOxOmKQZr/vN/lmoGlZK1CJ97TKZJ13fkXTcPFT9
 fB4w==
X-Gm-Message-State: APjAAAVD/PHM6DX/3g2hIvUkcDqeUq2teu/PopOWeiLdgiMHaY2EFpwr
 FXSOp68VY/MzfV+3UiE80REnPYh1dM/+glz3pe44Ux3VF4w8+QqBxAIckslzXRB+J8d+281Efwk
 05Pojm3jV/+UVi1rLwjZnf7pG0tJWWcc=
X-Received: by 2002:a05:6830:1003:: with SMTP id
 a3mr6367269otp.166.1571915579133; 
 Thu, 24 Oct 2019 04:12:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzgeTJR0woCmzAkkFWpuNfq1DQcA5xKHk2J7BuUbaxmOizL4X47kI//iATfvfu2aqnF0v5qUGf8amsD2uWJVgE=
X-Received: by 2002:a05:6830:1003:: with SMTP id
 a3mr6367236otp.166.1571915578846; 
 Thu, 24 Oct 2019 04:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-24-marcandre.lureau@redhat.com>
 <06288994-a5d3-038d-794e-ed63acdadd95@redhat.com>
In-Reply-To: <06288994-a5d3-038d-794e-ed63acdadd95@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 24 Oct 2019 13:12:47 +0200
Message-ID: <CAMxuvawLDSsNkoSXNprXAWVZ13FZT_WZ5V3AXyN0euT9SKa1DQ@mail.gmail.com>
Subject: Re: [PATCH v3 23/33] dp8393x: replace PROP_PTR with PROP_LINK
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 1:02 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Link property is the correct way to pass a MemoryRegion to a device
> > for DMA purposes.
> >
> > Sidenote: as a sysbus device, this remains non-usercreatable
> > even though we can drop the specific flag here.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/mips/mips_jazz.c | 3 ++-
> >   hw/net/dp8393x.c    | 7 +++----
> >   2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> > index 8d010a0b6e..878925a963 100644
> > --- a/hw/mips/mips_jazz.c
> > +++ b/hw/mips/mips_jazz.c
> > @@ -284,7 +284,8 @@ static void mips_jazz_init(MachineState *machine,
> >               dev =3D qdev_create(NULL, "dp8393x");
> >               qdev_set_nic_properties(dev, nd);
> >               qdev_prop_set_uint8(dev, "it_shift", 2);
> > -            qdev_prop_set_ptr(dev, "dma_mr", rc4030_dma_mr);
> > +            object_property_set_link(OBJECT(dev), OBJECT(rc4030_dma_mr=
),
> > +                                     "dma_mr", &error_abort);
> >               qdev_init_nofail(dev);
> >               sysbus =3D SYS_BUS_DEVICE(dev);
> >               sysbus_mmio_map(sysbus, 0, 0x80001000);
> > diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> > index a5678e11fa..946c7a8f64 100644
> > --- a/hw/net/dp8393x.c
> > +++ b/hw/net/dp8393x.c
> > @@ -173,7 +173,7 @@ typedef struct dp8393xState {
> >       int loopback_packet;
> >
> >       /* Memory access */
> > -    void *dma_mr;
> > +    MemoryRegion *dma_mr;
> >       AddressSpace as;
> >   } dp8393xState;
> >
> > @@ -922,7 +922,8 @@ static const VMStateDescription vmstate_dp8393x =3D=
 {
> >
> >   static Property dp8393x_properties[] =3D {
> >       DEFINE_NIC_PROPERTIES(dp8393xState, conf),
> > -    DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
> > +    DEFINE_PROP_LINK("dma_mr", dp8393xState, dma_mr,
> > +                     TYPE_MEMORY_REGION, MemoryRegion *),
> >       DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> > @@ -936,8 +937,6 @@ static void dp8393x_class_init(ObjectClass *klass, =
void *data)
> >       dc->reset =3D dp8393x_reset;
> >       dc->vmsd =3D &vmstate_dp8393x;
> >       dc->props =3D dp8393x_properties;
> > -    /* Reason: dma_mr property can't be set */
> > -    dc->user_creatable =3D false;
>
> Patch is OK except this user_creatable change I don't understand.

It's a sysbus device, so it's not user-creatable anyway. I'll add a
commit comment.

>
> >   }
> >
> >   static const TypeInfo dp8393x_info =3D {
> >

