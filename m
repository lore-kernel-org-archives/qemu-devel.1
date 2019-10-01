Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B1AFA373A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 08:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C397921783
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 08:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C397921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFDKN-0002VQ-Tc
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 04:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iFDJX-0001zj-Gq
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iFDJV-0007e5-5I
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:15:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iFDJU-0007de-TD; Tue, 01 Oct 2019 04:15:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30BE0308FBA9;
 Tue,  1 Oct 2019 08:15:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1A021001B12;
 Tue,  1 Oct 2019 08:15:07 +0000 (UTC)
Subject: Re: [PATCH v3 7/7] s390x/mmu: Convert to non-recursive page table walk
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190927095831.23543-1-david@redhat.com>
 <20190927095831.23543-8-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <b6ad5c2a-bacc-9b41-d141-c8da2fb4ae8d@redhat.com>
Date: Tue, 1 Oct 2019 10:15:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190927095831.23543-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 01 Oct 2019 08:15:15 +0000 (UTC)
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
Cc: Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/09/2019 11.58, David Hildenbrand wrote:
> A non-recursive implementation allows to make better use of the
> branch predictor, avoids function calls, and makes the implementation o=
f
> new features only for a subset of region table levels easier.
>=20
> We can now directly compare our implementation to the KVM gaccess
> implementation in arch/s390/kvm/gaccess.c:guest_translate().
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mmu_helper.c | 212 ++++++++++++++++++++------------------
>  1 file changed, 112 insertions(+), 100 deletions(-)
>=20
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index a114fb1628..6b34c4c7b4 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -114,107 +114,16 @@ static inline bool read_table_entry(CPUS390XStat=
e *env, hwaddr gaddr,
>      return true;
>  }
> =20
> -/* Decode page table entry (normal 4KB page) */
> -static int mmu_translate_pte(CPUS390XState *env, target_ulong vaddr,
> -                             uint64_t asc, uint64_t pt_entry,
> -                             target_ulong *raddr, int *flags, int rw, =
bool exc)
> -{
> -    if (pt_entry & PAGE_ENTRY_I) {
> -        return PGM_PAGE_TRANS;
> -    }
> -    if (pt_entry & PAGE_ENTRY_0) {
> -        return PGM_TRANS_SPEC;
> -    }
> -    if (pt_entry & PAGE_ENTRY_P) {
> -        *flags &=3D ~PAGE_WRITE;
> -    }
> -
> -    *raddr =3D pt_entry & TARGET_PAGE_MASK;
> -    return 0;
> -}
> -
> -/* Decode segment table entry */
> -static int mmu_translate_segment(CPUS390XState *env, target_ulong vadd=
r,
> -                                 uint64_t asc, uint64_t st_entry,
> -                                 target_ulong *raddr, int *flags, int =
rw,
> -                                 bool exc)
> -{
> -    uint64_t origin, offs, pt_entry;
> -
> -    if (st_entry & SEGMENT_ENTRY_P) {
> -        *flags &=3D ~PAGE_WRITE;
> -    }
> -
> -    if ((st_entry & SEGMENT_ENTRY_FC) && (env->cregs[0] & CR0_EDAT)) {
> -        /* Decode EDAT1 segment frame absolute address (1MB page) */
> -        *raddr =3D (st_entry & SEGMENT_ENTRY_SFAA) |
> -                 (vaddr & ~SEGMENT_ENTRY_SFAA);
> -        return 0;
> -    }
> -
> -    /* Look up 4KB page entry */
> -    origin =3D st_entry & SEGMENT_ENTRY_ORIGIN;
> -    offs =3D VADDR_PAGE_TX(vaddr) * 8;
> -    if (!read_table_entry(env, origin + offs, &pt_entry)) {
> -        return PGM_ADDRESSING;
> -    }
> -    return mmu_translate_pte(env, vaddr, asc, pt_entry, raddr, flags, =
rw, exc);
> -}
> -
> -/* Decode region table entries */
> -static int mmu_translate_region(CPUS390XState *env, target_ulong vaddr=
,
> -                                uint64_t asc, uint64_t entry, int leve=
l,
> -                                target_ulong *raddr, int *flags, int r=
w,
> -                                bool exc)
> -{
> -    uint64_t origin, offs, new_entry;
> -    const int pchks[4] =3D {
> -        PGM_SEGMENT_TRANS, PGM_REG_THIRD_TRANS,
> -        PGM_REG_SEC_TRANS, PGM_REG_FIRST_TRANS
> -    };
> -
> -    origin =3D entry & REGION_ENTRY_ORIGIN;
> -    offs =3D (vaddr >> (17 + 11 * level / 4)) & 0x3ff8;
> -
> -    if (!read_table_entry(env, origin + offs, &new_entry)) {
> -        return PGM_ADDRESSING;
> -    }
> -
> -    if (new_entry & REGION_ENTRY_I) {
> -        return pchks[level / 4];
> -    }
> -
> -    if ((new_entry & REGION_ENTRY_TT) !=3D level) {
> -        return PGM_TRANS_SPEC;
> -    }
> -
> -    if (level =3D=3D ASCE_TYPE_SEGMENT) {
> -        return mmu_translate_segment(env, vaddr, asc, new_entry, raddr=
, flags,
> -                                     rw, exc);
> -    }
> -
> -    /* Check region table offset and length */
> -    offs =3D (vaddr >> (28 + 11 * (level - 4) / 4)) & 3;
> -    if (offs < ((new_entry & REGION_ENTRY_TF) >> 6)
> -        || offs > (new_entry & REGION_ENTRY_TL)) {
> -        return pchks[level / 4 - 1];
> -    }
> -
> -    if ((env->cregs[0] & CR0_EDAT) && (new_entry & REGION_ENTRY_P)) {
> -        *flags &=3D ~PAGE_WRITE;
> -    }
> -
> -    /* yet another region */
> -    return mmu_translate_region(env, vaddr, asc, new_entry, level - 4,
> -                                raddr, flags, rw, exc);
> -}
> -
>  static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
>                                uint64_t asc, uint64_t asce, target_ulon=
g *raddr,
>                                int *flags, int rw, bool exc)
>  {
> +    const bool edat1 =3D (env->cregs[0] & CR0_EDAT) &&
> +                       s390_has_feat(S390_FEAT_EDAT);
>      const int asce_tl =3D asce & ASCE_TABLE_LENGTH;
> -    int level;
> +    const int asce_p =3D asce & ASCE_PRIVATE_SPACE;
> +    hwaddr gaddr =3D asce & ASCE_ORIGIN;
> +    uint64_t entry;
> =20
>      if (asce & ASCE_REAL_SPACE) {
>          /* direct mapping */
> @@ -222,12 +131,12 @@ static int mmu_translate_asce(CPUS390XState *env,=
 target_ulong vaddr,
>          return 0;
>      }
> =20
> -    level =3D asce & ASCE_TYPE_MASK;
> -    switch (level) {
> +    switch (asce & ASCE_TYPE_MASK) {
>      case ASCE_TYPE_REGION1:
>          if (VADDR_REGION1_TL(vaddr) > asce_tl) {
>              return PGM_REG_FIRST_TRANS;
>          }
> +        gaddr +=3D VADDR_REGION1_TX(vaddr) * 8;
>          break;
>      case ASCE_TYPE_REGION2:
>          if (VADDR_REGION1_TX(vaddr)) {
> @@ -236,6 +145,7 @@ static int mmu_translate_asce(CPUS390XState *env, t=
arget_ulong vaddr,
>          if (VADDR_REGION2_TL(vaddr) > asce_tl) {
>              return PGM_REG_SEC_TRANS;
>          }
> +        gaddr +=3D VADDR_REGION2_TX(vaddr) * 8;
>          break;
>      case ASCE_TYPE_REGION3:
>          if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr)) {
> @@ -244,6 +154,7 @@ static int mmu_translate_asce(CPUS390XState *env, t=
arget_ulong vaddr,
>          if (VADDR_REGION3_TL(vaddr) > asce_tl) {
>              return PGM_REG_THIRD_TRANS;
>          }
> +        gaddr +=3D VADDR_REGION3_TX(vaddr) * 8;
>          break;
>      case ASCE_TYPE_SEGMENT:
>          if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr) ||
> @@ -253,11 +164,112 @@ static int mmu_translate_asce(CPUS390XState *env=
, target_ulong vaddr,
>          if (VADDR_SEGMENT_TL(vaddr) > asce_tl) {
>              return PGM_SEGMENT_TRANS;
>          }
> +        gaddr +=3D VADDR_SEGMENT_TX(vaddr) * 8;
> +        break;
> +    default:
> +        g_assert_not_reached();

As far as I can see, all four cases are handled above, so this default
case should really not be necessary here.

> +    }
> +
> +    switch (asce & ASCE_TYPE_MASK) {
> +    case ASCE_TYPE_REGION1:
> +        if (!read_table_entry(env, gaddr, &entry)) {
> +            return PGM_ADDRESSING;
> +        }
> +        if (entry & REGION_ENTRY_I) {
> +            return PGM_REG_FIRST_TRANS;
> +        }
> +        if ((entry & REGION_ENTRY_TT) !=3D REGION_ENTRY_TT_REGION1) {
> +            return PGM_TRANS_SPEC;
> +        }
> +        if (VADDR_REGION2_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 |=
|
> +            VADDR_REGION2_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
> +            return PGM_REG_SEC_TRANS;
> +        }
> +        if (edat1 && (entry & REGION_ENTRY_P)) {
> +            *flags &=3D ~PAGE_WRITE;
> +        }
> +        gaddr =3D (entry & REGION_ENTRY_ORIGIN) + VADDR_REGION2_TX(vad=
dr) * 8;
> +        /* fall through */
> +    case ASCE_TYPE_REGION2:
> +        if (!read_table_entry(env, gaddr, &entry)) {
> +            return PGM_ADDRESSING;
> +        }
> +        if (entry & REGION_ENTRY_I) {
> +            return PGM_REG_SEC_TRANS;
> +        }
> +        if ((entry & REGION_ENTRY_TT) !=3D REGION_ENTRY_TT_REGION2) {
> +            return PGM_TRANS_SPEC;
> +        }
> +        if (VADDR_REGION3_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 |=
|
> +            VADDR_REGION3_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
> +            return PGM_REG_THIRD_TRANS;
> +        }
> +        if (edat1 && (entry & REGION_ENTRY_P)) {
> +            *flags &=3D ~PAGE_WRITE;
> +        }
> +        gaddr =3D (entry & REGION_ENTRY_ORIGIN) + VADDR_REGION3_TX(vad=
dr) * 8;
> +        /* fall through */
> +    case ASCE_TYPE_REGION3:
> +        if (!read_table_entry(env, gaddr, &entry)) {
> +            return PGM_ADDRESSING;
> +        }
> +        if (entry & REGION_ENTRY_I) {
> +            return PGM_REG_THIRD_TRANS;
> +        }
> +        if ((entry & REGION_ENTRY_TT) !=3D REGION_ENTRY_TT_REGION3) {
> +            return PGM_TRANS_SPEC;
> +        }
> +        if (edat1 && (entry & REGION_ENTRY_P)) {
> +            *flags &=3D ~PAGE_WRITE;
> +        }

Shouldn't that check be done below the next if-statement?

> +        if (VADDR_SEGMENT_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 |=
|
> +            VADDR_SEGMENT_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
> +            return PGM_SEGMENT_TRANS;
> +        }
> +        gaddr =3D (entry & REGION_ENTRY_ORIGIN) + VADDR_SEGMENT_TX(vad=
dr) * 8;
> +        /* fall through */
> +    case ASCE_TYPE_SEGMENT:
> +        if (!read_table_entry(env, gaddr, &entry)) {
> +            return PGM_ADDRESSING;
> +        }
> +        if (entry & SEGMENT_ENTRY_I) {
> +            return PGM_SEGMENT_TRANS;
> +        }
> +        if ((entry & SEGMENT_ENTRY_TT) !=3D SEGMENT_ENTRY_TT_SEGMENT) =
{
> +            return PGM_TRANS_SPEC;
> +        }
> +        if ((entry & SEGMENT_ENTRY_CS) && asce_p) {
> +            return PGM_TRANS_SPEC;
> +        }
> +        if (entry & SEGMENT_ENTRY_P) {
> +            *flags &=3D ~PAGE_WRITE;
> +        }
> +        if (edat1 && (entry & SEGMENT_ENTRY_FC)) {
> +            *raddr =3D (entry & SEGMENT_ENTRY_SFAA) |
> +                     (vaddr & ~SEGMENT_ENTRY_SFAA);
> +            return 0;
> +        }
> +        gaddr =3D (entry & SEGMENT_ENTRY_ORIGIN) + VADDR_PAGE_TX(vaddr=
) * 8;
>          break;
> +    default:
> +        g_assert_not_reached();

That default case could be dropped, too.

> +    }
> +
> +    if (!read_table_entry(env, gaddr, &entry)) {
> +        return PGM_ADDRESSING;
> +    }
> +    if (entry & PAGE_ENTRY_I) {
> +        return PGM_PAGE_TRANS;
> +    }
> +    if (entry & PAGE_ENTRY_0) {
> +        return PGM_TRANS_SPEC;
> +    }
> +    if (entry & PAGE_ENTRY_P) {
> +        *flags &=3D ~PAGE_WRITE;
>      }
> =20
> -    return mmu_translate_region(env, vaddr, asc, asce, level, raddr, f=
lags, rw,
> -                                exc);
> +    *raddr =3D entry & TARGET_PAGE_MASK;
> +    return 0;
>  }

 Thomas

