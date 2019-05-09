Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC886C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA43206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA43206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOfsA-0007QI-SQ
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:01:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hOfpW-000530-FP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hOfpU-0003hb-Dt
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:59:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46662
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hOfpU-0003ge-8t
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:59:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x499moLK057372
	for <qemu-devel@nongnu.org>; Thu, 9 May 2019 05:59:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2scfjey227-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 05:59:05 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 9 May 2019 10:59:03 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 9 May 2019 10:59:02 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
	[9.149.105.58])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x499x0k859441308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 9 May 2019 09:59:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4646A4C04A;
	Thu,  9 May 2019 09:59:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE0804C046;
	Thu,  9 May 2019 09:58:59 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.71])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  9 May 2019 09:58:59 +0000 (GMT)
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
	qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net,
	david@redhat.com, pasic@linux.ibm.com, mst@redhat.com, pbonzini@redhat.com
References: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
	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
	syiRa+UVlsKmx1hsEg==
Date: Thu, 9 May 2019 11:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050909-0012-0000-0000-00000319E096
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050909-0013-0000-0000-00002152663F
Message-Id: <4f5c8f1a-8898-c5e3-0b96-065a1ac21476@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905090061
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v4] s390: diagnose 318 info reset and
 migration support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 02.05.19 00:31, Collin Walling wrote:
> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
> be intercepted by SIE and handled via KVM. Let's introduce some
> functions to communicate between QEMU and KVM via ioctls. These
> will be used to get/set the diag318 related information (also known
> as the "Control Program Code" or "CPC"), as well as check the system
> if KVM supports handling this instruction.
> 
> The availability of this instruction is determined by byte 134, bit 0
> of the Read Info block. This coincidentally expands into the space used
> for CPU entries, which means VMs running with the diag318 capability
> will have a reduced maximum CPU count. To alleviate this, let's calculate
> the actual max CPU entry space by subtracting the size of Read Info from
> the SCCB size then dividing that number by the size of a CPU entry. If
> this value is less than the value denoted by S390_MAX_CPUS, then let's
> reduce the max cpus for s390 from 248 to 240 in an effort to anticipate
> this potentially happening again in the future.
> 
> In order to simplify the migration and system reset requirements of
> the diag318 data, let's introduce it as a device class and include
> a VMStateDescription.
> 
> Diag318 is reset on during modified clear and load normal.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/Makefile.objs       |   1 +
>  hw/s390x/diag318.c           | 100 +++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/diag318.h           |  39 +++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c   |  23 ++++++++++
>  hw/s390x/sclp.c              |   5 +++
>  include/hw/s390x/sclp.h      |   2 +
>  linux-headers/asm-s390/kvm.h |   4 ++
>  target/s390x/kvm-stub.c      |  15 +++++++
>  target/s390x/kvm.c           |  32 ++++++++++++++
>  target/s390x/kvm_s390x.h     |   3 ++
>  10 files changed, 224 insertions(+)
>  create mode 100644 hw/s390x/diag318.c
>  create mode 100644 hw/s390x/diag318.h
> 
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index e02ed80..93621dc 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -34,3 +34,4 @@ obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
>  obj-y += s390-ccw.o
>  obj-y += ap-device.o
>  obj-y += ap-bridge.o
> +obj-y += diag318.o
> diff --git a/hw/s390x/diag318.c b/hw/s390x/diag318.c
> new file mode 100644
> index 0000000..94b44da
> --- /dev/null
> +++ b/hw/s390x/diag318.c
> @@ -0,0 +1,100 @@
> +/*
> + * DIAGNOSE 0x318 functions for reset and migration
> + *
> + * Copyright IBM, Corp. 2019
> + *
> + * Authors:
> + *  Collin Walling <walling@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at your
> + * option) any later version. See the COPYING file in the top-level directory.
> + */
> +
> +#include "hw/s390x/diag318.h"
> +#include "qapi/error.h"
> +#include "kvm_s390x.h"
> +#include "sysemu/kvm.h"
> +
> +static int diag318_post_load(void *opaque, int version_id)
> +{
> +    DIAG318State *d = opaque;
> +
> +    kvm_s390_set_cpc(d->cpc);
> +
> +    /* It is not necessary to retain a copy of the cpc after migration. */
> +    d->cpc = 0;

But we also do not need to zero it out? Can't you just drop these 2 lines?


> +
> +    return 0;
> +}
> +
> +static int diag318_pre_save(void *opaque)
> +{
> +    DIAG318State *d = opaque;
> +
> +    kvm_s390_get_cpc(&d->cpc);
> +    return 0;
> +}
> +
> +static bool diag318_needed(void *opaque)
> +{
> +    DIAG318State *d = opaque;
> +
> +    return d->enabled;
> +}

I would like to have a cpumodel entry that allows to disable that feature. And we should
then check for this.

> +
> +const VMStateDescription vmstate_diag318 = {
> +    .name = "vmstate_diag318",
> +    .post_load = diag318_post_load,
> +    .pre_save = diag318_pre_save,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = diag318_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(cpc, DIAG318State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void s390_diag318_realize(DeviceState *dev, Error **errp)
> +{
> +    DIAG318State *d = DIAG318(dev);
> +
> +    if (kvm_s390_has_diag318()) {
> +        d->enabled = true;
> +    }

same here -> cpumodel
Then we can get rid of the enabled bool.
> +}
> +
> +static void s390_diag318_reset(DeviceState *dev)
> +{
> +    DIAG318State *d = DIAG318(dev);
> +
> +    if (d->enabled) {
> +        kvm_s390_set_cpc(0);
> +    }
> +}
> +
> +static void s390_diag318_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = s390_diag318_realize;
> +    dc->reset = s390_diag318_reset;
> +    dc->vmsd = &vmstate_diag318;
> +    dc->hotpluggable = false;
> +    /* Reason: Set automatically during IPL */
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo s390_diag318_info = {
> +    .class_init = s390_diag318_class_init,
> +    .parent = TYPE_DEVICE,
> +    .name = TYPE_S390_DIAG318,
> +    .instance_size = sizeof(DIAG318State),
> +};
> +
> +static void s390_diag318_register_types(void)
> +{
> +    type_register_static(&s390_diag318_info);
> +}
> +
> +type_init(s390_diag318_register_types)
> diff --git a/hw/s390x/diag318.h b/hw/s390x/diag318.h
> new file mode 100644
> index 0000000..c154b0a
> --- /dev/null
> +++ b/hw/s390x/diag318.h
> @@ -0,0 +1,39 @@
> +/*
> + * DIAGNOSE 0x318 functions for reset and migration
> + *
> + * Copyright IBM, Corp. 2019
> + *
> + * Authors:
> + *  Collin Walling <walling@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at your
> + * option) any later version. See the COPYING file in the top-level directory.
> + */
> +
> + #ifndef DIAG318_H
> + #define DIAG318_H
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev.h"
> +
> +#define TYPE_S390_DIAG318 "diag318"
> +#define DIAG318(obj) \
> +    OBJECT_CHECK(DIAG318State, (obj), TYPE_S390_DIAG318)
> +
> +typedef struct DIAG318State {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    uint64_t cpc;
> +    bool enabled;
> +} DIAG318State;
> +
> +typedef struct DIAG318Class {
> +    /*< private >*/
> +    DeviceClass parent_class;
> +
> +    /*< public >*/
> +} DIAG318Class;
> +
> +#endif /* DIAG318_H */
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d11069b..44a424b 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -36,6 +36,7 @@
>  #include "cpu_models.h"
>  #include "hw/nmi.h"
>  #include "hw/s390x/tod.h"
> +#include "hw/s390x/diag318.h"
>  
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -92,6 +93,7 @@ static const char *const reset_dev_types[] = {
>      "s390-sclp-event-facility",
>      "s390-flic",
>      "diag288",
> +    TYPE_S390_DIAG318,
>  };
>  
>  static void subsystem_reset(void)
> @@ -246,6 +248,17 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
>      qdev_init_nofail(dev);
>  }
>  
> +static void s390_init_diag318(void)
> +{
> +    Object *new = object_new(TYPE_S390_DIAG318);
> +    DeviceState *dev = DEVICE(new);
> +
> +    object_property_add_child(qdev_get_machine(), TYPE_S390_DIAG318,
> +                              new, NULL);
> +    object_unref(new);
> +    qdev_init_nofail(dev);
> +}
> +
>  static void ccw_init(MachineState *machine)
>  {
>      int ret;
> @@ -302,6 +315,8 @@ static void ccw_init(MachineState *machine)
>  
>      /* init the TOD clock */
>      s390_init_tod();
> +
> +    s390_init_diag318();
>  }
>  
>  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
> @@ -570,6 +585,7 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
>          ms->loadparm[i] = ' '; /* pad right with spaces */
>      }
>  }
> +
>  static inline void s390_machine_initfn(Object *obj)
>  {
>      object_property_add_bool(obj, "aes-key-wrap",
> @@ -652,6 +668,13 @@ static void ccw_machine_4_0_instance_options(MachineState *machine)
>  
>  static void ccw_machine_4_0_class_options(MachineClass *mc)
>  {
> +    /*
> +     * Read Info might reveal more bytes used to detect facilities, thus
> +     * reducing the number of CPU entries. Let's reduce the max CPUs by
> +     * an arbitrary number in effort to anticipate future facility bytes.
> +     */
> +    if ((SCCB_SIZE - sizeof(ReadInfo)) / sizeof(CPUEntry) < S390_MAX_CPUS)
> +        mc->max_cpus = S390_MAX_CPUS - 8;

Maybe this should depend on the presence of this feature in the cpumodel?

>  }
>  DEFINE_CCW_MACHINE(4_0, "4.0", true);
>  
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 4510a80..9cfa188 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -22,6 +22,7 @@
>  #include "hw/s390x/event-facility.h"
>  #include "hw/s390x/s390-pci-bus.h"
>  #include "hw/s390x/ipl.h"
> +#include "kvm_s390x.h"
>  
>  static inline SCLPDevice *get_sclp_device(void)
>  {
> @@ -74,6 +75,10 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
>                           read_info->conf_char_ext);
>  
> +    /* Enable diag318 for guest if KVM supports emulation */
> +    if (kvm_s390_has_diag318())
> +        read_info->fac134 = 0x80;

I think we should rather make this part of the cpumodel


> +
>      read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
>                                          SCLP_HAS_IOA_RECONFIG);
>  
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index f9db243..d47e10a 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -133,6 +133,8 @@ typedef struct ReadInfo {
>      uint16_t highest_cpu;
>      uint8_t  _reserved5[124 - 122];     /* 122-123 */
>      uint32_t hmfai;
> +    uint8_t  _reserved7[134 - 128];     /* 128-133 */
> +    uint8_t  fac134;
>      struct CPUEntry entries[0];
>  } QEMU_PACKED ReadInfo;
>  
> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
> index 0265482..735f5a4 100644
> --- a/linux-headers/asm-s390/kvm.h
> +++ b/linux-headers/asm-s390/kvm.h
> @@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
>  #define KVM_S390_VM_CRYPTO		2
>  #define KVM_S390_VM_CPU_MODEL		3
>  #define KVM_S390_VM_MIGRATION		4
> +#define KVM_S390_VM_MISC		5

Can you split that out into a separate patch (header sync). (We also need the relevant kernel
patch first, I could not find it right now).
>  
>  /* kvm attributes for mem_ctrl */
>  #define KVM_S390_VM_MEM_ENABLE_CMMA	0
> @@ -168,6 +169,9 @@ struct kvm_s390_vm_cpu_subfunc {
>  #define KVM_S390_VM_MIGRATION_START	1
>  #define KVM_S390_VM_MIGRATION_STATUS	2
>  
> +/* kvm attributes for KVM_S390_VM_MISC */
> +#define KVM_S390_VM_MISC_CPC		0
> +
>  /* for KVM_GET_REGS and KVM_SET_REGS */
>  struct kvm_regs {
>  	/* general purpose regs for s390 */
> diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
> index bf7795e..7861ccd 100644
> --- a/target/s390x/kvm-stub.c
> +++ b/target/s390x/kvm-stub.c
> @@ -104,3 +104,18 @@ void kvm_s390_stop_interrupt(S390CPU *cpu)
>  void kvm_s390_restart_interrupt(S390CPU *cpu)
>  {
>  }
> +
> +int kvm_s390_get_cpc(uint64_t *cpc)
> +{
> +    return 0;
> +}
> +
> +int kvm_s390_set_cpc(uint64_t cpc)
> +{
> +    return 0;
> +}
> +
> +bool kvm_s390_has_diag318(void)
> +{
> +    return false;
> +}
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 19530fb..225e516 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -747,6 +747,38 @@ int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
>      return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
> +int kvm_s390_get_cpc(uint64_t *cpc)
> +{
> +    struct kvm_device_attr attr = {
> +        .group = KVM_S390_VM_MISC,
> +        .attr = KVM_S390_VM_MISC_CPC,
> +        .addr = (uint64_t)cpc,
> +    };
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
> +}
> +
> +int kvm_s390_set_cpc(uint64_t cpc)
> +{
> +    struct kvm_device_attr attr = {
> +        .group = KVM_S390_VM_MISC,
> +        .attr = KVM_S390_VM_MISC_CPC,
> +        .addr = (uint64_t)&cpc,
> +    };
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> +}
> +
> +bool kvm_s390_has_diag318(void)
> +{
> +    struct kvm_device_attr attr = {
> +        .group = KVM_S390_VM_MISC,
> +        .attr = KVM_S390_VM_MISC_CPC,
> +    };
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr) == 0;
> +}
> +
>  /**
>   * kvm_s390_mem_op:
>   * @addr:      the logical start address in guest memory
> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
> index 6e52287..53f165f 100644
> --- a/target/s390x/kvm_s390x.h
> +++ b/target/s390x/kvm_s390x.h
> @@ -29,6 +29,9 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
>  int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
>  int kvm_s390_set_clock(uint8_t tod_high, uint64_t tod_clock);
>  int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_clock);
> +int kvm_s390_get_cpc(uint64_t *cpc);
> +int kvm_s390_set_cpc(uint64_t cpc);
> +bool kvm_s390_has_diag318(void);
>  void kvm_s390_enable_css_support(S390CPU *cpu);
>  int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
>                                      int vq, bool assign);
> 


