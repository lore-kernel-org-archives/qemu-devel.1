Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAF4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024B320B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024B320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrWv-0007cm-8F
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMrWC-00076u-5K
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMrWA-0008Dy-SW
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:36:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMrWA-0008Db-Il
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:35:58 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68F2E368E2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:35:57 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o128so8326825wmo.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 03:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f0q8fIpV9ECYNdGuFoWEvPSk29jvKO4VCTXV6ut9pj4=;
 b=IGJYFbv7n/C94KKo4M11OnhPDAVWfSDIZDkuLmvoVpZRu3m07ccTC/VZ33DFLTXPwX
 rNbNQHvVpFmstAZ0iYCcr17RpNPXye7ru4oqp7u9IeMrWBa8Poj8Zi2Cg6b7JURKVOwI
 PRKUYLCTc03cfXKgKd/YUKjnnk6FuAWUtJuNe9wAG2636q7SdXZ2LpmbC+ptLuigvopY
 exW6idKzg77NF5iZ30yaqchap3BKWTsyNr+flkbnxMGys6wf0bQfTJ1vyo8FVmYm7fQs
 Tj/X4+7vsYWKEnzYY/z5UcEqUOPIjwU2dResekElUvH7yTeESuytGEHybydi+LfMnBm5
 83Sg==
X-Gm-Message-State: APjAAAXlQJPDvXKcebD8ea1xG1GYtZ2xkm3+8WkCaXrFhE4/yjygl/JG
 hiKHVNnV8YrI63yibiFl6lGK1sToXFzKXrForu1xJE8imMoFP/UlNDy9+MbRVgfJTqJ/pXuyYav
 YmLXjlu3P/wdqsok=
X-Received: by 2002:adf:fc10:: with SMTP id i16mr2715933wrr.157.1571740556083; 
 Tue, 22 Oct 2019 03:35:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwglst3tJqRIZGqf+Xe3PQIxEIqP7pVUGbJk0jDY+8jEH7IjoOkiv8/hoKI/559OizfFb5sTw==
X-Received: by 2002:adf:fc10:: with SMTP id i16mr2715894wrr.157.1571740555786; 
 Tue, 22 Oct 2019 03:35:55 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id u7sm11374341wre.59.2019.10.22.03.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 03:35:55 -0700 (PDT)
Subject: Re: [PATCH v8 7/8] bootdevice: FW_CFG interface for LCHS values
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20191016164145.115898-1-sameid@google.com>
 <20191016164145.115898-9-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <90c66621-3a56-cb5e-2403-fc9197a8aec1@redhat.com>
Date: Tue, 22 Oct 2019 12:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016164145.115898-9-sameid@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 jsnow@redhat.com, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, lersek@redhat.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 6:41 PM, Sam Eiderman wrote:
> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>=20
> Using fw_cfg, supply logical CHS values directly from QEMU to the BIOS.
>=20
> Non-standard logical geometries break under QEMU.
>=20
> A virtual disk which contains an operating system which depends on
> logical geometries (consistent values being reported from BIOS INT13
> AH=3D08) will most likely break under QEMU/SeaBIOS if it has non-standa=
rd
> logical geometries - for example 56 SPT (sectors per track).
> No matter what QEMU will report - SeaBIOS, for large enough disks - wil=
l
> use LBA translation, which will report 63 SPT instead.
>=20
> In addition we cannot force SeaBIOS to rely on physical geometries at
> all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
> report more than 16 physical heads when moved to an IDE controller,
> since the ATA spec allows a maximum of 16 heads - this is an artifact o=
f
> virtualization.
>=20
> By supplying the logical geometries directly we are able to support suc=
h
> "exotic" disks.
>=20
> We serialize this information in a similar way to the "bootorder"
> interface.
> The new fw_cfg entry is "bios-geometry".
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> Signed-off-by: Sam Eiderman <sameid@google.com>
> ---
>   bootdevice.c            | 31 +++++++++++++++++++++++++++++++
>   hw/nvram/fw_cfg.c       | 14 +++++++++++---
>   include/sysemu/sysemu.h |  1 +
>   3 files changed, 43 insertions(+), 3 deletions(-)
>=20
> diff --git a/bootdevice.c b/bootdevice.c
> index 2cf6b37c57..03aaffcc8d 100644
> --- a/bootdevice.c
> +++ b/bootdevice.c
> @@ -405,3 +405,34 @@ void del_boot_device_lchs(DeviceState *dev, const =
char *suffix)
>           }
>       }
>   }
> +
> +char *get_boot_devices_lchs_list(size_t *size)
> +{
> +    FWLCHSEntry *i;
> +    size_t total =3D 0;
> +    char *list =3D NULL;
> +
> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
> +        char *bootpath;
> +        char *chs_string;
> +        size_t len;
> +
> +        bootpath =3D get_boot_device_path(i->dev, false, i->suffix);
> +        chs_string =3D g_strdup_printf("%s %" PRIu32 " %" PRIu32 " %" =
PRIu32,
> +                                     bootpath, i->lcyls, i->lheads, i-=
>lsecs);
> +
> +        if (total) {
> +            list[total - 1] =3D '\n';
> +        }
> +        len =3D strlen(chs_string) + 1;
> +        list =3D g_realloc(list, total + len);
> +        memcpy(&list[total], chs_string, len);
> +        total +=3D len;
> +        g_free(chs_string);
> +        g_free(bootpath);
> +    }
> +

Hmm maybe assert(size !=3D NULL) or if(size) {

> +    *size =3D total;

} or simply document "@size must not be NULL" in the declaration.

Can be a follow-up cleaning patch.

Regardless:
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
> +    return list;
> +}
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 7dc3ac378e..18aff658c0 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const cha=
r *filename,
>  =20
>   static void fw_cfg_machine_reset(void *opaque)
>   {
> +    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> +    FWCfgState *s =3D opaque;
>       void *ptr;
>       size_t len;
> -    FWCfgState *s =3D opaque;
> -    char *bootindex =3D get_boot_devices_list(&len);
> +    char *buf;
>  =20
> -    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, l=
en);
> +    buf =3D get_boot_devices_list(&len);
> +    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len);
>       g_free(ptr);
> +
> +    if (!mc->legacy_fw_cfg_order) {
> +        buf =3D get_boot_devices_lchs_list(&len);
> +        ptr =3D fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)buf,=
 len);
> +        g_free(ptr);
> +    }
>   }
>  =20
>   static void fw_cfg_machine_ready(struct Notifier *n, void *data)
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 5bc5c79cbc..80c57fdc4e 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -106,6 +106,7 @@ void validate_bootdevices(const char *devices, Erro=
r **errp);
>   void add_boot_device_lchs(DeviceState *dev, const char *suffix,
>                             uint32_t lcyls, uint32_t lheads, uint32_t l=
secs);
>   void del_boot_device_lchs(DeviceState *dev, const char *suffix);
> +char *get_boot_devices_lchs_list(size_t *size);
>  =20
>   /* handler to set the boot_device order for a specific type of Machin=
eClass */
>   typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

