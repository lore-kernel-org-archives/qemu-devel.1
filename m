Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C998DC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 05:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F5F2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 05:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GRmqGJSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F5F2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEno8-0001Qs-Q4
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 01:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jEnjm-00052y-Qy
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 01:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jEnjl-0004M2-5N
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 01:28:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56575 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jEnjk-0004C3-3G; Thu, 19 Mar 2020 01:28:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48jb6q40Rnz9sPk; Thu, 19 Mar 2020 16:28:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584595731;
 bh=t1248ftJUHILXR5f9HC5KN53ZdslCmhixJmmStm56dA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GRmqGJSa39gSS7Obr9TmOn1EYNNyVYKb5IIbHnUdpcueq/V/ryJ82TUrgEsPX9Q6H
 aC3545ncoSzatg42BLFTyngcYH9o/+x6eJDu2HU0yV1i47HrcWrnve8G6BNiWIKDjV
 3/DNTs3R7XR9rczSYAcRRfoP7JYkHmQ2l5wwv7K4=
Date: Thu, 19 Mar 2020 16:17:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vincent Fazio <vfazio@xes-inc.com>
Subject: Re: [PATCH 1/1] target/ppc: fix ELFv2 signal handler endianness
Message-ID: <20200319051745.GC628315@umbus.fritz.box>
References: <20200315155202.13107-1-vfazio@xes-inc.com>
 <346e47c8-4a80-860c-ec55-e38d2021d63d@vivier.eu>
 <CAOrEah5Fq7Kp9wF_4Vtb4Qfcdm0gtwin_5b_ft7h7my+RnTOWA@mail.gmail.com>
 <20200316022107.GA2013@umbus.fritz.box>
 <0a4f5e07-3934-ea6b-4fe1-9fc3ec4c8d85@xes-inc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <0a4f5e07-3934-ea6b-4fe1-9fc3ec4c8d85@xes-inc.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Vincent Fazio <vfazio@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2020 at 10:00:20AM -0500, Vincent Fazio wrote:
> David, Laurent,
>=20
> On 3/15/20 9:21 PM, David Gibson wrote:
> > On Sun, Mar 15, 2020 at 07:29:04PM -0500, Vincent Fazio wrote:
> > > Laurent,
> > >=20
> > > On Sun, Mar 15, 2020 at 1:10 PM Laurent Vivier <laurent@vivier.eu> wr=
ote:
> > > > Le 15/03/2020 =E0 16:52, Vincent Fazio a =E9crit :
> > > > > From: Vincent Fazio <vfazio@gmail.com>
> > > > >=20
> > > > > In ELFv2, function pointers are entry points and are in host endi=
anness.
> > > > "host endianness" is misleading here. "target endianness" is better.
> > Yeah, the trouble here is that I think the ELF spec will use "host"
> > and "target" in a quite different sense than qemu.
> >=20
> I'll be simplifying the wording in the message to just mention the
> problematic cross-endian scenario
> > > I do want to clarify here. In a mixed endian scenario (my test case
> > > was an x86 host and e5500 PPC BE target), the function pointers are in
> > > host endianness (little endian) so that the virtual address can be
> > > dereferenced by the host for the target instructions to be
> > > translated.
> > This can't be right.  The ELF is operating entirely within the guest,
> > and has no concept of a host (in the qemu sense).  Therefore it's
> > impossible for it to specify anything as "host endian" (again in the
> > qemu sense).
> >=20
> > It *is* possible that it's little endian explicitly (in which case
> > we'd need a conditional swap that's different from the one we have
> > now).
> >=20
> > But even that seems pretty odd.  AFAICT that target_sigaction
> > structure is copied verbatim from guest memory when the guest makes
> > the sigaction() syscall.  Are we expecting a BE process to put LE
> > parameters into a syscall structure?  That seems unlikely.
> >=20
> > I really think you need to put some instrumentation in the sigaction()
> > call that comes before this, to see exactly what the guest process is
> > supplying there.
> >=20
> > And then we maybe need to look at your guest side libc and/or a native
> > e5500 BE kernel to see what it expects in that structure.
> As we discussed in the other thread, I missed the endian swap done as part
> of get_user in do_sigaction.

Right, as did I when I looked the first time.

> So while my initial determination for the root
> cause of the problem was wrong, the fix is still the same (drop the `tswa=
pl`
> call). The commit message will be updated.

Right, agreed.

> > > > > Previously, the signal handler would be swapped if the target CPU=
 was a
> > > > > different endianness than the host. This would cause a SIGSEGV wh=
en
> > > > > attempting to translate the opcode pointed to by the swapped addr=
ess.
> > > > This is correct.
> > > >=20
> > > > >   Thread 1 "qemu-ppc64" received signal SIGSEGV, Segmentation fau=
lt.
> > > > >   0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at qe=
mu/include/qemu/bswap.h:351
> > > > >   351        __builtin_memcpy(&r, ptr, sizeof(r));
> > > > >=20
> > > > >   #0  0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) a=
t qemu/include/qemu/bswap.h:351
> > > > >   #1  0x00000000600a92fe in ldl_be_p (ptr=3D0x4c2c061000000000) a=
t qemu/include/qemu/bswap.h:449
> > > > >   #2  0x00000000600c0790 in translator_ldl_swap at qemu/include/e=
xec/translator.h:201
> > > > >   #3  0x000000006011c1ab in ppc_tr_translate_insn at qemu/target/=
ppc/translate.c:7856
> > > > >   #4  0x000000006005ae70 in translator_loop at qemu/accel/tcg/tra=
nslator.c:102
> > > > >=20
> > > > > Now, no swap is performed and execution continues properly.
> > > > >=20
> > > > > Signed-off-by: Vincent Fazio <vfazio@gmail.com>
> > > > > ---
> > > > >   linux-user/ppc/signal.c | 10 +++++++---
> > > > >   1 file changed, 7 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> > > > > index 5b82af6cb6..c7f6455170 100644
> > > > > --- a/linux-user/ppc/signal.c
> > > > > +++ b/linux-user/ppc/signal.c
> > > > > @@ -567,9 +567,13 @@ void setup_rt_frame(int sig, struct target_s=
igaction *ka,
> > > > >           env->nip =3D tswapl(handler->entry);
> > > > >           env->gpr[2] =3D tswapl(handler->toc);
> > > > >       } else {
> > > > > -        /* ELFv2 PPC64 function pointers are entry points, but R=
12
> > > > > -         * must also be set */
> > > > > -        env->nip =3D tswapl((target_ulong) ka->_sa_handler);
> > > > > +        /*
> > > > > +         * ELFv2 PPC64 function pointers are entry points and ar=
e in host
> > > > > +         * endianness so should not to be swapped.
> > > > "target endianness"
> > > >=20
> > > > > +         *
> > > > > +         * Note: R12 must also be set.
> > > > > +         */
> > > > > +        env->nip =3D (target_ulong) ka->_sa_handler;
> > > > The cast is not needed: nip and _sa_handler are abi_ulong.
> > > I'll drop this in v2
> > >=20
> > > > >           env->gpr[12] =3D env->nip;
> > > > >       }
> > > > >   #else
> > > > >=20
> > > > If you repost with the fix I've reported above you can add my:
> > > >=20
> > > > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> > > >=20
> > > I'll hold off on reposting until the endianness wording is figured ou=
t.
> I'll be submitting v2 shortly, but it will have a different commit message
> to better reflect the issue.
> > > > Thanks,
> > > > Laurent
> > > Thanks,
> > > -Vincent
> > >=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5zAHYACgkQbDjKyiDZ
s5J1Mw/+MN44y9JPiUcwgwkrfq4bMZJpNxLaeoVQwzbnLeGxsw+V/wIwjia6kDjA
+cTn5X8o6hctUnQ7j20p4+Q2JTHISW7qBRuszAKCj8wBFrp6fbroetZjzJY9pGNq
DuoiSNH5D7Orf3rzJEiD7YmVzWsVG+SYo9a3W+cAxiKf3F1oapkRxnIED9tMyKUP
T8S71qlKapeLTwzP6RGomqQEo1HTxLamPjeFoo5bY8kTvUrpLdruQvclQBG2f0/j
9JFU5dDN/0OIjzHTvavRycK5ryh4MihtAuOAK/4Zx09PJZta954Y7atbCglXommy
YFlH1Gmr8/E+dmjd4VQ//UxehkyO9BTYyq0hE86Bu8+SmO1keRASLI6JPGgHefGO
6PSGuP/oiHCyCfsFCdRPOv04dPXCVF7/NrwzQ7FdiHM6iEZQxaWtr/qy3TWZacC9
IOyHDQtCUkW5hczYY50RiwcC4tkcG0IpglrsD1B8rkfozR8nw/thS/Qu/N8HpOXp
4OIzFwKjyCja54/BF7+rxgUTeMiiAwY3IxhnxPcH9kp/VWAelekkQuFjCQ6GXWre
IxwVCl9rXJ70jjBM37uPxCh+ZRaNLlFCT+PPIFOV/4+9FlZzMaQd6smmBE7EGE7J
jSDiAaNu7MK1HaSF2+gwNWPOj8xT1KDmWqwHZVYUvmEnxNoBI3M=
=H9E9
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--

