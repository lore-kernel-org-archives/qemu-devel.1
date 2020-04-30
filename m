Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6BFC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3E920873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7IyprrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3E920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBwk-0008JG-9n
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jUBuk-0006Mx-HX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jUBui-0005kA-UB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:19:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jUBui-0005cT-CM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588263590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YJzj8uUbM7k8AvEzlFKC80PIGU9BafiShnrKc9zkNc=;
 b=M7IyprrHYMbPxeXwyBFEyhYRNK9N2fL+wrw0VuwW5GtYuLENOdqM284oNMBhYLjg4/mwgh
 0VltkcWoluA3Mumr9jyPWz2LAkei00RJQcmmuYekZmmnqSKW5ZaHybCMGbbGWSSYDRAbiv
 PfWjzru4p3RDb0DP92NQt1qt0/9R3v4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-LHzJe68gMDWrn5a3G0KcDA-1; Thu, 30 Apr 2020 12:19:48 -0400
X-MC-Unique: LHzJe68gMDWrn5a3G0KcDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B8EF100A61D;
 Thu, 30 Apr 2020 16:19:47 +0000 (UTC)
Received: from localhost (unknown [10.40.208.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4371E60C84;
 Thu, 30 Apr 2020 16:19:30 +0000 (UTC)
Date: Thu, 30 Apr 2020 18:19:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 12/15] acpi: move aml builder code for floppy device
Message-ID: <20200430181927.641ba2c7@redhat.com>
In-Reply-To: <20200429140003.7336-13-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-13-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Apr 2020 16:00:00 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

see small nit below

> ---
>  hw/block/fdc.c       | 83 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c | 83 --------------------------------------------
>  stubs/cmos.c         |  7 ++++
>  stubs/Makefile.objs  |  1 +
>  4 files changed, 91 insertions(+), 83 deletions(-)
>  create mode 100644 stubs/cmos.c
> 
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 33bc9e2f9249..56ddc26c7065 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -32,6 +32,8 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> +#include "hw/i386/pc.h"
> +#include "hw/acpi/aml-build.h"
>  #include "hw/irq.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> @@ -2764,6 +2766,85 @@ void isa_fdc_get_drive_max_chs(FloppyDriveType type,
>      (*maxc)--;
>  }
>  
> +static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
> +{
> +    Aml *dev, *fdi;
> +    uint8_t maxc, maxh, maxs;
> +
> +    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
       ^^^ can be made static now


> +
> +    dev = aml_device("FLP%c", 'A' + idx);
> +
> +    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
> +
> +    fdi = aml_package(16);
> +    aml_append(fdi, aml_int(idx));  /* Drive Number */
> +    aml_append(fdi,
> +        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
> +    /*
> +     * the values below are the limits of the drive, and are thus independent
> +     * of the inserted media
> +     */
> +    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
> +    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
> +    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
> +    /*
> +     * SeaBIOS returns the below values for int 0x13 func 0x08 regardless of
> +     * the drive type, so shall we
> +     */
> +    aml_append(fdi, aml_int(0xAF));  /* disk_specify_1 */
> +    aml_append(fdi, aml_int(0x02));  /* disk_specify_2 */
> +    aml_append(fdi, aml_int(0x25));  /* disk_motor_wait */
> +    aml_append(fdi, aml_int(0x02));  /* disk_sector_siz */
> +    aml_append(fdi, aml_int(0x12));  /* disk_eot */
> +    aml_append(fdi, aml_int(0x1B));  /* disk_rw_gap */
> +    aml_append(fdi, aml_int(0xFF));  /* disk_dtl */
> +    aml_append(fdi, aml_int(0x6C));  /* disk_formt_gap */
> +    aml_append(fdi, aml_int(0xF6));  /* disk_fill */
> +    aml_append(fdi, aml_int(0x0F));  /* disk_head_sttl */
> +    aml_append(fdi, aml_int(0x08));  /* disk_motor_strt */
> +
> +    aml_append(dev, aml_name_decl("_FDI", fdi));
> +    return dev;
> +}
> +
> +static void fdc_isa_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    Aml *dev;
> +    Aml *crs;
> +    int i;
> +
> +#define ACPI_FDE_MAX_FD 4
> +    uint32_t fde_buf[5] = {
> +        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
> +        cpu_to_le32(2)  /* tape presence (2 == never present) */
> +    };
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
> +    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
> +    aml_append(crs, aml_irq_no_flags(6));
> +    aml_append(crs,
> +        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
> +
> +    dev = aml_device("FDC0");
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    for (i = 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
> +        FloppyDriveType type = isa_fdc_get_drive_type(isadev, i);
> +
> +        if (type < FLOPPY_DRIVE_TYPE_NONE) {
> +            fde_buf[i] = cpu_to_le32(1);  /* drive present */
> +            aml_append(dev, build_fdinfo_aml(i, type));
> +        }
> +    }
> +    aml_append(dev, aml_name_decl("_FDE",
> +               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
> +
> +    aml_append(scope, dev);
> +}
> +
>  static const VMStateDescription vmstate_isa_fdc ={
>      .name = "fdc",
>      .version_id = 2,
> @@ -2797,11 +2878,13 @@ static Property isa_fdc_properties[] = {
>  static void isabus_fdc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>  
>      dc->realize = isabus_fdc_realize;
>      dc->fw_name = "fdc";
>      dc->reset = fdctrl_external_reset_isa;
>      dc->vmsd = &vmstate_isa_fdc;
> +    isa->build_aml = fdc_isa_build_aml;
>      device_class_set_props(dc, isa_fdc_properties);
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 12a017e1f45b..7415bd5fdce0 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1052,85 +1052,6 @@ static void build_hpet_aml(Aml *table)
>      aml_append(table, scope);
>  }
>  
> -static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
> -{
> -    Aml *dev, *fdi;
> -    uint8_t maxc, maxh, maxs;
> -
> -    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
> -
> -    dev = aml_device("FLP%c", 'A' + idx);
> -
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
> -
> -    fdi = aml_package(16);
> -    aml_append(fdi, aml_int(idx));  /* Drive Number */
> -    aml_append(fdi,
> -        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
> -    /*
> -     * the values below are the limits of the drive, and are thus independent
> -     * of the inserted media
> -     */
> -    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
> -    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
> -    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
> -    /*
> -     * SeaBIOS returns the below values for int 0x13 func 0x08 regardless of
> -     * the drive type, so shall we
> -     */
> -    aml_append(fdi, aml_int(0xAF));  /* disk_specify_1 */
> -    aml_append(fdi, aml_int(0x02));  /* disk_specify_2 */
> -    aml_append(fdi, aml_int(0x25));  /* disk_motor_wait */
> -    aml_append(fdi, aml_int(0x02));  /* disk_sector_siz */
> -    aml_append(fdi, aml_int(0x12));  /* disk_eot */
> -    aml_append(fdi, aml_int(0x1B));  /* disk_rw_gap */
> -    aml_append(fdi, aml_int(0xFF));  /* disk_dtl */
> -    aml_append(fdi, aml_int(0x6C));  /* disk_formt_gap */
> -    aml_append(fdi, aml_int(0xF6));  /* disk_fill */
> -    aml_append(fdi, aml_int(0x0F));  /* disk_head_sttl */
> -    aml_append(fdi, aml_int(0x08));  /* disk_motor_strt */
> -
> -    aml_append(dev, aml_name_decl("_FDI", fdi));
> -    return dev;
> -}
> -
> -static Aml *build_fdc_device_aml(ISADevice *fdc)
> -{
> -    int i;
> -    Aml *dev;
> -    Aml *crs;
> -
> -#define ACPI_FDE_MAX_FD 4
> -    uint32_t fde_buf[5] = {
> -        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
> -        cpu_to_le32(2)  /* tape presence (2 == never present) */
> -    };
> -
> -    dev = aml_device("FDC0");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
> -
> -    crs = aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
> -    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
> -    aml_append(crs, aml_irq_no_flags(6));
> -    aml_append(crs,
> -        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    for (i = 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
> -        FloppyDriveType type = isa_fdc_get_drive_type(fdc, i);
> -
> -        if (type < FLOPPY_DRIVE_TYPE_NONE) {
> -            fde_buf[i] = cpu_to_le32(1);  /* drive present */
> -            aml_append(dev, build_fdinfo_aml(i, type));
> -        }
> -    }
> -    aml_append(dev, aml_name_decl("_FDE",
> -               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
> -
> -    return dev;
> -}
> -
>  static Aml *build_kbd_device_aml(void)
>  {
>      Aml *dev;
> @@ -1169,7 +1090,6 @@ static Aml *build_mouse_device_aml(void)
>  
>  static void build_isa_devices_aml(Aml *table)
>  {
> -    ISADevice *fdc = pc_find_fdc0();
>      bool ambiguous;
>  
>      Aml *scope = aml_scope("_SB.PCI0.ISA");
> @@ -1177,9 +1097,6 @@ static void build_isa_devices_aml(Aml *table)
>  
>      aml_append(scope, build_kbd_device_aml());
>      aml_append(scope, build_mouse_device_aml());
> -    if (fdc) {
> -        aml_append(scope, build_fdc_device_aml(fdc));
> -    }
>  
>      if (ambiguous) {
>          error_report("Multiple ISA busses, unable to define IPMI ACPI data");
> diff --git a/stubs/cmos.c b/stubs/cmos.c
> new file mode 100644
> index 000000000000..416cbe4055ff
> --- /dev/null
> +++ b/stubs/cmos.c
> @@ -0,0 +1,7 @@
> +#include "qemu/osdep.h"
> +#include "hw/i386/pc.h"
> +
> +int cmos_get_fd_drive_type(FloppyDriveType fd0)
> +{
> +    return 0;
> +}
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 45be5dc0ed78..3cbe472d1c6c 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -3,6 +3,7 @@ stub-obj-y += bdrv-next-monitor-owned.o
>  stub-obj-y += blk-commit-all.o
>  stub-obj-y += blockdev-close-all-bdrv-states.o
>  stub-obj-y += clock-warp.o
> +stub-obj-y += cmos.o
>  stub-obj-y += cpu-get-clock.o
>  stub-obj-y += cpu-get-icount.o
>  stub-obj-y += dump.o


