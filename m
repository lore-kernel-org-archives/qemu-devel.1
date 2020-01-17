Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4209C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812AF20730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3IR67is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812AF20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isOHt-0002rD-Ls
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 04:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1isOH9-00026T-TA
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1isOH6-0007g6-Fy
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:50:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44645
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1isOH6-0007fs-Cs
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579254644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6W46C2To8bMeKKC6puqI4drhhWBpfh81HVIFggRLJ8=;
 b=P3IR67is5rULDgxxCXnsM4GC9GPzMKiriJaMXG3s+Uqcedb9goK316y1jQqrX38DYE/U2J
 xprRO/x5Y9ej0y/IHi6TfAp/hii/EhcnlJR2qWBb5uIhS2/OfNLOj/cPFaca+T08wPOZpR
 OEr55u0icufRi876zLJ46KmcWik6NXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-SHBF_-YuO2aKGSawgTozNQ-1; Fri, 17 Jan 2020 04:50:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81841183B54F;
 Fri, 17 Jan 2020 09:50:39 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60EA819C4F;
 Fri, 17 Jan 2020 09:50:34 +0000 (UTC)
Date: Fri, 17 Jan 2020 10:50:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v3 18/86] arm:kzm: drop RAM size fixup
Message-ID: <20200117105033.6801593a@redhat.com>
In-Reply-To: <dc8d8594-0bf8-e6c2-9ce8-94bf5361bca3@redhat.com>
References: <87sgkgv6dh.wl-Peter.Chubb@data61.csiro.au>
 <1579195564-95459-1-git-send-email-imammedo@redhat.com>
 <dc8d8594-0bf8-e6c2-9ce8-94bf5361bca3@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SHBF_-YuO2aKGSawgTozNQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter.Chubb@data61.csiro.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 19:22:08 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/16/20 6:26 PM, Igor Mammedov wrote:
> > If the user provided too large a RAM size, the code used to
> > complain and trim it to the max size.  Now tht RAM is allocated by
> > generic code, that's no longer possible, so generate an error and
> > exit instead.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v3:
> >   * rephrase commit message in nicer way
> >     ("Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.=
au>)
> >   * reword error message and use size_to_str() to pretty print suggeste=
d size
> >     ("Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.=
au>)
> >=20
> > CC: peter.chubb@nicta.com.au
> > CC: peter.maydell@linaro.org
> > CC: qemu-arm@nongnu.org
> > ---
> >   hw/arm/kzm.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
> > index 1d5ef28..94cbac1 100644
> > --- a/hw/arm/kzm.c
> > +++ b/hw/arm/kzm.c
> > @@ -25,6 +25,7 @@
> >   #include "hw/char/serial.h"
> >   #include "sysemu/qtest.h"
> >   #include "sysemu/sysemu.h"
> > +#include "qemu/cutils.h"
> >  =20
> >   /* Memory map for Kzm Emulation Baseboard:
> >    * 0x00000000-0x7fffffff See i.MX31 SOC for support
> > @@ -78,10 +79,10 @@ static void kzm_init(MachineState *machine)
> >  =20
> >       /* Check the amount of memory is compatible with the SOC */
> >       if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1=
_SIZE)) {
> > -        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
> > -                    "reduced to %x", machine->ram_size,
> > -                    FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE);
> > -        machine->ram_size =3D FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1=
_SIZE;
> > +        char *sz =3D size_to_str(FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDR=
AM1_SIZE);
> > +        error_report("RAM size more than %s is not supported", sz); =
=20
>=20
> Yay! Can you use this pattern the other patches too?

I plan to, as it's much neater and I can avoid adding RAM_ADDR_FMT

Would your acks still stand or should I drop your Reviewed-bys
on changed in such way patches?
=20
> You might want to add:
>=20
> #define FSL_IMX31_SDRAM_SIZE_MAX \
>    (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE)
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> > +        g_free(sz);
> > +        exit(EXIT_FAILURE);
> >       }
> >  =20
> >       memory_region_allocate_system_memory(&s->ram, NULL, "kzm.ram",
> >  =20
>=20


