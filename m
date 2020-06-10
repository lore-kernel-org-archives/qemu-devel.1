Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7BFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91622074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XzhPdfyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91622074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisy5-0001Wm-1e
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjJ-0002YO-Ln; Wed, 10 Jun 2020 00:52:49 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41619 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjG-0004eU-Nx; Wed, 10 Jun 2020 00:52:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49hZFC2R7Fz9sQx; Wed, 10 Jun 2020 14:46:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591764367;
 bh=ZG+dSKtYCs4GWV8rc0PS07x5YfO+R2meZ1M5/uNSHm4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XzhPdfyZna8knULwR8dW3AxZ9yupXAterKxp1g8FBQxFilRqpBfNuA6h8NKlxZukD
 8AhBA+3rsr5+Z9Dawd/C0pDnukIxuIOXmqtdnbSh5Xx/Eo9+Yge2tl9Qia5XVPPngl
 T42kjdNYONicLk2/QBhRTvEpz4E2AFJFV0q8ybKc=
Date: Wed, 10 Jun 2020 14:29:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200610042929.GE494336@umbus.fritz.box>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
 <20200609182839.7ac80938.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <20200609182839.7ac80938.pasic@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Viktor Mihajlovski <mihajlov@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 06:28:39PM +0200, Halil Pasic wrote:
> On Tue, 9 Jun 2020 17:47:47 +0200
> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
>=20
> > On Tue, 9 Jun 2020 11:41:30 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >=20
> > [...]
> >=20
> > > I don't know. Janosch could answer that, but he is on vacation. Adding
> > > Claudio maybe he can answer. My understanding is, that while it might
> > > be possible, it is ugly at best. The ability to do a transition is
> > > indicated by a CPU model feature. Indicating the feature to the guest
> > > and then failing the transition sounds wrong to me.
> >=20
> > I agree. If the feature is advertised, then it has to work. I don't
> > think we even have an architected way to fail the transition for that
> > reason.
> >=20
> > What __could__ be done is to prevent qemu from even starting if an
> > incompatible device is specified together with PV.
>=20
> AFAIU, the "specified together with PV" is the problem here. Currently
> we don't "specify PV" but PV is just a capability that is managed by the
> CPU model (like so many other). I.e. the fact that the
> visualization environment is capable providing PV (unpack facility
> available), and the fact, that the end user didn't fence the unpack
> facility, does not mean, the user is dead set to use PV.
>=20
> My understanding is, that we want PV to just work, without having to
> put together a peculiar VM definition that says: this is going to be
> used as a PV VM.

Having had a similar discussion for POWER, I no longer think this is a
wise model.  I think we want to have an explicit "allow PV" option -
but we do want it to be a *single* option, rather than having to
change configuration of a whole bunch of places.

My intention is for my 'host-trust-limitation' series to accomplish
that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7gYakACgkQbDjKyiDZ
s5KssBAAv3X5FqeJqLQeW/ZNYCqjJcTdXoC2k8qhTxQMwpbSV8bM0/1FASFNK02X
bMXzdr7FcBc9wLyGBd75Bfga6jDgffWEMparTTNmaPBBiMG9neq/TVX34OlEipGW
7MK8BSJbK9RIOUP7NNGnV9K5VDVMSoX8f1kIUmiOGAzyIyj8UNJfuL/16L/SG1W+
xQQrV+LCu0BE03qEhVCEEIwZKtDTBMxT6iNmAPw4RKuRkgHOGX3q+hL8+7T/2vog
+B2d5nu00hJcIY7smT+R1PNyCAya+JeVLEW5cMwCx7VtRjmAeGLlHnNfAPOveGoG
tvueN+IiiN7MhJmGMYOzVbWh6J4aeats47SevyVNwAS0C1X/prMLMRL1h9z+2xwu
n64CZq+G+5awmuOwzbbxAyEyFdBOXiIpunO2PZk7bK8i4Q9bf60Mo3Tk/tujB8Uv
2Yb7Dt1OBp7rxe0qOBeTpDIoE87qOaQMaFt3KJPcCwPPT6UPBsGTyaXgYLcZjAiP
YHS7Kt2VWUIS78k7nUgxD5XA3ZJ1QCuW7hgpfMMscbXtbQgf7a7m71nc1KecldCp
70zykGZO/P7xvDd75Shh1l+NNzO0lEUV7Y0w0QX6aPZR6DZnc+87pmqcRYMnKZM1
KWv9xstukqQqu4HmiXujF39GRwL01pl9FPEbfTsyrBe0VKeiY+c=
=lwkf
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--

