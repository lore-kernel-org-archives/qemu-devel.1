Received: from eggs.gnu.org ([2001:4830:134:3::10]:37119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8kL-0002CY-VJ
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8kH-0003Yz-35
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:26:25 -0500
Message-ID: <1512224762.2224.53.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 02 Dec 2017 08:26:02 -0600
In-Reply-To: <b921075a-8c4a-c806-e169-5d17c4b233f5@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-10-clg@kaod.org>
	<20171128054553.GO11775@umbus.fritz.box>
	<b921075a-8c4a-c806-e169-5d17c4b233f5@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/25] spapr: introduce handlers for XIVE
 interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 2017-11-28 at 18:18 +0000, C=C3=A9dric Le Goater wrote:
> AFAICT, it doesn't. LSI events are configured as the other XIVE interru=
pts.=20
> The level is converted in the P bit and the Q bit should always be zero.
> So I should be able to simplify the proposed model which still is mimic=
king=20
> XICS  ... I will take a look at it.=20
>=20
> There are a sort of special degenerated LSIs but these are for bringup.

Not really. So for MSIs you don't need your state flags.

For LSIs, you do need the "asserted" one that keeps track of the LSI
input state. See my other note with the actual states.

Cheers,
Ben.
