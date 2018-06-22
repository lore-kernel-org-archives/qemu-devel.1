Received: from eggs.gnu.org ([2001:4830:134:3::10]:56689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWFSt-00080j-H9
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 02:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWFSo-0007bL-JM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 02:22:35 -0400
Date: Fri, 22 Jun 2018 08:22:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180622062225.ay4bubgshxjj3uey@sirius.home.kraxel.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
	<20180621171257.14897-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180621171257.14897-6-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] hw/display/cirrus: Convert printf()
 calls to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Thu, Jun 21, 2018 at 02:12:51PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/display/cirrus_vga.c | 25 ++++++-------------------
>  hw/display/trace-events |  2 ++
>  2 files changed, 8 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 138ae961b9..a826bef6ec 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -2608,11 +2608,8 @@ static uint64_t cirrus_vga_ioport_read(void *opa=
que, hwaddr addr,
>  	    break;
>  	case 0x3c5:
>  	    val =3D cirrus_vga_read_sr(c);
> +        trace_vga_cirrus_read_reg("SR", s->sr_index, val);
>              break;
> -#ifdef DEBUG_VGA_REG
> -	    printf("vga: read SR%x =3D 0x%02x\n", s->sr_index, val);
> -#endif

Indention looks weird.

otherwise the patch looks fine.

cheers,
  Gerd
