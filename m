Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D41C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789402053B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789402053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQXM-0002rf-Sl
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDQWe-0002NW-4X
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDQWc-0003Eh-Hn
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDQWb-0003Di-P6
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:57:25 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BEDFE4E924
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:57:24 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id n18so711742wro.11
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 02:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Uu+ezf+5NbgmdN1TU+zbFPGDa7PFlR5gP4aWtA07fdw=;
 b=iTSB8fOYGvC5qn+0pjLE0cFhEJCtrqds/AGFPd7oDYMyKgQfvN2WCoSWxJRhZRScVy
 OHhdICccpre00PU7N+2wWASFDBmdeRprOLkGZNNjr32PlbWsTGs5tyozHk9wtjUqd2J/
 YJ5vQNxJ2PtypJLrPquEF84kL2LLPd1jx26zcMnRCMRDH6go9LSVjWoTOmcO26Rto1mz
 06rWlnBfykNouCRav5RQoGcuv207bZQECwqs+XJzVySKyiB/ZlTabsuhxr2Ayw2mphUO
 XO4zqo8uE/BKQjStmezde3upXSKy1fR8QzQFXSzy+Q9KmoORmiTrVTkT7lZb/HC4tkVe
 0Jjg==
X-Gm-Message-State: APjAAAVbgBsfYXJmBewgWSHJ+M+xXaQFDx9NTI+uAX+wfHkzu4WiufUL
 xB010IKvdZtdDb2kG68W1OWIdEo2xAhgTGOVB9d/PooC+Cm8/BCfPF5vJ85zRE8jYm9GQJbIoTD
 u15V97fuxe96E3aM=
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr2170781wru.89.1569491843460;
 Thu, 26 Sep 2019 02:57:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzEUqN41kpTwGjrgpI/M0Zsm8jKuxPcbMmpJ9lyLuUlk7iyYD2WiVOsomItLEszt3oJDzJM7g==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr2170761wru.89.1569491843076;
 Thu, 26 Sep 2019 02:57:23 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id d4sm1375080wrq.22.2019.09.26.02.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 02:57:22 -0700 (PDT)
Subject: Re: [SeaBIOS] [PATCH v7 7/8] bootdevice: FW_CFG interface for LCHS
 values
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
Date: Thu, 26 Sep 2019 11:57:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925110639.100699-8-sameid@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 seabios@seabios.org, kraxel@redhat.com, Laszlo Ersek <lersek@redhat.com>,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sam,

On 9/25/19 1:06 PM, Sam Eiderman wrote:
> From: Sam Eiderman <shmuel.eiderman@oracle.com>
> 
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
> The new fw_cfg entry is "bios-geometry".
> 
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  bootdevice.c            | 32 ++++++++++++++++++++++++++++++++
>  hw/nvram/fw_cfg.c       | 14 +++++++++++---
>  include/sysemu/sysemu.h |  1 +
>  3 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/bootdevice.c b/bootdevice.c
> index 2b12fb85a4..b034ad7bdc 100644
> --- a/bootdevice.c
> +++ b/bootdevice.c
> @@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState *dev, const char *suffix)
>          }
>      }
>  }
> +
> +/* Serialized as: (device name\0 + lchs struct) x devices */
> +char *get_boot_devices_lchs_list(size_t *size)
> +{
> +    FWLCHSEntry *i;
> +    size_t total = 0;
> +    char *list = NULL;
> +
> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
> +        char *bootpath;
> +        char *chs_string;
> +        size_t len;
> +
> +        bootpath = get_boot_device_path(i->dev, false, i->suffix);
> +        chs_string = g_strdup_printf("%s %" PRIu32 " %" PRIu32 " %" PRIu32,
> +                                     bootpath, i->lcyls, i->lheads, i->lsecs);

Hmm maybe we can g_free(bootpath) directly here.

> +
> +        if (total) {
> +            list[total - 1] = '\n';
> +        }
> +        len = strlen(chs_string) + 1;
> +        list = g_realloc(list, total + len);
> +        memcpy(&list[total], chs_string, len);
> +        total += len;
> +        g_free(chs_string);
> +        g_free(bootpath);
> +    }
> +
> +    *size = total;
> +
> +    return list;
> +}
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 7dc3ac378e..18aff658c0 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
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
> +        buf = get_boot_devices_lchs_list(&len);
> +        ptr = fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)buf, len);

OK. Can you add a test in tests/fw_cfg-test.c please?

> +        g_free(ptr);
> +    }
>  }
>  
>  static void fw_cfg_machine_ready(struct Notifier *n, void *data)
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 5bc5c79cbc..80c57fdc4e 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -106,6 +106,7 @@ void validate_bootdevices(const char *devices, Error **errp);
>  void add_boot_device_lchs(DeviceState *dev, const char *suffix,
>                            uint32_t lcyls, uint32_t lheads, uint32_t lsecs);
>  void del_boot_device_lchs(DeviceState *dev, const char *suffix);
> +char *get_boot_devices_lchs_list(size_t *size);

Please add some documentation. At least 'size' must be non-NULL.

Ideally you should add doc for the other functions added in 3/8
"bootdevice: Add interface to gather LCHS" too.

John, what do you think about extracting the *boot_device* functions out
of "sysemu.h"?

Thanks,

Phil.

>  
>  /* handler to set the boot_device order for a specific type of MachineClass */
>  typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
> 

