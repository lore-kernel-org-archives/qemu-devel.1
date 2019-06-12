Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7C9C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8DF20684
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8DF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2iF-0001gB-Lh
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50744)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hb2Ly-00073n-2O
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hb2Lw-0001Nk-8k
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:27:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hb2Lq-0000yT-HF; Wed, 12 Jun 2019 08:27:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C2933003185;
 Wed, 12 Jun 2019 12:27:31 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-191.ams2.redhat.com
 [10.36.117.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 900FD1001B0A;
 Wed, 12 Jun 2019 12:27:22 +0000 (UTC)
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 seabios@seabios.org, kraxel@redhat.com, kevin@koconnor.net
References: <20190612094237.47462-1-shmuel.eiderman@oracle.com>
 <20190612094237.47462-8-shmuel.eiderman@oracle.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dc9c9c32-2fcb-a501-525b-a9bba8f22340@redhat.com>
Date: Wed, 12 Jun 2019 14:27:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190612094237.47462-8-shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 12:27:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU] [PATCH 7/8] bootdevice: FW_CFG interface
 for LCHS values
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
Cc: liran.alon@oracle.com, karl.heubaum@oracle.com, arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/12/19 11:42, Sam Eiderman wrote:
> Using fw_cfg, supply logical CHS values directly from QEMU to the BIOS.
> 
> Non-standard logical geometries break under QEMU.
> 
> A virtual disk which contains an operating system which depends on
> logical geometries (consistent values being reported from BIOS INT13
> AH=08) will most likely break under QEMU/SeaBIOS if it has non-standard
> logical geometries - for example 56 SPT (sectors per track).
> No matter what QEMU will report - SeaBIOS, for large enough disks - will
> use LBA translation, which will report 63 SPT instead.
> 
> In addition we cannot force SeaBIOS to rely on physical geometries at
> all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
> report more than 16 physical heads when moved to an IDE controller,
> since the ATA spec allows a maximum of 16 heads - this is an artifact of
> virtualization.
> 
> By supplying the logical geometries directly we are able to support such
> "exotic" disks.
> 
> We serialize this information in a similar way to the "bootorder"
> interface.
> The fw_cfg entry is "bootdevices" and it serializes a struct.
> At the moment the struct holds the values of logical CHS values but it
> can be expanded easily due to the extendable ABI implemented.
> 
> (In the future, we can pass the bootindex through "bootdevices" instead
> "bootorder" - unifying all bootdevice information in one fw_cfg value)

I would disagree with that. UEFI guest firmware doesn't seem to have any
use for this new type of information ("logical CHS values"), so the
current interface (the "bootorder" fw_cfg file) should continue to work.
The ArmVirtQemu and OVMF platform firmwares (built from the edk2
project, and bundled with QEMU 4.1+) implement some serious parsing and
processing for "bootorder".

Independently, another comment:

> The PV interface through fw_cfg could have also been implemented using
> device specific keys, e.g.: "/etc/bootdevice/%s/logical_geometry" where
> %s is the device name QEMU produces - but this implementation would
> require much more code refactoring, both in QEMU and SeaBIOS, so the
> current implementation was chosen.
> 
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  bootdevice.c            | 42 ++++++++++++++++++++++++++++++++++++++++++
>  hw/nvram/fw_cfg.c       | 14 +++++++++++---
>  include/sysemu/sysemu.h |  1 +
>  3 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/bootdevice.c b/bootdevice.c
> index 2b12fb85a4..84c2a83f25 100644
> --- a/bootdevice.c
> +++ b/bootdevice.c
> @@ -405,3 +405,45 @@ void del_boot_device_lchs(DeviceState *dev, const char *suffix)
>          }
>      }
>  }
> +
> +typedef struct QEMU_PACKED BootDeviceEntrySerialized {
> +    /* Do not change field order - add new fields below */
> +    uint32_t lcyls;
> +    uint32_t lheads;
> +    uint32_t lsecs;
> +} BootDeviceEntrySerialized;
> +
> +/* Serialized as: struct size (4) + (device name\0 + device struct) x devices */
> +char *get_boot_devices_info(size_t *size)
> +{
> +    FWLCHSEntry *i;
> +    BootDeviceEntrySerialized s;
> +    size_t total = 0;
> +    char *list = NULL;
> +
> +    list = g_malloc0(sizeof(uint32_t));
> +    *((uint32_t *)list) = (uint32_t)sizeof(s);
> +    total = sizeof(uint32_t);
> +
> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
> +        char *bootpath;
> +        size_t len;
> +
> +        bootpath = get_boot_device_path(i->dev, false, i->suffix);
> +        s.lcyls = i->lcyls;
> +        s.lheads = i->lheads;
> +        s.lsecs = i->lsecs;

You should document the endianness of the fields in
BootDeviceEntrySerialized, and then call byte order conversion functions
here accordingly (most probably cpu_to_le32()).

As written, this code would break if you ran qemu-system-x86_64 /
qemu-system-i386 (with TCG acceleration) on a big endian host.

Thanks
Laszlo

> +
> +        len = strlen(bootpath) + 1;
> +        list = g_realloc(list, total + len + sizeof(s));
> +        memcpy(&list[total], bootpath, len);
> +        memcpy(&list[total + len], &s, sizeof(s));
> +        total += len + sizeof(s);
> +
> +        g_free(bootpath);
> +    }
> +
> +    *size = total;
> +
> +    return list;
> +}
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 9f7b7789bc..008b21542f 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -916,13 +916,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>  
>  static void fw_cfg_machine_reset(void *opaque)
>  {
> +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> +    FWCfgState *s = opaque;
>      void *ptr;
>      size_t len;
> -    FWCfgState *s = opaque;
> -    char *bootindex = get_boot_devices_list(&len);
> +    char *buf;
>  
> -    ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
> +    buf = get_boot_devices_list(&len);
> +    ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len);
>      g_free(ptr);
> +
> +    if (!mc->legacy_fw_cfg_order) {
> +        buf = get_boot_devices_info(&len);
> +        ptr = fw_cfg_modify_file(s, "bootdevices", (uint8_t *)buf, len);
> +        g_free(ptr);
> +    }
>  }
>  
>  static void fw_cfg_machine_ready(struct Notifier *n, void *data)
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 173dfbb539..f0552006f4 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -174,6 +174,7 @@ void validate_bootdevices(const char *devices, Error **errp);
>  void add_boot_device_lchs(DeviceState *dev, const char *suffix,
>                            uint32_t lcyls, uint32_t lheads, uint32_t lsecs);
>  void del_boot_device_lchs(DeviceState *dev, const char *suffix);
> +char *get_boot_devices_info(size_t *size);
>  
>  /* handler to set the boot_device order for a specific type of MachineClass */
>  typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
> 


