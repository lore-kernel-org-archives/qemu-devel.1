Received: from eggs.gnu.org ([2001:4830:134:3::10]:50437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ePhuY-0007YT-FD
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 23:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ePhuU-0006oW-8E
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 23:47:50 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:37506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ePhuU-0006o1-29
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 23:47:46 -0500
Received: by mail-it0-x241.google.com with SMTP id d137so16164237itc.2
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 20:47:45 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
	by smtp.googlemail.com with ESMTPSA id
	l12sm2953543iog.69.2017.12.14.20.47.43 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Dec 2017 20:47:44 -0800 (PST)
References: <20171026014139.46221-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <82b6cfcf-70ae-2817-8eb8-fe630d3bec95@ozlabs.ru>
Date: Fri, 15 Dec 2017 15:47:40 +1100
MIME-Version: 1.0
In-Reply-To: <20171026014139.46221-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] machine: Polish -machine xxx,help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 26/10/17 12:41, Alexey Kardashevskiy wrote:
> The "-machine xxx,help" prints kernel-irqchip possible values as
> "OnOffSplit", this adds separators to the printed line.
> 
> Also, since only lower case letters are specified in qapi/common.json,
> this changes the letter cases too.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

ping?


> ---
> 
> aik@fstn1-p1:~$ ./qemu-system-ppc64 -machine pseries,help 2>&1 | grep kernel-irqchip
> 
> Was:
> pseries-2.11.kernel-irqchip=OnOffSplit (Configure KVM in-kernel irqchip)
> 
> Now:
> pseries-2.11.kernel-irqchip=on|off|split (Configure KVM in-kernel irqchip)
> ---
>  hw/core/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 36c2fb069c..bd3db14e12 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -506,7 +506,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      object_class_property_set_description(oc, "accel",
>          "Accelerator list", &error_abort);
>  
> -    object_class_property_add(oc, "kernel-irqchip", "OnOffSplit",
> +    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
>          NULL, machine_set_kernel_irqchip,
>          NULL, NULL, &error_abort);
>      object_class_property_set_description(oc, "kernel-irqchip",
> 


-- 
Alexey
