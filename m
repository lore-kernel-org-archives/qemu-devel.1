Received: from eggs.gnu.org ([2001:4830:134:3::10]:48359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gNb9W-00012F-Kz
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gNb9S-00069n-Nw
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:15:06 -0500
Date: Fri, 16 Nov 2018 11:14:38 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181116101438.GY7447@toto>
References: <20181115094207.22846-1-luc.michel@greensocs.com>
	<20181115094207.22846-16-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181115094207.22846-16-luc.michel@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH v6 15/16] gdbstub: add multiprocess
 extension support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>

On Thu, Nov 15, 2018 at 10:42:06AM +0100, Luc Michel wrote:
> Add multiprocess extension support by enabling multiprocess mode when
> the peer requests it, and by replying that we actually support it in the
> qSupported reply packet.
>=20
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> ---
>  gdbstub.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 89819a6a72..e0b844c040 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1721,10 +1721,16 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>              snprintf(buf, sizeof(buf), "PacketSize=3D%x", MAX_PACKET_LEN=
GTH);
>              cc =3D CPU_GET_CLASS(first_cpu);
>              if (cc->gdb_core_xml_file !=3D NULL) {
>                  pstrcat(buf, sizeof(buf), ";qXfer:features:read+");
>              }
> +
> +            if (strstr(p, "multiprocess+")) {
> +                s->multiprocess =3D true;
> +            }
> +            pstrcat(buf, sizeof(buf), ";multiprocess+");
> +
>              put_packet(s, buf);
>              break;
>          }
>          if (strncmp(p, "Xfer:features:read:", 19) =3D=3D 0) {
>              const char *xml;
> --=20
> 2.19.1
>=20
