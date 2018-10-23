Received: from eggs.gnu.org ([2001:4830:134:3::10]:36256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF570-0007i4-Np
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF56q-0006LG-1M
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:25:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gF56k-0006DK-3b
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:25:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so3393652wrn.0
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 15:24:59 -0700 (PDT)
References: <20181022183656.4902-1-sameo@linux.intel.com>
	<20181022183656.4902-2-sameo@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d032609f-b20e-9e55-a3b2-18333d801b00@redhat.com>
Date: Wed, 24 Oct 2018 00:24:53 +0200
MIME-Version: 1.0
In-Reply-To: <20181022183656.4902-2-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/26] hw: i386: Decouple the ACPI build
 from the PC machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 22/10/2018 20:36, Samuel Ortiz wrote:
> +static void acpi_conf_pc_init(MachineState *machine)

This should take a PCMachineState*, since you never use "machine" except
for downcasting.

Paolo

> +{
> +    PCMachineState *pcms = PC_MACHINE(machine);
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
> +    AcpiConfiguration *conf = &pcms->acpi_configuration;
> +
> +    /* Machine class settings */
> +    conf->legacy_acpi_table_size = pcmc->legacy_acpi_table_size;
> +    conf->legacy_cpu_hotplug = pcmc->legacy_cpu_hotplug;
> +    conf->rsdp_in_ram = pcmc->rsdp_in_ram;
> +
> +    /* ACPI build state */
> +    conf->build_state = NULL;
> +}
> +
