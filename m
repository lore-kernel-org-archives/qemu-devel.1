Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BB1FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBC1214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBC1214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7Sg-000854-CP
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iL6bj-0006eU-Jc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iL6bi-0004K6-HS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iL6bi-0004JL-BO; Thu, 17 Oct 2019 10:18:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 777553086218;
 Thu, 17 Oct 2019 14:18:25 +0000 (UTC)
Received: from gondolin (dhcp-192-202.str.redhat.com [10.33.192.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F259B5C1D8;
 Thu, 17 Oct 2019 14:18:21 +0000 (UTC)
Date: Thu, 17 Oct 2019 16:18:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] s390x/mmu: Remove duplicate check for MMU_DATA_STORE
Message-ID: <20191017161819.2fd1a86e.cohuck@redhat.com>
In-Reply-To: <20191017121922.18840-1-david@redhat.com>
References: <20191017121922.18840-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 17 Oct 2019 14:18:25 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 14:19:22 +0200
David Hildenbrand <david@redhat.com> wrote:

> No need to double-check if we have a write.
> 
> Found by Coverity (CID: 1381016).
> 
> Fixes: 31b59419069e ("target/s390x: Return exception from mmu_translate_real")
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mmu_helper.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 90b81335f9..c9f3f34750 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -556,9 +556,7 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
>          *flags |= PAGE_WRITE_INV;
>          if (is_low_address(raddr) && rw == MMU_DATA_STORE) {
>              /* LAP sets bit 56 */
> -            *tec = (raddr & TARGET_PAGE_MASK)
> -                 | (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ)
> -                 | 0x80;
> +            *tec = (raddr & TARGET_PAGE_MASK) | FS_WRITE | 0x80;
>              return PGM_PROTECTION;
>          }
>      }

Thanks, applied.

