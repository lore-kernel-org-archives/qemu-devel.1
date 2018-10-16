Received: from eggs.gnu.org ([2001:4830:134:3::10]:33099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCN2y-0004zk-U1
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCN2y-0006zH-1P
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:57:56 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCN2x-0006yJ-QQ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:57:55 -0400
Received: by mail-oi1-x241.google.com with SMTP id 22-v6so17662767oiz.2
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 03:57:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181011035026.23517-1-xypron.glpk@gmx.de>
References: <20181010185445.10290-1-xypron.glpk@gmx.de>
	<20181011035026.23517-1-xypron.glpk@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 11:57:34 +0100
Message-ID: <CAFEAcA-95cCzjw6opxqCPvQjNOdRBh+ive3+G-SE-04c3qKF5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] hw/arm/virt: provide a model
 property in the fdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 11 October 2018 at 04:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> According to the "Devicetree Specification, Release v0.2" 'model' is a
> required property of the root node.
>
> Some software like the Debian flash-kernel package rely on this property
> to identify boards.
>
> The patch sets the model property to 'qemu,virt'.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> v2
>         use the recommended format of the model property
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 281ddcdf6e..abe366895a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -200,6 +200,7 @@ static void create_fdt(VirtMachineState *vms)
>      vms->fdt = fdt;
>
>      /* Header */
> +    qemu_fdt_setprop_string(fdt, "/", "model", "qemu,virt");
>      qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,dummy-virt");
>      qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
>      qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);

The spec says "a string that uniquely identifies the model of the system
board". So should we be using "virt" for everything, or should we use
"virt-2.10", "virt-2.11", "virt-2.12", etc ?

thanks
-- PMM
