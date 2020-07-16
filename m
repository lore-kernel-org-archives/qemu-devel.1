Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1B8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 00:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176AF206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 00:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="m9Q5rm/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176AF206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwDxp-00047l-Da
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 20:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwDvS-0001SC-0p; Thu, 16 Jul 2020 20:08:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwDvO-0001j3-2L; Thu, 16 Jul 2020 20:08:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B7BKd1mmpz9sRN; Fri, 17 Jul 2020 10:08:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594944501;
 bh=2vx06zp73wz3Ol1Zy6rKplIQTC2vMPbjd/OKSA2mZPM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m9Q5rm/a5D+WlTbyGyL4x6OW4jnsdPXj2q1u8W0jopVplJLh6Kc9JIvN5oHkRAWHm
 GGSz0TRtKyUHv3jnaoA32yUsHzUG9JNrqFH1/h+LM4x9Z5dVFOSSmCEkqdXHPkXQB1
 PUe6IhT4Nbvero5F3KJ7WIZyYesf/N9k86q2Qzgs=
Date: Fri, 17 Jul 2020 09:57:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
Message-ID: <20200716235731.GD5607@umbus.fritz.box>
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
 <20200716044540.GL93134@umbus.fritz.box>
 <20200716123244.1f854c63@bahia.lan>
 <20200716131109.GA5607@umbus.fritz.box>
 <87r1tblerr.fsf@dusky.pond.sub.org>
 <20200716165754.50af735a@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20200716165754.50af735a@bahia.lan>
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
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 04:57:54PM +0200, Greg Kurz wrote:
> On Thu, 16 Jul 2020 16:23:52 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>=20
> > David Gibson <david@gibson.dropbear.id.au> writes:
> >=20
> > > On Thu, Jul 16, 2020 at 12:32:44PM +0200, Greg Kurz wrote:
> > >> On Thu, 16 Jul 2020 14:45:40 +1000
> > >> David Gibson <david@gibson.dropbear.id.au> wrote:
> > >>=20
> > >> > On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
> > >> > > Some recent error handling cleanups unveiled issues with our sup=
port of
> > >> > > PCI bridges:
> > >> > >=20
> > >> > > 1) QEMU aborts when using non-standard PCI bridge types,
> > >> > >    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead erro=
r handling"
> > >> > >=20
> > >> > > $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
> > >> > > Unexpected error in object_property_find() at qom/object.c:1240:
> > >> > > qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_n=
r' not found
> > >> > > Aborted (core dumped)
> > >> >=20
> > >> > Oops, I thought we had a check that we actually had a "pci-bridge"
> > >> > device before continuing with the hotplug, but I guess not.
> > >>=20
> > >> Ah... are you suggesting we should explicitly check the actual type
> > >> of the bridge rather than looking for the "chassis_nr" property ?
> > >
> > > Uh.. I thought about it, but I don't think it matters much which way
> > > we do it.
> >=20
> > Would it make sense to add the "chassis_nr" property to *all* PCI
> > bridge devices?
> >=20
>=20
> I see that the "PCI Express to PCI/PCI-X Bridge Specification" mentions
> a "Chassis Number Register" which looks very similar to the what exists
> in standard PCI-to-PCI brdiges. This doesn't seem to be implemented in
> our "pcie-pci-bridge" device model though, but of course I have no idea
> why :)

We could consider it, but I don't think there's a lot to be gained by
it at this stage.  I don't think there's really any reason to want to
use bridges other than plain "pci-bridge" on the pseries machine.

PCI is a bit weird on pseries, since it's explicitly paravirt.
Although you can use extended config space, and thereby PCI-E devices
on it, the topology really looks pretty much identical to vanilla
PCI.  So, I don't think there's any reason to use PCI-E bridges on
pseries.

Other than PCI-E bridges of various sorts, a quick scan suggests all
the other bridge types in qemu are weird variants that are mostly
specific to some particular platform.  I don't see any reason we'd
want those on pseries either.

> Maybe Michael or Marcel (cc'd) can share some thoughts about that ?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Q6WsACgkQbDjKyiDZ
s5IbZA//SFBSz7PXDYxyNsMKMUcjC2fdSM8FXsIpm4hZxSvauxEWzfVRS5FqFtjt
Gq78Qg2XFMbe42bFRWwU9dXKGL//IBHzMuF4FWv0HxNWoKVsxzgYQiHk1lH8+RGL
/a271Hyr54bYMP5Q1uJujzwSfFZSHbcHhnTfOBOev/EVVXWAtEhKYeqvnqlhe9S2
lspYMFYOyovbPFIhejOdhSrPajCx/jDtpKvDEQ75yJ82c6IBK5er7cKOMW7aJpHn
Odaz5CNy2AOMKtp43ldA5Dm7splTCQN2THgYApdPcVdwINm5BhlcuuNi82EJsABB
UZoeas1U/OA2ewj7YD3gpm/i4g21u4LwoDChdGSUSFWyisnishR9BqV7KMz4rQtm
YBXmqaaSG5CjiWa3LhFPsR9xvF3JxC8PWzXLphA5lgcOr4Ijap5BYhOvSbgyEI66
cAawcPFGpfEtNM1FKqyGCnRpgD69k5gzV54NeWWgRhEIsbp/BJqKE3KDFUqDtoPM
tujqvPEUewwo40zF5J2pxgxgPpW19ZEH5dmOESP9uorXHsVdkhvEWCYUdJUW44t1
6fXZg8R/5cWfTkDvZDHtM9fgZMxLl9hnzfJem0wNsYrzdjL5naze9T5MDVdr0IiQ
Cq5xLgpMmfU8sSBEON4KKuEkBRQD/YT888MOG13durjPAgKJMbQ=
=AdXU
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--

