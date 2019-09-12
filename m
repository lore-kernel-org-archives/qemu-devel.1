Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D7FC49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9B8206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9B8206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Lp4-0000y7-59
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8Lnf-0007tK-Qz
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8Lne-0004dS-P3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:54:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8Lne-0004cl-GS
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:54:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3691310CC1E0;
 Thu, 12 Sep 2019 09:54:01 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54BBD10AFDEA;
 Thu, 12 Sep 2019 09:54:00 +0000 (UTC)
Date: Thu, 12 Sep 2019 10:53:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Ivan Ren <renyime@gmail.com>
Message-ID: <20190912095357.GA7230@work-vm>
References: <1567044996-2362-1-git-send-email-ivanren@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567044996-2362-1-git-send-email-ivanren@tencent.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 12 Sep 2019 09:54:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: multifd_send_thread always post
 p->sem_sync when error happen
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Queued

* Ivan Ren (renyime@gmail.com) wrote:
> From: Ivan Ren <ivanren@tencent.com>
> 
> When encounter error, multifd_send_thread should always notify who pay
> attention to it before exit. Otherwise it may block migration_thread
> at multifd_send_sync_main forever.
> 
> Error as follow:
> -------------------------------------------------------------------------------
>  (gdb) bt
>  #0  0x00007f4d669dfa0b in do_futex_wait.constprop.1 () from /lib64/libpthread.so.0
>  #1  0x00007f4d669dfa9f in __new_sem_wait_slow.constprop.0 () from /lib64/libpthread.so.0
>  #2  0x00007f4d669dfb3b in sem_wait@@GLIBC_2.2.5 () from /lib64/libpthread.so.0
>  #3  0x0000562ccf0a5614 in qemu_sem_wait (sem=sem@entry=0x562cd1b698e8) at util/qemu-thread-posix.c:319
>  #4  0x0000562ccecb4752 in multifd_send_sync_main (rs=<optimized out>) at /qemu/migration/ram.c:1099
>  #5  0x0000562ccecb95f4 in ram_save_iterate (f=0x562cd0ecc000, opaque=<optimized out>) at /qemu/migration/ram.c:3550
>  #6  0x0000562ccef43c23 in qemu_savevm_state_iterate (f=0x562cd0ecc000, postcopy=false) at migration/savevm.c:1189
>  #7  0x0000562ccef3dcf3 in migration_iteration_run (s=0x562cd09fabf0) at migration/migration.c:3131
>  #8  migration_thread (opaque=opaque@entry=0x562cd09fabf0) at migration/migration.c:3258
>  #9  0x0000562ccf0a4c26 in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:502
>  #10 0x00007f4d669d9e25 in start_thread () from /lib64/libpthread.so.0
>  #11 0x00007f4d6670635d in clone () from /lib64/libc.so.6
>  (gdb) f 4
>  #4  0x0000562ccecb4752 in multifd_send_sync_main (rs=<optimized out>) at /qemu/migration/ram.c:1099
>  1099	        qemu_sem_wait(&p->sem_sync);
>  (gdb) list
>  1094	    }
>  1095	    for (i = 0; i < migrate_multifd_channels(); i++) {
>  1096	        MultiFDSendParams *p = &multifd_send_state->params[i];
>  1097
>  1098	        trace_multifd_send_sync_main_wait(p->id);
>  1099	        qemu_sem_wait(&p->sem_sync);
>  1100	    }
>  1101	    trace_multifd_send_sync_main(multifd_send_state->packet_num);
>  1102	}
>  1103
>  (gdb) p i
>  $1 = 0
>  (gdb)  p multifd_send_state->params[0].pending_job
>  $2 = 2    //It means the job before MULTIFD_FLAG_SYNC has already fail
>  (gdb)  p multifd_send_state->params[0].quit
>  $3 = true
> 
> Signed-off-by: Ivan Ren <ivanren@tencent.com>
> ---
>  migration/ram.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index b01a37e7ca..0047286b7e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1112,6 +1112,7 @@ static void *multifd_send_thread(void *opaque)
>      rcu_register_thread();
>  
>      if (multifd_send_initial_packet(p, &local_err) < 0) {
> +        ret = -1;
>          goto out;
>      }
>      /* initial packet */
> @@ -1179,9 +1180,7 @@ out:
>       * who pay attention to me.
>       */
>      if (ret != 0) {
> -        if (flags & MULTIFD_FLAG_SYNC) {
> -            qemu_sem_post(&p->sem_sync);
> -        }
> +        qemu_sem_post(&p->sem_sync);
>          qemu_sem_post(&multifd_send_state->channels_ready);
>      }
>  
> -- 
> 2.17.2 (Apple Git-113)
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

