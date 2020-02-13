Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA784C3B18F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D2020675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qD8qhRs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D2020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NVB-0004mU-PG
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j2NQy-00075R-Mw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j2NQx-0006V9-8x
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:58:12 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39985 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j2NQv-0006Gt-PS; Thu, 13 Feb 2020 17:58:10 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48JX3Z6Y7dz9sRG; Fri, 14 Feb 2020 09:58:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581634682;
 bh=diOphC0RvZAzk7sd5XPNf8YAh2BCWesdZSoV6j22MaM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qD8qhRs6zuK3fcjQRL/o3f3ozpXTYjbqWXUGHktynbVSnv5hygwXzpKX7wRbSNvto
 ZHYi1Bv5bvokdJ73XNuQ5Krs/fOx5wjnRA42D8J6bOGdT5wVDABm6xfq827mLZXx0a
 H5bEs0xYkPNbfdgOKYyhnLHUCDiajmn0pBsXU4s8=
Date: Fri, 14 Feb 2020 09:57:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 0/2] spapr: Use vIOMMU translation for virtio by default
Message-ID: <20200213225756.GI124369@umbus.fritz.box>
References: <20200213005837.131791-1-david@gibson.dropbear.id.au>
 <20200213124643.7b205d44@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline
In-Reply-To: <20200213124643.7b205d44@bahia.lan>
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, mdroth@us.ibm.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 12:46:43PM +0100, Greg Kurz wrote:
> On Thu, 13 Feb 2020 11:58:35 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Upcoming Secure VM support for pSeries machines introduces some
> > complications for virtio, since the transfer buffers need to be
> > explicitly shared so that the hypervisor can access them.
> >=20
> > While it's not strictly speaking dependent on it, the fact that virtio
> > devices bypass normal platform IOMMU translation complicates the issue
> > on the guest side.  Since there are some significan downsides to
> > bypassing the vIOMMU anyway, let's just disable that.
> >=20
> > There's already a flag to do this in virtio, just turn it on by
> > default for forthcoming pseries machine types.
> >=20
> > Any opinions on whether dropping support for the older guest kernels
> > is acceptable at this point?
> >=20
>=20
> As expected, this breaks compatibility with existing RHEL 6.10 guests. Ea=
ch
> patch in this series requires an extra -global option to be specified on
> the command line in order to boot successfully.
>=20
> Patch 1: -global virtio-pci.disable-legacy=3Dauto
> Patch 2: -global virtio-pci.iommu_platform=3Doff

Right, or setting an older machine type.

> As seen on the RH site [1], RHEL6 will reach "End of Maintenance Support
> or Maintenance Support 2 (Product retirement)" on November 30, 2020 and
> "End of Extended Life-cycle Support" on June 30, 2024.
>=20
> Not sure if it's okay to drop support for RHEL6 this soon.

Hm, yeah.  I'm happy enough to do this upstream, downstream will
require some discussion.

> RHEL 7.7 guests seem to be unaffected.

Yeah, I already checked and RHEL7 has backported support for modern
virtio and the iommu platform flag.

>=20
> [1] https://access.redhat.com/support/policy/updates/errata/#Life_Cycle_D=
ates
>=20
> > Changes since v1:
> >  * Added information on which guest kernel versions will no longer
> >    work with these changes
> >  * Use Michael Tsirkin's suggested better way of handling the machine
> >    type change
> >=20
> > David Gibson (2):
> >   spapr: Disable legacy virtio devices for pseries-5.0 and later
> >   spapr: Enable virtio iommu_platform=3Don by default
> >=20
> >  hw/ppc/spapr.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5F1HQACgkQbDjKyiDZ
s5Kp8BAA5s7lU2O9pHRUGE1w1AN9HLT/I2wsICxTCpqzYDu1TcZky+lZVaGa5u+8
edLRQogRxd9vkK7o4QEAbsJVr705X8tR6C5iF4ErV1vkmxljFmMSMfpFg/qVPcXd
sSXo/Owdio7dQRPlHPGc7vXFlPWsihcOKIAvX4Sy8uij7iA+2/pqIk81jJoUNPaD
/9cFSNSHlqtvHbN+Sqzr06RYMcmRIrSMOFsQxalmiSgw/Xcujf5nWnkhEMRE0j1p
eT2N2EWM76N8I9pU4lKJNx4zwzHtJeJvQGFXEiTVz1FbkWaJmBEnN+V0l/+R/nRn
wONTAaQO+gR/PAaqSuoLLTUbErR4+yWDuuwsJ8vS69aRuHl9BexjD1AzKVSC9D6i
PU+HNboNdMfjbuQe9NcKjPU2UBdbrRpPGRbmKWM5V6mtCSincIfkR3O4IcQ9Lblf
CCGkNPAKswEtoQQEFkGI+LPIkhMn2Exwg49oNH61CT9epLrTamysheijozxLAo3O
HVLZHD9JKyD8rIU0jYMq3N5OmdS8iJZ1zlj9jQWjpneRL9abOflAvLYujRzwtFH2
VhxnsJ0ToStrc42ZgxLZNeeqDXc5Hx/ajl4pVWvPisJdPEgAfg9ao6K2b4rQjf7h
60mYOz9rv/FUfpiNZ8UvtL85OcncvnyJby11/9E2u0wkN3tq628=
=K/Ky
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--

