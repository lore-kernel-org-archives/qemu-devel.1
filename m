Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F95C2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 05:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FFD20706
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 05:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hmwh6QTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FFD20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijcsw-0002tj-5x
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 00:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijcs2-0001yj-Vu
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 00:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijcs1-0003ZQ-BB
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 00:36:38 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37195 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijcs0-0003L4-90; Tue, 24 Dec 2019 00:36:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47hlML0qt9z9sP6; Tue, 24 Dec 2019 16:36:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577165790;
 bh=ZvPbNLyyloftXPdG86oAKU+tnwleI7uEMh+7917IPTA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hmwh6QTDYgCT1rWTllgIlhYmDzO32Mb5Cgeoqt4pjrIDhwBUf8Zmv/j5Jl1/qpb8W
 Cla/g58+1D+Sim0wiUd72W4FDPjTbonDA0Jk6mXVaJP7DoPoRPOkh7uqxAMViaAcr5
 Mb0W4jPHz0CkUD3qAbFJYOrGtxMDz6gZ2XcYWKp4=
Date: Tue, 24 Dec 2019 16:19:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: fix memory dump endianness in QEMU monitor
Message-ID: <20191224051904.GK38380@umbus.modem>
References: <20191219163854.8945-1-maxiwell@linux.ibm.com>
 <20191223063043.GH38380@umbus.modem> <875zi6fwqy.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Content-Disposition: inline
In-Reply-To: <875zi6fwqy.fsf@linux.ibm.com>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2019 at 08:27:49PM -0300, Fabiano Rosas wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > b) AFAICT this is the *only* thing that looks for the LE bit in
> > hflags. Given that, and the fact that it would be wrong in most cases,
> > we should remove it from hflags entirely along with this change.
> >
>=20
> I see there is:
>=20
> static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState =
*cs)
> {
>     ...
>     ctx->le_mode =3D !!(env->hflags & (1 << MSR_LE));
>     ...
> }

Ah... good point, I missed that one, sorry.  That makes all the
difference.

My guess is that this bit exists to be a universal flag for endianness
mode, generalizing across the MSR bit on modern cpus, and the old 601
which had it in the HID register.  I'm a bit dubious as to whether our
601 emulation is good enough to warrant bothering with this, but it's
probably best not to mess with it.


> And we call hreg_recompute_hflags in some places:

ITYM hreg_compute_hflags().

> - powerpc_excp (target/ppc/excp_helper.c)
>   Called from TCG do_interrupt
>=20
> - ppc_cpu_reset (target/ppc/translate_init.inc.c)
>   Called from spapr_machine_reset
>=20
> - hreg_store_msr (target/ppc/helper_regs.h)
>   This is used for migration and for do_rfi, store_msr

Huh... given this, I'm not sure how hflags was getting out of sync
with the MSR in the first place, which brings the initial patch into
question.

> - h_cede (hw/ppc/spapr_hcall.c)
>   QEMU-side H_CEDE hypercall implementation=20
>=20
>=20
> It looks like the hflags MSR_LE is being updated correctly with TCG. But
> with KVM we only touch it on system_reset

Ah.. right.  I think to fix that we'd want an hreg_compute_hflags() at
the end of sucking the state out of KVM.

> (and possibly h_cede? I don't
> know if it is QEMU who handles it).

It's KVM.  If we used the qemu one it would add an awful lot of
latency to cedes.
>=20
> So I would let hflags be.
>=20
>=20
> ... Actually, I don't really know the purpose of hflags. It comes from:
>=20
>   commit 3f3373166227b13e762e20d2fb51eadfa6a2d653
>   Author: Fabrice Bellard <fabrice@bellard.org>
>   Date:   Wed Aug 20 23:02:09 2003 +0000
>  =20
>       pop ss, mov ss, x and sti disable irqs for the next instruction -
>       began dispatch optimization by adding new x86 cpu 'hidden' flags
>      =20
>      =20
>       git-svn-id: svn://svn.savannah.nongnu.org/qemu/trunk@372 c046a42c-6=
fe2-441c-8c8c-71466251a162
>=20
> Could any one clarify that?

Not really.  It's really, really old, in the cruft bits of TCG I don't
much understand.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4Bn8gACgkQbDjKyiDZ
s5JFhhAAhTbLOoCfdmnD+eTrOp81/xphIaKzRyrM0XIqfcPVMyp8Glr0FEbeJ5mU
hHQ5OwmjaRw2DP47o558Q5iZ6Z/edPAIlk8I5ocPs3/GWRVIMnCFLDM98Pn7OP/V
9LUgzZl5keePTzjiIB0naZfQ1SduUmYqJ3TnnoQ5jALa4B/S/kdZEACc6ubKskxc
ok/cK+oOfHc857tH1jEka2a41oowtdrsIJjvlZVal+omsDDpwlLoGSf1Bj//OnDB
IOjdIh9JldterY7Nkr0eEzejJvehEyVQGnfinqBMxuS1HVqQ1EoktUURjmmCZZln
wSiHbI4R9ksOgwFOuen5DSO2SfPpKboJXSqQz/d/EWUv1VlWA1K2SjrHP7sjsCnc
xX0Msu7qGCXrIrU5NWACnYq+VAURU2hrg0Mmtf20ZoEXNiEFqlsik/HIXAE/MzLF
CMYXQeN6rKMk0ym10UXow6v8D3C7+8V76qFgLml2rRFEXqe9S+FsMTWsQKIiPnVf
N41KHrLMS58DDxb/RopgNvzuA75+CuoefSIvcea4rDJCiqdENPp+kciGQ//xuF23
ec/e/R7JCqlIxMQ8+0e3OoB2fAaAA4XKACj9ugVpOLZKfEmuT+El5budz2Y9xwEg
461eJLkWOSBgzgkV5GigpSCrew00a3mrJ9zEoQzcX2O92If6C00=
=TaTW
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--

