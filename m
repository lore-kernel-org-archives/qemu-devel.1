Received: from eggs.gnu.org ([2001:4830:134:3::10]:50466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwP1x-0001xt-Fp
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwP1u-0005ky-6R
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:46:21 -0400
References: <20170925083348.17126-1-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <30287e8a-e697-b33e-bcf0-94bf7fe291de@redhat.com>
Date: Mon, 25 Sep 2017 10:46:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170925083348.17126-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/pnv: check for firmware
 file presence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

On 25.09.2017 10:33, C=C3=A9dric Le Goater wrote:
> and exit before uslessly trying to load it if the file does

s/uslessly/uselessly/

> not exists.
>=20
> Issue dicovered by Coverity Scan.

/dicovered/discovered/

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 47221158d415..7728eece2eec 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -570,6 +570,10 @@ static void ppc_powernv_init(MachineState *machine=
)
>      }
> =20
>      fw_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +    if (!fw_filename) {
> +        error_report("Could not find OPAL '%s'", bios_name);

I'd suggest to say "OPAL firmware" instead of just "OPAL". Not every
user knows what OPAL is.

> +        exit(1);
> +    }
> =20
>      fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_=
SIZE);
>      if (fw_size < 0) {
>=20

 Thomas
