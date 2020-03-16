Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E3C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 02:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB0D20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 02:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZdFTEqI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB0D20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDfSr-0000Ma-Pv
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 22:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDfNf-00083H-Ql
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 22:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDfNd-0008LX-Nw
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 22:21:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45035)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDfNc-0007LK-O7; Sun, 15 Mar 2020 22:21:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48gg5l0n8Sz9sPk; Mon, 16 Mar 2020 13:21:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584325275;
 bh=kNPuvmutNMSpow2OEw0f9w0Hrn2qrGtSJHoDupFgDlY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZdFTEqI0b40VhWqxYNlNIsgTEMcxJ7Pwfk/uqTPrnbryvdNPunmGN7yO/AQPLCs2D
 ZfcARtGYlPN/xd7DrhVTg86+UMyJfTktToBxThjuqwPEU9zuLO0TqFCJzq9gCgbj7n
 BdCqMBySKXEv8Dq9Q/4xGoM/xFbVt1F9b9O7XQ10=
Date: Mon, 16 Mar 2020 13:21:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vincent Fazio <vfazio@gmail.com>
Subject: Re: [PATCH 1/1] target/ppc: fix ELFv2 signal handler endianness
Message-ID: <20200316022107.GA2013@umbus.fritz.box>
References: <20200315155202.13107-1-vfazio@xes-inc.com>
 <346e47c8-4a80-860c-ec55-e38d2021d63d@vivier.eu>
 <CAOrEah5Fq7Kp9wF_4Vtb4Qfcdm0gtwin_5b_ft7h7my+RnTOWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <CAOrEah5Fq7Kp9wF_4Vtb4Qfcdm0gtwin_5b_ft7h7my+RnTOWA@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Vincent Fazio <vfazio@xes-inc.com>, qemu-trivial@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2020 at 07:29:04PM -0500, Vincent Fazio wrote:
> Laurent,
>=20
> On Sun, Mar 15, 2020 at 1:10 PM Laurent Vivier <laurent@vivier.eu> wrote:
> >
> > Le 15/03/2020 =E0 16:52, Vincent Fazio a =E9crit :
> > > From: Vincent Fazio <vfazio@gmail.com>
> > >
> > > In ELFv2, function pointers are entry points and are in host endianne=
ss.
> >
> > "host endianness" is misleading here. "target endianness" is better.

Yeah, the trouble here is that I think the ELF spec will use "host"
and "target" in a quite different sense than qemu.

> I do want to clarify here. In a mixed endian scenario (my test case
> was an x86 host and e5500 PPC BE target), the function pointers are in
> host endianness (little endian) so that the virtual address can be
> dereferenced by the host for the target instructions to be
> translated.

This can't be right.  The ELF is operating entirely within the guest,
and has no concept of a host (in the qemu sense).  Therefore it's
impossible for it to specify anything as "host endian" (again in the
qemu sense).

It *is* possible that it's little endian explicitly (in which case
we'd need a conditional swap that's different from the one we have
now).

But even that seems pretty odd.  AFAICT that target_sigaction
structure is copied verbatim from guest memory when the guest makes
the sigaction() syscall.  Are we expecting a BE process to put LE
parameters into a syscall structure?  That seems unlikely.

I really think you need to put some instrumentation in the sigaction()
call that comes before this, to see exactly what the guest process is
supplying there.

And then we maybe need to look at your guest side libc and/or a native
e5500 BE kernel to see what it expects in that structure.

> > > Previously, the signal handler would be swapped if the target CPU was=
 a
> > > different endianness than the host. This would cause a SIGSEGV when
> > > attempting to translate the opcode pointed to by the swapped address.
> >
> > This is correct.
> >
> > >  Thread 1 "qemu-ppc64" received signal SIGSEGV, Segmentation fault.
> > >  0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at qemu/in=
clude/qemu/bswap.h:351
> > >  351        __builtin_memcpy(&r, ptr, sizeof(r));
> > >
> > >  #0  0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at qem=
u/include/qemu/bswap.h:351
> > >  #1  0x00000000600a92fe in ldl_be_p (ptr=3D0x4c2c061000000000) at qem=
u/include/qemu/bswap.h:449
> > >  #2  0x00000000600c0790 in translator_ldl_swap at qemu/include/exec/t=
ranslator.h:201
> > >  #3  0x000000006011c1ab in ppc_tr_translate_insn at qemu/target/ppc/t=
ranslate.c:7856
> > >  #4  0x000000006005ae70 in translator_loop at qemu/accel/tcg/translat=
or.c:102
> > >
> > > Now, no swap is performed and execution continues properly.
> > >
> > > Signed-off-by: Vincent Fazio <vfazio@gmail.com>
> > > ---
> > >  linux-user/ppc/signal.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> > > index 5b82af6cb6..c7f6455170 100644
> > > --- a/linux-user/ppc/signal.c
> > > +++ b/linux-user/ppc/signal.c
> > > @@ -567,9 +567,13 @@ void setup_rt_frame(int sig, struct target_sigac=
tion *ka,
> > >          env->nip =3D tswapl(handler->entry);
> > >          env->gpr[2] =3D tswapl(handler->toc);
> > >      } else {
> > > -        /* ELFv2 PPC64 function pointers are entry points, but R12
> > > -         * must also be set */
> > > -        env->nip =3D tswapl((target_ulong) ka->_sa_handler);
> > > +        /*
> > > +         * ELFv2 PPC64 function pointers are entry points and are in=
 host
> > > +         * endianness so should not to be swapped.
> >
> > "target endianness"
> >
> > > +         *
> > > +         * Note: R12 must also be set.
> > > +         */
> > > +        env->nip =3D (target_ulong) ka->_sa_handler;
> >
> > The cast is not needed: nip and _sa_handler are abi_ulong.
>=20
> I'll drop this in v2
>=20
> >
> > >          env->gpr[12] =3D env->nip;
> > >      }
> > >  #else
> > >
> >
> > If you repost with the fix I've reported above you can add my:
> >
> > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> >
>=20
> I'll hold off on reposting until the endianness wording is figured out.
>=20
> > Thanks,
> > Laurent
>=20
> Thanks,
> -Vincent
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5u4pMACgkQbDjKyiDZ
s5Igsg/+Mvu/+X+e+CbgPKcjNA0dOSBYCdBEzoAPI3cfIk+OoAKmTBDObK2BKJ4X
88axe7ZIcZp5zsVkpLFHsPFoSAkNTvVKPQFoGqqN8FCHH0fdt32JDHhErkjCIl4O
sZ2svN60qemNvNyK/tnrFGifeQedpfOSiiGhi1CVwBplDkd8LMX6XyqkJG+b8vh5
WIqhcUPTzgaCyUh/JSyY3yvBlhQXKWL/J2jlAUTIQxn2pXYajafaSQoawHCst6Hy
W+0clM4641izXfYxMJjFQa6vrGy/JPnhUSuAClHqO8yJ52zvQq0iHtHm4FIpg4sF
Km0VDp482k6ze9qK6Qt8nUTTLMN3LX18Rh6xI2mvNjOY1FBggc6pMg9PaGXSz5Gu
vneTkUFvQORe3TxrAdnHKajFHpG+5g99y9YgP5q4usJKsbZ7VJmw+BOwvmwyik3y
NXblhPuVnuPtOIUN7LMuYzjI3M00B+MviTqqRph1CN2gcWq2AGLQC+jW+05v02r5
0l5WsLIBNaflPw4Fk+DtGxR/ACpuIzLylK+sw9T+6tICepxLMKQNoxanS6o2w44a
EA1NWd0z7/aw0++eEsU/CDM4TY+AZLdo/HLiAY4p9pv7Uu1KRsbbKvdScRmZaraM
iElE6zjsZbDm7s2VIJGKrUc5gXYUA87tuzPuoGVv7A3WDviDWn4=
=4ygq
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

