Received: from eggs.gnu.org ([2001:4830:134:3::10]:50123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ff6Yl-0007b3-3f
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ff6Yi-0004xI-1O
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:41:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ff6Yh-0004x3-RZ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:41:11 -0400
Date: Mon, 16 Jul 2018 19:41:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180716194039-mutt-send-email-mst@kernel.org>
References: <20180716125948.11666-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180716125948.11666-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 0/5] Add support for TPM Physical
 Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jul 16, 2018 at 02:59:43PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> The following patches implement the TPM Physical Presence Interface
> that allows a user to set a command via ACPI (sysfs entry in Linux)
> that, upon the next reboot, the firmware looks for and acts upon by
> sending sequences of commands to the TPM.
>=20
> A dedicated memory region is added to the TPM CRB & TIS devices, at
> address/size 0xFED45000/0x400. A new "etc/tpm/config" fw_cfg entry
> holds the location for that PPI region and some version details, to
> allow for future flexibility.
>=20
> With the associated edk2/ovmf firmware, the Windows HLK "PPI 1.3" test
> now runs successfully.
>=20
> It is based on previous work from Stefan Berger ("[PATCH v2 0/4]
> Implement Physical Presence interface for TPM 1.2 and 2")
>=20
> The edk2 support is merged upstream.

ACPI bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v8: ACPI code improvements
> - replace various aml_int() with variables
> - make op/op_flags common variables
> - replace the switch field indexing hack by a dynamic operation region
>=20
> v7:
> - relace RAM with RAM device ptr
> - a few ACPI code & comments improvements
> - add back proof-of-concept ACPI memory clear interface, handled in
>   qemu (pass again WHLK TCG tests)
>=20
> Marc-Andr=E9 Lureau (2):
>   tpm: add a "ppi" boolean property
>   PoC: tpm: add ACPI memory clear interface
>=20
> Stefan Berger (3):
>   tpm: implement virtual memory device for TPM PPI
>   acpi: add fw_cfg file for TPM and PPI virtual memory device
>   acpi: build TPM Physical Presence interface
>=20
>  hw/tpm/tpm_ppi.h      |  26 +++
>  include/hw/acpi/tpm.h |  17 ++
>  include/hw/compat.h   |  10 +
>  hw/i386/acpi-build.c  | 456 +++++++++++++++++++++++++++++++++++++++++-
>  hw/tpm/tpm_crb.c      |  11 +
>  hw/tpm/tpm_ppi.c      |  56 ++++++
>  hw/tpm/tpm_tis.c      |  11 +
>  docs/specs/tpm.txt    | 101 ++++++++++
>  hw/tpm/Makefile.objs  |   1 +
>  hw/tpm/trace-events   |   3 +
>  10 files changed, 690 insertions(+), 2 deletions(-)
>  create mode 100644 hw/tpm/tpm_ppi.h
>  create mode 100644 hw/tpm/tpm_ppi.c
>=20
> --=20
> 2.18.0.129.ge3331758f1
