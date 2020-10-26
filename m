Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FF3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0804222C8
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Now0h8qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0804222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6oj-0002us-KI
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX6R3-0006uR-4P
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX6R1-0002Uw-7m
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603733850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgLbSSo+gwIjMjhb1TdrDhXyagceazXJeQgMeT6e9ug=;
 b=Now0h8qkeXEZRiu0XjUQBubIghpoK+FnCpph7rkyghbBJkL6YMUuLH0JSMJFvwhCxUCgPg
 dg2nt5OTv1WpI+84ZWnYDb5CpmcdwajRtwMmbKQhwI5Hpaaybp4+AkvIvbhBuDyXYOjlmZ
 vUcANRYieiRj4eaAXEQ68ArArY7tHfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-hA-fk-aYNMyDO67OlORgyQ-1; Mon, 26 Oct 2020 13:37:28 -0400
X-MC-Unique: hA-fk-aYNMyDO67OlORgyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D495757203;
 Mon, 26 Oct 2020 17:37:26 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42F035C1BB;
 Mon, 26 Oct 2020 17:37:17 +0000 (UTC)
Date: Mon, 26 Oct 2020 11:37:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH 02/13] linux-headers: update against 5.10-rc1
Message-ID: <20201026113716.2c67aec6@w520.home>
In-Reply-To: <1603726481-31824-3-git-send-email-mjrosato@linux.ibm.com>
References: <1603726481-31824-1-git-send-email-mjrosato@linux.ibm.com>
 <1603726481-31824-3-git-send-email-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mst@redhat.com, pbonzini@redhat.com, philmd@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 11:34:30 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  .../drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h | 14 ++--
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h        |  2 +-
>  include/standard-headers/linux/ethtool.h           |  2 +
>  include/standard-headers/linux/fuse.h              | 50 +++++++++++++-
>  include/standard-headers/linux/input-event-codes.h |  4 ++
>  include/standard-headers/linux/pci_regs.h          |  6 +-
>  include/standard-headers/linux/virtio_fs.h         |  3 +
>  include/standard-headers/linux/virtio_gpu.h        | 19 ++++++
>  include/standard-headers/linux/virtio_mmio.h       | 11 +++
>  include/standard-headers/linux/virtio_pci.h        | 11 ++-
>  linux-headers/asm-arm64/kvm.h                      | 25 +++++++
>  linux-headers/asm-arm64/mman.h                     |  1 +
>  linux-headers/asm-generic/hugetlb_encode.h         |  1 +
>  linux-headers/asm-generic/unistd.h                 | 18 ++---
>  linux-headers/asm-mips/unistd_n32.h                |  1 +
>  linux-headers/asm-mips/unistd_n64.h                |  1 +
>  linux-headers/asm-mips/unistd_o32.h                |  1 +
>  linux-headers/asm-powerpc/unistd_32.h              |  1 +
>  linux-headers/asm-powerpc/unistd_64.h              |  1 +
>  linux-headers/asm-s390/unistd_32.h                 |  1 +
>  linux-headers/asm-s390/unistd_64.h                 |  1 +
>  linux-headers/asm-x86/kvm.h                        | 20 ++++++
>  linux-headers/asm-x86/unistd_32.h                  |  1 +
>  linux-headers/asm-x86/unistd_64.h                  |  1 +
>  linux-headers/asm-x86/unistd_x32.h                 |  1 +
>  linux-headers/linux/kvm.h                          | 19 ++++++
>  linux-headers/linux/mman.h                         |  1 +
>  linux-headers/linux/vfio.h                         | 29 +++++++-
>  linux-headers/linux/vfio_zdev.h                    | 78 ++++++++++++++++++++++
>  29 files changed, 301 insertions(+), 23 deletions(-)
>  create mode 100644 linux-headers/linux/vfio_zdev.h
> 
> diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
> index 7b4062a..acd4c83 100644
> --- a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
> +++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
> @@ -68,7 +68,7 @@ static inline int pvrdma_idx_valid(uint32_t idx, uint32_t max_elems)
>  
>  static inline int32_t pvrdma_idx(int *var, uint32_t max_elems)
>  {
> -	const unsigned int idx = qatomic_read(var);
> +	const unsigned int idx = atomic_read(var);
>  
>  	if (pvrdma_idx_valid(idx, max_elems))
>  		return idx & (max_elems - 1);
> @@ -77,17 +77,17 @@ static inline int32_t pvrdma_idx(int *var, uint32_t max_elems)
>  
>  static inline void pvrdma_idx_ring_inc(int *var, uint32_t max_elems)
>  {
> -	uint32_t idx = qatomic_read(var) + 1;	/* Increment. */
> +	uint32_t idx = atomic_read(var) + 1;	/* Increment. */
>  
>  	idx &= (max_elems << 1) - 1;		/* Modulo size, flip gen. */
> -	qatomic_set(var, idx);
> +	atomic_set(var, idx);
>  }
>  
>  static inline int32_t pvrdma_idx_ring_has_space(const struct pvrdma_ring *r,
>  					      uint32_t max_elems, uint32_t *out_tail)
>  {
> -	const uint32_t tail = qatomic_read(&r->prod_tail);
> -	const uint32_t head = qatomic_read(&r->cons_head);
> +	const uint32_t tail = atomic_read(&r->prod_tail);
> +	const uint32_t head = atomic_read(&r->cons_head);
>  
>  	if (pvrdma_idx_valid(tail, max_elems) &&
>  	    pvrdma_idx_valid(head, max_elems)) {
> @@ -100,8 +100,8 @@ static inline int32_t pvrdma_idx_ring_has_space(const struct pvrdma_ring *r,
>  static inline int32_t pvrdma_idx_ring_has_data(const struct pvrdma_ring *r,
>  					     uint32_t max_elems, uint32_t *out_head)
>  {
> -	const uint32_t tail = qatomic_read(&r->prod_tail);
> -	const uint32_t head = qatomic_read(&r->cons_head);
> +	const uint32_t tail = atomic_read(&r->prod_tail);
> +	const uint32_t head = atomic_read(&r->cons_head);
>  
>  	if (pvrdma_idx_valid(tail, max_elems) &&
>  	    pvrdma_idx_valid(head, max_elems)) {


The above is clearly just going to revert Stefan's changes to this file
via:

d73415a31547 )"qemu/atomic.h: rename atomic_ to qatomic_")

For now I'm just going to drop these changes (with comment) to avoid
that.  I'll leave it to others to fix the header update script to either
reimplement the s/atomic_/qatomic_/ conversion or remove these code
blocks altogether.  Sound ok?  Thanks,

Alex


