Received: from eggs.gnu.org ([209.51.188.92]:45156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Jmk-0002ir-4m
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Jmj-0007iT-02
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:59:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2Jmi-0007hZ-Lj
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:59:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id i16so22283965wrs.13
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 09:59:52 -0800 (PST)
References: <20190308152511.10882-1-eric.auger@redhat.com>
	<20190308152511.10882-2-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4dbd1705-af66-6152-d865-5bdfeb290178@redhat.com>
Date: Fri, 8 Mar 2019 18:59:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190308152511.10882-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] nvdimm: Rename AcpiNVDIMMState into
 NVDIMMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, richard.henderson@linaro.org, sbhat@linux.ibm.com

On 3/8/19 4:25 PM, Eric Auger wrote:
> As we intend to migrate the acpi_nvdimm_state into
> the base machine with a new dimms_state name, let's
> also rename the datatype.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/acpi/nvdimm.c        | 18 +++++++++---------
>  hw/i386/pc.c            |  2 +-
>  include/hw/i386/pc.h    |  2 +-
>  include/hw/mem/nvdimm.h | 10 +++++-----
>  4 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index e53b2cb681..f73cfb9d90 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -382,7 +382,7 @@ nvdimm_build_structure_caps(GArray *structures, uint32_t capabilities)
>      nfit_caps->capabilities = cpu_to_le32(capabilities);
>  }
>  
> -static GArray *nvdimm_build_device_structure(AcpiNVDIMMState *state)
> +static GArray *nvdimm_build_device_structure(NVDIMMState *state)
>  {
>      GSList *device_list = nvdimm_get_device_list();
>      GArray *structures = g_array_new(false, true /* clear */, 1);
> @@ -416,7 +416,7 @@ static void nvdimm_init_fit_buffer(NvdimmFitBuffer *fit_buf)
>      fit_buf->fit = g_array_new(false, true /* clear */, 1);
>  }
>  
> -static void nvdimm_build_fit_buffer(AcpiNVDIMMState *state)
> +static void nvdimm_build_fit_buffer(NVDIMMState *state)
>  {
>      NvdimmFitBuffer *fit_buf = &state->fit_buf;
>  
> @@ -425,12 +425,12 @@ static void nvdimm_build_fit_buffer(AcpiNVDIMMState *state)
>      fit_buf->dirty = true;
>  }
>  
> -void nvdimm_plug(AcpiNVDIMMState *state)
> +void nvdimm_plug(NVDIMMState *state)
>  {
>      nvdimm_build_fit_buffer(state);
>  }
>  
> -static void nvdimm_build_nfit(AcpiNVDIMMState *state, GArray *table_offsets,
> +static void nvdimm_build_nfit(NVDIMMState *state, GArray *table_offsets,
>                                GArray *table_data, BIOSLinker *linker)
>  {
>      NvdimmFitBuffer *fit_buf = &state->fit_buf;
> @@ -570,7 +570,7 @@ nvdimm_dsm_no_payload(uint32_t func_ret_status, hwaddr dsm_mem_addr)
>  #define NVDIMM_QEMU_RSVD_HANDLE_ROOT         0x10000
>  
>  /* Read FIT data, defined in docs/specs/acpi_nvdimm.txt. */
> -static void nvdimm_dsm_func_read_fit(AcpiNVDIMMState *state, NvdimmDsmIn *in,
> +static void nvdimm_dsm_func_read_fit(NVDIMMState *state, NvdimmDsmIn *in,
>                                       hwaddr dsm_mem_addr)
>  {
>      NvdimmFitBuffer *fit_buf = &state->fit_buf;
> @@ -619,7 +619,7 @@ exit:
>  }
>  
>  static void
> -nvdimm_dsm_handle_reserved_root_method(AcpiNVDIMMState *state,
> +nvdimm_dsm_handle_reserved_root_method(NVDIMMState *state,
>                                         NvdimmDsmIn *in, hwaddr dsm_mem_addr)
>  {
>      switch (in->function) {
> @@ -863,7 +863,7 @@ nvdimm_dsm_read(void *opaque, hwaddr addr, unsigned size)
>  static void
>  nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>  {
> -    AcpiNVDIMMState *state = opaque;
> +    NVDIMMState *state = opaque;
>      NvdimmDsmIn *in;
>      hwaddr dsm_mem_addr = val;
>  
> @@ -925,7 +925,7 @@ void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
>      }
>  }
>  
> -void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
> +void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
>                              FWCfgState *fw_cfg, Object *owner)
>  {
>      memory_region_init_io(&state->io_mr, owner, &nvdimm_dsm_ops, state,
> @@ -1319,7 +1319,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
>  }
>  
>  void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
> -                       BIOSLinker *linker, AcpiNVDIMMState *state,
> +                       BIOSLinker *linker, NVDIMMState *state,
>                         uint32_t ram_slots)
>  {
>      GSList *device_list;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 42128183e9..0338dbe9da 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2571,7 +2571,7 @@ static void pc_machine_set_nvdimm_persistence(Object *obj, const char *value,
>                                                 Error **errp)
>  {
>      PCMachineState *pcms = PC_MACHINE(obj);
> -    AcpiNVDIMMState *nvdimm_state = &pcms->acpi_nvdimm_state;
> +    NVDIMMState *nvdimm_state = &pcms->acpi_nvdimm_state;
>  
>      if (strcmp(value, "cpu") == 0)
>          nvdimm_state->persistence = 3;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 54222a202d..94fb620d65 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -45,7 +45,7 @@ struct PCMachineState {
>      OnOffAuto vmport;
>      OnOffAuto smm;
>  
> -    AcpiNVDIMMState acpi_nvdimm_state;
> +    NVDIMMState acpi_nvdimm_state;
>  
>      bool acpi_build_enabled;
>      bool smbus_enabled;
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index c5c9b3c7f8..523a9b3d4a 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -123,7 +123,7 @@ struct NvdimmFitBuffer {
>  };
>  typedef struct NvdimmFitBuffer NvdimmFitBuffer;
>  
> -struct AcpiNVDIMMState {
> +struct NVDIMMState {
>      /* detect if NVDIMM support is enabled. */
>      bool is_enabled;
>  
> @@ -141,13 +141,13 @@ struct AcpiNVDIMMState {
>      int32_t persistence;
>      char    *persistence_string;
>  };
> -typedef struct AcpiNVDIMMState AcpiNVDIMMState;
> +typedef struct NVDIMMState NVDIMMState;
>  
> -void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
> +void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
>                              FWCfgState *fw_cfg, Object *owner);
>  void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
> -                       BIOSLinker *linker, AcpiNVDIMMState *state,
> +                       BIOSLinker *linker, NVDIMMState *state,
>                         uint32_t ram_slots);
> -void nvdimm_plug(AcpiNVDIMMState *state);
> +void nvdimm_plug(NVDIMMState *state);
>  void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
>  #endif
> 
