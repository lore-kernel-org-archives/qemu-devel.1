Received: from eggs.gnu.org ([209.51.188.92]:53148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gokyP-00049n-LL
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gokyP-0005QF-3S
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:11:53 -0500
Date: Wed, 30 Jan 2019 09:11:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190130091147.4fb3ebc7@Igors-MacBook-Pro.local>
In-Reply-To: <20190130000653.16267-4-richardw.yang@linux.intel.com>
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190130000653.16267-4-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] hw/acpi: remove unnecessary
 variable acpi_table_builtin
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

On Wed, 30 Jan 2019 08:06:53 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> acpi_table_builtin is now always false, it is not necessary to check it
> again.
>=20
> This patch just removes it.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=E8=8C=85 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E8=8C=85 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index e9b1a85e54..f9c96535d1 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -303,8 +303,6 @@ out:
>      error_propagate(errp, err);
>  }
> =20
> -static bool acpi_table_builtin =3D false;
> -
>  unsigned acpi_table_len(void *current)
>  {
>      struct acpi_table_header *hdr =3D current - sizeof(hdr->_length);
> @@ -320,7 +318,7 @@ void *acpi_table_hdr(void *h)
> =20
>  uint8_t *acpi_table_first(void)
>  {
> -    if (acpi_table_builtin || !acpi_tables) {
> +    if (!acpi_tables) {
>          return NULL;
>      }
>      return acpi_table_hdr(acpi_tables + ACPI_TABLE_PFX_SIZE);
