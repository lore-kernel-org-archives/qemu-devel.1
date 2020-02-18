Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A51C3404D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 23:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3333422B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 23:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j4Y+jlWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3333422B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4CCF-0005pq-Dt
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 18:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4CB8-0004mr-DR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 18:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4CB6-0006sn-L8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 18:21:21 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45631 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4CB6-0006m0-9D; Tue, 18 Feb 2020 18:21:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48McL41100z9sPK; Wed, 19 Feb 2020 10:21:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582068076;
 bh=XDhp6Acx7sHCQYXBtnxQzp6QziSAoWDIFAIbPWD95Wc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j4Y+jlWV2mc66IfZepsW8YepdZjLh61aBd1ZLS3OWy/CY9bvzhfC5DObUZAbzjSD5
 O/ImI38x1m3Uwc1lGf75Af/iHmvS6iHQ2vy7FSX22BpXR12XMw5SIa4i6Ns/B3OFro
 1KAeWnTmE6bXSkLenIohJfMWZYvD8LRLdEGEh/Zc=
Date: Wed, 19 Feb 2020 10:10:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Message-ID: <20200218231026.GE1764@umbus.fritz.box>
References: <20200217021217.95766-1-aik@ozlabs.ru>
 <8e67117e-e74a-fb5c-226b-78e62ac26291@kaod.org>
 <44499677-3099-56c6-7249-afa8eccc7668@ozlabs.ru>
 <bdfb7d07-c5fd-c21e-f812-4a0a747b02c3@kaod.org>
 <0c21bb33-e6c0-c117-c9e7-dda16d3b13a5@ozlabs.ru>
 <4a8261b3-3842-869c-0997-b997229ff3f6@ozlabs.ru>
 <20649920-f867-7193-e86e-89b42ec6ae97@kaod.org>
 <474f7204-fcee-ae4b-eb9a-d5d0a987c4a2@kaod.org>
 <74ccc95e-d4bb-e540-5d63-ab057c504806@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <74ccc95e-d4bb-e540-5d63-ab057c504806@kaod.org>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 01:59:44PM +0100, C=E9dric Le Goater wrote:
> On 2/18/20 1:48 PM, C=E9dric Le Goater wrote:
> > On 2/18/20 10:40 AM, C=E9dric Le Goater wrote:
> >> On 2/18/20 10:10 AM, Alexey Kardashevskiy wrote:
> >>>
> >>>
> >>> On 18/02/2020 20:05, Alexey Kardashevskiy wrote:
> >>>>
> >>>>
> >>>> On 18/02/2020 18:12, C=E9dric Le Goater wrote:
> >>>>> On 2/18/20 1:30 AM, Alexey Kardashevskiy wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 17/02/2020 20:48, C=E9dric Le Goater wrote:
> >>>>>>> On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
> >>>>>>>> The following changes since commit 05943fb4ca41f626078014c032778=
1815c6584c5:
> >>>>>>>>
> >>>>>>>>   ppc: free 'fdt' after reset the machine (2020-02-17 11:27:23 +=
1100)
> >>>>>>>>
> >>>>>>>> are available in the Git repository at:
> >>>>>>>>
> >>>>>>>>   git@github.com:aik/qemu.git tags/qemu-slof-20200217
> >>>>>>>>
> >>>>>>>> for you to fetch changes up to ea9a03e5aa023c5391bab5259898475d0=
298aac2:
> >>>>>>>>
> >>>>>>>>   pseries: Update SLOF firmware image (2020-02-17 13:08:59 +1100)
> >>>>>>>>
> >>>>>>>> ----------------------------------------------------------------
> >>>>>>>> Alexey Kardashevskiy (1):
> >>>>>>>>       pseries: Update SLOF firmware image
> >>>>>>>>
> >>>>>>>>  pc-bios/README   |   2 +-
> >>>>>>>>  pc-bios/slof.bin | Bin 931032 -> 968560 bytes
> >>>>>>>>  roms/SLOF        |   2 +-
> >>>>>>>>  3 files changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> *** Note: this is not for master, this is for pseries
> >>>>>>>>
> >>>>>>>
> >>>>>>> Hello Alexey,
> >>>>>>>
> >>>>>>> QEMU fails to boot from disk. See below.
> >>>>>>
> >>>>>>
> >>>>>> It does boot mine (fedora 30, ubuntu 18.04), see below. I believe I
> >>>>>> could have broken something but I need more detail. Thanks,
> >>>>>
> >>>>> fedora31 boots but not ubuntu 19.10. Could it be GRUB version 2.04 =
?=20
> >>>>
> >>>>
> >>>> No, not that either:
> >>>
> >>>
> >>> but it might be because of power9 - I only tried power8, rsyncing the
> >>> image to a p9 machine now...
> >>
> >> Here is the disk :=20
> >>
> >> Disk /dev/sda: 50 GiB, 53687091200 bytes, 104857600 sectors
> >> Disk model: QEMU HARDDISK  =20
> >> Units: sectors of 1 * 512 =3D 512 bytes
> >> Sector size (logical/physical): 512 bytes / 512 bytes
> >> I/O size (minimum/optimal): 512 bytes / 512 bytes
> >> Disklabel type: gpt
> >> Disk identifier: 27DCE458-231A-4981-9FF1-983F87C2902D
> >>
> >> Device         Start       End   Sectors Size Type
> >> /dev/sda1       2048     16383     14336   7M PowerPC PReP boot
> >> /dev/sda2      16384 100679679 100663296  48G Linux filesystem
> >> /dev/sda3  100679680 104857566   4177887   2G Linux swap
> >>
> >>
> >> GPT ?=20
> >=20
> > For the failure, I bisected up to :
> >=20
> > f12149908705 ("ext2: Read all 64bit of inode number")
>=20
> Here is a possible fix for it. I did some RPN on my hp28s in the past=20
> but I am not forth fluent.
>=20
> "slash not found" is still there though.=20

I've removed this SLOF update from my ppc-for-5.0 staging tree until
we figure out what's going wrong here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5MbuIACgkQbDjKyiDZ
s5IywRAAqZJwgQ3dkT9i4i4vpi70LRWvBoDqdV1yTpW4mTl4G3ZWWuK8WpXdPGv8
9Mx/UA+FXja+fLezdgxGiyyKwZy1ZwbbVAyvOkUaMj0nY81HT9OfmOzEyl6KB2pm
MbCeYAdfLatzEFLe32o02N4ASwp9dqxLTHtfLh3GruxB/eQQoWwm0n8yKVmIyuIB
2y6MEmmdedNu8ZY5TAKSu2JreM1e55+Sqg14L9DE2shhyDznkRzenv+cjE1Sonfk
J4oHZjZPc+/gi4g/k4mZ3b44jR0H5jaX6qD22cm6NIQM7WTb/MddPU4vYARQWZnk
CgGjyARcQ5ZkAv5KSJaiia17NpidE/0qxay/JzFvYOR4yZ4YzttrYB1r/MxRIWKB
k+atFLqCVHHJ5U5dz9zXI22ec9KqF0KwwtXKf3cqbRx0aurS5LR54mhv1zoR+WiJ
RXtQ6BWu7rrgQysIYoxCUCm6yBaWelsLyBI3S0m9714TvzkjK5k2K3Y5vZPcZhwi
4QQDge9RMyijwjs/khW2S56UnYP7rQ0Fv3T4jHSq5V3PVbRCVUUEpKPD4vRHgsuV
On/k6V/N3JIfV3X0va/yjON3PS26EHNvWu845vCqECTdJrKaMJ++zhBXN1wkrAQq
D1yBUWAZqTiL0TzRup3qAmE+6iB0A/wfngkKC5hW6JjcQxxKSVk=
=fe+Z
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--

