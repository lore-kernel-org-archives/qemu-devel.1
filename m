Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED8CC35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 05:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5982082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 05:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="i7AILthF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5982082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izDW7-0006rc-EM
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 00:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1izDV9-0006JU-9O
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 00:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1izDV7-0006nC-NI
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 00:45:26 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43251 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1izDV6-0006i2-JL; Wed, 05 Feb 2020 00:45:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48C9Wd17N4z9sSY; Wed,  5 Feb 2020 16:45:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580881517;
 bh=r0PpC8TdzXwyRsQBNlfqC3e5swdZylSIgsblP4mlPhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i7AILthFxRzPM6nya530crPgo5+cYlClkYrjI29670PPdV11fhim7rGyytP+AvtD0
 ow1GIqBW08WV2Oq4/NiUSVpspgzzPnRWotHov397tNdRjlcWWkbdIez6eipOr5/P7z
 pP54hq7lEC4/FDvrVx32C4DYN0jUXSEWTaIefDoc=
Date: Wed, 5 Feb 2020 16:30:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Restrictions of libnet (was: Re: VW ELF loader)
Message-ID: <20200205053049.GF60221@umbus.fritz.box>
References: <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <d13eea1d-7942-47e0-6189-a66ce9639db4@redhat.com>
 <20200204095403.04d9dd29.conny@cornelia-huck.de>
 <4794cf7a-7b53-5fea-c89d-baa01d3ed0ce@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <4794cf7a-7b53-5fea-c89d-baa01d3ed0ce@redhat.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Cornelia Huck <conny@cornelia-huck.de>, qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 10:20:14AM +0100, Thomas Huth wrote:
> On 04/02/2020 09.54, Cornelia Huck wrote:
> > On Tue, 4 Feb 2020 07:16:46 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >=20
> >> On 04/02/2020 00.26, Paolo Bonzini wrote:
> >>>
> >>>
> >>> Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru
> >>> <mailto:aik@ozlabs.ru>> ha scritto:
> >>>
> >>>     Speaking seriously, what would I put into the guest?
> >>>
> >>> Only things that would be considered drivers. Ignore the partitions
> >>> issue for now so that you can just pass the device tree services to Q=
EMU
> >>> with hypercalls.
> >>>
> >>>     Netboot's dhcp/tftp/ip/ipv6 client? It is going to be another SLO=
F,
> >>>     smaller but adhoc with only a couple of people knowing it.
> >>>
> >>>
> >>> You can generalize and reuse the s390 code. All you have to write is =
the
> >>> PCI scan and virtio-pci setup. =20
> >>
> >> Well, for netbooting, the s390-ccw bios uses the libnet code from SLOF,
> >> so re-using this for a slim netboot client on ppc64 would certainly be
> >> feasible (especially since there are also already virtio drivers in SL=
OF
> >> that are written in C), but I think it is not very future proof. The
> >> libnet from SLOF only supports UDP, and no TCP. So for advanced boot
> >> scenarios like booting from HTTP or even HTTPS, you need something else
> >> (i.e. maybe grub is the better option, indeed).
> >=20
> > That makes me wonder what that means for s390: We're inheriting
> > libnet's limitations, but we don't have grub -- do we need to come up
> > with something different? Or improve libnet?
>=20
> I don't think that it makes sense to re-invent the wheel yet another
> time and write yet another TCP implementation (which is likely quite a
> bit of work, too, especially if you also want to do secure HTTPS in the
> end). So yes, in the long run (as soon as somebody seriously asks for
> HTTP booting on s390x) we need something different here.
>=20
> Now looking at our standard s390x bootloader zipl - this has been giving
> us a headache a couple of times in the past, too (from a distro point of
> view since s390x is the only major platform left that does not use grub,
> but also from a s390-ccw bios point of view, see e.g.
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03046.html and
> related discussions).
>=20
> So IMHO the s390x world should move towards grub2, too. We could e.g.
> link it initially into the s390-ccw bios bios ... and if that works out
> well, later also use it as normal bootloader instead of zipl (not sure
> if that works in all cases, though, IIRC there were some size
> constraints and stuff like that).

petitboot would be another reasonable thing to consider here.  Since
it's Linux based, you have all the drivers you have there.  It's not
quite grub, but it does at least parse the same configuration files.

You do need kexec() of course, I don't know if you have that already
for s390 or not.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl46UwcACgkQbDjKyiDZ
s5ILkRAAnj1VjoulEKnFzs1npv00RDcnPDMwJmJkYUHu3MSb1YAPw2kWXoJJebUx
jbKwfLjl6YafvyW75b7PUFwvr2jOFMDj17KuKj/Zfqdxce7qtXSf1zV7cg0NA2X6
sQsg5GySfj5BljhebD6KAeQNyBAFI56cZl7TCYt+2T6xaYHJL0wji1nNGKBCGDIJ
eU2uomgMtu7E1fBQdO2IEOpZdF4WKxvBBfK4v84A2ZzbwvVB7BkitFlv4igWMxZ0
6UZTFfhuVl9jeUPJhvaK3jj+wYUpbi9r121uwlqRLBYh54X+2o2Nr80OToZnSvxg
LUxDBShftsqK+o2nVud9izWNp4y9wG9/n2ts6Ez3X6aB6nKVxUHwwQiwtBRfKRbH
u1QaqVBtztqSrDnzn6CqxeUd9Ng7N/x6E8wlx6L8jlBKq5rnAEaWRgyBGuJ7kpJI
zBCbHIgdMJw02eQ84/Br1WAPCxu3rntZh23BCga+y/LhmLwde33d0UeQGK5/qj6o
gkECYZ6dfCutSbPyg1M00uTCjiyzOGb7HEfvcPYlFJY5l2gKOEyE189UJzueE1+6
5u7Pekq2Qsee2m2kHQRYvBn8KAMs8+y+mBPBRcszGN7V/58Kj1WD5EKx/jrnyl02
QUG7iKJWB8D5B7zH5G4xDeNbdyZTli87RRIRUf3WGhMYpKtZGNQ=
=X2Qv
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--

