Received: from eggs.gnu.org ([2001:4830:134:3::10]:56945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cw67n-0006YS-Gb
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cw67i-0000lx-0t
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:02:51 -0400
Message-ID: <1491480116.4166.108.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Apr 2017 22:01:56 +1000
In-Reply-To: <9a5826c0-5940-f668-fbef-f90f277408e0@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-5-git-send-email-clg@kaod.org>
	<20170406042318.GA12179@umbus>
	<6e24736f-5a64-ea4a-f9bb-6ebed5acca4a@kaod.org>
	<1491470207.4166.107.camel@kernel.crashing.org>
	<9a5826c0-5940-f668-fbef-f90f277408e0@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/21] ppc/pnv: enable only one LPC bus
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

On Thu, 2017-04-06 at 13:50 +0200, C=C3=A9dric Le Goater wrote:
>=20
> So, looking at hostboot, the lower level firmware, I think the
> initial=C2=A0
> patch is more in sync with it :=C2=A0
>=20
> =C2=A0=C2=A0=C2=A0https://github.com/open-power/hostboot/blob/master-p8=
/src/usr/devt
> ree/bld_devtree.C#L1038
>=20
> David, can we keep it as it is ? I will change the commit log which
> is=C2=A0a bit fuzzy.=C2=A0

Note that OPAL should be happy to have multiple LPCs in the DT as long
as one of them has the "primary" property in the node to tell it that's
where the UART etc... are.

Cheers,
Ben.
