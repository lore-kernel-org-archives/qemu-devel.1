Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A5AC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 11:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE30206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 11:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE30206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i80gG-0005gx-S3
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 07:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1i80fE-00055A-Eo
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 07:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1i80fD-0004nH-Az
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 07:19:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1i80fD-0004mp-5k
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 07:19:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA6F530655F9;
 Wed, 11 Sep 2019 11:19:53 +0000 (UTC)
Received: from redhat.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28E4C5D9E2;
 Wed, 11 Sep 2019 11:19:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Ivan Ren <renyime@gmail.com>
In-Reply-To: <1567044996-2362-1-git-send-email-ivanren@tencent.com> (Ivan
 Ren's message of "Thu, 29 Aug 2019 10:16:36 +0800")
References: <1567044996-2362-1-git-send-email-ivanren@tencent.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 11 Sep 2019 13:19:49 +0200
Message-ID: <8736h3w04q.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 11 Sep 2019 11:19:53 +0000 (UTC)
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
Reply-To: quintela@redhat.com
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ivan Ren <renyime@gmail.com> wrote:
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

Reviewed-by: Juan Quintela <quintela@redhat.com>

