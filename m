Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D53DC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA03206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="htvyRepq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA03206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJDZ-0001jI-B9
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45106)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnJD1-00006h-MR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnJD0-0007TZ-4R
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:53:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58705 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnJCz-0007SJ-1O; Tue, 16 Jul 2019 04:53:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45nvLY4HxLz9sNp; Tue, 16 Jul 2019 18:53:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563267189;
 bh=s1wRmK0MVG64rLPyBaUut9UQuelJLlGKqjzYZkvKjuk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=htvyRepqCWtlBdFYtMQ55e8bsMb1OazVLc6CQxWlPh2atlmCmjCDkesEGpCncvUGM
 bLgNMwoeCEvwWPRW5AiHyfRN0MrWHdSDFHNLHmBORJfQNcOo2mFiU/dPbdQzusAWuV
 b5+tYuzFsMJiWsKz+c4jZueiI9Ze2zBb8C0hYUWs=
Date: Tue, 16 Jul 2019 18:52:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190716085236.GH7525@umbus.fritz.box>
References: <20190716045633.15319-1-joel@jms.id.au>
 <6e98fffb-2642-3835-d3ba-f06b73ca2fdc@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline
In-Reply-To: <6e98fffb-2642-3835-d3ba-f06b73ca2fdc@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Warn when using -initrd and low
 ram
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
Cc: qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 09:39:36AM +0200, C=E9dric Le Goater wrote:
> On 16/07/2019 06:56, Joel Stanley wrote:
> > When booting with the default amount of RAM the powernv machine will
> > load the initrd above the top of RAM and cause the Linux kernel to crash
> > when it attempts to access the initrd:
> >=20
> >   Linux/PowerPC load:
> >   Finalizing device tree... flat tree at 0x202770c0
> >   [    0.070476] nvram: Failed to find or create lnx,oops-log partition=
, err -28
> >   [    0.073270] nvram: Failed to initialize oops partition!
> >   [    0.156302] BUG: Unable to handle kernel data access at 0xc0000000=
60000000
> >   [    0.158009] Faulting instruction address: 0xc000000001002e5c
> >   cpu 0x0: Vector: 300 (Data Access) at [c00000003d1e3870]
> >       pc: c000000001002e5c: unpack_to_rootfs+0xdc/0x2f0
> >       lr: c000000001002df4: unpack_to_rootfs+0x74/0x2f0
> >       sp: c00000003d1e3b00
> >      msr: 9000000002009033
> >      dar: c000000060000000
> >    dsisr: 40000000
> >     current =3D 0xc00000003d1c0000
> >     paca    =3D 0xc000000001320000	 irqmask: 0x03	 irq_happened: 0x01
> >       pid   =3D 1, comm =3D swapper/0
> >   Linux version 5.2.0-10292-g040e2e618374 (joel@voyager) (gcc version 8=
=2E3.0 (Debian 8.3.0-2)) #1 SMP Tue Jul 16 13:50:32 ACST 2019
> >   enter ? for help
> >   [c00000003d1e3bb0] c000000001003c90 populate_rootfs+0x84/0x1dc
> >   [c00000003d1e3c40] c00000000000f494 do_one_initcall+0x88/0x1d0
> >   [c00000003d1e3d10] c000000001000fc4 kernel_init_freeable+0x24c/0x250
> >   [c00000003d1e3db0] c00000000000f7a0 kernel_init+0x1c/0x150
> >   [c00000003d1e3e20] c00000000000b8a4 ret_from_kernel_thread+0x5c/0x78
> >=20
> > Provide a helpful message for users so they don't go reporting bugs to
> > kernel developers.
> >=20
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > We could solve this in other ways, such as warn when loading the initrd
> > outside of RAM, or load it within the known boundaries or RAM, but after
> > hitting this myself I wanted to start the discussion.
>=20
> We should also increase :=20
>=20
>     mc->default_ram_size =3D 1 * GiB;
>=20
> to 2 or 4 GiB. I always use 4.

It seems to be increasing the default addresses the real problem in
practice.  Putting in a warning but still letting you do it, rather
than relocating where we load the image based on the ram size seems
kind of roundabout.

>=20
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  hw/ppc/pnv.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index bd4531c82260..bbd596ab9eca 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -649,6 +649,13 @@ static void pnv_init(MachineState *machine)
>=20
>=20
> at the beginning of this routine we have :
>=20
>     /* allocate RAM */
>     if (machine->ram_size < (1 * GiB)) {
>         warn_report("skiboot may not work with < 1GB of RAM");
>     }
>=20
> and we should exit instead.=20
>=20
> >      /* load initrd */
> >      if (machine->initrd_filename) {
> > +        if (machine->ram_size <=3D (1.5 * GiB)) {
> > +            /* INITRD_LOAD_ADDR is at 1.5GB, so we require at least th=
at much RAM
> > +             * when specifying the initrd on the command line */
> > +            warn_report("initrd load requires > %ld MB of RAM",
> > +                    INITRD_LOAD_ADDR / MiB);
> > +        }
>=20
> Shouldn't we take into account the initrd size also ? I don't know if it =
is=20
> relevant as it can be compressed.
>=20
> >          pnv->initrd_base =3D INITRD_LOAD_ADDR;
> >          pnv->initrd_size =3D load_image_targphys(machine->initrd_filen=
ame,
> >                                    pnv->initrd_base, INITRD_MAX_SIZE);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0tkFEACgkQbDjKyiDZ
s5LjMA/+NmpSzvPQTRYlDiu5LyppJ7GsYFfLTcqZwcxcuQZs/9+9EdmzpVIn4A8n
Ro25eIbC6ryChYTveRzb3F29U2+CPWN8W3CT8wIf4j0vkAFy9NNnCuhuMBNrdhn6
0a4r1PnNBN4HTrFp+Lg0qf5LmAjhPFoQRDQzF2D7piCX2V4MKMfybqB5s0FqgTN0
AhYHQuQ70yUAWGoWz4NytcW6zsuLVC9xTlUYBvq6kQTrVVS84No355RyeXCWfIZF
uxG1wxLSgUIB/th4ee5B3B8Qku4r+rSKc0PtNRDbHAvD7vT7G91RAzFfFUg10UzK
TJJnL1r4E2WZ5KYScktGDyb8JHM5wwJFh6RIyw28AY6m30p3DZIBoJ4wTG4LeBwF
nJEIbqQhdILGkVq08SpUnrdy5u4NiuNCYsqUaSuI0paQAQ8SucrCX6Y6/g9cqvDx
04eUJe+6V1lYNhZkUbvOAoJREuv5TYklocEvjwN796FjKipP3P/ihaIT2jkx0aCq
4gmngSblhomOIFSQV0g0uVRlc8hyjxrqtLU2PwZDJUxoev9erT4rn32D2fMc0mEr
imY+d+mk1oESMntCy0lQpU84U2I2AjlnWihwm9JqauYnwn2othGcF5f1w/kGNk6a
FUZIvAV5XUAriLmqE1GXn/BB4i7MgpBKddPhG6UbVyjS20EKVrI=
=Jdfr
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--

