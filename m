Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1E0C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710CA21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710CA21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAy59-0008Qj-GF
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iAy3t-0007kw-AQ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iAy3q-00056u-3x
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:09:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iAy3p-00056h-Sn
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:09:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B789308212D;
 Thu, 19 Sep 2019 15:09:33 +0000 (UTC)
Received: from [10.36.118.9] (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5A2160BF1;
 Thu, 19 Sep 2019 15:09:29 +0000 (UTC)
Subject: Re: [RFC v2 3/5] cputlb: Introduce TLB_BSWAP
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190918180251.32003-1-richard.henderson@linaro.org>
 <20190918180251.32003-4-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <1b0987d1-2606-8278-374b-8e383aec3c51@redhat.com>
Date: Thu, 19 Sep 2019 17:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918180251.32003-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 19 Sep 2019 15:09:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18.09.19 20:02, Richard Henderson wrote:
> Handle bswap on ram directly in load/store_helper.  This fixes a
> bug with the previous implementation in that one cannot use the
> I/O path for RAM.
>=20
> Fixes: a26fc6f5152b47f1
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h |   2 +
>  accel/tcg/cputlb.c     | 105 +++++++++++++++++++++--------------------
>  2 files changed, 57 insertions(+), 50 deletions(-)
>=20
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index d2d443c4f9..3928edab9a 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -331,6 +331,8 @@ CPUArchState *cpu_copy(CPUArchState *env);
>  #define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
>  /* Set if TLB entry contains a watchpoint.  */
>  #define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS - 4))
> +/* Set if TLB entry requires byte swap.  */
> +#define TLB_BSWAP           (1 << (TARGET_PAGE_BITS - 5))

Shouldn't you also take care of TLB_BSWAP in probe_access?

> =20
>  /* Use this mask to check interception with an alignment mask
>   * in a TCG backend.
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index b4a63d3928..7301f9e699 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -737,8 +737,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_=
ulong vaddr,
>          address |=3D TLB_INVALID_MASK;
>      }
>      if (attrs.byte_swap) {
> -        /* Force the access through the I/O slow path.  */
> -        address |=3D TLB_MMIO;
> +        address |=3D TLB_BSWAP;
>      }
>      if (!memory_region_is_ram(section->mr) &&
>          !memory_region_is_romd(section->mr)) {
> @@ -901,10 +900,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOT=
LBEntry *iotlbentry,
>      bool locked =3D false;
>      MemTxResult r;
> =20
> -    if (iotlbentry->attrs.byte_swap) {
> -        op ^=3D MO_BSWAP;
> -    }
> -
>      section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->at=
trs);
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
> @@ -947,10 +942,6 @@ static void io_writex(CPUArchState *env, CPUIOTLBE=
ntry *iotlbentry,
>      bool locked =3D false;
>      MemTxResult r;
> =20
> -    if (iotlbentry->attrs.byte_swap) {
> -        op ^=3D MO_BSWAP;
> -    }
> -
>      section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->at=
trs);
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
> @@ -1311,7 +1302,8 @@ static inline uint64_t wrap_ldul_le(const void *h=
addr)
>  static inline uint64_t QEMU_ALWAYS_INLINE
>  load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>              uintptr_t retaddr, MemOp op, bool code_read,
> -            FullLoadHelper *full_load, LoadHelper *direct)
> +            FullLoadHelper *full_load, LoadHelper *direct,
> +            LoadHelper *direct_swap)
>  {
>      uintptr_t mmu_idx =3D get_mmuidx(oi);
>      uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> @@ -1361,17 +1353,22 @@ load_helper(CPUArchState *env, target_ulong add=
r, TCGMemOpIdx oi,
>              /* On watchpoint hit, this will longjmp out.  */
>              cpu_check_watchpoint(env_cpu(env), addr, size,
>                                   iotlbentry->attrs, BP_MEM_READ, retad=
dr);
> -
> -            /* The backing page may or may not require I/O.  */
> -            tlb_addr &=3D ~TLB_WATCHPOINT;
> -            if ((tlb_addr & ~TARGET_PAGE_MASK) =3D=3D 0) {
> -                goto do_aligned_access;
> -            }
>          }
> =20
>          /* Handle I/O access.  */
> -        return io_readx(env, iotlbentry, mmu_idx, addr,
> -                        retaddr, access_type, op);
> +        if (likely(tlb_addr & TLB_MMIO)) {
> +            return io_readx(env, iotlbentry, mmu_idx, addr,
> +                            retaddr, access_type,
> +                            op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0)=
);
> +        }
> +
> +        haddr =3D (void *)((uintptr_t)addr + entry->addend);
> +
> +        if (unlikely(tlb_addr & TLB_BSWAP)) {
> +            return direct_swap(haddr);
> +        } else {
> +            return direct(haddr);
> +        }

You can drop the else statement and just return.

[...]

I assume this patch does not yet result in the issues you are
experiencing, right?

Looks in general sane to me ...

--=20

Thanks,

David / dhildenb

