Received: from eggs.gnu.org ([2001:4830:134:3::10]:48703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cxtgp-0001wr-Gd
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cxtgk-0004cO-Uj
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:10:27 -0400
Message-ID: <1491909013.4099.4.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 11 Apr 2017 13:10:13 +0200
In-Reply-To: <1491396106-26376-22-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-22-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 21/21] ppc/pnv: Create a default
 PCI layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

On Wed, 2017-04-05 at 14:41 +0200, C=C3=A9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=C2=A0
> This creates a legacy PCIe->PCI bridge under the PHB by default to whic=
h
> a bunch of standard devices are attached. Currently:
>=C2=A0
>=C2=A0=C2=A0=C2=A0- VGA (as specified by -vga)
>=C2=A0=C2=A0=C2=A0- USB (with keyboard and mouse if graphcis is enabled)
>=C2=A0=C2=A0=C2=A0- AHCI
>=C2=A0=C2=A0=C2=A0- e1000
>=C2=A0
> This gives us something close to a standard OpenPower platform.

These bridges and devices are not added when -nodefaults
is in use, right?

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
