Received: from eggs.gnu.org ([2001:4830:134:3::10]:48686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eil6y-0003xh-T7
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eil6x-0001Th-UE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:03:24 -0500
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:47100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eil6x-0001SN-MU
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:03:23 -0500
Received: by mail-lf0-x235.google.com with SMTP id q194so42988916lfe.13
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 10:03:23 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180205150426.20542-1-peter.maydell@linaro.org>
References: <20180205150426.20542-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 5 Feb 2018 10:02:51 -0800
Message-ID: <CAKmqyKN0UC+J8o8YnPph-jLAhUO0QjUrtHvhRx_e5M_mVKybbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Allow PC to be set
 on command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Patch Tracking <patches@linaro.org>

On Mon, Feb 5, 2018 at 7:04 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> The documentation for the generic loader claims that you can
> set the PC for a CPU with an option of the form
>   -device loader,cpu-num=0,addr=0x10000004
>
> However if you try this QEMU complains:
>   cpu_num must be specified when setting a program counter
>
> This is because we were testing against 0 rather than CPU_NONE.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

> ---
> I've also noticed that you can't use this to specify that
> the starting address should be in Thumb mode for Arm CPUs,
> but I'm not so sure of the right way to fix that...

Should we at least update the documentation to mention this then?

Alistair

>
>  hw/core/generic-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index 46012673c3..cb0e68486d 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -105,7 +105,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>              error_setg(errp, "data can not be specified when setting a "
>                         "program counter");
>              return;
> -        } else if (!s->cpu_num) {
> +        } else if (s->cpu_num == CPU_NONE) {
>              error_setg(errp, "cpu_num must be specified when setting a "
>                         "program counter");
>              return;
> --
> 2.16.1
>
>
