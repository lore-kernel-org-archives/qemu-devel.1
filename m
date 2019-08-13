Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C1C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B0120679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B0120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxX4p-0004tP-B1
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33314)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hxX4S-0004SF-56
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hxX4R-0001bX-6u
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hxX4R-0001b8-0s; Tue, 13 Aug 2019 09:42:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0A94315C027;
 Tue, 13 Aug 2019 13:42:37 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7302960852;
 Tue, 13 Aug 2019 13:42:34 +0000 (UTC)
Date: Tue, 13 Aug 2019 15:42:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190813154232.0478c9d9.cohuck@redhat.com>
In-Reply-To: <20190812112737.6652-4-david@redhat.com>
References: <20190812112737.6652-1-david@redhat.com>
 <20190812112737.6652-4-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 13 Aug 2019 13:42:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v1 3/6] s390x/tcg: Flush the TLB of
 all CPUs on SSKE and RRBE
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 13:27:34 +0200
David Hildenbrand <david@redhat.com> wrote:

> Whenever we modify a storage key, we shuld flush the TLBs of all CPUs,
> so the MMU fault handling code can properly consider the changed storage
> key (to e.g., properly set the reference and change bit on the next
> accesses).
> 
> These functions are barely used in modern Linux guests, so the performance
> implications are neglectable for now.
> 
> This is a preparation for better reference and change bit handling for
> TCG, which will require more MMU changes.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 29d9eaa5b7..ed54265e03 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1815,6 +1815,8 @@ void HELPER(sske)(CPUS390XState *env, uint64_t r1, uint64_t r2)
>  
>      key = (uint8_t) r1;
>      skeyclass->set_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
> +    /* TODO: Flush only entries with this target address */
> +    tlb_flush_all_cpus_synced(env_cpu(env));
>  }
>  
>  /* reset reference bit extended */
> @@ -1843,6 +1845,8 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_t r2)
>      if (skeyclass->set_skeys(ss, r2 / TARGET_PAGE_SIZE, 1, &key)) {
>          return 0;
>      }
> +    /* TODO: Flush only entries with this target address */
> +    tlb_flush_all_cpus_synced(env_cpu(env));
>  
>      /*
>       * cc

Seems reasonable.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

