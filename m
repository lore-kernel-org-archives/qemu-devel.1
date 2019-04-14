Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A32C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 18:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0568C20850
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2bb2fbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0568C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFkHO-0000tq-47
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 14:55:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hFkGU-0000Yf-HU
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hFkGQ-0002Nw-Jz
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:54:04 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:54083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
	id 1hFkGN-0002E8-NL; Sun, 14 Apr 2019 14:54:00 -0400
Received: by mail-it1-x143.google.com with SMTP id y204so23684847itf.3;
	Sun, 14 Apr 2019 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=U6JYYJtDcFUR2lci3Z9YTCspBToy3x2dQwOLVF5zitM=;
	b=X2bb2fbFzeTW40HYujTfW/bdod3isscSKEIigydknJXZiDY95Utv39iu4vgm6HXxCq
	L6/+FKYYEDyHefwR2coMblK7Q+VnuKJDbLk9zx78S5TKZ+UZ6cpuZrK1h5RVduhbW05n
	GRO/txh9LKOI9tejxKDs0ydLQJ5Jc9D5l0fG1SELFh8edRsfSNYRDUNnLvzcNMBC0Jx2
	EspLDk2Y5DJfXPlyh0zU/dGRqxXg1kJ3xkQeCP2DdPBN4qyIhD/MfjLOn2RJSCpz+k1i
	NNemEfQv9vsI3plboNxIsCzG66RyEgGQHsJxUr/CmkPjH/7GcsQriBdDwj2gsYF2op7/
	EiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=U6JYYJtDcFUR2lci3Z9YTCspBToy3x2dQwOLVF5zitM=;
	b=FrAWyxOw3aGFe8XgRYjlFgQAGd09ItixrfG3ikay+4ldNOeL0bMixEWM11f+u7/9Ix
	0HzdTCpT5LKIA9VkzX4Qetc6mfiVQMjIybxclXDUiIV5+5neOXqhrz+Bf1NUDFoi74rG
	N+rhbXRlCyfDcVQ7/uW+GNdu0I0agaWHIv5JENmQK0v0zPcV4+z1IgnKDGSWpwae4ls3
	+YHxj3Vp9ULZMDyoCI5hru9I2BB9Q7gQdbL2Ga6c1+ooeJdg08rdU3cV/sPN2atH78Gw
	rV7jbaJ7UD2sUfbvAFhRRi13dNFVaD7T0xl4YJ2byh+YPOMraAgqVPIhbutXEdu6ij5W
	CHOw==
X-Gm-Message-State: APjAAAVZgBQ8p8J3pkW1wNJ+u98hXA4IJD17q/Z9/m7ELcBv8NI0xG+5
	Dex1bLjNWVTughA2pZSceFfQl69+3fbHsdLZTnI=
X-Google-Smtp-Source: APXvYqziWOkhHD6E226yHYl2ihMTc3MnlCqCHFXBvFYSbhNIBQ3nR/4fNZ2mcgDZZ311qBgSnol+GnhF2XksHZUCYM8=
X-Received: by 2002:a24:2846:: with SMTP id h67mr23014224ith.138.1555268025736;
	Sun, 14 Apr 2019 11:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
	<29f79530-fd9e-ea60-8cf3-df593b855f10@reactos.org>
In-Reply-To: <29f79530-fd9e-ea60-8cf3-df593b855f10@reactos.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sun, 14 Apr 2019 20:53:34 +0200
Message-ID:
 <CACXAS8De=OS0O4O2=Q721KCUc9RuQryOGNfedejM+yzWcX9aOg@mail.gmail.com>
To: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/isa/i82378.c: use 1900 as a base
 year
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:PReP" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414185334.lY5TYRG80MuskoJDHgrv_guH9rSwTAK4I6wWOLwBgLg@z>

On Sun, Apr 14, 2019 at 7:01 PM Herv=C3=A9 Poussineau <hpoussin@reactos.org=
> wrote:
>
> Le 12/04/2019 =C3=A0 23:06, Artyom Tarasenko a =C3=A9crit :
> > AIX 5.1 expects the base year to be 1900. Adjust accordingly.
> >
> > Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> > ---
> >   hw/isa/i82378.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> > index a5d67bc..546c928 100644
> > --- a/hw/isa/i82378.c
> > +++ b/hw/isa/i82378.c
> > @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error **=
errp)
> >       isa =3D isa_create_simple(isabus, "i82374");
> >
> >       /* timer */
> > -    isa_create_simple(isabus, TYPE_MC146818_RTC);
> > +    isa =3D isa_create(isabus, TYPE_MC146818_RTC);
> > +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
> > +    qdev_init_nofail(DEVICE(isa));
>
> I am not sure the base_year should be hardcoded in i82378. I can assume o=
ther machines with a i82378 can have another base_year.

I doubt it to be honest. How would it work in the hardware? Is there a
pin which would switch a year?
I do believe the different i823xx may have the different base years though.

> Maybe you can you add a base_year property to i82378, and forward it to m=
c146818 with object_property_add_alias?
> Then, change 40p machine to set it to 1900, without changing it for prep =
machine.

Were you not going to drop the -M prep ? Because I sort of dropped the
support for it in OFW.
I had a branch were I added some registers to -M prep  enough that it
would be able to turn itself out as a PowerStack II Utah,
but then again I couldn't find any advantage of having two PReP machines.
AFAIK, the only OS which can run on Powerstack, but not on 40p is Motorola =
AIX.
But since we can have IBM AIX, I don't see why would we want to keep -M pre=
p.

On the other hand, if you plan to revive it, I'll think about adding
the support for it to OFW.
PowerStack had a Cirrus VGA which we already have.

> >   }
> >
> >   static void i82378_init(Object *obj)
> >
>
> Herv=C3=A9



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

