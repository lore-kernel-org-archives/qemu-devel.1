Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14219C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 07:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D9720663
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 07:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D9720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx4dl-00078b-0M
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 03:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hx4dB-0006h0-Cy
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hx4d9-00019D-9t
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:20:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hx4d4-00015c-QZ; Mon, 12 Aug 2019 03:20:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79FCE3090FDE;
 Mon, 12 Aug 2019 07:20:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-157.ams2.redhat.com [10.36.116.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E60F6012D;
 Mon, 12 Aug 2019 07:20:21 +0000 (UTC)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190805152947.28536-1-david@redhat.com>
 <20190805152947.28536-4-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <247d75d4-b717-7690-c448-60884a3e9545@redhat.com>
Date: Mon, 12 Aug 2019 09:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805152947.28536-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 12 Aug 2019 07:20:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v1 3/9] s390x/mmu: DAT translation
 rewrite
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
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/19 5:29 PM, David Hildenbrand wrote:
> Let's rewrite the DAT translation in a non-recursive way, similar to
> arch/s390/kvm/gaccess.c:guest_translate() in KVM. This makes the
> code much easier to read, compare and maintain.
> 
> Use better names for the region/section/page table entries and for the
> macros to extract relevant parts from virtual address. Introduce defines
> for all defined bits, this will come in handy soon.
> 
> All access exceptions now directly go via trigger_access_exception(),
> at a central point. DAT protection checks are performed at a central
> place.
> 
> Also, we now catch and indicate invalid addresses of page tables. All
> table entries are accessed via read_table_entry().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h        |  77 +++++---
>  target/s390x/mem_helper.c |  13 +-
>  target/s390x/mmu_helper.c | 360 +++++++++++++++++---------------------
>  3 files changed, 229 insertions(+), 221 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index c34992bb2e..1ff14250bd 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -554,26 +554,63 @@ QEMU_BUILD_BUG_ON(sizeof(SysIB) != 4096);
>  #define ASCE_TYPE_SEGMENT     0x00        /* segment table type               */
>  #define ASCE_TABLE_LENGTH     0x03        /* region table length              */
>  
> -#define REGION_ENTRY_ORIGIN   (~0xfffULL) /* region/segment table origin    */
> -#define REGION_ENTRY_RO       0x200       /* region/segment protection bit  */
> -#define REGION_ENTRY_TF       0xc0        /* region/segment table offset    */
> -#define REGION_ENTRY_INV      0x20        /* invalid region table entry     */
> -#define REGION_ENTRY_TYPE_MASK 0x0c       /* region/segment table type mask */
> -#define REGION_ENTRY_TYPE_R1  0x0c        /* region first table type        */
> -#define REGION_ENTRY_TYPE_R2  0x08        /* region second table type       */
> -#define REGION_ENTRY_TYPE_R3  0x04        /* region third table type        */
> -#define REGION_ENTRY_LENGTH   0x03        /* region third length            */
> -
> -#define SEGMENT_ENTRY_ORIGIN  (~0x7ffULL) /* segment table origin        */
> -#define SEGMENT_ENTRY_FC      0x400       /* format control              */
> -#define SEGMENT_ENTRY_RO      0x200       /* page protection bit         */
> -#define SEGMENT_ENTRY_INV     0x20        /* invalid segment table entry */
> -
> -#define VADDR_PX              0xff000     /* page index bits   */
> -
> -#define PAGE_RO               0x200       /* HW read-only bit  */
> -#define PAGE_INVALID          0x400       /* HW invalid bit    */
> -#define PAGE_RES0             0x800       /* bit must be zero  */
> +#define REGION_ENTRY_ORIGIN         0xfffffffffffff000ULL
> +#define REGION_ENTRY_P              0x0000000000000200ULL
> +#define REGION_ENTRY_TF             0x00000000000000c0ULL
> +#define REGION_ENTRY_I              0x0000000000000020ULL
> +#define REGION_ENTRY_TT             0x000000000000000cULL
> +#define REGION_ENTRY_TL             0x0000000000000003ULL
> +
> +#define REGION_ENTRY_TT_REGION1     0x000000000000000cULL
> +#define REGION_ENTRY_TT_REGION2     0x0000000000000008ULL
> +#define REGION_ENTRY_TT_REGION3     0x0000000000000004ULL
> +
> +#define REGION3_ENTRY_RFAA          0xffffffff80000000ULL
> +#define REGION3_ENTRY_AV            0x0000000000010000ULL
> +#define REGION3_ENTRY_ACC           0x000000000000f000ULL
> +#define REGION3_ENTRY_F             0x0000000000000800ULL
> +#define REGION3_ENTRY_FC            0x0000000000000400ULL
> +#define REGION3_ENTRY_IEP           0x0000000000000100ULL
> +#define REGION3_ENTRY_CR            0x0000000000000010ULL
> +
> +#define SEGMENT_ENTRY_ORIGIN        0xfffffffffffff800ULL
> +#define SEGMENT_ENTRY_SFAA          0xfffffffffff80000ULL
> +#define SEGMENT_ENTRY_AV            0x0000000000010000ULL
> +#define SEGMENT_ENTRY_ACC           0x000000000000f000ULL
> +#define SEGMENT_ENTRY_F             0x0000000000000800ULL
> +#define SEGMENT_ENTRY_FC            0x0000000000000400ULL
> +#define SEGMENT_ENTRY_P             0x0000000000000200ULL
> +#define SEGMENT_ENTRY_IEP           0x0000000000000100ULL
> +#define SEGMENT_ENTRY_I             0x0000000000000020ULL
> +#define SEGMENT_ENTRY_CS            0x0000000000000010ULL
> +#define SEGMENT_ENTRY_TT            0x000000000000000cULL
> +
> +#define SEGMENT_ENTRY_TT_REGION1    0x000000000000000cULL
> +#define SEGMENT_ENTRY_TT_REGION2    0x0000000000000008ULL
> +#define SEGMENT_ENTRY_TT_REGION3    0x0000000000000004ULL
> +#define SEGMENT_ENTRY_TT_SEGMENT    0x0000000000000000ULL
> +
> +#define PAGE_ENTRY_0                0x0000000000000800ULL
> +#define PAGE_ENTRY_I                0x0000000000000400ULL
> +#define PAGE_ENTRY_P                0x0000000000000200ULL
> +#define PAGE_ENTRY_IEP              0x0000000000000100ULL
> +
> +#define VADDR_REGION1_TX_MASK       0xffe0000000000000ULL
> +#define VADDR_REGION2_TX_MASK       0x001ffc0000000000ULL
> +#define VADDR_REGION3_TX_MASK       0x000003ff80000000ULL
> +#define VADDR_SEGMENT_TX_MASK       0x000000007ff00000ULL
> +#define VADDR_PAGE_TX_MASK          0x00000000000ff000ULL
> +
> +#define VADDR_REGION1_TX(vaddr)     (((vaddr) & VADDR_REGION1_TX_MASK) >> 53)
> +#define VADDR_REGION2_TX(vaddr)     (((vaddr) & VADDR_REGION2_TX_MASK) >> 42)
> +#define VADDR_REGION3_TX(vaddr)     (((vaddr) & VADDR_REGION3_TX_MASK) >> 31)
> +#define VADDR_SEGMENT_TX(vaddr)     (((vaddr) & VADDR_SEGMENT_TX_MASK) >> 20)
> +#define VADDR_PAGE_TX(vaddr)        (((vaddr) & VADDR_PAGE_TX_MASK) >> 12)
> +
> +#define VADDR_REGION1_TL(vaddr)     (((vaddr) & 0xc000000000000000ULL) >> 62)
> +#define VADDR_REGION2_TL(vaddr)     (((vaddr) & 0x0018000000000000ULL) >> 51)
> +#define VADDR_REGION3_TL(vaddr)     (((vaddr) & 0x0000030000000000ULL) >> 40)
> +#define VADDR_SEGMENT_TL(vaddr)     (((vaddr) & 0x0000000060000000ULL) >> 29)

Ugh, this patch is quite big, and you're doing multiple things at once
here, e.g. renaming macros from PAGE_INVALID to PAGE_ENTRY_I ... could
you maybe split this up in multiple patches instead? Also, is this
complete rewrite really necessary, just to match your personal taste? I
think it would be easier to review if you'd just fix the current code
instead if necessary...

 Thomas



