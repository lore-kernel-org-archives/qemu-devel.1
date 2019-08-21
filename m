Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D2C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 19:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF35E22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 19:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF35E22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0WQE-0006xU-5F
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 15:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i0WPD-00064r-1p
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i0WPA-00006i-Ji
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:36:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i0WPA-00005r-Ah; Wed, 21 Aug 2019 15:36:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5951C8980EA;
 Wed, 21 Aug 2019 19:36:23 +0000 (UTC)
Received: from [10.36.118.29] (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78449194B2;
 Wed, 21 Aug 2019 19:36:21 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190821092252.26541-1-david@redhat.com>
 <20190821092252.26541-3-david@redhat.com>
 <dc42887a-f991-1fe0-36a7-a7804bc4a939@linaro.org>
 <60d60d82-0407-9549-09b8-ff35218a4e71@redhat.com>
 <8973f904-c171-bcdd-3f6e-5e18cb37035c@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <1c0c597d-c851-4116-184e-6b35fae08011@redhat.com>
Date: Wed, 21 Aug 2019 21:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8973f904-c171-bcdd-3f6e-5e18cb37035c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 21 Aug 2019 19:36:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 2/4] s390x/tcg: Introduce
 probe_read_access()
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21.08.19 21:19, Richard Henderson wrote:
> On 8/21/19 10:37 AM, David Hildenbrand wrote:
>> Hah, guess what, I implemented a similar variant of "fetch all
>> of the host addresses" *but* it is not that easy as you might
>> think (sorry for the bad news).
>=20
> I think it is, because I didn't think it *that* easy.  :-)

:) hehe

>=20
>> There are certain cases where we can't get access to the raw host
>> page. Namely, cpu watchpoints, LAP, NODIRTY. In summary: this won't
>> as you describe. (my first approach did exactly this)
>=20
> NODIRTY and LAP are automatically handled via probe_write
> faulting instead of returning the address.  I think there
> may be a bug in probe_write at present not checking

For LAP pages we immediately set TLB_INVALID_MASK again, to trigger a
new fault on the next write access (only). The could be handled in
tlb_vaddr_to_host(), simply returning the address to the page after
trying to fill the tlb and succeeding (I implemented that, that's the
easy part).

TLB_NOTDIRTY and TLB_MMIO are the real issue. We don't want to refault,
we want to treat that memory like IO memory and route it via
MemoryRegionOps() - e.g., watch_mem_ops() in qemu/exec.c. So it's not a
fault but IO memory.

That's why we don't expose that memory via tlb_vaddr_to_host(). Faulting
in case of TLB_NOTDIRTY or TLB_MMIO would be bad.

>=20
> Watchpoints could be handled the same way, if we were to
> export check_watchpoint from exec.c.  Indeed, I see no way
> to handle watchpoints correctly if we don't.  I think that's
> an outstanding bug with probe_write.

probe_write() performs the MMU translation. If that succeeds, there is
no fault. If there are watchpoints, the memory is treated like IO and
memory access is rerouted. I think this works as designed.

>=20
> Any other objections?  I certainly think that restricting the
> size of such operations to one page is a large simplification
> over the S390Access array thing that you create in this patch.

You mean two pages I assume. Yeah, I could certainly simplify the
prototype patch I have here quite a lot. 2 pages should be enough for
everybody ;)

The basic question is: Should we try to somehow work around IO memory
access (including NOTDIRTY and watchpoints) in tlb_vaddr_to_host() or
perform access in these cases via cpu_physical_memory_write() ?

It feels somewhat wrong to me to tune tlb_vaddr_to_host() to always
return the address of a page although we are dealing with
MemoryRegionOps()  that want a more controlled access mechanism.

>=20
>=20
> r~
>=20
>>
>> The following patch requires another re-factoring
>> (tcg_s390_cpu_mmu_translate), but you should get the idea.
>>
>>
>>
>> From 0cacd2aea3dbc25e93492cca04f6c866b86d7f8a Mon Sep 17 00:00:00 2001
>> From: David Hildenbrand <david@redhat.com>
>> Date: Tue, 20 Aug 2019 09:37:11 +0200
>> Subject: [PATCH v1] s390x/tcg: Fault-safe MVC (MOVE) implementation
>>
>> MVC can cross page boundaries. In case we fault on the second page, we
>> already partially copied data. If we have overlaps, we would
>> trigger a fault after having partially moved data, eventually having
>> our original data already overwritten. When continuing after the fault=
,
>> we would try to move already modified data, not the original data -
>> very bad.
>>
>> glibc started to use MVC for forward memmove() and is able to trigger
>> exectly this corruption (via rpmbuild and rpm). Fedora 31 (rawhide)
>> currently fails to install as we trigger rpm database corruptions due =
to
>> this bug.
>>
>> We need a way to translate a virtual address range to individual pages=
 that
>> we can access later on without triggering faults. Probing all virtual
>> addresses once before the read/write is not sufficient - the guest cou=
ld
>> have modified the page tables (e.g., write-protect, map out) in betwee=
n,
>> so on we could fault on any new tlb_fill() - we have to skip any new M=
MU
>> translations.
>>
>> Unfortunately, there are TLB entries for which cannot get a host addre=
ss
>> for (esp., watchpoints, LAP, NOTDIRTY) - in these cases we cannot avoi=
d
>> a new MMU translation using the ordinary ld/st helpers. Let's fallback
>> to guest physical addresses in these cases, that we access via
>> cpu_physical_memory_(read|write),
>>
>> This change reduced the boottime for s390x guests (to prompt) from ~1:=
29
>> min to ~1:19 min in my tests. For example, LAP protected pages are now=
 only
>> translated once when writing to them using MVC and we don't always fal=
lback
>> to byte-based copies.
>>
>> We will want to use the same mechanism for other accesses as well (e.g=
.,
>> mvcl), prepare for that right away.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/mem_helper.c | 213 +++++++++++++++++++++++++++++++++++--=
-
>>  1 file changed, 200 insertions(+), 13 deletions(-)
>>
>> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
>> index 91ba2e03d9..1ca293e00d 100644
>> --- a/target/s390x/mem_helper.c
>> +++ b/target/s390x/mem_helper.c
>> @@ -24,8 +24,10 @@
>>  #include "exec/helper-proto.h"
>>  #include "exec/exec-all.h"
>>  #include "exec/cpu_ldst.h"
>> +#include "exec/cpu-common.h"
>>  #include "qemu/int128.h"
>>  #include "qemu/atomic128.h"
>> +#include "tcg_s390x.h"
>> =20
>>  #if !defined(CONFIG_USER_ONLY)
>>  #include "hw/s390x/storage-keys.h"
>> @@ -104,6 +106,181 @@ static inline void cpu_stsize_data_ra(CPUS390XSt=
ate *env, uint64_t addr,
>>      }
>>  }
>> =20
>> +/*
>> + * An access covers one page, except for the start/end of the transla=
ted
>> + * virtual address range.
>> + */
>> +typedef struct S390Access {
>> +    union {
>> +        char *haddr;
>> +        hwaddr paddr;
>> +    };
>> +    uint16_t size;
>> +    bool isHaddr;
>> +} S390Access;
>> +
>> +/*
>> + * Prepare access to a virtual address range, guaranteeing we won't t=
rigger
>> + * faults during the actual access. Sometimes we can't get access to =
the
>> + * host address (e.g., LAP, cpu watchpoints/PER, clean pages, ...). T=
hen, we
>> + * translate to guest physical addresses instead. We'll have to perfo=
rm
>> + * slower, indirect, access to these physical addresses then.
>> + */
>> +static void access_prepare_idx(CPUS390XState *env, S390Access access[=
],
>> +                               int nb_access, vaddr vaddr, target_ulo=
ng size,
>> +                               MMUAccessType access_type, int mmu_idx=
,
>> +                               uintptr_t ra)
>> +{
>> +    int i =3D 0;
>> +    int cur_size;
>> +
>> +    /*
>> +     * After we obtained the host address of a TLB entry that entry m=
ight
>> +     * be invalidated again - e.g., via tlb_set_dirty(), via another
>> +     * tlb_fill(). We assume here that it is fine to temporarily stor=
e the
>> +     * host address to access it later - we didn't agree to any tlb f=
lush and
>> +     * there seems to be no mechanism protecting the return value of
>> +     * tlb_vaddr_to_host().
>> +     */
>> +    while (size) {
>> +        g_assert(i < nb_access);
>> +        cur_size =3D adj_len_to_page(size, vaddr);
>> +
>> +        access[i].isHaddr =3D true;
>> +        access[i].haddr =3D tlb_vaddr_to_host(env, vaddr, access_type=
, mmu_idx);
>> +        if (!access[i].haddr) {
>> +            access[i].isHaddr =3D false;
>> +            tcg_s390_cpu_mmu_translate(env, vaddr, cur_size, access_t=
ype,
>> +                                       mmu_idx, false, &access[i].pad=
dr,
>> +                                       NULL, ra);
>> +        }
>> +        access[i].size =3D cur_size;
>> +
>> +        vaddr +=3D cur_size;
>> +        size -=3D cur_size;
>> +        i++;
>> +    }
>> +
>> +    /* let's zero-out the remaining entries, so we have a size of 0 *=
/
>> +    if (i < nb_access) {
>> +        memset(&access[i], 0 , sizeof(S390Access) * (nb_access - i));
>> +    }
>> +}
>> +
>> +static void access_prepare(CPUS390XState *env, S390Access access[],
>> +                           int nb_access, target_ulong vaddr, target_=
ulong size,
>> +                           MMUAccessType access_type, uintptr_t ra)
>> +{
>> +    int mmu_idx =3D cpu_mmu_index(env, false);
>> +
>> +    access_prepare_idx(env, access, nb_access, vaddr, size, access_ty=
pe,
>> +                       mmu_idx, ra);
>> +}
>> +
>> +static void access_set(CPUS390XState *env, S390Access write[], int nb=
_write,
>> +                       uint8_t byte, target_ulong size)
>> +{
>> +    target_ulong cur_size;
>> +    void *buf =3D NULL;
>> +    int w =3D 0;
>> +
>> +    while (size) {
>> +        g_assert(w < nb_write);
>> +        if (!write[w].size) {
>> +            w++;
>> +            continue;
>> +        }
>> +
>> +        cur_size =3D MIN(size, write[w].size);
>> +        if (write[w].isHaddr) {
>> +            memset(write[w].haddr, byte, cur_size);
>> +            write[w].haddr +=3D cur_size;
>> +        } else {
>> +#ifndef CONFIG_USER_ONLY
>> +            if (!buf) {
>> +                buf =3D g_malloc(TARGET_PAGE_SIZE);
>> +                memset(buf, byte, cur_size);
>> +            }
>> +            cpu_physical_memory_write(write[w].paddr, buf, cur_size);
>> +            write[w].paddr +=3D cur_size;
>> +#else
>> +            g_assert_not_reached();
>> +#endif
>> +        }
>> +        write[w].size -=3D cur_size;
>> +        size -=3D cur_size;
>> +    }
>> +    g_free(buf);
>> +}
>> +
>> +/*
>> + * Copy memory in chunks up to chunk_size. If the ranges don't overla=
p or
>> + * if it's a forward move, this function behaves like memmove().
>> + *
>> + * To achieve a backwards byte-by-byte copy (e.g., MVC), the chunk_si=
ze
>> + * must not be bigger than the address difference (in the worst case,=
 1 byte).
>> + */
>> +static void access_copy(CPUS390XState *env, S390Access write[], int n=
b_write,
>> +                        S390Access read[], int nb_read, target_ulong =
size,
>> +                        target_ulong chunk_size)
>> +{
>> +    target_ulong cur_size;
>> +    void *buf =3D NULL;
>> +    int r =3D 0;
>> +    int w =3D 0;
>> +
>> +    g_assert(chunk_size > 0);
>> +    chunk_size =3D MIN(chunk_size, TARGET_PAGE_SIZE);
>> +
>> +    while (size) {
>> +        g_assert(w < nb_write);
>> +        g_assert(r < nb_read);
>> +        if (!write[w].size) {
>> +            w++;
>> +            continue;
>> +        }
>> +        if (!read[r].size) {
>> +            r++;
>> +            continue;
>> +        }
>> +        cur_size =3D MIN(MIN(MIN(size, write[w].size), read[r].size),=
 chunk_size);
>> +
>> +        if (write[w].isHaddr && read[r].isHaddr) {
>> +            memmove(write[w].haddr, read[r].haddr,
>> +                    cur_size);
>> +            write[w].haddr +=3D cur_size;
>> +            read[r].haddr +=3D cur_size;
>> +#ifndef CONFIG_USER_ONLY
>> +        } else if (!write[w].isHaddr && read[r].isHaddr) {
>> +            cpu_physical_memory_write(write[w].paddr,
>> +                                      read[r].haddr, cur_size);
>> +            write[w].paddr +=3D cur_size;
>> +            read[r].haddr +=3D cur_size;
>> +        } else if (write[w].isHaddr && !read[r].isHaddr) {
>> +            cpu_physical_memory_read(read[r].paddr,
>> +                                     write[w].haddr, cur_size);
>> +            write[w].haddr +=3D cur_size;
>> +            read[r].paddr +=3D cur_size;
>> +        } else {
>> +            if (!buf) {
>> +                buf =3D g_malloc(chunk_size);
>> +            }
>> +            cpu_physical_memory_read(read[r].paddr, buf, cur_size);
>> +            cpu_physical_memory_write(write[w].paddr, buf, cur_size);
>> +            write[w].paddr +=3D cur_size;
>> +            read[r].paddr +=3D cur_size;
>> +#else
>> +        } else {
>> +            g_assert_not_reached();
>> +#endif
>> +        }
>> +        write[w].size -=3D cur_size;
>> +        read[r].size -=3D cur_size;
>> +        size -=3D cur_size;
>> +    }
>> +    g_free(buf);
>> +}
>> +
>>  static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t by=
te,
>>                          uint32_t l, uintptr_t ra)
>>  {
>> @@ -302,24 +479,34 @@ uint32_t HELPER(oc)(CPUS390XState *env, uint32_t=
 l, uint64_t dest,
>>  static uint32_t do_helper_mvc(CPUS390XState *env, uint32_t l, uint64_=
t dest,
>>                                uint64_t src, uintptr_t ra)
>>  {
>> -    uint32_t i;
>> +    /* 256 bytes cannot cross more than two pages */
>> +    S390Access read[2];
>> +    S390Access write[2];
>> =20
>>      HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
>>                 __func__, l, dest, src);
>> +    l++;
>> =20
>> -    /* mvc and memmove do not behave the same when areas overlap! */
>> -    /* mvc with source pointing to the byte after the destination is =
the
>> -       same as memset with the first source byte */
>> +    g_assert(l <=3D 256);
>> +    access_prepare(env, write, ARRAY_SIZE(write), dest, l, MMU_DATA_S=
TORE, ra);
>> +
>> +    /*
>> +     * The result of MVC is as if moving single bytes from left to ri=
ght
>> +     * (in contrast to memmove()). It can be used like memset().
>> +     */
>>      if (dest =3D=3D src + 1) {
>> -        fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l + 1,=
 ra);
>> -    } else if (dest < src || src + l < dest) {
>> -        fast_memmove(env, dest, src, l + 1, ra);
>> -    } else {
>> -        /* slow version with byte accesses which always work */
>> -        for (i =3D 0; i <=3D l; i++) {
>> -            uint8_t x =3D cpu_ldub_data_ra(env, src + i, ra);
>> -            cpu_stb_data_ra(env, dest + i, x, ra);
>> -        }
>> +        access_set(env, write, ARRAY_SIZE(write),
>> +                   cpu_ldub_data_ra(env, src, ra), l);
>> +        return env->cc_op;
>> +    }
>> +
>> +    access_prepare(env, read, ARRAY_SIZE(read), src, l, MMU_DATA_LOAD=
, ra);
>> +    if (dest < src || src + l <=3D dest) {
>> +        access_copy(env, write, ARRAY_SIZE(write), read, ARRAY_SIZE(r=
ead), l,
>> +                    TARGET_PAGE_SIZE);
>> +    } else if (src < dest) {
>> +        access_copy(env, write, ARRAY_SIZE(write), read, ARRAY_SIZE(r=
ead), l,
>> +                    dest - src);
>>      }
>> =20
>>      return env->cc_op;
>>
>=20


--=20

Thanks,

David / dhildenb

