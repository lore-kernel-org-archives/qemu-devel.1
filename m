Received: from eggs.gnu.org ([2001:4830:134:3::10]:55597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eJ4rH-0005KI-Bv
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eJ4rC-0008Pz-IG
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:53:03 -0500
Message-ID: <1511733153.2466.62.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 27 Nov 2017 08:52:33 +1100
In-Reply-To: <33a8ec4c-c47f-e5d4-6562-0e72b2eecdbd@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-14-clg@kaod.org>
	<1511469108.2466.43.camel@kernel.crashing.org>
	<33a8ec4c-c47f-e5d4-6562-0e72b2eecdbd@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/25] spapr: introduce the XIVE Event
 Queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Fri, 2017-11-24 at 09:15 +0100, C=C3=A9dric Le Goater wrote:
> So The Linux driver is expected to choose priority 6. The priority
> validity is then checked in each hcall returning H_P4/H_P3 in case of=20
> failure. =20
>=20
> But it is true that we scale the arrays with :
> =20
>     #define XIVE_PRIORITY_MAX  7
>=20
> Do you want QEMU to completely remove prio 7 ?=20

I'd like qemu to be consistent, at least make sure it errors out if the
OS tries to configue prio 7 or route an irq to it.

Cheers,
Ben.
