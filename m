Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47605C10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E5521726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E5521726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCQ7L-0004PL-2k
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 10:46:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCQ4R-0000b0-4y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCPrN-0003Tw-Qr
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCPrL-0003Me-3w
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:30:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AAA213AAE;
	Fri,  5 Apr 2019 14:30:22 +0000 (UTC)
Received: from work-vm (ovpn-117-242.ams2.redhat.com [10.36.117.242])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9553B1A927;
	Fri,  5 Apr 2019 14:30:20 +0000 (UTC)
Date: Fri, 5 Apr 2019 15:30:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhang Chen <chen.zhang@intel.com>
Message-ID: <20190405143017.GF2819@work-vm>
References: <20190329222951.28945-1-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190329222951.28945-1-chen.zhang@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 05 Apr 2019 14:30:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration/ram.c: Fix codes conflict about
 bitmap_mutex
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Wei Wang <wei.w.wang@intel.com>, Juan Quintela <quintela@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405143018.xFAJoXfhGZ7LSNZb3-cikuWbbIQzBZ77X3KOoVjyGAw@z>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> I found upstream codes conflict with COLO and lead to crash,
> and I located to this patch:

Queued.

> 
> commit 386a907b37a9321bc5d699bc37104d6ffba1b34d
> Author: Wei Wang <wei.w.wang@intel.com>
> Date:   Tue Dec 11 16:24:49 2018 +0800
> 
> migration: use bitmap_mutex in migration_bitmap_clear_dirty
> 
> My colleague Wei's patch add bitmap_mutex in migration_bitmap_clear_dirty,
> but COLO didn't initialize the bitmap_mutex. So we always get an error
> when COLO start up. like that:
> qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
> 
> This patch add the bitmap_mutex initialize and destroy in COLO
> lifecycle.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  migration/ram.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index d7f8fe45a8..f68beeeeff 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3918,6 +3918,7 @@ int colo_init_ram_cache(void)
>      }
>      ram_state = g_new0(RAMState, 1);
>      ram_state->migration_dirty_pages = 0;
> +    qemu_mutex_init(&ram_state->bitmap_mutex);
>      memory_global_dirty_log_start();
>  
>      return 0;
> @@ -3956,6 +3957,7 @@ void colo_release_ram_cache(void)
>      }
>  
>      rcu_read_unlock();
> +    qemu_mutex_destroy(&ram_state->bitmap_mutex);
>      g_free(ram_state);
>      ram_state = NULL;
>  }
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

