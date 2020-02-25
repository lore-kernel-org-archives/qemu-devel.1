Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44850C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1141B21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EET2eFvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1141B21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Wts-0008Ts-Aa
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ardb@kernel.org>) id 1j6WtF-0007uL-LZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ardb@kernel.org>) id 1j6WtD-00063q-S3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:52:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ardb@kernel.org>) id 1j6WtD-00063D-JP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:52:31 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A1C7A22464
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 09:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582624349;
 bh=yL8uE5WMhKq1o5etaCnyZbl3zusrXmLorDrq92/aIfA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EET2eFvtT0pgmDFmVTyTj/Ul+q1PQ1T4e1giHGa8GyG3yYWbT9Hc2VwQYA6PgivER
 Xjget1i00Y4Hz87GMXtBkkMLxOs8cj51Dc5DOCCfXZaohLP0WgXy9T3EPzCkZHDhu+
 Kp2CSTn/+uDzFSpDJZP7QKbfUfW0i26WeVSXOchA=
Received: by mail-wm1-f43.google.com with SMTP id m3so2249894wmi.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 01:52:29 -0800 (PST)
X-Gm-Message-State: APjAAAVW3JC8g/KaTceHVun1/AMi3i4qNPwlVa5eHcnc7xh/0v/nQ7Ht
 BiCF100J3asa4M1lyw2/w+W+u69ahWd5DPdRz2fg3Q==
X-Google-Smtp-Source: APXvYqx3MnTWqW7CmNLnPQ04YEGePxZc3s1I/lnoJTvUlVc7Pn1oZAIegRAdzrzJcskV5AP5vxTjSjHLxMTkP4rB9YE=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr4209216wmf.40.1582624347927; 
 Tue, 25 Feb 2020 01:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-6-eric.auger@redhat.com>
 <b0c30022-e6f3-b52d-60f8-e94db6b6fe99@linux.ibm.com>
 <0f249506-1d16-2a4c-c3b4-1644536a64f5@redhat.com>
 <13c8e9f4-16d9-6926-a2d0-a5771b8d4bf3@redhat.com>
In-Reply-To: <13c8e9f4-16d9-6926-a2d0-a5771b8d4bf3@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 25 Feb 2020 10:52:17 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_nnkZD4LO85Jo32MpdhX_FAgG=zk1GvS0ceUPp2x20-A@mail.gmail.com>
Message-ID: <CAKv+Gu_nnkZD4LO85Jo32MpdhX_FAgG=zk1GvS0ceUPp2x20-A@mail.gmail.com>
Subject: Re: [RFC v2 5/6] tpm: Add the SysBus TPM TIS device
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Laszlo Ersek <lersek@redhat.com>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 10:19, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi,
>
> On 2/17/20 7:13 PM, Auger Eric wrote:
> > Hi Stefan,
> >
> > On 2/16/20 7:32 PM, Stefan Berger wrote:
> >> On 2/14/20 1:37 PM, Eric Auger wrote:
> >>> Introduce the tpm-tis-device which is a sysbus device
> >>> and is bound to be used on ARM.
> >>>
> >>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>> ---
> >>>   hw/tpm/Kconfig          |   5 ++
> >>>   hw/tpm/Makefile.objs    |   1 +
> >>>   hw/tpm/tpm_tis_sysbus.c | 159 ++++++++++++++++++++++++++++++++++++++++
> >>>   include/sysemu/tpm.h    |   1 +
> >>>   4 files changed, 166 insertions(+)
> >>>   create mode 100644 hw/tpm/tpm_tis_sysbus.c
> >>>
> >>> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> >>> index 686f8206bb..4794e7fe28 100644
> >>> --- a/hw/tpm/Kconfig
> >>> +++ b/hw/tpm/Kconfig
> >>> @@ -7,6 +7,11 @@ config TPM_TIS_ISA
> >>>       depends on TPM && ISA_BUS
> >>>       select TPM_TIS
> >>>   +config TPM_TIS_SYSBUS
> >>> +    bool
> >>> +    depends on TPM
> >>> +    select TPM_TIS
> >>> +
> >>>   config TPM_TIS
> >>>       bool
> >>>       depends on TPM
> >>> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> >>> index 3ef2036cca..f1ec4beb95 100644
> >>> --- a/hw/tpm/Makefile.objs
> >>> +++ b/hw/tpm/Makefile.objs
> >>> @@ -1,6 +1,7 @@
> >>>   common-obj-$(CONFIG_TPM) += tpm_util.o
> >>>   obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) += tpm_ppi.o
> >>>   common-obj-$(CONFIG_TPM_TIS_ISA) += tpm_tis_isa.o
> >>> +common-obj-$(CONFIG_TPM_TIS_SYSBUS) += tpm_tis_sysbus.o
> >>>   common-obj-$(CONFIG_TPM_TIS) += tpm_tis_common.o
> >>>   common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
> >>>   common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
> >>> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> >>> new file mode 100644
> >>> index 0000000000..18c02aed67
> >>> --- /dev/null
> >>> +++ b/hw/tpm/tpm_tis_sysbus.c
> >>> @@ -0,0 +1,159 @@
> >>> +/*
> >>> + * tpm_tis_sysbus.c - QEMU's TPM TIS SYSBUS Device
> >>> + *
> >>> + * Copyright (C) 2006,2010-2013 IBM Corporation
> >>> + *
> >>> + * Authors:
> >>> + *  Stefan Berger <stefanb@us.ibm.com>
> >>> + *  David Safford <safford@us.ibm.com>
> >>> + *
> >>> + * Xen 4 support: Andrease Niederl <andreas.niederl@iaik.tugraz.at>
> >>> + *
> >>> + * This work is licensed under the terms of the GNU GPL, version 2 or
> >>> later.
> >>> + * See the COPYING file in the top-level directory.
> >>> + *
> >>> + * Implementation of the TIS interface according to specs found at
> >>> + * http://www.trustedcomputinggroup.org. This implementation currently
> >>> + * supports version 1.3, 21 March 2013
> >>> + * In the developers menu choose the PC Client section then find the TIS
> >>> + * specification.
> >>> + *
> >>> + * TPM TIS for TPM 2 implementation following TCG PC Client Platform
> >>> + * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
> >>> + */
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "hw/qdev-properties.h"
> >>> +#include "migration/vmstate.h"
> >>> +#include "tpm_util.h"
> >>> +#include "hw/sysbus.h"
> >>> +#include "tpm_tis.h"
> >>> +
> >>> +typedef struct TPMStateSysBus {
> >>> +    /*< private >*/
> >>> +    SysBusDevice parent_obj;
> >>> +
> >>> +    /*< public >*/
> >>> +    TPMState state; /* not a QOM object */
> >>> +} TPMStateSysBus;
> >>> +
> >>> +#define TPM_TIS_SYSBUS(obj) OBJECT_CHECK(TPMStateSysBus, (obj),
> >>> TYPE_TPM_TIS_SYSBUS)
> >>> +
> >>> +static int tpm_tis_pre_save_sysbus(void *opaque)
> >>> +{
> >>> +    TPMStateSysBus *sbdev = opaque;
> >>> +
> >>> +    return tpm_tis_pre_save(&sbdev->state);
> >>> +}
> >>> +
> >>> +static const VMStateDescription vmstate_tpm_tis_sysbus = {
> >>> +    .name = "tpm-tis",
> >>> +    .version_id = 0,
> >>> +    .pre_save  = tpm_tis_pre_save_sysbus,
> >>> +    .fields = (VMStateField[]) {
> >>> +        VMSTATE_BUFFER(state.buffer, TPMStateSysBus),
> >>> +        VMSTATE_UINT16(state.rw_offset, TPMStateSysBus),
> >>> +        VMSTATE_UINT8(state.active_locty, TPMStateSysBus),
> >>> +        VMSTATE_UINT8(state.aborting_locty, TPMStateSysBus),
> >>> +        VMSTATE_UINT8(state.next_locty, TPMStateSysBus),
> >>> +
> >>> +        VMSTATE_STRUCT_ARRAY(state.loc, TPMStateSysBus,
> >>> TPM_TIS_NUM_LOCALITIES,
> >>> +                             0, vmstate_locty, TPMLocality),
> >>> +
> >>> +        VMSTATE_END_OF_LIST()
> >>> +    }
> >>> +};
> >>> +
> >>> +static void tpm_tis_sysbus_request_completed(TPMIf *ti, int ret)
> >>> +{
> >>> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(ti);
> >>> +    TPMState *s = &sbdev->state;
> >>> +
> >>> +    tpm_tis_request_completed(s, ret);
> >>> +}
> >>> +
> >>> +static enum TPMVersion tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
> >>> +{
> >>> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(ti);
> >>> +    TPMState *s = &sbdev->state;
> >>> +
> >>> +    return tpm_tis_get_tpm_version(s);
> >>> +}
> >>> +
> >>> +static void tpm_tis_sysbus_reset(DeviceState *dev)
> >>> +{
> >>> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
> >>> +    TPMState *s = &sbdev->state;
> >>> +
> >>> +    return tpm_tis_reset(s);
> >>> +}
> >>> +
> >>> +static Property tpm_tis_sysbus_properties[] = {
> >>> +    DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num,
> >>> TPM_TIS_IRQ),
> >>> +    DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> >>> +    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
> >>> +    DEFINE_PROP_END_OF_LIST(),
> >>> +};
> >>> +
> >>> +static void tpm_tis_sysbus_initfn(Object *obj)
> >>> +{
> >>> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
> >>> +    TPMState *s = &sbdev->state;
> >>> +
> >>> +    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
> >>> +                          s, "tpm-tis-mmio",
> >>> +                          TPM_TIS_NUM_LOCALITIES <<
> >>> TPM_TIS_LOCALITY_SHIFT);
> >>> +
> >>> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> >>> +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> >>> +}
> >>> +
> >>> +static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
> >>> +{
> >>> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
> >>> +    TPMState *s = &sbdev->state;
> >>> +
> >>> +    if (!tpm_find()) {
> >>> +        error_setg(errp, "at most one TPM device is permitted");
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    if (!s->be_driver) {
> >>> +        error_setg(errp, "'tpmdev' property is required");
> >>> +        return;
> >>> +    }
> >>> +}
> >>> +
> >>> +static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
> >>> +{
> >>> +    DeviceClass *dc = DEVICE_CLASS(klass);
> >>> +    TPMIfClass *tc = TPM_IF_CLASS(klass);
> >>> +
> >>> +    device_class_set_props(dc, tpm_tis_sysbus_properties);
> >>> +    dc->vmsd  = &vmstate_tpm_tis_sysbus;
> >>> +    tc->model = TPM_MODEL_TPM_TIS;
> >>> +    dc->realize = tpm_tis_sysbus_realizefn;
> >>> +    dc->user_creatable = true;
> >>> +    dc->reset = tpm_tis_sysbus_reset;
> >>> +    tc->request_completed = tpm_tis_sysbus_request_completed;
> >>> +    tc->get_version = tpm_tis_sysbus_get_tpm_version;
> >>> +}
> >>> +
> >>> +static const TypeInfo tpm_tis_sysbus_info = {
> >>> +    .name = TYPE_TPM_TIS_SYSBUS,
> >>> +    .parent = TYPE_SYS_BUS_DEVICE,
> >>> +    .instance_size = sizeof(TPMStateSysBus),
> >>> +    .instance_init = tpm_tis_sysbus_initfn,
> >>> +    .class_init  = tpm_tis_sysbus_class_init,
> >>> +    .interfaces = (InterfaceInfo[]) {
> >>> +        { TYPE_TPM_IF },
> >>> +        { }
> >>> +    }
> >>> +};
> >>> +
> >>> +static void tpm_tis_sysbus_register(void)
> >>> +{
> >>> +    type_register_static(&tpm_tis_sysbus_info);
> >>> +}
> >>> +
> >>> +type_init(tpm_tis_sysbus_register)
> >>> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> >>> index 1691b92c28..f37851b1aa 100644
> >>> --- a/include/sysemu/tpm.h
> >>> +++ b/include/sysemu/tpm.h
> >>> @@ -44,6 +44,7 @@ typedef struct TPMIfClass {
> >>>   } TPMIfClass;
> >>>     #define TYPE_TPM_TIS_ISA            "tpm-tis"
> >>> +#define TYPE_TPM_TIS_SYSBUS         "tpm-tis-device"
> >>
> >>
> >> hm, replace the rather generic 'device' with 'sysbus'?
> > I used the "-device" suffix because this kind of naming was used for
> > virtio-<type>-device when based on MMIO rather than virtio-<type>-pci.
> > For instance virtio-net-device instead of virtio-net-pci. There are
> > quite a lot of devices using that suffix. I only see xen-sysbus with the
> > sysbus suffix.
> >
> > Now personally I don't have any strong preference and I will pick up the
> > name chosen by consensus.
>
> Does anyone else have an opinion on the name to be chosen for this new
> device:
>
> 1) tpm-tis-device or
> 2) tpm-tis-sysbus ?
>

It is slightly unfortunate that we cannot retain the 'tpm-tis' name,
given that this is simply a TPM with a memory mapped TIS frame, like
the ISA one, and the fact that QEMU instantiates this differently
based on the emulated architecture is really an implementation detail.

So I prefer 'tpm-tis-device', since it doesn't define how it is backed
under the hood, and allows us to potentially instantiate it in a
different way in the future if we wanted to. Alternatively, something
like 'tpm-tis-mmmio' might be appropriate.

-- 
Ard.

