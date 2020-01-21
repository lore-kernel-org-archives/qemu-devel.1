Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C05DC47409
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 07:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C3824125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 07:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C3824125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ito7z-0007aB-Vk
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 02:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ito7H-00073I-AH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ito7E-0000U7-Cl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:38:27 -0500
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:48307)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ito7E-0000TA-6Z
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:38:24 -0500
Received: from player771.ha.ovh.net (unknown [10.108.57.150])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id DF094129698
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 08:38:21 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id EA1F0E84B2EA;
 Tue, 21 Jan 2020 07:38:13 +0000 (UTC)
Date: Tue, 21 Jan 2020 08:38:11 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200121083811.75112e56@bahia.lan>
In-Reply-To: <20200121034126.GB265522@umbus.fritz.box>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <6fb96fed-9590-aa7c-cf00-038ab776ccb5@kaod.org>
 <20200121034126.GB265522@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d6bj9c9m3.zFpIHu2m6GhT/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 12280471762345499110
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudejgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.43.93
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
Cc: Laurent Vivier <lvivier@redhat.com>, Lukas Doktor <ldoktor@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/d6bj9c9m3.zFpIHu2m6GhT/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jan 2020 14:41:26 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jan 15, 2020 at 07:10:47PM +0100, C=C3=A9dric Le Goater wrote:
> > On 1/15/20 6:48 PM, Greg Kurz wrote:
> > > Migration can potentially race with CAS reboot. If the migration thre=
ad
> > > completes migration after CAS has set spapr->cas_reboot but before the
> > > mainloop could pick up the reset request and reset the machine, the
> > > guest is migrated unrebooted and the destination doesn't reboot it
> > > either because it isn't aware a CAS reboot was needed (eg, because a
> > > device was added before CAS). This likely result in a broken or hung
> > > guest.
> > >=20
> > > Even if it is small, the window between CAS and CAS reboot is enough =
to
> > > re-qualify spapr->cas_reboot as state that we should migrate. Add a n=
ew
> > > subsection for that and always send it when a CAS reboot is pending.
> > > This may cause migration to older QEMUs to fail but it is still better
> > > than end up with a broken guest.
> > >=20
> > > The destination cannot honour the CAS reboot request from a post load
> > > handler because this must be done after the guest is fully restored.
> > > It is thus done from a VM change state handler.
> > >=20
> > > Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> > C=C3=A9dric Le Goater <clg@kaod.org>
> >=20
> > Nice work ! That was quite complex to catch !
>=20
> It is a very nice analysis.  However, I'm disinclined to merge this
> for the time being.
>=20
> My preferred approach would be to just eliminate CAS reboots
> altogether, since that has other benefits.  I'm feeling like this
> isn't super-urgent, since CAS reboots are extremely rare in practice,
> now that we've eliminated the one for the irq switchover.
>=20

Yeah. The only _true_ need for CAS rebooting now seems to be hotplug
before CAS, which is likely not something frequent.

> However, if it's not looking like we'll be ready to do that as the
> qemu-5.0 release approaches, then I'll be more than willing to
> reconsider this.
>=20

I hope we can drop CAS reboot in time.

--Sig_/d6bj9c9m3.zFpIHu2m6GhT/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl4mqmMACgkQcdTV5YIv
c9ZXPA//Vtypgf9BtbRF1opMUSFMPVWK1WIyv3fPrLVCtyF7B7vEO6366nlB57Mh
SkBAOHC7LcqZ4RCbrvtsu2c3Q68ngiH9wA+zfKe88+SVM7husOY9sIbYADEgi7N4
tW8/7tz3v9MIDWipzCpV8ul+Nu10mpo5FW8vW6WX2LSNJRQUiKfJHGgM9mnlVmmb
FKIgKkE6R1Smu/nv2vB4ZlwUvqsqRcjBtXYqIFetGbK9mApa2YuUCDQBWZuYhrpe
X6ZdW4ymPuZkDtkyk8qFagZnrIB7VBf2Fq22CRUej4BCbhBXztDR05wK0PMoNS9h
QLdmGAq/3bSdduXQRThkhGvFr3fGLztiARJyX0UzdmX3F/TydAwqE6x+xctY20lB
HVOkefw4msFqQNK4wR9xMg7zeCB63rLAsuBfgb3EfuwvQHNEwXvBX6YJxeyNEfs0
FHptbCIdMdMM6Ln84IRaziwDorXp3e8ge9NQTEGNeEQ30BW4wGuwUDnFf9/MwbMP
NrHGhPJhuh23Vshp0Dlru7Q9AubAiRd+cI9KZ+0iBnpReE+6JnFVIo3YGHlAJ9qJ
HuReyQmy6TwIf8BWypvNON5dvCzqkqJIPaE61qLsWK6Mkp1LO4WWabokHaTHbmEr
GNtJoWhluN9e8hcDdVymVJ09s5cgvCskfCnqSse7KP1fRgz2Ves=
=8GCg
-----END PGP SIGNATURE-----

--Sig_/d6bj9c9m3.zFpIHu2m6GhT/--

