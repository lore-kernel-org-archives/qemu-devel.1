Received: from eggs.gnu.org ([2001:4830:134:3::10]:59997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cz8Fp-0005RO-U7
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 16:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cz8Fo-0005pi-HR
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 16:55:41 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170414083717.13641-2-lvivier@redhat.com>
References: <20170414083717.13641-1-lvivier@redhat.com>
	<20170414083717.13641-2-lvivier@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 14 Apr 2017 13:55:08 -0700
Message-ID: <CAKmqyKN6Wuf1H0E=T4RrpKZQnsgExJwShW42WNMr7b8ZQjv=RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/4] arm: remove remaining
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc@nongnu.org, Antony Pavlov <antonynpavlov@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Apr 14, 2017 at 1:37 AM, Laurent Vivier <lvivier@redhat.com> wrote:
> With commit ce5b1bbf624b ("exec: move cpu_exec_init() calls to
> realize functions"), we can now remove all the
> remaining cannot_destroy_with_object_finalize_yet as
> unsafe references have been moved to cpu_exec_realizefn().
> (tested with QOM command provided by commit 4c315c27).
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/arm/allwinner-a10.c | 6 ------
>  hw/arm/bcm2836.c       | 6 ------
>  hw/arm/digic.c         | 6 ------
>  hw/arm/fsl-imx25.c     | 5 -----
>  hw/arm/fsl-imx31.c     | 5 -----
>  hw/arm/fsl-imx6.c      | 5 -----
>  hw/arm/xlnx-zynqmp.c   | 6 ------
>  7 files changed, 39 deletions(-)
>
> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
> index ca15d1c..f62a9a3 100644
> --- a/hw/arm/allwinner-a10.c
> +++ b/hw/arm/allwinner-a10.c
> @@ -118,12 +118,6 @@ static void aw_a10_class_init(ObjectClass *oc, void *data)
>      DeviceClass *dc = DEVICE_CLASS(oc);
>
>      dc->realize = aw_a10_realize;
> -
> -    /*
> -     * Reason: creates an ARM CPU, thus use after free(), see
> -     * arm_cpu_class_init()
> -     */
> -    dc->cannot_destroy_with_object_finalize_yet = true;
>  }
>
>  static const TypeInfo aw_a10_type_info = {
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 8451190..8c43291 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -160,12 +160,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
>
>      dc->props = bcm2836_props;
>      dc->realize = bcm2836_realize;
> -
> -    /*
> -     * Reason: creates an ARM CPU, thus use after free(), see
> -     * arm_cpu_class_init()
> -     */
> -    dc->cannot_destroy_with_object_finalize_yet = true;
>  }
>
>  static const TypeInfo bcm2836_type_info = {
> diff --git a/hw/arm/digic.c b/hw/arm/digic.c
> index d60ea39..94f3263 100644
> --- a/hw/arm/digic.c
> +++ b/hw/arm/digic.c
> @@ -101,12 +101,6 @@ static void digic_class_init(ObjectClass *oc, void *data)
>      DeviceClass *dc = DEVICE_CLASS(oc);
>
>      dc->realize = digic_realize;
> -
> -    /*
> -     * Reason: creates an ARM CPU, thus use after free(), see
> -     * arm_cpu_class_init()
> -     */
> -    dc->cannot_destroy_with_object_finalize_yet = true;
>  }
>
>  static const TypeInfo digic_type_info = {
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 2126f73..9056f27 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -290,11 +290,6 @@ static void fsl_imx25_class_init(ObjectClass *oc, void *data)
>
>      dc->realize = fsl_imx25_realize;
>
> -    /*
> -     * Reason: creates an ARM CPU, thus use after free(), see
> -     * arm_cpu_class_init()
> -     */
> -    dc->cannot_destroy_with_object_finalize_yet = true;
>      dc->desc = "i.MX25 SOC";
>  }
>
> diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
> index dd1c713..d7e2d83 100644
> --- a/hw/arm/fsl-imx31.c
> +++ b/hw/arm/fsl-imx31.c
> @@ -262,11 +262,6 @@ static void fsl_imx31_class_init(ObjectClass *oc, void *data)
>
>      dc->realize = fsl_imx31_realize;
>
> -    /*
> -     * Reason: creates an ARM CPU, thus use after free(), see
> -     * arm_cpu_class_init()
> -     */
> -    dc->cannot_destroy_with_object_finalize_yet = true;
>      dc->desc = "i.MX31 SOC";
>  }
>
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index 76dd8a4..6969e73 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -442,11 +442,6 @@ static void fsl_imx6_class_init(ObjectClass *oc, void *data)
>
>      dc->realize = fsl_imx6_realize;
>
> -    /*
> -     * Reason: creates an ARM CPU, thus use after free(), see
> -     * arm_cpu_class_init()
> -     */
> -    dc->cannot_destroy_with_object_finalize_yet = true;
>      dc->desc = "i.MX6 SOC";
>  }
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index bc4e66b..4f67158 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -439,12 +439,6 @@ static void xlnx_zynqmp_class_init(ObjectClass *oc, void *data)
>
>      dc->props = xlnx_zynqmp_props;
>      dc->realize = xlnx_zynqmp_realize;
> -
> -    /*
> -     * Reason: creates an ARM CPU, thus use after free(), see
> -     * arm_cpu_class_init()
> -     */
> -    dc->cannot_destroy_with_object_finalize_yet = true;
>  }
>
>  static const TypeInfo xlnx_zynqmp_type_info = {
> --
> 2.9.3
>
>
