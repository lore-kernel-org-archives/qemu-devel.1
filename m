Received: from eggs.gnu.org ([2001:4830:134:3::10]:37828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fXqLm-0006of-HE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fXqLj-0004VL-CZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:57:50 -0400
Message-ID: <7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 26 Jun 2018 17:57:41 +0200
In-Reply-To: <20180626135928.23950-1-clg@kaod.org>
References: <20180626135928.23950-1-clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 2018-06-26 at 15:59 +0200, C=C3=A9dric Le Goater wrote:
> This is a model of the PCIe host bridge found on Power8 chips,
> including PowerBus logic interface, IOMMU support, PCIe root complex,
> XICS MSI and LSI interrupt sources.
>=20
> 4 PHBs are provisioned under the Power8 chip model to fit hardware but
> only one is currently initialized.

What's the advantage in creating 4 PHBs instead of a single one,
like we already do for pSeries guests? As it is, this will confuse
the heck out of libvirt's PCI address allocation algorithm :)

--=20
Andrea Bolognani / Red Hat / Virtualization
