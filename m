Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344AC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B002A20818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6UpGncc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B002A20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZlH-0000WW-MV
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZl4-00007F-VL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZl3-0005zu-Hm
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:46516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZl3-0005xi-82
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:29 -0400
Received: by mail-pl1-x635.google.com with SMTP id c2so11086081plz.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mpanv0GkI1qUuScVTMz+GrOkxn/egYEtKNugwHi11io=;
 b=n6UpGncc1ao8AqP08b2Do4YCKVVfs3CdAN/hzn33d6BoLH8JWqrRmNXzXpty03aRGI
 mk/GoDwTScaHdOcdkl6ivXz2PZkfFJorFG1djRsNhJpujkMLcgkS+rUrQm1evb0KVRQy
 wI0I6Aj1OuOvnX+L0cmVLrIU+v23k5HHPdM66gaHc/8bUyY5UF9FR+EtLHRs5YB/8W7j
 uagJRxjAWJ0zEhkPlcR/MPcMzr0scyWgY84sYMUxmjiuRr70c7TRQm03bqZWQGfP4/CI
 lWJmlzrYcDmLZgUFT5ORvmun3QSnuLeuPsm7FtBhgKXeN9e6l8dehl6UNJfmo5rncIhM
 hS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mpanv0GkI1qUuScVTMz+GrOkxn/egYEtKNugwHi11io=;
 b=LY+WTYyGkkKTo4CI6jQIkRtp4CvkDIBFvDheCMDpP3QTuoyfmwXSCfsfnzqNoeFdx6
 OI0+JFp0noUuA6T1YUmkDik1tnmVn7IlHODgDbnjunP4KHG5O7zg1som4pj7dUpVvr6v
 +lrCG0FgU6ESBDE3CS2G6trY7j8FzKpqzwrZlMKgRTcXpznda7698/r6MTyxVMQ6UY8H
 tHKBhd5XPw25MzbPtxUS5rHOElKb/KRYquFPoWVBzp3s2I11F7ogLiohbKe0ZdJJ6msP
 wYPZ1Ao/jLwuUnQEWTIy+JgZHvOLoq9X4dGFn/DBTTxaJqRgnejd3gp+VdYkT58ezTpi
 HO6g==
X-Gm-Message-State: APjAAAVr0hCJJRrp7/RvoO4W/53mC0kQDo36uFuq1llvsojNYZSiq6QF
 O6FCe1jn+0jIxGqU3gfWVZ/bTngw
X-Google-Smtp-Source: APXvYqyxTqGJddCQZEgdUlou7WMkw6QUmT/B8kAP1YGxp4xzu6Qa1uJ9bCMAp1F3c1z9bv0FGG88BQ==
X-Received: by 2002:a17:902:8547:: with SMTP id
 d7mr40432783plo.171.1563330806454; 
 Tue, 16 Jul 2019 19:33:26 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:33:25 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:32:59 +0800
Message-Id: <20190717023310.197246-1-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::635
Subject: [Qemu-devel] [PATCH v14 00/11] qemu_thread_create: propagate the
 error to callers to handle
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
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This idea comes from BiteSizedTasks, and this patch series implement
the error checking of qemu_thread_create: make qemu_thread_create
return a flag to indicate if it succeeded rather than failing with
an error; make all callers check it.

The first patch modifies the qemu_thread_create() by passing
&error_abort and returing a value to indicate if it succeeds. The next
10 patches will improve on &error_abort for callers who could handle
more properly.

Please help to review, thanks a lot! 

v14:
- For patch 1/11, complement qemu_thread_create(xxx, &error_abort) for all 
  corresponding files, esp for files under tests/.

v13:
- Add one Acked-by for patch 2/11.
- Resend as the last version was divided into several parts. 

v12:
- For patch 6/11, make event_thread terminate by stopping vevent
  thread when failing to create handle_apdu_thread.
- Rectify the commit message for patch 7/11, 8/11.
- For patch 9/11, change two cleanup sentences' order when failing
  to create multifd_recv_thread.
- For patch 11/11, fix the SIGBUS conflict for touch_all_pages().

v11:
- Resend as I sent the last version in a mess..

v10:
- Make qemu_thread_create() return -errno instead of a Boolean.
- Add more cleanup for pci_edu_realize()/emulated_realize(). 
- Polish for iothread_complete()/compress_threads_save_cleanup()/
  vnc_start_worker_thread()/touch_all_pages.
- Change to return H_HARDWARE for h_resize_hpt_prepare().
- Remove five derivative patches as they have been merged.

v9:
- To ease the review and involve the appropriate maintainers, split
  the previous 6/7 patch into 10 patches: the 6/16 patch passes
  the &error_abort to qemu_thread_create() everywhere, and the next
  9 patches will improve on &error_abort for callers who need.
- Add a new patch 5/7 to unify error handling for 
  process_incoming_migration_co().
- Merge the previous 2/7 to current 7/16 to collaboratively handle
  for qemu_X_start_vcpu and for the qemu_init_vpcu in each arch.
- Add comment for multifd_recv_new_channel() in current patch 2/7.

v8:
- Remove previous two patches trying to fix the multifd issue on the
  source side, as we are still waiting for maintainer's opinions.
- Use atomic_read to get multifd_recv_state->count in patch 3/7.
- Get three more "Reviewed-by:".

v7:
- Split the previous multifd-migration into two patches: the src and
  the dst. For the dst, only dump the error instead of quitting.
- Safely do the cleanup for postcopy_ram_enable_notify().
- Split the previous migration-error-handling patch into two patches.

v6:
- Add a new migration-multifd related patch. BTW, delete the previous
  vnc related patch as it has been upstreamed.
- Use error_setg_errno() to set the errno when qemu_thread_create()
  fails for both Linux and Windows implementation.
- Optimize the first patch, less codes are needed

v5:
- Remove `errno = err` in qemu_thread_create() for Linux, and change
  `return errno` to `return -1` in qemu_signal_init() to indicate
  the error in case qemu_thread_create() fails.
- Delete the v4-added qemu_cond/mutex_destroy() in iothread_complete()
  as the destroy() will be done by its callers' object_unref().

v4:
- Separate the migration compression patch from this series
- Add one more error handling patch related with migration
- Add more cleaning up code for touched functions

v3:
- Add two migration related patches to fix the segmentaion fault
- Extract the segmentation fault fix from v2's last patch to be a
  separate patch

v2:
- Pass errp straightly instead of using a local_err & error_propagate
- Return a bool: false/true to indicate if one function succeeds
- Merge v1's last two patches into one to avoid the compile error
- Fix one omitted error in patch1 and update some error messages


Fei Li (11):
  qemu_thread: make qemu_thread_create() take Error ** argument
  qemu_thread: supplement error handling for qemu_X_start_vcpu
  qemu_thread: supplement error handling for qmp_dump_guest_memory
  qemu_thread: supplement error handling for pci_edu_realize
  qemu_thread: supplement error handling for h_resize_hpt_prepare
  qemu_thread: supplement error handling for emulated_realize
  qemu_thread: supplement error handling for iothread_complete
  qemu_thread: supplement error handling for qemu_signalfd_compat
  qemu_thread: supplement error handling for migration
  qemu_thread: supplement error handling for vnc_start_worker_thread
  qemu_thread: supplement error handling for touch_all_pages

 accel/tcg/user-exec-stub.c      |  3 +-
 cpus.c                          | 69 +++++++++++++++++++++++++----------------
 dump/dump.c                     |  2 +-
 hw/misc/edu.c                   | 11 +++++--
 hw/ppc/spapr_hcall.c            | 10 ++++--
 hw/rdma/rdma_backend.c          |  3 +-
 hw/usb/ccid-card-emulated.c     | 16 +++++++---
 include/qemu/thread.h           |  6 ++--
 include/qom/cpu.h               |  2 +-
 io/task.c                       |  3 +-
 iothread.c                      | 17 +++++++---
 migration/migration.c           | 30 ++++++++++++++----
 migration/postcopy-ram.c        | 14 +++++++--
 migration/ram.c                 | 66 ++++++++++++++++++++++++++-------------
 migration/savevm.c              | 11 +++++--
 target/alpha/cpu.c              |  4 ++-
 target/arm/cpu.c                |  4 ++-
 target/cris/cpu.c               |  4 ++-
 target/hppa/cpu.c               |  4 ++-
 target/i386/cpu.c               |  4 ++-
 target/lm32/cpu.c               |  4 ++-
 target/m68k/cpu.c               |  4 ++-
 target/microblaze/cpu.c         |  4 ++-
 target/mips/cpu.c               |  4 ++-
 target/moxie/cpu.c              |  4 ++-
 target/nios2/cpu.c              |  4 ++-
 target/openrisc/cpu.c           |  4 ++-
 target/ppc/translate_init.inc.c |  4 ++-
 target/riscv/cpu.c              |  4 ++-
 target/s390x/cpu.c              |  4 ++-
 target/sh4/cpu.c                |  4 ++-
 target/sparc/cpu.c              |  4 ++-
 target/tilegx/cpu.c             |  4 ++-
 target/tricore/cpu.c            |  4 ++-
 target/unicore32/cpu.c          |  4 ++-
 target/xtensa/cpu.c             |  4 ++-
 tests/atomic64-bench.c          |  3 +-
 tests/atomic_add-bench.c        |  3 +-
 tests/iothread.c                |  2 +-
 tests/qht-bench.c               |  3 +-
 tests/rcutorture.c              |  3 +-
 tests/test-aio.c                |  2 +-
 tests/test-char.c               |  6 ++--
 tests/test-rcu-list.c           |  3 +-
 tests/test-util-filemonitor.c   |  2 +-
 ui/cocoa.m                      |  2 +-
 ui/vnc-jobs.c                   | 17 +++++++---
 ui/vnc-jobs.h                   |  2 +-
 ui/vnc.c                        |  4 ++-
 util/compatfd.c                 | 13 ++++++--
 util/oslib-posix.c              | 34 +++++++++++++-------
 util/qemu-thread-posix.c        | 30 +++++++++++++-----
 util/qemu-thread-win32.c        | 13 ++++++--
 util/rcu.c                      |  3 +-
 util/thread-pool.c              |  4 ++-
 55 files changed, 351 insertions(+), 145 deletions(-)

-- 
2.11.0


