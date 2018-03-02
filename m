Received: from eggs.gnu.org ([2001:4830:134:3::10]:34253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eroZr-0005Ra-QZ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eroZr-0006Mn-2p
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:34:39 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eroZq-0006MW-UU
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:34:39 -0500
Received: by mail-ot0-x242.google.com with SMTP id l5so9382146otf.9
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 09:34:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e63c2c456e5b24f1ab493e4dd8a40091bbad9ca0.1520010339.git.alistair.francis@xilinx.com>
References: <cover.1520010339.git.alistair.francis@xilinx.com>
	<e63c2c456e5b24f1ab493e4dd8a40091bbad9ca0.1520010339.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 17:34:17 +0000
Message-ID: <CAFEAcA_41mZnGOKw0ybo4f=_LWPJCN5=0TjJsCkgKy_KL73Z6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] hw/arm: Set the core count for
 Xilinx's ZynqMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 2 March 2018 at 17:06, Alistair Francis <alistair.francis@xilinx.com> wrote:
> Set the ARM CPU core count property for the A53's attached to the Xilnx
> ZynqMP machine.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>
>  hw/arm/xlnx-zynqmp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 69227fd4c9..465796e97c 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -282,6 +282,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>                                   s->virt, "has_el2", NULL);
>          object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
>                                  "reset-cbar", &error_abort);
> +        object_property_set_int(OBJECT(&s->apu_cpu[i]), num_apus,
> +                                "core-count", &error_abort);
>          object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
>                                   &err);
>          if (err) {

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
