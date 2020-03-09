Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FFDC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E8420675
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5I6IHCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E8420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBIc1-0003oB-Ed
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jBIbI-0003Cd-1t
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jBIbF-0005zJ-GG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:37:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38206
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jBIbF-0005vQ-Bu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583761057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uS8lxgQt8N6HUT3pBQxdTcfk0fhOiV3bAjD1lXfN8xI=;
 b=i5I6IHCNmJ5IVPGHLPO+FPSDO0vgIRAr65re6+01dklow9H2xVsUq6WuE97EmvYCaLgN9Q
 PezToUaH2toFtFkZECX5R1fj19oOaZriQB6T9P5MTvZd+LcMobFKzieILjwnxZyfKMpi+P
 ppUe6ioffQrfHmf4j27X5mF+SpOLyLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-JMOpwolbNnyCJAQRx3f2yg-1; Mon, 09 Mar 2020 09:37:33 -0400
X-MC-Unique: JMOpwolbNnyCJAQRx3f2yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AA6C101FC68;
 Mon,  9 Mar 2020 13:37:32 +0000 (UTC)
Received: from [10.36.118.226] (unknown [10.36.118.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71D6D5D9C5;
 Mon,  9 Mar 2020 13:37:28 +0000 (UTC)
Subject: Re: [PATCH v7 02/15] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200309112206.20261-1-frankja@linux.ibm.com>
 <20200309112206.20261-3-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <b608f7d8-81ac-1e5b-011d-bd576f77aade@redhat.com>
Date: Mon, 9 Mar 2020 14:37:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309112206.20261-3-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.03.20 12:21, Janosch Frank wrote:
> The unpack facility provides the means to setup a protected guest. A
> protected guest can not be introspected by the hypervisor or any
> user/administrator of the machine it is running on.
>=20
> Protected guests are encrypted at rest and need a special boot
> mechanism via diag308 subcode 8 and 10.
>=20
> Code 8 sets the PV specific IPLB which is retained seperately from
> those set via code 5.
>=20
> Code 10 is used to unpack the VM into protected memory, verify its
> integrity and start it.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
> to machine]

As you signed this patch off, Maybe this should rather be a Co-developed-by=
:

[...]

>  {
>      S390IPLState *ipl =3D get_ipl_device();
> @@ -561,7 +581,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_r=
eset reset_type)
>  {
>      S390IPLState *ipl =3D get_ipl_device();
> =20
> -    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S390_=
RESET_REIPL) {
> +    if (reset_type =3D=3D S390_RESET_EXTERNAL || reset_type =3D=3D S390_=
RESET_REIPL ||
> +        reset_type =3D=3D S390_RESET_PV) {
>          /* use CPU 0 for full resets */
>          ipl->reset_cpu_index =3D 0;

This looks wrong. In case of an error, you modify the registers of a
theoretically unrelated CPU.


>      } else {
> @@ -635,6 +656,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>      cpu_physical_memory_unmap(addr, len, 1, len);
>  }
> =20
> +int s390_ipl_prepare_pv_header(void)
> +{
> +    S390IPLState *ipl =3D get_ipl_device();
> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;
> +    void *hdr =3D g_malloc(ipib_pv->pv_header_len);

Should there be an upper limit? The guest can allocate quite some memory
this way and theoretically crash the VM.

> +    int rc;
> +
> +    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
> +                             ipib_pv->pv_header_len);

Shouldn't we validate if this memory is accessible at all?

> +    rc =3D s390_pv_set_sec_parms((uint64_t)hdr,
> +                          ipib_pv->pv_header_len);
> +    g_free(hdr);
> +    return rc;
> +}
> +
> +int s390_ipl_pv_unpack(void)
> +{
> +    int i, rc =3D 0;

NIT: These declarations last.

> +    S390IPLState *ipl =3D get_ipl_device();
> +    IPLBlockPV *ipib_pv =3D &ipl->iplb_pv.pv;

use s390_ipl_get_iplb_pv() and assert that we don't get NULL?

> +
> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
> +        rc =3D s390_pv_unpack(ipib_pv->components[i].addr,
> +                            TARGET_PAGE_ALIGN(ipib_pv->components[i].siz=
e),
> +                            ipib_pv->components[i].tweak_pref);
> +        if (rc) {
> +            break;
> +        }
> +    }
> +    return rc;
> +}
> +
>  void s390_ipl_prepare_cpu(S390CPU *cpu)
>  {
>      S390IPLState *ipl =3D get_ipl_device();
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index d4813105db..b2ccdd9dae 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -15,6 +15,24 @@
>  #include "cpu.h"
>  #include "hw/qdev-core.h"
> =20
> +struct IPLBlockPVComp {
> +    uint64_t tweak_pref;
> +    uint64_t addr;
> +    uint64_t size;
> +} QEMU_PACKED;
> +typedef struct IPLBlockPVComp IPLBlockPVComp;
> +
> +struct IPLBlockPV {
> +    uint8_t  reserved18[87];    /* 0x18 */
> +    uint8_t  version;           /* 0x6f */
> +    uint32_t reserved70;        /* 0x70 */
> +    uint32_t num_comp;          /* 0x70 */
> +    uint64_t pv_header_addr;    /* 0x74 */
> +    uint64_t pv_header_len;     /* 0x7c */
> +    struct IPLBlockPVComp components[];
> +} QEMU_PACKED;
> +typedef struct IPLBlockPV IPLBlockPV;
> +
>  struct IplBlockCcw {
>      uint8_t  reserved0[85];
>      uint8_t  ssid;
> @@ -71,6 +89,7 @@ union IplParameterBlock {
>          union {
>              IplBlockCcw ccw;
>              IplBlockFcp fcp;
> +            IPLBlockPV pv;
>              IplBlockQemuScsi scsi;
>          };
>      } QEMU_PACKED;
> @@ -85,8 +104,11 @@ typedef union IplParameterBlock IplParameterBlock;
> =20
>  int s390_ipl_set_loadparm(uint8_t *loadparm);
>  void s390_ipl_update_diag308(IplParameterBlock *iplb);
> +int s390_ipl_prepare_pv_header(void);
> +int s390_ipl_pv_unpack(void);
>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>  IplParameterBlock *s390_ipl_get_iplb(void);
> +IplParameterBlock *s390_ipl_get_iplb_pv(void);
> =20
>  enum s390_reset {
>      /* default is a reset not triggered by a CPU e.g. issued by QMP */
> @@ -94,6 +116,7 @@ enum s390_reset {
>      S390_RESET_REIPL,
>      S390_RESET_MODIFIED_CLEAR,
>      S390_RESET_LOAD_NORMAL,
> +    S390_RESET_PV,
>  };
>  void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type);
>  void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_ty=
pe);
> @@ -133,6 +156,7 @@ struct S390IPLState {
>      /*< private >*/
>      DeviceState parent_obj;
>      IplParameterBlock iplb;
> +    IplParameterBlock iplb_pv;
>      QemuIplParameters qipl;
>      uint64_t start_addr;
>      uint64_t compat_start_addr;
> @@ -140,6 +164,7 @@ struct S390IPLState {
>      uint64_t compat_bios_start_addr;
>      bool enforce_bios;
>      bool iplb_valid;
> +    bool iplb_valid_pv;
>      bool netboot;
>      /* reset related properties don't have to be migrated or reset */
>      enum s390_reset reset_type;
> @@ -161,9 +186,11 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3,=
 "alignment of iplb wrong");
> =20
>  #define S390_IPL_TYPE_FCP 0x00
>  #define S390_IPL_TYPE_CCW 0x02
> +#define S390_IPL_TYPE_PV 0x05
>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
> =20
>  #define S390_IPLB_HEADER_LEN 8
> +#define S390_IPLB_MIN_PV_LEN 148
>  #define S390_IPLB_MIN_CCW_LEN 200
>  #define S390_IPLB_MIN_FCP_LEN 384
>  #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
> @@ -173,16 +200,49 @@ static inline bool iplb_valid_len(IplParameterBlock=
 *iplb)
>      return be32_to_cpu(iplb->len) <=3D sizeof(IplParameterBlock);
>  }
> =20
> -static inline bool iplb_valid_ccw(IplParameterBlock *iplb)
> +static inline bool s390_ipl_pv_check_components(IplParameterBlock *iplb)

Still don't like the function name :)

ipl_valid_pv_components() ?

>  {
> -    return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_CCW_LEN &&
> -           iplb->pbt =3D=3D S390_IPL_TYPE_CCW;
> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
> +    int i;
> +
> +    if (ipib_pv->num_comp =3D=3D 0) {
> +        return false;
> +    }
> +
> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
> +        /* Addr must be 4k aligned */
> +        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
> +            return false;
> +        }
> +
> +        /* Tweak prefix is monotonically increasing with each component =
*/
> +        if (i < ipib_pv->num_comp - 1 &&
> +            ipib_pv->components[i].tweak_pref >=3D
> +            ipib_pv->components[i + 1].tweak_pref) {
> +            return false;
> +        }
> +    }
> +    return true;
>  }
> =20
> -static inline bool iplb_valid_fcp(IplParameterBlock *iplb)
> +static inline bool iplb_valid(IplParameterBlock *iplb)
>  {
> -    return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_FCP_LEN &&
> -           iplb->pbt =3D=3D S390_IPL_TYPE_FCP;
> +    switch (iplb->pbt) {
> +        case S390_IPL_TYPE_FCP:
> +            return (be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_FCP_LEN &&
> +                    iplb->pbt =3D=3D S390_IPL_TYPE_FCP);
> +        case S390_IPL_TYPE_CCW:
> +            return (be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_CCW_LEN &&
> +                    iplb->pbt =3D=3D S390_IPL_TYPE_CCW);

That's a refactoring you could have split out.

> +        case S390_IPL_TYPE_PV:
> +            if(be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN ||
> +               iplb->pbt !=3D S390_IPL_TYPE_PV) {
> +                return false;
> +            }
> +            return s390_ipl_pv_check_components(iplb);
> +    default:
> +        return false;
> +    }
>  }
> =20
>  #endif
> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> new file mode 100644
> index 0000000000..ba6409246e
> --- /dev/null
> +++ b/hw/s390x/pv.c
> @@ -0,0 +1,104 @@
> +/*
> + * Secure execution functions
> + *
> + * Copyright IBM Corp. 2020
> + * Author(s):
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +#include "qemu/osdep.h"
> +
> +#include <linux/kvm.h>
> +
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +#include "pv.h"
> +
> +const char *cmd_names[] =3D {
> +    "VM_ENABLE",
> +    "VM_DISABLE",
> +    "VM_SET_SEC_PARAMS",
> +    "VM_UNPACK",
> +    "VM_VERIFY",
> +    "VM_PREP_RESET",
> +    "VM_UNSHARE_ALL",
> +};
> +
> +static int s390_pv_cmd(uint32_t cmd, void *data)
> +{
> +    int rc;
> +    struct kvm_pv_cmd pv_cmd =3D {
> +        .cmd =3D cmd,
> +        .data =3D (uint64_t)data,
> +    };
> +
> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
> +    if (rc) {
> +        error_report("KVM PV command %d (%s) failed: header rc %x rrc %x=
 "
> +                     "IOCTL rc: %d", cmd, cmd_names[cmd], pv_cmd.rc, pv_=
cmd.rrc,
> +                     rc);
> +    }
> +    return rc;
> +}
> +
> +static void s390_pv_cmd_exit(uint32_t cmd, void *data)
> +{
> +    int rc;
> +
> +    rc =3D s390_pv_cmd(cmd, data);
> +    if (rc) {
> +        exit(1);
> +    }
> +}
> +
> +int s390_pv_vm_enable(void)
> +{
> +    return s390_pv_cmd(KVM_PV_ENABLE, NULL);
> +}
> +
> +void s390_pv_vm_disable(void)
> +{
> +     s390_pv_cmd_exit(KVM_PV_DISABLE, NULL);
> +}
> +
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
> +{
> +    struct kvm_s390_pv_sec_parm args =3D {
> +        .origin =3D origin,
> +        .length =3D length,
> +    };
> +
> +    return s390_pv_cmd(KVM_PV_VM_SET_SEC_PARMS, &args);
> +}
> +
> +/*
> + * Called for each component in the SE type IPL parameter block 0.
> + */
> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
> +{
> +    struct kvm_s390_pv_unp args =3D {
> +        .addr =3D addr,
> +        .size =3D size,
> +        .tweak =3D tweak,
> +    };
> +
> +    return s390_pv_cmd(KVM_PV_VM_UNPACK, &args);
> +}
> +
> +void s390_pv_perf_clear_reset(void)
> +{
> +    s390_pv_cmd_exit(KVM_PV_VM_PREP_RESET, NULL);
> +}
> +
> +int s390_pv_verify(void)
> +{
> +    return s390_pv_cmd(KVM_PV_VM_VERIFY, NULL);
> +}
> +
> +void s390_pv_unshare(void)
> +{
> +    s390_pv_cmd_exit(KVM_PV_VM_UNSHARE_ALL, NULL);
> +}
> diff --git a/hw/s390x/pv.h b/hw/s390x/pv.h
> new file mode 100644
> index 0000000000..e58fbca96a
> --- /dev/null
> +++ b/hw/s390x/pv.h
> @@ -0,0 +1,34 @@
> +/*
> + * Protected Virtualization header
> + *
> + * Copyright IBM Corp. 2020
> + * Author(s):
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef HW_S390_PV_H
> +#define HW_S390_PV_H
> +
> +#ifdef CONFIG_KVM
> +int s390_pv_vm_enable(void);
> +void s390_pv_vm_disable(void);
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
> +void s390_pv_perf_clear_reset(void);
> +int s390_pv_verify(void);
> +void s390_pv_unshare(void);
> +#else
> +static inline int s390_pv_vm_enable(void) { return 0; }
> +static inline void s390_pv_vm_disable(void) {}
> +static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t length=
) { return 0; }
> +static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t =
tweak) { return 0; }
> +static inline void s390_pv_perf_clear_reset(void) {}
> +static inline int s390_pv_verify(void) { return 0; }
> +static inline void s390_pv_unshare(void) {}
> +#endif
> +
> +#endif /* HW_S390_PV_H */
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index a89cf4c129..f718cfc591 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -41,6 +41,8 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/s390x/tod.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/s390x/pv.h"
> +#include <linux/kvm.h>
> =20
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -238,9 +240,11 @@ static void s390_create_sclpconsole(const char *type=
, Chardev *chardev)
>  static void ccw_init(MachineState *machine)
>  {
>      int ret;
> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(machine);
>      VirtualCssBus *css_bus;
>      DeviceState *dev;
> =20
> +    ms->pv =3D false;
>      s390_sclp_init();
>      /* init memory + setup max page size. Required for the CPU model */
>      s390_memory_init(machine->ram);
> @@ -316,10 +320,90 @@ static inline void s390_do_cpu_ipl(CPUState *cs, ru=
n_on_cpu_data arg)
>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>  }
> =20
> +static void s390_machine_unprotect(S390CcwMachineState *ms)
> +{
> +    CPUState *t;
> +
> +    if (ms->pv) {

This is always the case. The check for ms->pv dropped (and if other
patches require this, it is to be handled in the caller).

> +        s390_pv_vm_disable();
> +        CPU_FOREACH(t) {
> +            S390_CPU(t)->env.pv =3D false;
> +        }
> +        ms->pv =3D false;
> +    }
> +}
> +
> +static int s390_machine_protect(S390CcwMachineState *ms)
> +{
> +    CPUState *t;
> +    int rc;
> +
> +    /* Create SE VM */
> +    rc =3D s390_pv_vm_enable();
> +    if (rc) {
> +        return rc;
> +    }
> +
> +    CPU_FOREACH(t) {
> +        S390_CPU(t)->env.pv =3D true;
> +    }
> +    ms->pv =3D true;
> +
> +    /* Set SE header and unpack */
> +    rc =3D s390_ipl_prepare_pv_header();
> +    if (rc) {
> +        goto out_err;
> +    }
> +
> +    /* Decrypt image */
> +    rc =3D s390_ipl_pv_unpack();
> +    if (rc) {
> +        goto out_err;
> +    }
> +
> +    /* Verify integrity */
> +    rc =3D s390_pv_verify();
> +    if (rc) {
> +        goto out_err;
> +    }
> +    return rc;
> +
> +out_err:
> +    s390_machine_unprotect(ms);
> +    return rc;
> +}
> +
> +#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
> +static void s390_machine_inject_pv_error(CPUState *cs)
> +{
> +    int r1 =3D (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
> +    CPUS390XState *env =3D &S390_CPU(cs)->env;
> +
> +    /* Report that we are unable to enter protected mode */
> +    env->regs[r1 + 1] =3D DIAG_308_RC_INVAL_FOR_PV;
> +}
> +
> +static void s390_pv_prepare_reset(CPUS390XState *env)
> +{
> +    CPUState *cs;
> +
> +    if (!env->pv) {
> +        return;
> +    }
> +    CPU_FOREACH(cs) {
> +        s390_cpu_set_state(S390_CPU_STATE_STOPPED, S390_CPU(cs));
> +    }

This is done by the CPU reset in all cases? Why is that needed? (->comment)

> +    s390_pv_unshare();
> +    s390_pv_perf_clear_reset();
> +}
> +
>  static void s390_machine_reset(MachineState *machine)
>  {
>      enum s390_reset reset_type;
>      CPUState *cs, *t;
> +    S390CPU *cpu;
> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(machine);

Nit: Move this to the very top.

> +    CPUS390XState *env;
> =20
>      /* get the reset parameters, reset them once done */
>      s390_ipl_get_reset_request(&cs, &reset_type);
> @@ -327,9 +411,16 @@ static void s390_machine_reset(MachineState *machine=
)
>      /* all CPUs are paused and synchronized at this point */
>      s390_cmma_reset();
> =20
> +    cpu =3D S390_CPU(cs);
> +    env =3D &cpu->env;

Can you just pass "cpu" to s390_pv_prepare_reset() and handle it in there?

> +
>      switch (reset_type) {
>      case S390_RESET_EXTERNAL:
>      case S390_RESET_REIPL:
> +        if (ms->pv) {
> +            s390_machine_unprotect(ms);
> +        }
> +
>          qemu_devices_reset();
>          s390_crypto_reset();
> =20
> @@ -337,22 +428,52 @@ static void s390_machine_reset(MachineState *machin=
e)
>          run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
>          break;
>      case S390_RESET_MODIFIED_CLEAR:
> +        /*
> +         * Susbsystem reset needs to be done before we unshare memory
> +         * and loose access to VIRTIO structures in guest memory.
> +         */
> +        subsystem_reset();
> +        s390_crypto_reset();
> +        s390_pv_prepare_reset(env);
>          CPU_FOREACH(t) {
>              run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
>          }
> -        subsystem_reset();
> -        s390_crypto_reset();
>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>          break;
>      case S390_RESET_LOAD_NORMAL:
> +        /*
> +         * Susbsystem reset needs to be done before we unshare memory
> +         * and loose access to VIRTIO structures in guest memory.
> +         */
> +        subsystem_reset();
> +        s390_pv_prepare_reset(env);
>          CPU_FOREACH(t) {
>              if (t =3D=3D cs) {
>                  continue;
>              }
>              run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>          }
> -        subsystem_reset();
>          run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
> +        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
> +        break;
> +    case S390_RESET_PV: /* Subcode 10 */
> +        subsystem_reset();
> +        s390_crypto_reset();
> +
> +        CPU_FOREACH(t) {
> +            if (t =3D=3D cs) {
> +                continue;
> +            }
> +            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
> +        }
> +        run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
> +
> +        if (s390_machine_protect(ms)) {
> +            s390_machine_inject_pv_error(cs);
> +            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> +            return;
> +        }
> +
>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);

[...]

> =20
> +#if !defined(CONFIG_USER_ONLY)
> +static bool machine_is_pv(MachineState *ms)
> +{
> +    Object *obj;
> +
> +    /* we have to bail out for the "none" machine */
> +    obj =3D object_dynamic_cast(OBJECT(ms), TYPE_S390_CCW_MACHINE);
> +     if (!obj) {
> +        return false;
> +    }
> +    return S390_CCW_MACHINE(obj)->pv;

Maybe you want to cache the machine, so you can avoid the
lookup+conversion on every new CPU.

> +}
> +#endif

[...]
>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t =
addr,
>                                uintptr_t ra, bool write)
>  {
> +    /* Handled by the Ultravisor */
> +    if (env->pv) {
> +        return 0;
> +    }
>      if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return -1;
> @@ -93,6 +101,11 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1,=
 uint64_t r3, uintptr_t ra)
>          return;
>      }
> =20
> +    if (subcode > 7 && !s390_has_feat(S390_FEAT_UNPACK)) {

>=3D DIAG308_PV_SET

> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +


--=20
Thanks,

David / dhildenb


