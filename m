Received: from eggs.gnu.org ([2001:4830:134:3::10]:49779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cp09w-0007pJ-M0
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 18:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cp09r-00070l-NE
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 18:15:44 -0400
Message-ID: <1489788924.2504.15.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 18 Mar 2017 09:15:24 +1100
In-Reply-To: <22f93cf3-faa4-f912-2d98-41d7f149029b@kaod.org>
References: <1447201710-10229-1-git-send-email-benh@kernel.crashing.org>
	<1447201710-10229-49-git-send-email-benh@kernel.crashing.org>
	<22f93cf3-faa4-f912-2d98-41d7f149029b@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 48/77] ppc/pnv: Add model for
 Power8 PHB3 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

On Fri, 2017-03-17 at 09:24 +0100, C=C3=A9dric Le Goater wrote:
> I changed that to :
>=20
> =C2=A0=C2=A0=C2=A0 pnv_phb3_msi_update_config(phb->msis, comp, count - =
PHB_NUM_LSI);
>=20
> else the IRQ numbers overlap with the LSI and I think this why we
> were=C2=A0
> uselessly looping on the EOI.
>=20
> Correct ?=C2=A0

Quite possibly though to be honest, I have swapped out a lot of that
out of my brain :-)

Cheers,
Ben.
