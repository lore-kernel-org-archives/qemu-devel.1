Received: from eggs.gnu.org ([2001:4830:134:3::10]:40980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emSQb-0005i3-Jn
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1emSQa-0005O1-Ni
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:54:57 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:39781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1emSQa-0005LF-GL
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:54:56 -0500
Received: by mail-lf0-x243.google.com with SMTP id h78so1743215lfg.6
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:54:56 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180215221325.7611-11-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
	<20180215221325.7611-11-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 15 Feb 2018 14:54:24 -0800
Message-ID: <CAKmqyKMPvYDu_m8O3LuAzMBm4y3YdXCTGHTUipo1KrLi8qt_ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/20] sdcard: handle the Security
 Specification commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Feb 15, 2018 at 2:13 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> returning sd_illegal, since they are not implemented.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 30acd04ad7..0457f5214b 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1551,6 +1551,17 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>          }
>          break;
>
> +    case 18:    /* Reserved for SD security applications */
> +    case 25:
> +    case 26:
> +    case 38:
> +    case 43 ... 49:
> +        /* Refer to the "SD Specifications Part3 Security Specification"=
 for
> +         * information about the SD Security Features */

The */ should be on a new line.

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> +        qemu_log_mask(LOG_UNIMP, "SD: CMD%i Security not implemented\n",
> +                      req.cmd);
> +        return sd_illegal;
> +
>      default:
>          /* Fall back to standard commands.  */
>          return sd_normal_command(sd, req);
> --
> 2.16.1
>
>
