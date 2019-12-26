Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE97C2D0C8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 01:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E6D20740
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 01:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hDWlJQwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E6D20740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikINC-0007l5-UR
	for qemu-devel@archiver.kernel.org; Wed, 25 Dec 2019 20:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ikIML-0007AM-OX
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 20:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ikIMJ-0000ow-V3
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 20:54:41 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51931 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ikIMH-0000ma-LG; Wed, 25 Dec 2019 20:54:39 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47jtLH3cbvz9sPJ; Thu, 26 Dec 2019 12:54:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577325271;
 bh=C/vdMGPZrblj+EeZhY8jDgUw1y8TDrFgMh1qx1+mJ7k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hDWlJQwerSq/0AHEdxoLyYUqRU1GfYCcUJcM/i6reSDLMkKgZ19wnQQuf9yYLWkPQ
 amcB52od2ZfxfEj0G4SZkThSVgHUmfutC3CqbSNBeFqVGV8Tt3TNqOHGGRoDkZo0yN
 Iv2IML3U3uWmZMlT/JWYnIT1qmVBC3vJLvnUxQ+s=
Date: Thu, 26 Dec 2019 12:54:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: fix memory dump endianness in QEMU monitor
Message-ID: <20191226015425.GA4812@umbus.modem>
References: <20191219163854.8945-1-maxiwell@linux.ibm.com>
 <20191223063043.GH38380@umbus.modem> <875zi6fwqy.fsf@linux.ibm.com>
 <20191224051904.GK38380@umbus.modem> <8736d9g0w5.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <8736d9g0w5.fsf@linux.ibm.com>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2019 at 01:10:34PM -0300, Fabiano Rosas wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> >> It looks like the hflags MSR_LE is being updated correctly with TCG. B=
ut
> >> with KVM we only touch it on system_reset
> >
> > Ah.. right.  I think to fix that we'd want an hreg_compute_hflags() at
> > the end of sucking the state out of KVM.
> >
>=20
> Hm.. The hflags is a TCG thing that does not get used with KVM at all,
> except for that one bit in the monitor disas function. I'd rather keep
> it completely out of kvm_enabled code.

That's a fair point.

It doesn't look like there's any reason ppc_tr_init_disas_context()
couldn't initialize ctx->le_mode directly from the MSR rather than
hflags anyway.  If we do that, we should again be able to remove the
LE bit from hflags entirely.  I think that's the way to go.

>=20
> Couldn't we perhaps make it conditional on the acceleration type?
> Using kvm_enabled() or some ifdef.
>=20
> Thanks
>=20
> >> (and possibly h_cede? I don't
> >> know if it is QEMU who handles it).
> >
> > It's KVM.  If we used the qemu one it would add an awful lot of
> > latency to cedes.
> >>=20
> >> So I would let hflags be.
> >>=20
> >>=20
> >> ... Actually, I don't really know the purpose of hflags. It comes from:
> >>=20
> >>   commit 3f3373166227b13e762e20d2fb51eadfa6a2d653
> >>   Author: Fabrice Bellard <fabrice@bellard.org>
> >>   Date:   Wed Aug 20 23:02:09 2003 +0000
> >>  =20
> >>       pop ss, mov ss, x and sti disable irqs for the next instruction -
> >>       began dispatch optimization by adding new x86 cpu 'hidden' flags
> >>      =20
> >>      =20
> >>       git-svn-id: svn://svn.savannah.nongnu.org/qemu/trunk@372 c046a42=
c-6fe2-441c-8c8c-71466251a162
> >>=20
> >> Could any one clarify that?
> >
> > Not really.  It's really, really old, in the cruft bits of TCG I don't
> > much understand.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4EEs4ACgkQbDjKyiDZ
s5KFwxAAvB8wbDKbHmGyQsQmmT2oaNHtb2+fYQYPcD7L/zRsmnwsG0ZdjN9Pd63C
93Kcvq95J/I6GbFlV3sUP7cmeJiviOLfXTR6226keszapySA9XqvDycqICvoJ1we
97NeKB2VwG10FcsNU3wN6nSWGxdyUxXGOY3c4U5L/uSK3JN1X+Z6+t2AGvKqrwYH
U0LcAlugOnlWlv8zY1mlw6LXmPapU+hqH3IwcbOgoxqnEfjl3vclOGiBxeyDzIS2
5WChyRFl28ynRAKTbIw2Zpf14OI9Zb6RnkmQhMKzGI79uf8wiIjvp7w/KniYgNXH
iW1TPfMkoWgc5S63Nsa/7gpYnU7YY08SQogVsN4OWK6uq5/NsKoEtPIc1+m1vVHc
jBQy3eCERQ7t7dB/2nSqA0VHADklCbP3m819v5JssNaYQX+cQ4r3sRGRzhOm4x5X
6INHdjwtZWeAN7/AJXdB3avxbIMfZ7ckQUVhWAoYvVGGuO3sgmrJje9DuLahdoni
O8lK0sbtqF8HG63jrng0MbVFTrvzIilm+GpzKV75hj8dCE0LMroR90nV9DPpGK8t
3vnDdANBTw2rO4wt6+uOkFhztURiYSwxsZYm6dEJPoea/MEu4KaHnKFWCAIHG1y3
FA97JFClLgkh98CqabegTzuHtFTI/icysfz9mvF52KWqy2Ed/Oc=
=tb56
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

