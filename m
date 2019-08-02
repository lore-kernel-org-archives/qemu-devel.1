Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D208C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F4F20679
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F4F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXyP-00029S-Af
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57051)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <borntraeger@de.ibm.com>) id 1htXxU-0001IZ-3s
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1htXxS-0008PK-CX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:51:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8478
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1htXxS-0008Mu-82
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:50:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x72Dkbl2047690
 for <qemu-devel@nongnu.org>; Fri, 2 Aug 2019 09:50:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u4ntysk9t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:50:54 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Fri, 2 Aug 2019 14:50:52 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 2 Aug 2019 14:50:48 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x72DoU8Y22479260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Aug 2019 13:50:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B68C352051;
 Fri,  2 Aug 2019 13:50:47 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.71])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7459F52054;
 Fri,  2 Aug 2019 13:50:47 +0000 (GMT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20190802133241.29298-1-imammedo@redhat.com>
 <20190802133241.29298-2-imammedo@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date: Fri, 2 Aug 2019 15:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802133241.29298-2-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19080213-0020-0000-0000-00000359C0A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080213-0021-0000-0000-000021ADD52A
Message-Id: <bebd2a66-cd60-93a7-a937-18e03c47edff@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-02_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020142
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x72Dkbl2047690
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH for-4.2 v3 1/2] kvm: s390: split too big
 memory section on several memslots
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
Cc: pbonzini@redhat.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 thuth@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 02.08.19 15:32, Igor Mammedov wrote:
> Max memslot size supported by kvm on s390 is 8Tb,
> move logic of splitting RAM in chunks upto 8T to KVM code.
>=20
> This way it will hide KVM specific restrictions in KVM code
> and won't affect baord level design decisions. Which would allow
> us to avoid misusing memory_region_allocate_system_memory() API
> and eventually use a single hostmem backend for guest RAM.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> patch prepares only KVM side for switching to single RAM memory region
> another patch will take care of  dropping manual RAM partitioning in
> s390 code.
> ---


/home/cborntra/REPOS/qemu/target/s390x/kvm.c: In function =E2=80=98kvm_ar=
ch_init=E2=80=99:
/home/cborntra/REPOS/qemu/target/s390x/kvm.c:350:5: error: implicit decla=
ration of function =E2=80=98kvm_set_max_memslot_size=E2=80=99; did you me=
an =E2=80=98kvm_get_max_memslots=E2=80=99? [-Werror=3Dimplicit-function-d=
eclaration]
  350 |     kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
      |     kvm_get_max_memslots
/home/cborntra/REPOS/qemu/target/s390x/kvm.c:350:5: error: nested extern =
declaration of =E2=80=98kvm_set_max_memslot_size=E2=80=99 [-Werror=3Dnest=
ed-externs]
cc1: all warnings being treated as errors
make[1]: *** [/home/cborntra/REPOS/qemu/rules.mak:69: target/s390x/kvm.o]=
 Error 1
make: *** [Makefile:472: s390x-softmmu/all] Error 2


We probably need an include of sysemu/kvm_int.h in target/s390x/kvm.c
I will test with that fixup....

>  include/hw/s390x/s390-virtio-ccw.h | 10 ++++
>  include/sysemu/kvm_int.h           |  1 +
>  accel/kvm/kvm-all.c                | 79 ++++++++++++++++++------------
>  hw/s390x/s390-virtio-ccw.c         |  9 ----
>  target/s390x/kvm.c                 |  1 +
>  5 files changed, 60 insertions(+), 40 deletions(-)
>=20
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390=
-virtio-ccw.h
> index 8aa27199c9..00632f94b4 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -21,6 +21,16 @@
>  #define S390_MACHINE_CLASS(klass) \
>      OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MAC=
HINE)
> =20
> +/*
> + * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
> + * as the dirty bitmap must be managed by bitops that take an int as
> + * position indicator. If we have a guest beyond that we will split of=
f
> + * new subregions. The split must happen on a segment boundary (1MB).
> + */
> +#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
> +#define SEG_MSK (~0xfffffULL)
> +#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) =
& SEG_MSK)
> +
>  typedef struct S390CcwMachineState {
>      /*< private >*/
>      MachineState parent_obj;
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 31df465fdc..7f7520bce2 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -41,4 +41,5 @@ typedef struct KVMMemoryListener {
>  void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
>                                    AddressSpace *as, int as_id);
> =20
> +void kvm_set_max_memslot_size(hwaddr max_slot_size);
>  #endif
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f450f25295..7a6efb9612 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -138,6 +138,7 @@ bool kvm_direct_msi_allowed;
>  bool kvm_ioeventfd_any_length_allowed;
>  bool kvm_msi_use_devid;
>  static bool kvm_immediate_exit;
> +static hwaddr kvm_max_slot_size =3D ~0;
> =20
>  static const KVMCapabilityInfo kvm_required_capabilites[] =3D {
>      KVM_CAP_INFO(USER_MEMORY),
> @@ -951,6 +952,14 @@ kvm_check_extension_list(KVMState *s, const KVMCap=
abilityInfo *list)
>      return NULL;
>  }
> =20
> +void kvm_set_max_memslot_size(hwaddr max_slot_size)
> +{
> +    g_assert(
> +        ROUND_UP(max_slot_size, qemu_real_host_page_size) =3D=3D max_s=
lot_size
> +    );
> +    kvm_max_slot_size =3D max_slot_size;
> +}
> +
>  static void kvm_set_phys_mem(KVMMemoryListener *kml,
>                               MemoryRegionSection *section, bool add)
>  {
> @@ -958,7 +967,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml=
,
>      int err;
>      MemoryRegion *mr =3D section->mr;
>      bool writeable =3D !mr->readonly && !mr->rom_device;
> -    hwaddr start_addr, size;
> +    hwaddr start_addr, size, slot_size;
>      void *ram;
> =20
>      if (!memory_region_is_ram(mr)) {
> @@ -983,41 +992,49 @@ static void kvm_set_phys_mem(KVMMemoryListener *k=
ml,
>      kvm_slots_lock(kml);
> =20
>      if (!add) {
> -        mem =3D kvm_lookup_matching_slot(kml, start_addr, size);
> -        if (!mem) {
> -            goto out;
> -        }
> -        if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> -            kvm_physical_sync_dirty_bitmap(kml, section);
> -        }
> +        do {
> +            slot_size =3D kvm_max_slot_size < size ? kvm_max_slot_size=
 : size;
> +            mem =3D kvm_lookup_matching_slot(kml, start_addr, slot_siz=
e);
> +            if (!mem) {
> +                goto out;
> +            }
> +            if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> +                kvm_physical_sync_dirty_bitmap(kml, section);
> +            }
> =20
> -        /* unregister the slot */
> -        g_free(mem->dirty_bmap);
> -        mem->dirty_bmap =3D NULL;
> -        mem->memory_size =3D 0;
> -        mem->flags =3D 0;
> -        err =3D kvm_set_user_memory_region(kml, mem, false);
> -        if (err) {
> -            fprintf(stderr, "%s: error unregistering slot: %s\n",
> -                    __func__, strerror(-err));
> -            abort();
> -        }
> +            /* unregister the slot */
> +            g_free(mem->dirty_bmap);
> +            mem->dirty_bmap =3D NULL;
> +            mem->memory_size =3D 0;
> +            mem->flags =3D 0;
> +            err =3D kvm_set_user_memory_region(kml, mem, false);
> +            if (err) {
> +                fprintf(stderr, "%s: error unregistering slot: %s\n",
> +                        __func__, strerror(-err));
> +                abort();
> +            }
> +            start_addr +=3D slot_size;
> +        } while ((size -=3D slot_size));
>          goto out;
>      }
> =20
>      /* register the new slot */
> -    mem =3D kvm_alloc_slot(kml);
> -    mem->memory_size =3D size;
> -    mem->start_addr =3D start_addr;
> -    mem->ram =3D ram;
> -    mem->flags =3D kvm_mem_flags(mr);
> -
> -    err =3D kvm_set_user_memory_region(kml, mem, true);
> -    if (err) {
> -        fprintf(stderr, "%s: error registering slot: %s\n", __func__,
> -                strerror(-err));
> -        abort();
> -    }
> +    do {
> +        slot_size =3D kvm_max_slot_size < size ? kvm_max_slot_size : s=
ize;
> +        mem =3D kvm_alloc_slot(kml);
> +        mem->memory_size =3D slot_size;
> +        mem->start_addr =3D start_addr;
> +        mem->ram =3D ram;
> +        mem->flags =3D kvm_mem_flags(mr);
> +
> +        err =3D kvm_set_user_memory_region(kml, mem, true);
> +        if (err) {
> +            fprintf(stderr, "%s: error registering slot: %s\n", __func=
__,
> +                    strerror(-err));
> +            abort();
> +        }
> +        start_addr +=3D slot_size;
> +    } while ((size -=3D slot_size));
> =20
>  out:
>      kvm_slots_unlock(kml);
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 5b6a9a4e55..0c03ffb7c7 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -151,15 +151,6 @@ static void virtio_ccw_register_hcalls(void)
>                                     virtio_ccw_hcall_early_printk);
>  }
> =20
> -/*
> - * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
> - * as the dirty bitmap must be managed by bitops that take an int as
> - * position indicator. If we have a guest beyond that we will split of=
f
> - * new subregions. The split must happen on a segment boundary (1MB).
> - */
> -#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
> -#define SEG_MSK (~0xfffffULL)
> -#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) =
& SEG_MSK)
>  static void s390_memory_init(ram_addr_t mem_size)
>  {
>      MemoryRegion *sysmem =3D get_system_memory();
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 6e814c230b..d0267da8e1 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -347,6 +347,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       */
>      /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
> =20
> +    kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
>      return 0;
>  }
> =20
>=20


