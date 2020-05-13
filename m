Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039D9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06393205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsEXWi2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06393205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYyI2-00048k-QT
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYyEX-0000gl-CN
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:44:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYyEV-0008HJ-Je
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589402642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SMd/C7Uhg0FsZU5iIxky5UGt4H/DLstw89tRKTTr2Z8=;
 b=YsEXWi2bP7Gl9SoIUDMoBGJF7+WOWYwG92KBS3jRfJMzsFIwtVvAhzR9yMYZcePx3i78f0
 MTXcYKYxh1TudKRIY1Mc5RUbHrvhDJSwqiFbL80N21COzvaOhu31uphuKDlcwZ0YwciiJx
 grHqSc1iAzoP9a1Dp75UFCIremPgss0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-FxKoI__aPmaINcYDPoPOhA-1; Wed, 13 May 2020 16:43:59 -0400
X-MC-Unique: FxKoI__aPmaINcYDPoPOhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CA9880B70D;
 Wed, 13 May 2020 20:43:58 +0000 (UTC)
Received: from [10.10.113.80] (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA86910013D9;
 Wed, 13 May 2020 20:43:44 +0000 (UTC)
Subject: Re: [PATCH v5 08/15] acpi: move aml builder code for floppy device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200507131640.14041-1-kraxel@redhat.com>
 <20200507131640.14041-9-kraxel@redhat.com>
 <2f7a76fe-9c38-1441-70cf-919dce82e4fe@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <77355745-5c13-6579-871d-4a2c02fb7049@redhat.com>
Date: Wed, 13 May 2020 16:43:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2f7a76fe-9c38-1441-70cf-919dce82e4fe@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:05:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/7/20 10:05 AM, Philippe Mathieu-Daudé wrote:
> +Hervé
> 
> On 5/7/20 3:16 PM, Gerd Hoffmann wrote:
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>   hw/block/fdc.c       | 83 ++++++++++++++++++++++++++++++++++++++++++++

oh no...

>>   hw/i386/acpi-build.c | 83 --------------------------------------------
>>   stubs/cmos.c         |  7 ++++
>>   stubs/Makefile.objs  |  1 +
>>   4 files changed, 91 insertions(+), 83 deletions(-)
>>   create mode 100644 stubs/cmos.c
>>
>> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
>> index 9628cc171ef8..40faa088b5f7 100644
>> --- a/hw/block/fdc.c
>> +++ b/hw/block/fdc.c
>> @@ -32,6 +32,8 @@
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/timer.h"
>> +#include "hw/i386/pc.h"
> 
> I'd rather not see this target-specific header used in the generic
> device model... The culprit seems cmos_get_fd_drive_type(). Is the value
> really PC specific?
> 
> Hervé, do you know if such info & RTC nvram layout is used in other arch?
> 

do we need pc-only floppy code somewhere to keep the makefile pure?
that's fine too.

>> +#include "hw/acpi/aml-build.h"
>>   #include "hw/irq.h"
>>   #include "hw/isa/isa.h"
>>   #include "hw/qdev-properties.h"
>> @@ -2765,6 +2767,85 @@ void isa_fdc_get_drive_max_chs(FloppyDriveType
>> type,
>>       (*maxc)--;
>>   }
>>   +static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
>> +{
>> +    Aml *dev, *fdi;
>> +    uint8_t maxc, maxh, maxs;
>> +
>> +    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
>> +
>> +    dev = aml_device("FLP%c", 'A' + idx);
>> +
>> +    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
>> +
>> +    fdi = aml_package(16);
>> +    aml_append(fdi, aml_int(idx));  /* Drive Number */
>> +    aml_append(fdi,
>> +        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
>> +    /*
>> +     * the values below are the limits of the drive, and are thus
>> independent
>> +     * of the inserted media
>> +     */
>> +    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
>> +    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
>> +    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
>> +    /*
>> +     * SeaBIOS returns the below values for int 0x13 func 0x08
>> regardless of
>> +     * the drive type, so shall we
>> +     */
>> +    aml_append(fdi, aml_int(0xAF));  /* disk_specify_1 */
>> +    aml_append(fdi, aml_int(0x02));  /* disk_specify_2 */
>> +    aml_append(fdi, aml_int(0x25));  /* disk_motor_wait */
>> +    aml_append(fdi, aml_int(0x02));  /* disk_sector_siz */
>> +    aml_append(fdi, aml_int(0x12));  /* disk_eot */
>> +    aml_append(fdi, aml_int(0x1B));  /* disk_rw_gap */
>> +    aml_append(fdi, aml_int(0xFF));  /* disk_dtl */
>> +    aml_append(fdi, aml_int(0x6C));  /* disk_formt_gap */
>> +    aml_append(fdi, aml_int(0xF6));  /* disk_fill */
>> +    aml_append(fdi, aml_int(0x0F));  /* disk_head_sttl */
>> +    aml_append(fdi, aml_int(0x08));  /* disk_motor_strt */
>> +
>> +    aml_append(dev, aml_name_decl("_FDI", fdi));
>> +    return dev;
>> +}
>> +
>> +static void fdc_isa_build_aml(ISADevice *isadev, Aml *scope)
>> +{
>> +    Aml *dev;
>> +    Aml *crs;
>> +    int i;
>> +
>> +#define ACPI_FDE_MAX_FD 4
>> +    uint32_t fde_buf[5] = {
>> +        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
>> +        cpu_to_le32(2)  /* tape presence (2 == never present) */
>> +    };
>> +
>> +    crs = aml_resource_template();
>> +    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
>> +    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
>> +    aml_append(crs, aml_irq_no_flags(6));
>> +    aml_append(crs,
>> +        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
>> +
>> +    dev = aml_device("FDC0");
>> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>> +
>> +    for (i = 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
>> +        FloppyDriveType type = isa_fdc_get_drive_type(isadev, i);
>> +
>> +        if (type < FLOPPY_DRIVE_TYPE_NONE) {
>> +            fde_buf[i] = cpu_to_le32(1);  /* drive present */
>> +            aml_append(dev, build_fdinfo_aml(i, type));
>> +        }
>> +    }
>> +    aml_append(dev, aml_name_decl("_FDE",
>> +               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
>> +
>> +    aml_append(scope, dev);
>> +}
>> +
>>   static const VMStateDescription vmstate_isa_fdc ={
>>       .name = "fdc",
>>       .version_id = 2,
>> @@ -2798,11 +2879,13 @@ static Property isa_fdc_properties[] = {
>>   static void isabus_fdc_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>>         dc->realize = isabus_fdc_realize;
>>       dc->fw_name = "fdc";
>>       dc->reset = fdctrl_external_reset_isa;
>>       dc->vmsd = &vmstate_isa_fdc;
>> +    isa->build_aml = fdc_isa_build_aml;
>>       device_class_set_props(dc, isa_fdc_properties);
>>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>   }
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 443db94deb5b..775936e28b9a 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1058,85 +1058,6 @@ static void build_hpet_aml(Aml *table)
>>       aml_append(table, scope);
>>   }
>>   -static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
>> -{
>> -    Aml *dev, *fdi;
>> -    uint8_t maxc, maxh, maxs;
>> -
>> -    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
>> -
>> -    dev = aml_device("FLP%c", 'A' + idx);
>> -
>> -    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
>> -
>> -    fdi = aml_package(16);
>> -    aml_append(fdi, aml_int(idx));  /* Drive Number */
>> -    aml_append(fdi,
>> -        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
>> -    /*
>> -     * the values below are the limits of the drive, and are thus
>> independent
>> -     * of the inserted media
>> -     */
>> -    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
>> -    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
>> -    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
>> -    /*
>> -     * SeaBIOS returns the below values for int 0x13 func 0x08
>> regardless of
>> -     * the drive type, so shall we
>> -     */
>> -    aml_append(fdi, aml_int(0xAF));  /* disk_specify_1 */
>> -    aml_append(fdi, aml_int(0x02));  /* disk_specify_2 */
>> -    aml_append(fdi, aml_int(0x25));  /* disk_motor_wait */
>> -    aml_append(fdi, aml_int(0x02));  /* disk_sector_siz */
>> -    aml_append(fdi, aml_int(0x12));  /* disk_eot */
>> -    aml_append(fdi, aml_int(0x1B));  /* disk_rw_gap */
>> -    aml_append(fdi, aml_int(0xFF));  /* disk_dtl */
>> -    aml_append(fdi, aml_int(0x6C));  /* disk_formt_gap */
>> -    aml_append(fdi, aml_int(0xF6));  /* disk_fill */
>> -    aml_append(fdi, aml_int(0x0F));  /* disk_head_sttl */
>> -    aml_append(fdi, aml_int(0x08));  /* disk_motor_strt */
>> -
>> -    aml_append(dev, aml_name_decl("_FDI", fdi));
>> -    return dev;
>> -}
>> -
>> -static Aml *build_fdc_device_aml(ISADevice *fdc)
>> -{
>> -    int i;
>> -    Aml *dev;
>> -    Aml *crs;
>> -
>> -#define ACPI_FDE_MAX_FD 4
>> -    uint32_t fde_buf[5] = {
>> -        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
>> -        cpu_to_le32(2)  /* tape presence (2 == never present) */
>> -    };
>> -
>> -    dev = aml_device("FDC0");
>> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
>> -
>> -    crs = aml_resource_template();
>> -    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
>> -    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
>> -    aml_append(crs, aml_irq_no_flags(6));
>> -    aml_append(crs,
>> -        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
>> -    aml_append(dev, aml_name_decl("_CRS", crs));
>> -
>> -    for (i = 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
>> -        FloppyDriveType type = isa_fdc_get_drive_type(fdc, i);
>> -
>> -        if (type < FLOPPY_DRIVE_TYPE_NONE) {
>> -            fde_buf[i] = cpu_to_le32(1);  /* drive present */
>> -            aml_append(dev, build_fdinfo_aml(i, type));
>> -        }
>> -    }
>> -    aml_append(dev, aml_name_decl("_FDE",
>> -               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
>> -
>> -    return dev;
>> -}
>> -
>>   static Aml *build_kbd_device_aml(void)
>>   {
>>       Aml *dev;
>> @@ -1175,7 +1096,6 @@ static Aml *build_mouse_device_aml(void)
>>     static void build_isa_devices_aml(Aml *table)
>>   {
>> -    ISADevice *fdc = pc_find_fdc0();
>>       bool ambiguous;
>>         Aml *scope = aml_scope("_SB.PCI0.ISA");
>> @@ -1183,9 +1103,6 @@ static void build_isa_devices_aml(Aml *table)
>>         aml_append(scope, build_kbd_device_aml());
>>       aml_append(scope, build_mouse_device_aml());
>> -    if (fdc) {
>> -        aml_append(scope, build_fdc_device_aml(fdc));
>> -    }
>>         if (ambiguous) {
>>           error_report("Multiple ISA busses, unable to define IPMI
>> ACPI data");
>> diff --git a/stubs/cmos.c b/stubs/cmos.c
>> new file mode 100644
>> index 000000000000..416cbe4055ff
>> --- /dev/null
>> +++ b/stubs/cmos.c
>> @@ -0,0 +1,7 @@
>> +#include "qemu/osdep.h"
>> +#include "hw/i386/pc.h"
>> +
>> +int cmos_get_fd_drive_type(FloppyDriveType fd0)
>> +{
>> +    return 0;
>> +}
>> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
>> index 45be5dc0ed78..3cbe472d1c6c 100644
>> --- a/stubs/Makefile.objs
>> +++ b/stubs/Makefile.objs
>> @@ -3,6 +3,7 @@ stub-obj-y += bdrv-next-monitor-owned.o
>>   stub-obj-y += blk-commit-all.o
>>   stub-obj-y += blockdev-close-all-bdrv-states.o
>>   stub-obj-y += clock-warp.o
>> +stub-obj-y += cmos.o
>>   stub-obj-y += cpu-get-clock.o
>>   stub-obj-y += cpu-get-icount.o
>>   stub-obj-y += dump.o
>>
> 

-- 
—js


