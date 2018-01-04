Received: from eggs.gnu.org ([2001:4830:134:3::10]:39903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eXB5q-000058-Mf
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eXB5p-0002BD-Kj
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:22:22 -0500
Date: Thu, 4 Jan 2018 17:22:03 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180104192203.GD3407@localhost.localdomain>
References: <20180104144046.30793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180104144046.30793-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] qom: introduce TypeInfo name
 aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jan 04, 2018 at 11:40:40AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> This RFC series is intended to simplify Flattened Device Tree support,
> in particular the 'compatible' FDT entry, when Linux names mismatches
> QEMU ones, but this is the same device modelled.
>=20
> Eventually this might help to remove the QDevAlias qdev_alias_table[]
> in qdev-monitor.c.
>=20

Didn't look closely at the patches yet, but this sounds like a
nice generic way to replace other alias systems.  We have at
least:

* qdev-monitor.c: qdev_alias_table[] (as mentioned above)
* chardev/char.c: chardev_alias_table[]
* target/alpha/cpu.c: alpha_cpu_aliases[]
* target/ppc/cpu-models.c: ppc_cpu_aliases[]
* include/hw/boards.h: MachineClass::alias

Probably there are others I couldn't find.


> So far this is only a 'proof of concept'.
> To see how the qtests perform, I only modified 3 devices, 2 used by the
> Xilinx Zynq machines (Cadence), and the e1000 (used by the PXE test).
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (6):
>   qom: introduce TypeInfo name aliases
>   hw/net/e1000: real device name is 'e1000-82540em', 'e1000' is an alia=
s
>   hw/char/cadence_uart: add FDT aliases
>   arm/xlnx-zynq: use FDT names for the Cadence UART
>   hw/net/cadence_gem: add FDT names as alias
>   hw/arm/xlnx-zynq: use FDT names for the Cadence GEM
>=20
>  include/qom/object.h   |  3 +++
>  hw/arm/xilinx_zynq.c   |  2 ++
>  hw/arm/xlnx-zynqmp.c   |  4 ++--
>  hw/char/cadence_uart.c |  7 +++++++
>  hw/net/cadence_gem.c   |  6 ++++++
>  hw/net/e1000.c         |  5 ++++-
>  qom/object.c           | 18 ++++++++++++++++--
>  7 files changed, 40 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.15.1
>=20

--=20
Eduardo
