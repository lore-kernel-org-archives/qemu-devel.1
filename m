Received: from eggs.gnu.org ([2001:4830:134:3::10]:43147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKQ6S-000664-6n
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKQ6L-0005b4-S6
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:50:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKQ6H-0004n4-Uw
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:50:39 -0500
Received: by mail-ed1-f67.google.com with SMTP id d15-v6so10764802edr.0
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 07:50:20 -0800 (PST)
References: <20181107152434.22219-1-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <79f59688-7d44-4392-9343-d19d5f1daa0b@redhat.com>
Date: Wed, 7 Nov 2018 16:50:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181107152434.22219-1-minyard@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] i386: Rename bools in PCMachineState to
 end in _enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 7/11/18 16:24, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> This makes their function more clear and prevents conflicts when adding
> the actual devices to the machine state, if necessary.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/i386/pc.c         | 18 +++++++++---------
>   hw/i386/pc_piix.c    |  3 ++-
>   hw/i386/pc_q35.c     |  6 +++---
>   include/hw/i386/pc.h |  6 +++---
>   4 files changed, 17 insertions(+), 16 deletions(-)
> 
> I have this change in my tree because I have SMBus ACPI support
> for an SMBus IPMI device.  Thus I need to add the smbus to the
> PC machine state and it seems better to have the device named
> "smbus" and the enable named "smbus_enabled".
> 
> However, I think this change makes the code more consistent and
> clear.  Thus I am sending it separately.
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f095725dba..4cd2fbca4d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2222,42 +2222,42 @@ static bool pc_machine_get_smbus(Object *obj, Error **errp)
>   {
>       PCMachineState *pcms = PC_MACHINE(obj);
>   
> -    return pcms->smbus;
> +    return pcms->smbus_enabled;
>   }
>   
>   static void pc_machine_set_smbus(Object *obj, bool value, Error **errp)
>   {
>       PCMachineState *pcms = PC_MACHINE(obj);
>   
> -    pcms->smbus = value;
> +    pcms->smbus_enabled = value;
>   }
>   
>   static bool pc_machine_get_sata(Object *obj, Error **errp)
>   {
>       PCMachineState *pcms = PC_MACHINE(obj);
>   
> -    return pcms->sata;
> +    return pcms->sata_enabled;
>   }
>   
>   static void pc_machine_set_sata(Object *obj, bool value, Error **errp)
>   {
>       PCMachineState *pcms = PC_MACHINE(obj);
>   
> -    pcms->sata = value;
> +    pcms->sata_enabled = value;
>   }
>   
>   static bool pc_machine_get_pit(Object *obj, Error **errp)
>   {
>       PCMachineState *pcms = PC_MACHINE(obj);
>   
> -    return pcms->pit;
> +    return pcms->pit_enabled;
>   }
>   
>   static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
>   {
>       PCMachineState *pcms = PC_MACHINE(obj);
>   
> -    pcms->pit = value;
> +    pcms->pit_enabled = value;
>   }
>   
>   static void pc_machine_initfn(Object *obj)
> @@ -2271,9 +2271,9 @@ static void pc_machine_initfn(Object *obj)
>       pcms->acpi_nvdimm_state.is_enabled = false;
>       /* acpi build is enabled by default if machine supports it */
>       pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
> -    pcms->smbus = true;
> -    pcms->sata = true;
> -    pcms->pit = true;
> +    pcms->smbus_enabled = true;
> +    pcms->sata_enabled = true;
> +    pcms->pit_enabled = true;
>   }
>   
>   static void pc_machine_reset(void)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index dc09466b3e..dc7a0d3fa1 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -239,7 +239,8 @@ static void pc_init1(MachineState *machine,
>   
>       /* init basic PC hardware */
>       pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
> -                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit, 0x4);
> +                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit_enabled,
> +                         0x4);
>   
>       pc_nic_init(pcmc, isa_bus, pci_bus);
>   
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 532241e3f8..0b65887bbf 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -236,13 +236,13 @@ static void pc_q35_init(MachineState *machine)
>   
>       /* init basic PC hardware */
>       pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, !mc->no_floppy,
> -                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit,
> +                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit_enabled,
>                            0xff0104);
>   
>       /* connect pm stuff to lpc */
>       ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms));
>   
> -    if (pcms->sata) {
> +    if (pcms->sata_enabled) {
>           /* ahci and SATA device, for q35 1 ahci controller is built-in */
>           ahci = pci_create_simple_multifunction(host_bus,
>                                                  PCI_DEVFN(ICH9_SATA1_DEV,
> @@ -262,7 +262,7 @@ static void pc_q35_init(MachineState *machine)
>           ehci_create_ich9_with_companions(host_bus, 0x1d);
>       }
>   
> -    if (pcms->smbus) {
> +    if (pcms->smbus_enabled) {
>           /* TODO: Populate SPD eeprom data.  */
>           smbus_eeprom_init(ich9_smb_init(host_bus,
>                                           PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 136fe497b6..7bb52b4762 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -49,9 +49,9 @@ struct PCMachineState {
>       AcpiNVDIMMState acpi_nvdimm_state;
>   
>       bool acpi_build_enabled;
> -    bool smbus;
> -    bool sata;
> -    bool pit;
> +    bool smbus_enabled;
> +    bool sata_enabled;
> +    bool pit_enabled;
>   
>       /* RAM information (sizes, addresses, configuration): */
>       ram_addr_t below_4g_mem_size, above_4g_mem_size;
> 
