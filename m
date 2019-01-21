Received: from eggs.gnu.org ([209.51.188.92]:46531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1glfKb-0003wK-R6
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1glfKb-0001g5-22
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:34:01 -0500
Date: Mon, 21 Jan 2019 11:33:20 -0800
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20190121193320.GC19750@toto>
References: <20190121152218.9592-1-peter.maydell@linaro.org>
	<20190121152218.9592-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121152218.9592-2-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] hw/arm/xlx-zynqmp: Realize cluster
 after putting RPUs in it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Emilio G . Cota" <cota@braap.org>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>

On Mon, Jan 21, 2019 at 03:22:15PM +0000, Peter Maydell wrote:
> Currently the cluster implementation doesn't have any constraints
> on the ordering of realizing the TYPE_CPU_CLUSTER and populating it
> with child objects. We want to impose a constraint that realize
> must happen only after all the child objects are added, so move
> the realize of rpu_cluster. (The apu_cluster is already
> realized after child population.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  hw/arm/xlnx-zynqmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index c67ac2e64ac..370b0e44a38 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -183,8 +183,6 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>                              &error_abort, NULL);
>      qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
>  
> -    qdev_init_nofail(DEVICE(&s->rpu_cluster));
> -
>      for (i = 0; i < num_rpus; i++) {
>          char *name;
>  
> @@ -212,6 +210,8 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>              return;
>          }
>      }
> +
> +    qdev_init_nofail(DEVICE(&s->rpu_cluster));
>  }
>  
>  static void xlnx_zynqmp_init(Object *obj)
> -- 
> 2.20.1
> 
