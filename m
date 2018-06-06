Received: from eggs.gnu.org ([2001:4830:134:3::10]:48011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fQajU-0002rx-R0
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fQajU-0005c9-2d
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:52:20 -0400
MIME-Version: 1.0
In-Reply-To: <20180606152128.449-4-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
	<20180606152128.449-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Jun 2018 08:51:32 -0700
Message-ID: <CAKmqyKNXV3bTx3nJq5=7daUZP5_eF5ePDazv=-B5poN5JnX0iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/11] xilinx-dp: Add trailing '\n' to
 qemu_log() call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jun 6, 2018 at 8:21 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/xlnx_dp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 6715b9cc2b..c32ab083f8 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1074,7 +1074,9 @@ static void xlnx_dp_avbufm_write(void *opaque, hwad=
dr offset, uint64_t value,
>      case AV_BUF_STC_SNAPSHOT1:
>      case AV_BUF_HCOUNT_VCOUNT_INT0:
>      case AV_BUF_HCOUNT_VCOUNT_INT1:
> -        qemu_log_mask(LOG_UNIMP, "avbufm: unimplmented");
> +        qemu_log_mask(LOG_UNIMP, "avbufm: unimplemented register 0x%04"
> +                                 PRIx64 "\n",
> +                      offset << 2);
>          break;
>      default:
>          s->avbufm_registers[offset] =3D value;
> --
> 2.17.1
>
>
