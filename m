Received: from eggs.gnu.org ([2001:4830:134:3::10]:55145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9dyq-0002wV-0j
	for qemu-devel@nongnu.org; Sat, 13 May 2017 16:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9dyp-0006ry-2b
	for qemu-devel@nongnu.org; Sat, 13 May 2017 16:49:36 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9dyo-0006rK-TM
	for qemu-devel@nongnu.org; Sat, 13 May 2017 16:49:34 -0400
Received: by mail-qk0-x244.google.com with SMTP id y128so12244089qka.3
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 13:49:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-15-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2594111b-1488-69a8-4d85-4cdb5f45a796@amsat.org>
Date: Sat, 13 May 2017 17:49:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170509173559.31598-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/17] acpi: fix s3/s4 disabled type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 05/09/2017 02:35 PM, Marc-André Lureau wrote:
> Use a more specific bool type.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/acpi/ich9.c       | 24 ++++++++++++------------
>  hw/acpi/piix4.c      |  8 ++++----
>  hw/i386/acpi-build.c |  5 +++--
>  3 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 5c279bbaca..3bd8c4bcf5 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -359,9 +359,9 @@ static void ich9_pm_get_disable_s3(Object *obj, Visitor *v, const char *name,
>                                     void *opaque, Error **errp)
>  {
>      ICH9LPCPMRegs *pm = opaque;
> -    uint8_t value = pm->disable_s3;
> +    bool value = pm->disable_s3;
>
> -    visit_type_uint8(v, name, &value, errp);
> +    visit_type_bool(v, name, &value, errp);
>  }
>
>  static void ich9_pm_set_disable_s3(Object *obj, Visitor *v, const char *name,
> @@ -369,9 +369,9 @@ static void ich9_pm_set_disable_s3(Object *obj, Visitor *v, const char *name,
>  {
>      ICH9LPCPMRegs *pm = opaque;
>      Error *local_err = NULL;
> -    uint8_t value;
> +    bool value;
>
> -    visit_type_uint8(v, name, &value, &local_err);
> +    visit_type_bool(v, name, &value, &local_err);
>      if (local_err) {
>          goto out;
>      }
> @@ -384,9 +384,9 @@ static void ich9_pm_get_disable_s4(Object *obj, Visitor *v, const char *name,
>                                     void *opaque, Error **errp)
>  {
>      ICH9LPCPMRegs *pm = opaque;
> -    uint8_t value = pm->disable_s4;
> +    bool value = pm->disable_s4;
>
> -    visit_type_uint8(v, name, &value, errp);
> +    visit_type_bool(v, name, &value, errp);
>  }
>
>  static void ich9_pm_set_disable_s4(Object *obj, Visitor *v, const char *name,
> @@ -394,9 +394,9 @@ static void ich9_pm_set_disable_s4(Object *obj, Visitor *v, const char *name,
>  {
>      ICH9LPCPMRegs *pm = opaque;
>      Error *local_err = NULL;
> -    uint8_t value;
> +    bool value;
>
> -    visit_type_uint8(v, name, &value, &local_err);
> +    visit_type_bool(v, name, &value, &local_err);
>      if (local_err) {
>          goto out;
>      }
> @@ -447,8 +447,8 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
>      static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
>      pm->acpi_memory_hotplug.is_enabled = true;
>      pm->cpu_hotplug_legacy = true;
> -    pm->disable_s3 = 0;
> -    pm->disable_s4 = 0;
> +    pm->disable_s3 = false;
> +    pm->disable_s4 = false;
>      pm->s4_val = 2;
>
>      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
> @@ -466,11 +466,11 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
>                               ich9_pm_get_cpu_hotplug_legacy,
>                               ich9_pm_set_cpu_hotplug_legacy,
>                               NULL);
> -    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "uint8",
> +    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "bool",
>                          ich9_pm_get_disable_s3,
>                          ich9_pm_set_disable_s3,
>                          NULL, pm, NULL);
> -    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "uint8",
> +    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "bool",
>                          ich9_pm_get_disable_s4,
>                          ich9_pm_set_disable_s4,
>                          NULL, pm, NULL);
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index a553a7e110..74692336b5 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -83,8 +83,8 @@ typedef struct PIIX4PMState {
>      AcpiPciHpState acpi_pci_hotplug;
>      bool use_acpi_pci_hotplug;
>
> -    uint8_t disable_s3;
> -    uint8_t disable_s4;
> +    bool disable_s3;
> +    bool disable_s4;
>      uint8_t s4_val;
>
>      bool cpu_hotplug_legacy;
> @@ -670,8 +670,8 @@ static void piix4_send_gpe(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>
>  static Property piix4_pm_properties[] = {
>      DEFINE_PROP_UINT32("smb_io_base", PIIX4PMState, smb_io_base, 0),
> -    DEFINE_PROP_UINT8(ACPI_PM_PROP_S3_DISABLED, PIIX4PMState, disable_s3, 0),
> -    DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState, disable_s4, 0),
> +    DEFINE_PROP_BOOL(ACPI_PM_PROP_S3_DISABLED, PIIX4PMState, disable_s3, false),
> +    DEFINE_PROP_BOOL(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState, disable_s4, false),
>      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
>                       use_acpi_pci_hotplug, true),
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1707fae9bf..27ad420914 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -22,6 +22,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/types.h"
>  #include "acpi-build.h"
>  #include "qemu-common.h"
>  #include "qemu/bitmap.h"
> @@ -149,14 +150,14 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>      /* Fill in optional s3/s4 related properties */
>      o = object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NULL);
>      if (o) {
> -        pm->s3_disabled = qnum_get_uint(qobject_to_qnum(o), &error_abort);
> +        pm->s3_disabled = qbool_get_bool(qobject_to_qbool(o));
>      } else {
>          pm->s3_disabled = false;
>      }
>      qobject_decref(o);
>      o = object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NULL);
>      if (o) {
> -        pm->s4_disabled = qnum_get_uint(qobject_to_qnum(o), &error_abort);
> +        pm->s4_disabled = qbool_get_bool(qobject_to_qbool(o));
>      } else {
>          pm->s4_disabled = false;
>      }
>
