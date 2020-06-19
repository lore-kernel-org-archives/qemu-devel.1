Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB77C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 00:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BED2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 00:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gMAeerAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BED2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm53G-0001Pu-31
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 20:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm51v-0008HY-5s; Thu, 18 Jun 2020 20:37:15 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57457 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm51q-0003RB-Si; Thu, 18 Jun 2020 20:37:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49p0Hj5tKcz9sDX; Fri, 19 Jun 2020 10:37:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592527025;
 bh=aIzCxhfv2ObrCJj0TCpd2WCdpmqx4fa6qkmXuPbbCXk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gMAeerAW/jhvWdQVplKDAN0nBfoh3osrHFz4g6HktljHnE5prJ2NJ7wA4OnoP5FT7
 gU5RLxfPuoa49u/fQvoqjv2JluWHurcY0DwZe7APAXstw/5GWYtyemz96Fy9eDGun6
 zzMRFFlOoEPZTwv+xK/pSFSgwFkysU62CVUrBzBw=
Date: Fri, 19 Jun 2020 10:36:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200619003607.GF17085@umbus.fritz.box>
References: <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
 <20200609182839.7ac80938.pasic@linux.ibm.com>
 <20200609124155-mutt-send-email-mst@kernel.org>
 <20200610043118.GF494336@umbus.fritz.box>
 <4e5d62d8-9bfb-67d5-7398-2079729fd85e@redhat.com>
 <20200610100756.GO494336@umbus.fritz.box>
 <858e9554-a4c7-6487-121b-ac3eaa209cb7@redhat.com>
 <4738b708-9d19-beae-4345-b77453afc585@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <4738b708-9d19-beae-4345-b77453afc585@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 03:19:22PM +0200, Viktor Mihajlovski wrote:
>=20
>=20
> On 6/10/20 12:24 PM, David Hildenbrand wrote:
> > On 10.06.20 12:07, David Gibson wrote:
> > > On Wed, Jun 10, 2020 at 09:22:45AM +0200, David Hildenbrand wrote:
> > > > On 10.06.20 06:31, David Gibson wrote:
> > > > > On Tue, Jun 09, 2020 at 12:44:39PM -0400, Michael S. Tsirkin wrot=
e:
> > > > > > On Tue, Jun 09, 2020 at 06:28:39PM +0200, Halil Pasic wrote:
> > > > > > > On Tue, 9 Jun 2020 17:47:47 +0200
> > > > > > > Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
> > > > > > >=20
> > > > > > > > On Tue, 9 Jun 2020 11:41:30 +0200
> > > > > > > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > > > > > > >=20
> > > > > > > > [...]
> > > > > > > >=20
> > > > > > > > > I don't know. Janosch could answer that, but he is on vac=
ation. Adding
> > > > > > > > > Claudio maybe he can answer. My understanding is, that wh=
ile it might
> > > > > > > > > be possible, it is ugly at best. The ability to do a tran=
sition is
> > > > > > > > > indicated by a CPU model feature. Indicating the feature =
to the guest
> > > > > > > > > and then failing the transition sounds wrong to me.
> > > > > > > >=20
> > > > > > > > I agree. If the feature is advertised, then it has to work.=
 I don't
> > > > > > > > think we even have an architected way to fail the transitio=
n for that
> > > > > > > > reason.
> > > > > > > >=20
> > > > > > > > What __could__ be done is to prevent qemu from even startin=
g if an
> > > > > > > > incompatible device is specified together with PV.
> > > > > > >=20
> > > > > > > AFAIU, the "specified together with PV" is the problem here. =
Currently
> > > > > > > we don't "specify PV" but PV is just a capability that is man=
aged by the
> > > > > > > CPU model (like so many other).
> > > > > >=20
> > > > > > So if we want to keep it user friendly, there could be
> > > > > > protection property with values on/off/auto, and auto
> > > > > > would poke at host capability to figure out whether
> > > > > > it's supported.
> > > > > >=20
> > > > > > Both virtio and CPU would inherit from that.
> > > > >=20
> > > > > Right, that's what I have in mind for my 'host-trust-limitation'
> > > > > property (a generalized version of the existing 'memory-encryptio=
n'
> > > > > machine option).  My draft patches already set virtio properties
> > > > > accordingly, it should be possible to set (default) cpu propertie=
s as
> > > > > well.
> > > >=20
> > > > No crazy CPU model hacks please (at least speaking for the s390x).
> > >=20
> > > Uh... I'm not really sure what you have in mind here.
> > >=20
> >=20
> > Reading along I got the impression that we want to glue the availability
> > of CPU features to other QEMU cmdline parameters (besides the
> > accelerator). ("to set (default) cpu properties as well"). If we are
> > talking about other CPU properties not expressed as CPU features (e.g.,
> > -cpu X,Y=3Don ...), then there is no issue.
> >=20
>=20
> The reason that the capability to run in PV mode is expressed in the CPU
> model is that this capability *is* provided by the CPU in terms of
> available instructions. I wouldn't see a benefit in providing
> a meta-property that needs to be synced with the CPU model.
>=20
> So, if something has to be concluded from the fact that a VM
> could run in PV mode, that decision should be derived from the
> CPU model.

The trouble is that that approach is inherently s390 specific, and I'm
hoping we can make the configuration at least somewhat common between
platforms.

It also seems a very nasty layering violation to me for changing cpu
properties to affect apparently unrelated devices (like virtio, for
example).  It's still a bit nasty doing it from a machine property,
but it seems more reasonable to me that a machine property could
affect things elsewhere in the.. well.. machine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7sCHcACgkQbDjKyiDZ
s5K0Fg/5AWMKq2FxW2frF8VirLlsZZ2VZqvPFDDqG5PD/W9kx0NpuhkNnEswM+8g
U1KMduikO+FhbSIyI8mAWXxpkUiIq+2B1YvuxEde0den8SujHMBbl1LpIX9lp0Zu
B6R6AJijQXVeQYNExcu+D9Xm2NBsg9W1pSHFHif3SuJeB/okAZfGSBbZl4dD6Frr
AkWMDrSaOzj6en/5jpd0P6joXvYvV3/FjkLBIB6gd7PJ3NFPjw4zOyBrx+rKDeIH
+2qGoXYddkkF0e/patU6XxDzWz2e5jKBXdrUAA0FHROnS+DjgceCaWst1NA05VH7
AmTYmfoC/11TosJJ1PUBSA+DqZU0WanfkpiYutq0pHshZGgpUVqFxM0JI178H1RJ
lqgN24sTmg7s9wG2/DAr2nrvK6tGdkTxfI+yziJd3RVYltV/DtRpu/2M54Yu0SIh
/bv3U1kW5bRYJprL32kFrs5odOcuAln3tIz27gxlAvZUUkr3N7a1q6IHJxOBx8lI
92IFS9oSw0U66A+osubbw/FBJ6c4azPXIuI7yRUxoz6yHlpcAVqRnp3Cx69B4sbz
YS8tn2AHwO3zXQgagSPTZq07VC1FBFuF196TusQ6nK5G/ZM2cYlcsEQv9RP1AtrH
WewINA1zSf16hcjXappGZ9b6v6l7H24AnDkCdjOxRWb2dTSoaLE=
=Rc/X
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--

