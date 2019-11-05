Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878F4C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481BA21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481BA21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS61o-0007S4-1B
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iS5p2-0000Kp-Dt
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iS5p0-0001wV-GU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iS5p0-0001vr-65
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:02 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44EEF369AF
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2019 20:53:01 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id c32so23782407qtb.14
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=csPHTzvEF6p0v4SejEaaXBZN7WwPJe9AL1C9qikcaYo=;
 b=qdPl22e+tuV/3uRFY7sunn1Kp4C+VKdZNMk269TwF1ZkVpCRtKcFz4rsx3XWrYP2gu
 gVYjS7XUD3oeBUNbuiuLbbnx0rHRST8WP7qkBSKoyBugBQ5RQb5VXLhQc+VEk8Z/T1cW
 M8RIczLj+aqmGw7XWoj/JwvzVN2M/sa1RwlADZe6yBIjAcXRS0eqgIbSNutxoVHGRAKx
 V+O0nZQBAdS1fX+TTRykuj6rrlDb3u1zRUFf57objWA4+jQsjD1XTJdBVqdYhkygpR/0
 3eKzx0HAKLX8Jt9t/tvTejoJpSOqsH7v/Sn3yEqijSaCoHoRuosPoWbyySOj+zSLBDQG
 UxNQ==
X-Gm-Message-State: APjAAAV1bU0LwWnS3o1N/VrtNQb7pp4OMIul6hXt2CdXqL7PxFknSHJ1
 s+wFpyPGtO4QJYmvzXqK8f62ZW7Y4Ogf7rlhKFN8rqWiIc8VJtSjBdJbxfRWUFrvzZkpLkXDv/h
 kmM8Rk1oI4JF8tqo=
X-Received: by 2002:a37:ad8:: with SMTP id 207mr8309381qkk.492.1572987180351; 
 Tue, 05 Nov 2019 12:53:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyT4Wm+DIPwheuSWTIWaHSByHOomyhKKaJQ/PZJcMjMPCQt0b3wDqVVGoFXXbVMRvFFZ2aYw==
X-Received: by 2002:a37:ad8:: with SMTP id 207mr8309369qkk.492.1572987180012; 
 Tue, 05 Nov 2019 12:53:00 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id g126sm11062375qkb.133.2019.11.05.12.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 12:52:59 -0800 (PST)
Date: Tue, 5 Nov 2019 15:52:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 3/4] virtio: increase virtuqueue sizes in new machine
 types
Message-ID: <20191105155224-mutt-send-email-mst@kernel.org>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-4-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105161105.19016-4-dplotnikov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 05, 2019 at 07:11:04PM +0300, Denis Plotnikov wrote:
> Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
> field reported by SCSI controler. Thus typical sequential read with
> 1 MB size results in the following pattern of the IO from the guest:
>   8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [dd]
>   8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [dd]
>   8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
>   8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0]
>   8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0]
>   8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
> The IO was generated by
>   dd if=/dev/sda of=/dev/null bs=1024 iflag=direct
> 
> This effectively means that on rotational disks we will observe 3 IOPS
> for each 2 MBs processed. This definitely negatively affects both
> guest and host IO performance.
> 
> The cure is relatively simple - we should report lengthy scatter-gather
> ability of the SCSI controller. Fortunately the situation here is very
> good. VirtIO transport layer can accomodate 1024 items in one request
> while we are using only 128. This situation is present since almost
> very beginning. 2 items are dedicated for request metadata thus we
> should publish VIRTQUEUE_MAX_SIZE - 2 as max_seg.
> 
> The following pattern is observed after the patch:
>   8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [dd]
>   8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [dd]
>   8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0]
>   8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0]
> which is much better.
> 
> To fix this particular case, the patch adds new machine types with
> extended virtqueue sizes to 256 which also increases max_seg to 254
> implicitly.
> 
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---



the way we normally do this is change the defaults to 256.
what is wrong with doing that?


>  hw/core/machine.c   | 14 ++++++++++++++
>  hw/i386/pc_piix.c   | 16 +++++++++++++---
>  hw/i386/pc_q35.c    | 14 ++++++++++++--
>  include/hw/boards.h |  6 ++++++
>  4 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 55b08f1466..28013a0e3f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -24,6 +24,13 @@
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
>  
> +GlobalProperty hw_compat_4_0_1[] = {
> +    { "virtio-blk-device", "queue-size", "128" },
> +    { "virtio-scsi-device", "virtqueue_size", "128" },
> +    { "vhost-scsi-device", "virtqueue_size", "128" },
> +};
> +const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
> +
>  GlobalProperty hw_compat_4_0[] = {
>      { "virtio-balloon-device", "qemu-4-0-config-size", "true" },
>  };
> @@ -157,6 +164,13 @@ GlobalProperty hw_compat_2_1[] = {
>  };
>  const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
>  
> +GlobalProperty hw_compat[] = {
> +    { "virtio-blk-device", "queue-size", "256" },
> +    { "virtio-scsi-device", "virtqueue_size", "256" },
> +    { "vhost-scsi-device", "virtqueue_size", "256" },
> +};
> +const size_t hw_compat_len = G_N_ELEMENTS(hw_compat);
> +
>  static char *machine_get_accel(Object *obj, Error **errp)
>  {
>      MachineState *ms = MACHINE(obj);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 8ad8e885c6..2260a61b1b 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -426,15 +426,27 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      m->default_machine_opts = "firmware=bios-256k.bin";
>      m->default_display = "std";
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
> +    compat_props_add(m->compat_props, hw_compat, hw_compat_len);
>  }
>  
> -static void pc_i440fx_4_0_machine_options(MachineClass *m)
> +static void pc_i440fx_4_0_2_machine_options(MachineClass *m)
>  {
>      pc_i440fx_machine_options(m);
>      m->alias = "pc";
>      m->is_default = 1;
>  }
>  
> +DEFINE_I440FX_MACHINE(v4_0_2, "pc-i440fx-4.0.2", NULL,
> +                      pc_i440fx_4_0_2_machine_options);
> +
> +static void pc_i440fx_4_0_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_4_0_2_machine_options(m);
> +    m->alias = NULL;
> +    m->is_default = 0;
> +    compat_props_add(m->compat_props, hw_compat_4_0_1, hw_compat_4_0_1_len);
> +}
> +
>  DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
>                        pc_i440fx_4_0_machine_options);
>  
> @@ -443,9 +455,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>  
>      pc_i440fx_4_0_machine_options(m);
> -    m->is_default = 0;
>      m->smbus_no_migration_support = true;
> -    m->alias = NULL;
>      pcmc->pvh_enabled = false;
>      compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
>      compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 45cc29d1ad..50ccd9ebcf 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -363,14 +363,25 @@ static void pc_q35_machine_options(MachineClass *m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>      m->max_cpus = 288;
> +    compat_props_add(m->compat_props, hw_compat, hw_compat_len);
>  }
>  
> -static void pc_q35_4_0_1_machine_options(MachineClass *m)
> +static void pc_q35_4_0_2_machine_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>      m->alias = "q35";
>  }
>  
> +DEFINE_Q35_MACHINE(v4_0_2, "pc-q35-4.0.2", NULL,
> +                   pc_q35_4_0_2_machine_options);
> +
> +static void pc_q35_4_0_1_machine_options(MachineClass *m)
> +{
> +    pc_q35_4_0_2_machine_options(m);
> +    m->alias = NULL;
> +    compat_props_add(m->compat_props, hw_compat_4_0_1, hw_compat_4_0_1_len);
> +}
> +
>  DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
>                     pc_q35_4_0_1_machine_options);
>  
> @@ -378,7 +389,6 @@ static void pc_q35_4_0_machine_options(MachineClass *m)
>  {
>      pc_q35_4_0_1_machine_options(m);
>      m->default_kernel_irqchip_split = true;
> -    m->alias = NULL;
>      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
>  }
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index fe1885cbff..cf10632dac 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -293,6 +293,9 @@ struct MachineState {
>      } \
>      type_init(machine_initfn##_register_types)
>  
> +extern GlobalProperty hw_compat_4_0_1[];
> +extern const size_t hw_compat_4_0_1_len;
> +
>  extern GlobalProperty hw_compat_4_0[];
>  extern const size_t hw_compat_4_0_len;
>  
> @@ -338,4 +341,7 @@ extern const size_t hw_compat_2_2_len;
>  extern GlobalProperty hw_compat_2_1[];
>  extern const size_t hw_compat_2_1_len;
>  
> +extern GlobalProperty hw_compat[];
> +extern const size_t hw_compat_len;
> +
>  #endif
> -- 
> 2.17.0

