Received: from eggs.gnu.org ([2001:4830:134:3::10]:47072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL95r-0005Es-Jt
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:48:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL95n-0000PO-OF
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:48:39 -0500
Message-ID: <1512226099.2224.71.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 02 Dec 2017 08:48:19 -0600
In-Reply-To: <ed946d89-61a0-7ef7-29a1-105a64a8e3f2@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-12-clg@kaod.org>
	<20171128064034.GQ11775@umbus.fritz.box>
	<1512224666.2224.52.camel@kernel.crashing.org>
	<ed946d89-61a0-7ef7-29a1-105a64a8e3f2@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/25] spapr: describe the XIVE interrupt
 source flags
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

On Sat, 2017-12-02 at 15:38 +0100, C=C3=A9dric Le Goater wrote:
> Hmm, yes. So, the current design for sPAPR handles all sources=20
> under the same XIVE object with a global memory region for all=20
> the ESBs.=20
>=20
> The first RFC had a mechanism to register source objects into=20
> the XIVE main one, allocating the IRQs per source and mapping=20
> the ESBs in the overall region. A bit like OPAL does. I then=20
> simplified for the sake of clarity and merged everything under=20
> the same XIVE object.=20
>=20
> Shall I reintroduce multiples sources support ? and provide a=20
> default one for IPIs and virtual devices of the machine.=20

That or you need state bits ;-)

Cheers,
Ben.
