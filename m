Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819CDC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4982E2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4982E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH870-00017Y-DB
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH845-00052i-JE
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH843-0004Q9-N3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1jH843-0004Nu-DU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PFXxtA020509; Wed, 25 Mar 2020 11:35:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywf0qbg0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:23 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02PFY1G2020701;
 Wed, 25 Mar 2020 11:35:23 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywf0qbfy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:22 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02PFZHO8001384;
 Wed, 25 Mar 2020 15:35:20 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03wdc.us.ibm.com with ESMTP id 2ywawa2ab3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 15:35:20 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFZKij53215660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:35:20 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20AAB112064;
 Wed, 25 Mar 2020 15:35:20 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDA07112061;
 Wed, 25 Mar 2020 15:35:18 +0000 (GMT)
Received: from localhost (unknown [9.85.207.6])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2020 15:35:18 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 15/15] exec: Ram blocks with resizeable anonymous
 allocations under POSIX
Date: Wed, 25 Mar 2020 12:34:55 -0300
Message-ID: <17423492.TemvMP7ggL@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200305142945.216465-16-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-16-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_08:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=1 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250124
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, March 5, 2020 11:29:45 AM -03 David Hildenbrand wrote:
> We can now make use of resizeable anonymous allocations to implement
> actually resizeable ram blocks. Resizeable anonymous allocations are
> not implemented under WIN32 yet and are not available when using
> alternative allocators. Fall back to the existing handling.
>
> We also have to fallback to the existing handling in case any ram block
> notifier does not support resizing (esp., AMD SEV, HAX) yet. Remember
> in RAM_RESIZEABLE_ALLOC if we are using resizeable anonymous allocations.
>
> Try to grow early, as that can easily fail if out of memory. Shrink late
> and ignore errors (nothing will actually break). Warn only.
>
> The benefit of actually resizeable ram blocks is that e.g., under Linux,
> only the actual size will be reserved (even if
> "/proc/sys/vm/overcommit_memory" is set to "never"). Additional memory will
> be reserved when trying to resize, which allows to have ram blocks that
> start small but can theoretically grow very large.
>
> Note1: We are not able to create resizeable ram blocks with pre-allocated
>        memory yet, so prealloc is not affected.
> Note2: mlock should work as it used to as os_mlock() does a
>        mlockall(MCL_CURRENT | MCL_FUTURE), which includes future
>        mappings.
> Note3: Nobody should access memory beyond used_length. Memory notifiers
>        already properly take care of this, only ram block notifiers
>        violate this constraint and, therefore, have to be special-cased.
>        Especially, any ram block notifier that might dynamically
>        register at runtime (e.g., vfio) has to support resizes. Add an
>        assert for that. Both, HAX and SEV register early, so they are
>        fine.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  exec.c                    | 65 ++++++++++++++++++++++++++++++++++++---
>  hw/core/numa.c            |  7 +++++
>  include/exec/cpu-common.h |  2 ++
>  include/exec/memory.h     |  8 +++++
>  4 files changed, 77 insertions(+), 5 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index 9c3cc79193..6c6b6e12d2 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2001,6 +2001,16 @@ void qemu_ram_unset_migratable(RAMBlock *rb)
>      rb->flags &= ~RAM_MIGRATABLE;
>  }
>
> +bool qemu_ram_is_resizeable(RAMBlock *rb)
> +{
> +    return rb->flags & RAM_RESIZEABLE;
> +}
> +
> +bool qemu_ram_is_resizeable_alloc(RAMBlock *rb)
> +{
> +    return rb->flags & RAM_RESIZEABLE_ALLOC;
> +}
> +
>  /* Called with iothread lock held.  */
>  void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceState
> *dev) {
> @@ -2094,6 +2104,7 @@ static void qemu_ram_apply_settings(void *host, size_t
> length) */
>  int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>  {
> +    const bool shared = block->flags & RAM_SHARED;

Do you think a new function, for example, qemu_ram_is_shared() would be
welcome to check for RAM_SHARED flag as well?  Similar to what is done
in qemu_ram_is_resizeable() and qemu_ram_is_resizeable_alloc().

Apart from that,

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

>      const ram_addr_t oldsize = block->used_length;
>
>      assert(block);
> @@ -2104,7 +2115,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t
> newsize, Error **errp) return 0;
>      }
>
> -    if (!(block->flags & RAM_RESIZEABLE)) {
> +    if (!qemu_ram_is_resizeable(block)) {
>          error_setg_errno(errp, EINVAL,
>                           "Length mismatch: %s: 0x" RAM_ADDR_FMT
>                           " in != 0x" RAM_ADDR_FMT, block->idstr,
> @@ -2120,6 +2131,15 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t
> newsize, Error **errp) return -EINVAL;
>      }
>
> +    if (oldsize < newsize && qemu_ram_is_resizeable_alloc(block)) {
> +        if (!qemu_anon_ram_resize(block->host, oldsize, newsize, shared)) {
> +            error_setg_errno(errp, -ENOMEM, "Cannot allocate enough
> memory."); +            return -ENOMEM;
> +        }
> +        /* apply settings for the newly accessible memory */
> +        qemu_ram_apply_settings(block->host + oldsize, newsize - oldsize);
> +    }
> +
>      /* Notify before modifying the ram block and touching the bitmaps. */
>      if (block->host) {
>          ram_block_notify_resize(block->host, oldsize, newsize);
> @@ -2133,6 +2153,16 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t
> newsize, Error **errp) if (block->resized) {
>          block->resized(block->idstr, newsize, block->host);
>      }
> +
> +    /*
> +     * Shrinking will only fail in rare scenarios (e.g., maximum number of
> +     * mappings reached), and can be ignored. Warn only.
> +     */
> +    if (newsize < oldsize && qemu_ram_is_resizeable_alloc(block) &&
> +        !qemu_anon_ram_resize(block->host, oldsize, newsize, shared)) {
> +        warn_report("Shrinking memory allocation failed.");
> +    }
> +
>      return 0;
>  }
>
> @@ -2211,6 +2241,29 @@ static void dirty_memory_extend(ram_addr_t
> old_ram_size, }
>  }
>
> +static void ram_block_alloc_ram(RAMBlock *rb)
> +{
> +    const bool shared = qemu_ram_is_shared(rb);
> +
> +    assert(!(rb->flags & RAM_RESIZEABLE_ALLOC));
> +    /*
> +     * If we can, try to allocate actually resizeable ram. Will also fail
> +     * if qemu_anon_ram_alloc_resizeable() is not implemented.
> +     */
> +    if (phys_mem_alloc == qemu_anon_ram_alloc &&
> +        qemu_ram_is_resizeable(rb) &&
> +        ram_block_notifiers_support_resize()) {
> +        rb->host = qemu_anon_ram_alloc_resizeable(rb->used_length,
> +                                                  rb->max_length,
> +                                                  &rb->mr->align, shared);
> +        if (rb->host) {
> +            rb->flags |= RAM_RESIZEABLE_ALLOC;
> +            return;
> +        }
> +    }
> +    rb->host = phys_mem_alloc(rb->max_length, &rb->mr->align, shared);
> +}
> +
>  static void ram_block_add(RAMBlock *new_block, Error **errp)
>  {
>      RAMBlock *block;
> @@ -2233,9 +2286,7 @@ static void ram_block_add(RAMBlock *new_block, Error
> **errp) return;
>              }
>          } else {
> -            new_block->host = phys_mem_alloc(new_block->max_length,
> -                                             &new_block->mr->align,
> -
> qemu_ram_is_shared(new_block)); +
> ram_block_alloc_ram(new_block);
>              if (!new_block->host) {
>                  error_setg_errno(errp, errno,
>                                   "cannot set up guest memory '%s'",
> @@ -2280,7 +2331,11 @@ static void ram_block_add(RAMBlock *new_block, Error
> **errp) DIRTY_CLIENTS_ALL);
>
>      if (new_block->host) {
> -        qemu_ram_apply_settings(new_block->host, new_block->max_length);
> +        if (qemu_ram_is_resizeable_alloc(new_block)) {
> +            qemu_ram_apply_settings(new_block->host,
> new_block->used_length); +        } else {
> +            qemu_ram_apply_settings(new_block->host,
> new_block->max_length); +        }
>          ram_block_notify_add(new_block->host, new_block->used_length,
>                               new_block->max_length);
>      }
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 1d5288c22c..c547549e49 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -862,6 +862,13 @@ static int ram_block_notify_add_single(RAMBlock *rb,
> void *opaque) RAMBlockNotifier *notifier = opaque;
>
>      if (host) {
> +        /*
> +         * Dynamically adding notifiers that don't support resizes is
> forbidden +         * when dealing with resizeable ram blocks that have
> actually resizeable +         * allocations.
> +         */
> +        g_assert(!qemu_ram_is_resizeable_alloc(rb) ||
> +                 notifier->ram_block_resized);
>          notifier->ram_block_added(notifier, host, size, max_size);
>      }
>      return 0;
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 09decb8d93..aacbf33b85 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -66,6 +66,8 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb);
>  bool qemu_ram_is_migratable(RAMBlock *rb);
>  void qemu_ram_set_migratable(RAMBlock *rb);
>  void qemu_ram_unset_migratable(RAMBlock *rb);
> +bool qemu_ram_is_resizeable(RAMBlock *rb);
> +bool qemu_ram_is_resizeable_alloc(RAMBlock *rb);
>
>  size_t qemu_ram_pagesize(RAMBlock *block);
>  size_t qemu_ram_pagesize_largest(void);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index b9b9470a56..74805dd448 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -129,6 +129,14 @@ typedef struct IOMMUNotifier IOMMUNotifier;
>  /* RAM is a persistent kind memory */
>  #define RAM_PMEM (1 << 5)
>
> +/*
> + * Implies RAM_RESIZEABLE. Memory beyond the used_length is inaccessible
> + * (esp. initially and after resizing). For such memory blocks, only the
> + * used_length is reserved in the OS - resizing might fail. Will only be
> + * used with host OS support and if all ram block notifiers support
> resizing. + */
> +#define RAM_RESIZEABLE_ALLOC (1 << 6)
> +
>  static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>                                         IOMMUNotifierFlag flags,
>                                         hwaddr start, hwaddr end,


--
Murilo

