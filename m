Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56061C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E08220872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E08220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dYE-0007zY-2x
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i7dLh-0002iR-NB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i7dLg-0003LY-OW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1i7dLd-0003KV-Q0; Tue, 10 Sep 2019 06:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A1BD18C8933;
 Tue, 10 Sep 2019 10:26:08 +0000 (UTC)
Received: from work-vm (ovpn-117-238.ams2.redhat.com [10.36.117.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 177E66061E;
 Tue, 10 Sep 2019 10:26:03 +0000 (UTC)
Date: Tue, 10 Sep 2019 11:26:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Beata Michalska <beata.michalska@linaro.org>
Message-ID: <20190910102601.GA2797@work-vm>
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-4-beata.michalska@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910095610.4546-4-beata.michalska@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 10 Sep 2019 10:26:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] migration: ram: Switch to ram block
 writeback
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Beata Michalska (beata.michalska@linaro.org) wrote:
> Switch to ram block writeback for pmem migration.
> 
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  migration/ram.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index b01a37e7ca..8ea0bd63fc 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -33,7 +33,6 @@
>  #include "qemu/bitops.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/main-loop.h"
> -#include "qemu/pmem.h"
>  #include "xbzrle.h"
>  #include "ram.h"
>  #include "migration.h"
> @@ -4064,9 +4063,7 @@ static int ram_load_cleanup(void *opaque)
>      RAMBlock *rb;
>  
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> -        if (ramblock_is_pmem(rb)) {
> -            pmem_persist(rb->host, rb->used_length);
> -        }
> +        qemu_ram_block_writeback(rb);

ACK for migration

Although I do worry that if you really have pmem hardware, is it better
to fail the migration if you don't have libpmem available?

Dave

>      }
>  
>      xbzrle_load_cleanup();
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

