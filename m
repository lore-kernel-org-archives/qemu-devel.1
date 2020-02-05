Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980DDC3524F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 06:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687A9217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 06:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NvlpF8p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687A9217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izDrH-00037b-K4
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 01:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1izDqL-0002Gx-8b
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1izDqJ-0001E5-Nm
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:07:20 -0500
Received: from ozlabs.org ([203.11.71.1]:44273)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1izDqI-0000xJ-Uf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:07:19 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48CB0y51b5z9sSY; Wed,  5 Feb 2020 17:07:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580882834;
 bh=AeQGXQ7d67f/m61qTX1JiCyGhDm66PxPLjB7TlV9n5M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NvlpF8p/Bww9NBbRqQQJK04fJkPzFss67WsYgBG88OL+i4k56tU62mavDnUpRwBfz
 XHBt48z4C4S1MJ57AYnbjnnolOV4FTKWcyD78T2v+/QrrUBOcd1ur9C+mJn58ICRNB
 fbhKeFgUozIlm8n4ydSvLsUyr6n1lGQtwnA4zzbA=
Date: Wed, 5 Feb 2020 17:06:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VW ELF loader
Message-ID: <20200205060634.GI60221@umbus.fritz.box>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Content-Disposition: inline
In-Reply-To: <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 12:26:32AM +0100, Paolo Bonzini wrote:
> Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru> ha scritto:
>=20
> >
> >
> > Speaking seriously, what would I put into the guest?
>=20
> Only things that would be considered drivers. Ignore the partitions issue
> for now so that you can just pass the device tree services to QEMU with
> hypercalls.

Urgh... first, I don't really see how you'd do that.  OF's whole
device model is based around the device tree.  So implementing OF
driver interactions would require the firmware to do a bunch of
internal hypercalls to do all the DT stuff, which brings us back to a
much more complex and active interface between firmware and hypervisor
than we really want.

Second, drivers are kind of where we'd get the most benefit by putting
them in qemu: from qemu we can just talk to the device backends
directly so we don't need to re-abstract the differences between
different device models of the same type.

> Netboot's dhcp/tftp/ip/ipv6 client? It is going to be another SLOF,
> > smaller but adhoc with only a couple of people knowing it.

Netboot I will grant is a pretty thorny problem, whichever way we
tackle it.

> You can generalize and reuse the s390 code. All you have to write is the
> PCI scan and virtio-pci setup.

If we assume virtio only.  In any case it sounds like the s390 code is
actually based on the SLOF code anyway.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl46W2oACgkQbDjKyiDZ
s5Lo6RAAlhRwNalbp+bt1q3+J5NJiTz1snTOtWh5wrB+hlQz/bGhdIO8/1zpm33V
FmvnZVGX1DLODKtJe9RdVIjRutMP3shRDLUP9x6BYbWLmyH/6CDmLpEGKj4JQ5DE
6o+I8jbo8qxPHWNLWyeNKxeNPz83Ho7Fk6QJc3fsA0x3fqRV8fcYzNg6Yuwb+Ogc
FTcbIxqWhgCHKi4mjV7UhlD8WYRKnF/7QOYCx71i5YbAQwIuiNF2VQ6sKk2OhJr1
kD34ju9gddE6L8F9RIPXkd+Ln9EReQLg/RzAXcp9fR/2mShOi+xZle9fde3vfoU2
w+422NwfCmHrvNwIJH001MH7B7csLJS7cPlXHOQbzqVBFFlt6CSCmBMm0KzdyAQi
8si5YEjDLNKL5MxapI92T3vfi4qdrM2Y4bJ5Vfnm+lnIvcgP39c0Vp/U91GzSi1h
9VpVig6rU+6DR7AfmXYTmyEmsVRg2IiyNEg05AwbCuPw3T85Xe5aJ4FyURBs9RO4
HAlLHIV9Yd1zHF6ak/cquc30wQvZ1URFl20dkFwx5/rym3zHVtbz8gUjaIqAnXG2
5aCiu+IM8hWtjpq4iboLCymo1wTmbL1jZuf3lNuUtqpl7NlQYjMCZrS/9JiqWHQl
M3VFy0CNLzDRFIqm8hWfAG8u8xRzOVdWa2wZc3UMO6yrtEjzGmg=
=DKyt
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--

