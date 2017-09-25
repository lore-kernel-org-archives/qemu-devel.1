Received: from eggs.gnu.org ([2001:4830:134:3::10]:55583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwPGn-0002To-Sl
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwPGl-0004Y2-AW
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:01:41 -0400
References: <20170925085825.20549-1-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <362d1a83-4838-f5ae-a45d-2d9e646fb1df@redhat.com>
Date: Mon, 25 Sep 2017 11:01:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170925085825.20549-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ppc/pnv: check for OPAL firmware file
 presence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

On 25.09.2017 10:58, C=C3=A9dric Le Goater wrote:
> and exit before uselessly trying to load it if the file does not
> exists.
>=20
> Issue discovered by Coverity Scan.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>=20
>  Changes since v1:
>=20
>  - fixed spelling
>  - improved OPAL naming by adding firmware=20
>=20
>  hw/ppc/pnv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 47221158d415..d46d91c76f5c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -570,10 +570,14 @@ static void ppc_powernv_init(MachineState *machin=
e)
>      }
> =20
>      fw_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +    if (!fw_filename) {
> +        error_report("Could not find OPAL firmware '%s'", bios_name);
> +        exit(1);
> +    }
> =20
>      fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_=
SIZE);
>      if (fw_size < 0) {
> -        error_report("Could not load OPAL '%s'", fw_filename);
> +        error_report("Could not load OPAL firmware '%s'", fw_filename)=
;
>          exit(1);
>      }
>      g_free(fw_filename);
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
