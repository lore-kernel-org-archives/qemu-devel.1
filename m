Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD89C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 00:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED9B208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 00:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MiCHd9Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED9B208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGXFl-0004gB-7y
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 20:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kGXFC-00048E-Ar; Thu, 10 Sep 2020 20:48:50 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56129 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kGXF9-0004id-KP; Thu, 10 Sep 2020 20:48:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BncZK4ls8z9sVD; Fri, 11 Sep 2020 10:48:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599785321;
 bh=ecH29wFHn7fDBKuWTIFIR7OnasRWCj9Prh0xecXMRTk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MiCHd9SlCXqSnYeoNWJqW+wNvLDa9CeQzk36UP+UshrL0Pq9d/z2e6zv7c9nnIQ6D
 musbknKQseEZ0syGNn1K79f824cFu9OX69L07eHrfuerTIELlpkv5SP9XDTlpwo8HW
 Ui7IppjTl8lNkjFjR7Z3IRp45gayu92RHQVRff5I=
Date: Fri, 11 Sep 2020 10:07:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [for-5.2 v4 10/10] s390: Recognize host-trust-limitation option
Message-ID: <20200911000718.GF66834@yekko.fritz.box>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-11-david@gibson.dropbear.id.au>
 <20200907172253.0a51f5f7.pasic@linux.ibm.com>
 <20200910133609.4ac88c25.cohuck@redhat.com>
 <20200910202924.3616935a.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <20200910202924.3616935a.pasic@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 08:29:24PM +0200, Halil Pasic wrote:
> On Thu, 10 Sep 2020 13:36:09 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > On Mon, 7 Sep 2020 17:22:53 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >=20
> > > On Fri, 24 Jul 2020 12:57:44 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > At least some s390 cpu models support "Protected Virtualization" (P=
V),
> > > > a mechanism to protect guests from eavesdropping by a compromised
> > > > hypervisor.
> > > >=20
> > > > This is similar in function to other mechanisms like AMD's SEV and
> > > > POWER's PEF, which are controlled bythe "host-trust-limitation"
> > > > machine option.  s390 is a slightly special case, because we already
> > > > supported PV, simply by using a CPU model with the required feature
> > > > (S390_FEAT_UNPACK).
> > > >=20
> > > > To integrate this with the option used by other platforms, we
> > > > implement the following compromise:
> > > >=20
> > > >  - When the host-trust-limitation option is set, s390 will recognize
> > > >    it, verify that the CPU can support PV (failing if not) and set
> > > >    virtio default options necessary for encrypted or protected gues=
ts,
> > > >    as on other platforms.  i.e. if host-trust-limitation is set, we
> > > >    will either create a guest capable of entering PV mode, or fail
> > > >    outright =20
> > >=20
> > > Shouldn't we also fail outright if the virtio features are not PV
> > > compatible (invalid configuration)?
> > >=20
> > > I would like to see something like follows as a part of this series.
> > > ----------------------------8<--------------------------
> > > From: Halil Pasic <pasic@linux.ibm.com>
> > > Date: Mon, 7 Sep 2020 15:00:17 +0200
> > > Subject: [PATCH] virtio: handle host trust limitation
> > >=20
> > > If host_trust_limitation_enabled() returns true, then emulated virtio
> > > devices must offer VIRTIO_F_ACCESS_PLATFORM, because the device is not
> > > capable of accessing all of the guest memory. Otherwise we are in
> > > violation of the virtio specification.
> > >=20
> > > Let's fail realize if we detect that VIRTIO_F_ACCESS_PLATFORM feature=
 is
> > > obligatory but missing.
> > >=20
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > ---
> > >  hw/virtio/virtio.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 5bd2a2f621..19b4b0a37a 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -27,6 +27,7 @@
> > >  #include "hw/virtio/virtio-access.h"
> > >  #include "sysemu/dma.h"
> > >  #include "sysemu/runstate.h"
> > > +#include "exec/host-trust-limitation.h"
> > > =20
> > >  /*
> > >   * The alignment to use between consumer and producer parts of vring.
> > > @@ -3618,6 +3619,12 @@ static void virtio_device_realize(DeviceState =
*dev, Error **errp)
> > >      /* Devices should either use vmsd or the load/save methods */
> > >      assert(!vdc->vmsd || !vdc->load);
> > > =20
> > > +    if (host_trust_limitation_enabled(MACHINE(qdev_get_machine()))
> > > +        && !virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
> > > +        error_setg(&err, "devices without VIRTIO_F_ACCESS_PLATFORM a=
re not compatible with host trust imitation");
> > > +        error_propagate(errp, err);
> > > +        return;
> >=20
> > How can we get here? I assume only if the user explicitly turned the
> > feature off while turning HTL on, as otherwise patch 9 should have
> > taken care of it?
> >=20
>=20
> Yes, we can get here only if iommu_platform is explicitly turned off.

Right.. my assumption was that if you really want to specify
contradictory options, you get to keep both pieces.  Or, more
seriously, there might be some weird experimental cases where this
combination could do something useful if you really know what you're
doing, and explicitly telling qemu to do this implies you know what
you're doing.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9av7QACgkQbDjKyiDZ
s5KUdA//eTOLAq2vCeftME7tezJbgx3MkmP7eAQdwQNSnnlozRafbKEbRqgrnX9h
5mwHktZAnL085yz/UVaHQ8TM+OdE3qcdZAMbSCPLr+p8WiP81J/Tw8jFt8FjQO/G
eBJrs/tiaR1EMhmRB40N7cEJL2FPI4l9EZoffESbkoowlOPw9vhlW7SCL/yOicI+
+KwViTJpUtAdTfPifgkbshCUk2Hv87KcueXYpCbMZAc5pt/1nwQqgr+VP/MFpsgU
lZ3fgj1Zd8hi+VaJzW2ckcZaCPlyGF8df+21sqV9q5XzjWizhyykCwt8XUB2CmTU
WhWpwrQwYYFRgRCbALT/bp6m8BiQ1J2RKVTXsbqI/TVYzIZRUcoV90iUdYFUGrsK
TW2h+CvOa2uY1MPuQxxI7VV73B4TQ7rfDpuHjmHdbqF/PmgooZLFcNzJ8j1mHdit
th6oy9kOoosfMCvoBLWwNM8IY34Ox0q60Ero5TeByToslwgHUOdflzpVyXVHZz55
UYUx+n84DCsv6fKE49ch5zd1S1AJEYYIoHhsBph9ByDvSKDsaEqdfcad6eq7tD24
Vgo3uFiuQahG4xX0vWCNVe8Y2KEAGlKaxnxaK8FK5wujBFL5bTsz+z77G9qUTMZs
ywkTlryy4of0u1murp4lLaM2sBq1XFec+ILMgm3QYTxSpFtStro=
=QrIg
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--

