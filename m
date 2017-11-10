Received: from eggs.gnu.org ([2001:4830:134:3::10]:58134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eDISQ-00061m-1I
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 18:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eDISP-0004tJ-2a
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 18:11:30 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1510343626-25861-5-git-send-email-cota@braap.org>
References: <1510343626-25861-1-git-send-email-cota@braap.org>
	<1510343626-25861-5-git-send-email-cota@braap.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 10 Nov 2017 15:10:56 -0800
Message-ID: <CAKmqyKPGafyXee3t+TX+vWkDvnwDJF661V82dx9yj_9DWRpV0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.11 4/5] xlnx-zcu102: Specify the max
 number of CPUs for the EP108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

On Fri, Nov 10, 2017 at 11:53 AM, Emilio G. Cota <cota@braap.org> wrote:
> Just like the zcu102, the ep108 can instantiate several CPUs.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

I completely missed this, thanks for the patch.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/arm/xlnx-zcu102.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index adddd23..190eb69 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -188,6 +188,7 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_IDE;
>      mc->units_per_default_bus = 1;
>      mc->ignore_memory_transaction_failures = true;
> +    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
>  }
>
>  static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
> --
> 2.7.4
>
>
