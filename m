Received: from eggs.gnu.org ([209.51.188.92]:37162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ghgTI-0006Rh-Kt
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ghgTH-0006OU-JS
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:58:32 -0500
MIME-Version: 1.0
References: <20190108163008.7006-1-peter.maydell@linaro.org>
	<20190108163008.7006-2-peter.maydell@linaro.org>
In-Reply-To: <20190108163008.7006-2-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 Jan 2019 11:52:56 -0800
Message-ID: <CAKmqyKNDXzs7qG2QvDH2+wwswn7m=SnxdzybHGM5TGO9hUzThg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/arm/xlx-zynqmp: Realize cluster
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
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Patch Tracking <patches@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 8, 2019 at 8:30 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Currently the cluster implementation doesn't have any constraints
> on the ordering of realizing the TYPE_CPU_CLUSTER and populating it
> with child objects. We want to impose a constraint that realize
> must happen only after all the child objects are added, so move
> the realize of rpu_cluster. (The apu_cluster is already
> realized after child population.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> 2.19.2
>
>
