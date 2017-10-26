Received: from eggs.gnu.org ([2001:4830:134:3::10]:50279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7X85-0005a8-Uy
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7X82-0000jV-S9
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:38:41 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:55410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e7X82-0000im-I0
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:38:38 -0400
Received: by mail-pg0-x244.google.com with SMTP id 15so1402925pgc.12
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 18:38:38 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
	by smtp.googlemail.com with ESMTPSA id
	s4sm6185223pgr.32.2017.10.25.18.38.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 25 Oct 2017 18:38:36 -0700 (PDT)
References: <20171026012910.45515-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f5bc7159-8f97-4acd-b21d-2de419af322c@ozlabs.ru>
Date: Thu, 26 Oct 2017 12:38:33 +1100
MIME-Version: 1.0
In-Reply-To: <20171026012910.45515-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] machine: Polish -machine xxx,help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 26/10/17 12:29, Alexey Kardashevskiy wrote:
> The "-machine xxx,help" prints kernel-irqchip possible values as
> "OnOffSplit", this adds separators to the printed line.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> aik@fstn1-p1:~$ ./qemu-system-ppc64 -machine pseries,help 2>&1 | grep kernel-irqchip
> 
> Was:
> pseries-2.11.kernel-irqchip=OnOffSplit (Configure KVM in-kernel irqchip)
> 
> Now:
> pseries-2.11.kernel-irqchip=On|Off|Split (Configure KVM in-kernel irqchip)
> ---
>  hw/core/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 36c2fb069c..ea89cf706e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -506,7 +506,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      object_class_property_set_description(oc, "accel",
>          "Accelerator list", &error_abort);
>  
> -    object_class_property_add(oc, "kernel-irqchip", "OnOffSplit",
> +    object_class_property_add(oc, "kernel-irqchip", "On|Off|Split",


ah, only small case letters are allowed actually, v2 with "on|off|split" is
coming.


>          NULL, machine_set_kernel_irqchip,
>          NULL, NULL, &error_abort);
>      object_class_property_set_description(oc, "kernel-irqchip",
> 


-- 
Alexey
