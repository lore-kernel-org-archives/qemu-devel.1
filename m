Received: from eggs.gnu.org ([209.51.188.92]:53060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gokyD-0003zW-G2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gokyC-0005Mw-RC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:11:41 -0500
Date: Wed, 30 Jan 2019 09:11:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190130091121.2a05e7f5@Igors-MacBook-Pro.local>
In-Reply-To: <20190130000653.16267-3-richardw.yang@linux.intel.com>
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190130000653.16267-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] hw/acpi: remove unused function
 acpi_table_add_builtin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com, laurent@vivier.eu, philmd@redhat.com

On Wed, 30 Jan 2019 08:06:52 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> Function acpi_table_add_builtin() is not used anymore.
>=20
> Remove the definition and declaration.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=E8=8C=85 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E8=8C=85 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/core.c         | 6 ------
>  include/hw/acpi/acpi.h | 1 -
>  2 files changed, 7 deletions(-)
>=20
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index d6f0709691..e9b1a85e54 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -305,12 +305,6 @@ out:
> =20
>  static bool acpi_table_builtin =3D false;
> =20
> -void acpi_table_add_builtin(const QemuOpts *opts, Error **errp)
> -{
> -    acpi_table_builtin =3D true;
> -    acpi_table_add(opts, errp);
> -}
> -
>  unsigned acpi_table_len(void *current)
>  {
>      struct acpi_table_header *hdr =3D current - sizeof(hdr->_length);
> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> index c20ace0d0b..4a8bbaf1b5 100644
> --- a/include/hw/acpi/acpi.h
> +++ b/include/hw/acpi/acpi.h
> @@ -190,7 +190,6 @@ uint8_t *acpi_table_first(void);
>  uint8_t *acpi_table_next(uint8_t *current);
>  unsigned acpi_table_len(void *current);
>  void acpi_table_add(const QemuOpts *opts, Error **errp);
> -void acpi_table_add_builtin(const QemuOpts *opts, Error **errp);
> =20
>  typedef struct AcpiSlicOem AcpiSlicOem;
>  struct AcpiSlicOem {
