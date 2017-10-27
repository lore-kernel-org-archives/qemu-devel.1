Received: from eggs.gnu.org ([2001:4830:134:3::10]:50420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e89Gp-0000KJ-LB
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e89Gk-0007oW-NF
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:22:15 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:54086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e89Gk-0007oO-IJ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:22:10 -0400
Received: by mail-qt0-x243.google.com with SMTP id n61so9503298qte.10
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 11:22:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <382833937419ccd4de5de9b65f74ca561cfa328d.1509114880.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb2390f6-61e7-7f9b-0e94-a0f2abf88af3@amsat.org>
Date: Fri, 27 Oct 2017 15:22:00 -0300
MIME-Version: 1.0
In-Reply-To: <382833937419ccd4de5de9b65f74ca561cfa328d.1509114880.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] xlnx-zcu102: Specify the number of
 max CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: edgar.iglesias@xilinx.com, alistair23@gmail.com, edgar.iglesias@gmail.com

Hi Alistair,

On 10/27/2017 11:35 AM, Alistair Francis wrote:
> Specify the number of CPUs that can run on ZynqMP.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  hw/arm/xlnx-zcu102.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 519a16ed98..b86c048bb3 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -240,6 +240,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
>      mc->block_default_type = IF_IDE;
>      mc->units_per_default_bus = 1;
>      mc->ignore_memory_transaction_failures = true;
> +    mc->max_cpus = 6;

This can be self-explanatory:

    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;

Then:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  }
>  
>  static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
> 
