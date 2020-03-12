Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB0C2BAEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 01:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A8620735
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 01:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MsYBHTx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A8620735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCCbb-00062Y-Rt
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 21:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jCCZc-0002gl-8w
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 21:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jCCZa-0006r0-P4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 21:23:43 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44645 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jCCZZ-0006co-VU; Wed, 11 Mar 2020 21:23:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48dB1344F2z9sSR; Thu, 12 Mar 2020 12:23:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583976215;
 bh=6bVymcVMzzG4v9GCQ5HBdrnEXNL0B3v7XlHhhDDWbVw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MsYBHTx7g7VAltohkqYaAlUYri4MbUNeBSJzKVbrKc3cyFrQiDVrrBim2NNaQQsFF
 p/syvc3hb8kcjM7gjMqAuOZmjuPdQl5vZWNrCBDykXSYxY8hCmI3m9HcWlvgPgnrHj
 Oo4jR/AY+oyV44AjTrD0BQvNOEnEdGc5dUZ1V3kY=
Date: Thu, 12 Mar 2020 12:14:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/2] spapr: Disable legacy virtio devices for
 pseries-5.0 and later
Message-ID: <20200312011420.GD711223@umbus.fritz.box>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200305043009.611636-2-david@gibson.dropbear.id.au>
 <20200310115611.GE3234052@redhat.com>
 <20200311005857.GS660117@umbus.fritz.box>
 <20200311030812-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <20200311030812-mutt-send-email-mst@kernel.org>
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
Cc: pair@us.ibm.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, aik@ozlabs.ru,
 groug@kaod.org, qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org,
 mdroth@us.ibm.com, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 03:11:16AM -0400, Michael S. Tsirkin wrote:
> On Wed, Mar 11, 2020 at 11:58:57AM +1100, David Gibson wrote:
> > Note that several things that I believe are now in the PCIe spec, but
> > really derive more from PC legacy considerations, don't apply at all
> > for PAPR.  e.g. there's no meaningful distinction between integrated
> > and slotted devices, multiple independent host bridges is routine and
> > doesn't require any (virtual) hardware visible domain numbers.
>=20
> Domain numbers are a Linux thing, not a PCIe thing. On x86 they come
> from ACPI segment numbers. As such they aren't usually hardware
> visible on x86, they are supplied by firmware.

Oh, ok.  I thought that at least on the standard IO 0xcf8 host bridge
controller the domain number was written into certain registers to
select the relevant root bus.

On POWER the domain numbers are arbitrarily assigned within Linux.
"Hardware" (well, the firmware/hypervisor) uses a different
identifier, called the BUID (generally a large, 64-bit pseudo-address)
in the device tree and hypercalls.

[As an aside, this means the use of domain numbers in libvirt XML is
complete bogosity]

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5pjOwACgkQbDjKyiDZ
s5KlsxAAo7e71SYU9t7mhzY649KCmWVdVlt9uoOVjbUl78O4+sw80Ja5o0wRF2aK
fkhoSNXdklrT4jb+edSM7gaUd0rvskjbkPkzXTh39mimhPVwlevZ1QduzRzNImlx
6wDaKSOVPpSVSthlAEShZTEkH4r/uR548Fy2CpAW893H0/cmrTZ5cEq/+/hE2que
yua3o3A9OtsDWAwSZEGBheD1S/aZ7J200l3T38EvG1j/+/0DLuH5WA6a+VGtKqlZ
Bbx2Cn35+NgQ2miHAXGwgkMv6SjctnPWHm4/hzlSvHNvq/PRxcnMvSS0d7K1RGnS
Gtw5yY5hMLNqKqI3Igjx5TFVeSYufzYRTIFs/VawkGGHDElB0qdGWIWfNETx1KcJ
rwRCWgKpjf1ZPfwk80GNDVLjbg3x627VkYlHMn3qdOHDyF3juQbAm2BWbEUxTNRb
is0RoT5U9K2oma3PdHMv2ogrSGkh3Ne7HpQb72Ri1zADcYA7NxSUMrDcTm1GYRc3
Gpk+527yGgnBZAY/zQhDRL6UCg2ochAnny0aAwiZXElYUlcCrQFpQnmLWjmI1m8H
j+CEP9Q00eKyfpFtLVajAUVBD6a8/1OqribxX862hpJe09k+Ezu828UCaZlo++yz
3zenpZR9qOaoi+7RV90y5hFBSF34HZ4Vd5nPPkXlOwJV8aCzR8o=
=ITAT
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--

