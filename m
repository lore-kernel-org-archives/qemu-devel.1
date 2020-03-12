Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F041C0044D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 01:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B9520735
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 01:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PndEnLqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B9520735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCCaO-0003fv-AJ
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 21:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jCCZc-0002gk-51
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 21:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jCCZa-0006qt-On
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 21:23:43 -0400
Received: from ozlabs.org ([203.11.71.1]:39801)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jCCZZ-0006cx-VW; Wed, 11 Mar 2020 21:23:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48dB131sxgz9sPK; Thu, 12 Mar 2020 12:23:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583976215;
 bh=eA7LdklqTkNHfO1jkvvmIIjlmld0I1X0pIGq9UPsZjg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PndEnLqHW08+yiNPPmQ+gOAne336D6UC+V5kF6skDaptRu8/KN22onTMf2V07+4y4
 DRREhvop/xFM7gxqK0HsLRN/OiptAq4svk/4NlWQYmidUqFyzjjPSO/t5wwQbAyLHu
 /SvSbVQjeirLchTnJeyVPy7EJJSt5aFIiw5j/qYA=
Date: Thu, 12 Mar 2020 12:09:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Upstream QEMU guest support policy ? Re: [PATCH v3 0/2] spapr:
 Use vIOMMU translation for virtio by default
Message-ID: <20200312010926.GB711223@umbus.fritz.box>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200310114343.GD3234052@redhat.com>
 <20200311011247.GT660117@umbus.fritz.box>
 <20200311100127.GC3614859@redhat.com>
 <20200311073145-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20200311073145-mutt-send-email-mst@kernel.org>
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
Cc: pair@us.ibm.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, aik@ozlabs.ru,
 groug@kaod.org, qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org,
 mdroth@us.ibm.com, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 07:48:26AM -0400, Michael S. Tsirkin wrote:
> On Wed, Mar 11, 2020 at 10:01:27AM +0000, Daniel P. Berrang=E9 wrote:
> > On Wed, Mar 11, 2020 at 12:12:47PM +1100, David Gibson wrote:
> > > On Tue, Mar 10, 2020 at 11:43:43AM +0000, Daniel P. Berrang=E9 wrote:
> > > > On Thu, Mar 05, 2020 at 03:30:07PM +1100, David Gibson wrote:
> > > > > Upcoming Secure VM support for pSeries machines introduces some
> > > > > complications for virtio, since the transfer buffers need to be
> > > > > explicitly shared so that the hypervisor can access them.
> > > > >=20
> > > > > While it's not strictly speaking dependent on it, the fact that v=
irtio
> > > > > devices bypass normal platform IOMMU translation complicates the =
issue
> > > > > on the guest side.  Since there are some significan downsides to
> > > > > bypassing the vIOMMU anyway, let's just disable that.
> > > > >=20
> > > > > There's already a flag to do this in virtio, just turn it on by
> > > > > default for forthcoming pseries machine types.
> > > >=20
> > > > Breaking existing guest OS to support a new secure VM feature that
> > > > may not even be used/wanted doesn't seems like a sensible tradeoff
> > > > for default out of the box behaviour.
> > > >=20
> > > > IOW, if Secure VM needs this, can we tie the change in virtio and
> > > > IOMMU defaults to the machine type flag that enables the use of
> > > > Secure VM.
> > >=20
> > > There is no such flag.
> > >=20
> > > In the POWER secure VM model, the secure mode option isn't something
> > > that's constructed in when the hypervisor builds the VM.  Instead the
> > > VM is started normally and transitions itself to secure mode by
> > > talking directly with the ultravisor (it then uses TPM shenannigans to
> > > safely get the keys to its real storage backend(s)).
> >=20
> > This is pretty suprising to me. The ability to use secure VM mode surely
> > depends on host hardware features. We would need to be able to block the
> > use of this, in order to allow VMs to be live migrated to hosts which
> > lack the feature. Automatically & silently enabling a feature that
> > has a hardware dependancy is something we aim to avoid, unless the user
> > has opted in via some flag (such as -cpu host, or a -cpu $NAME, that
> > implies the feature).
>=20
> That's something I don't know. Is migration supported in this mode?

Not at this stage, though there's plans for it later.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5pi8YACgkQbDjKyiDZ
s5LPcw//cZf8xj3fO2dEsNK6VqAlc7JM0+OTUJlgq5qd3Z8jUtxAOsSqou3OEsKJ
tJgqlxm+gKclNh8PFU/lACcv7Eza2MDgrXnJJAkI2aOnpMek4zN3VVAjiF7lGASu
GHkffZuOrdcuF2cGvdCehn9s2N+hPZxzhmL2XAHl6j+SSl1A4h7vnAHRtJ6EbfG2
IcfDVZBiUp6DyMpLbXZbfEgReTD9pWjBjpDg6uUqEId/7kzXuGF26ykCnW2fIiqz
Tt3eWRmAHvUudzRtcCrJ5y9KRBRBK0yiFgjb5o2SHmpKFF41zdgpTS/kshPrJw19
QOYZCspnYnF3hX9BpxG7/zLhgM+qtQDUtQ5TH3rFG9hak7aDutzMj0vNLwxjlXGm
L7pJ78e26SshfulL8AQqvAkbPj/uX8Npio6jkbdggIHT3XQnkDHBDPa/qKTs5dhE
6Jc2nQCBg0wyAjZXOd1rtUhEF7/2iXb5e91LiEUg0w4S7DuktayXthOquvBoKofV
rKDofXw2uGHH9KDlLPPSJpy3klgDaUqkEO3KuJjUOKP763BEfrcrRwp/qjJbgVXd
yTsXa7co3+9GokenjIwqTxGlbIDRwsMuQiuHkrIx6gj0cHd8bjsUhuH/m+fHZ1/l
aFDloZswv5QrSpO0t/gunVUAp4R/u2Xf/6/FY8Gc5mKuxvjsJMw=
=RinF
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

