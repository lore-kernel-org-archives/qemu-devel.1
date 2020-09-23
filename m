Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3752AC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F3221D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifem6szo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F3221D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6bR-0007ee-Ik
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL6YC-000348-0s
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL6Y9-0004vu-AC
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600874354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Pa/RbBj8ICBKRzq+OGO8l65CbIOFbQUlD/8xZlIbPE=;
 b=ifem6szoLXroEf+JPgkWEgYKMZGhpGlt7VVt258+R8UNwij6TulVH3Lseyby7nA/XwhYDo
 Tv5D8pX1ufM3zhzTuTSB9aigj4pDPlgBZVyDB6anSZb0qyh5xL5M2AroKOjh7TSww69NRA
 B06nf+nS5WUEWMNkUPXfzcARqxd5Cjo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-nlPDv8YgMtWjv-vMV4p71Q-1; Wed, 23 Sep 2020 11:19:11 -0400
X-MC-Unique: nlPDv8YgMtWjv-vMV4p71Q-1
Received: by mail-wr1-f71.google.com with SMTP id 33so9000160wre.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 08:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5Pa/RbBj8ICBKRzq+OGO8l65CbIOFbQUlD/8xZlIbPE=;
 b=Mcb8280WtnrGiU0PHXCAtT6QJerCUX7VuLXcdVk2BzPBYzCFvzQefs4QnWpt4B+Gmr
 DIz1gyI2X2GTpl7+oIagDnp/KequrYF14ujsbtPZ3pKov9VjW/eNQJQ0dH5UUTSl0tns
 ze6y8OQd/dVF7PXFTwBw7UiphzULx+Q8GDpDRjiRcNziMN8AznmAdxDTEGnWDpuCtWL5
 vF3M/0faJQ6b24nltiQ9zuOHdE590reN9MS3/r04XtjL9vZEgEaQkzVKGc+zTEsdCOfv
 zamApoIjkNuC/SIqQiN8rPphSWzmgz0gzKZwvCYLi7LE+LYr3x6q8zyp75Me+KtQ4893
 VLhw==
X-Gm-Message-State: AOAM530eEUOpr4JV09JF7Zh7I8e8UpPvUfTohq9RYLbE/ITdf0qR0/Sl
 2Gf2j/tcLV75fEJ32UMHRLgbDgu5g5VoP1ibWRmC4TyYGfdodYT4DvGDrLESktChqVbWzbfSG0r
 gHJnT+MMIn+KDgQg=
X-Received: by 2002:adf:e6c7:: with SMTP id y7mr127964wrm.147.1600874349429;
 Wed, 23 Sep 2020 08:19:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAszoiVbgF78o7P3CBpqQS2ATd/VZdDKv7YGlU3hs7tNJ9AhbVMnBgYZHmA35+zrPPXN8k1w==
X-Received: by 2002:adf:e6c7:: with SMTP id y7mr127939wrm.147.1600874349133;
 Wed, 23 Sep 2020 08:19:09 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n14sm98127wmi.33.2020.09.23.08.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 08:19:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] qemu/atomic.h: rename atomic_ to qatomic_
Date: Wed, 23 Sep 2020 17:18:59 +0200
Message-Id: <20200923151901.745277-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a respin of Stefan's already reviewed patch,
fixing checkpatch.pl issues first.

Philippe Mathieu-Daudé (1):
  qemu/atomic: Update coding style to make checkpatch.pl happier

Stefan Hajnoczi (1):
  qemu/atomic.h: rename atomic_ to qatomic_

 docs/devel/atomics.rst                        | 134 +++++-----
 docs/devel/lockcnt.txt                        |   8 +-
 docs/devel/rcu.txt                            |  34 +--
 accel/tcg/atomic_template.h                   |  20 +-
 include/block/aio-wait.h                      |   4 +-
 include/block/aio.h                           |   8 +-
 include/exec/cpu_ldst.h                       |   2 +-
 include/exec/exec-all.h                       |   6 +-
 include/exec/log.h                            |   6 +-
 include/exec/memory.h                         |   2 +-
 include/exec/ram_addr.h                       |  26 +-
 include/exec/ramlist.h                        |   2 +-
 include/exec/tb-lookup.h                      |   4 +-
 include/hw/core/cpu.h                         |   2 +-
 include/qemu/atomic.h                         | 249 +++++++++---------
 include/qemu/atomic128.h                      |   6 +-
 include/qemu/bitops.h                         |   2 +-
 include/qemu/coroutine.h                      |   2 +-
 include/qemu/log.h                            |   6 +-
 include/qemu/queue.h                          |   7 +-
 include/qemu/rcu.h                            |  10 +-
 include/qemu/rcu_queue.h                      | 100 +++----
 include/qemu/seqlock.h                        |   8 +-
 include/qemu/stats64.h                        |  28 +-
 include/qemu/thread.h                         |  24 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_ring.h    |  14 +-
 linux-user/qemu.h                             |   2 +-
 tcg/i386/tcg-target.h                         |   2 +-
 tcg/s390/tcg-target.h                         |   2 +-
 tcg/tci/tcg-target.h                          |   2 +-
 accel/kvm/kvm-all.c                           |  12 +-
 accel/tcg/cpu-exec.c                          |  15 +-
 accel/tcg/cputlb.c                            |  24 +-
 accel/tcg/tcg-all.c                           |   2 +-
 accel/tcg/translate-all.c                     |  55 ++--
 audio/jackaudio.c                             |  18 +-
 block.c                                       |   4 +-
 block/block-backend.c                         |  15 +-
 block/io.c                                    |  48 ++--
 block/nfs.c                                   |   2 +-
 block/sheepdog.c                              |   2 +-
 block/throttle-groups.c                       |  12 +-
 block/throttle.c                              |   4 +-
 blockdev.c                                    |   2 +-
 blockjob.c                                    |   2 +-
 contrib/libvhost-user/libvhost-user.c         |   2 +-
 cpus-common.c                                 |  26 +-
 dump/dump.c                                   |   8 +-
 exec.c                                        |  49 ++--
 hw/core/cpu.c                                 |   6 +-
 hw/display/qxl.c                              |   4 +-
 hw/hyperv/hyperv.c                            |  10 +-
 hw/hyperv/vmbus.c                             |   2 +-
 hw/i386/xen/xen-hvm.c                         |   2 +-
 hw/intc/rx_icu.c                              |  12 +-
 hw/intc/sifive_plic.c                         |   4 +-
 hw/misc/edu.c                                 |  16 +-
 hw/net/virtio-net.c                           |  10 +-
 hw/rdma/rdma_backend.c                        |  18 +-
 hw/rdma/rdma_rm.c                             |   2 +-
 hw/rdma/vmw/pvrdma_dev_ring.c                 |   4 +-
 hw/s390x/s390-pci-bus.c                       |   2 +-
 hw/s390x/virtio-ccw.c                         |   2 +-
 hw/virtio/vhost.c                             |   2 +-
 hw/virtio/virtio-mmio.c                       |   6 +-
 hw/virtio/virtio-pci.c                        |   6 +-
 hw/virtio/virtio.c                            |  16 +-
 hw/xtensa/pic_cpu.c                           |   4 +-
 iothread.c                                    |   6 +-
 linux-user/hppa/cpu_loop.c                    |  11 +-
 linux-user/signal.c                           |   8 +-
 migration/colo-failover.c                     |   4 +-
 migration/migration.c                         |   8 +-
 migration/multifd.c                           |  18 +-
 migration/postcopy-ram.c                      |  34 +--
 migration/rdma.c                              |  34 +--
 monitor/hmp.c                                 |   6 +-
 monitor/misc.c                                |   2 +-
 monitor/monitor.c                             |   6 +-
 qemu-nbd.c                                    |   2 +-
 qga/commands.c                                |  12 +-
 qom/object.c                                  |  20 +-
 scsi/qemu-pr-helper.c                         |   4 +-
 softmmu/cpu-throttle.c                        |  10 +-
 softmmu/cpus.c                                |  42 +--
 softmmu/memory.c                              |   6 +-
 softmmu/vl.c                                  |   2 +-
 target/arm/mte_helper.c                       |   6 +-
 target/hppa/op_helper.c                       |   2 +-
 target/i386/mem_helper.c                      |   2 +-
 target/i386/whpx-all.c                        |   6 +-
 target/riscv/cpu_helper.c                     |   2 +-
 target/s390x/mem_helper.c                     |   4 +-
 target/xtensa/exc_helper.c                    |   4 +-
 target/xtensa/op_helper.c                     |   2 +-
 tcg/tcg.c                                     |  58 ++--
 tcg/tci.c                                     |   2 +-
 tests/atomic64-bench.c                        |  14 +-
 tests/atomic_add-bench.c                      |  14 +-
 tests/iothread.c                              |   2 +-
 tests/qht-bench.c                             |  12 +-
 tests/rcutorture.c                            |  24 +-
 tests/test-aio-multithread.c                  |  52 ++--
 tests/test-logging.c                          |   4 +-
 tests/test-rcu-list.c                         |  38 +--
 tests/test-thread-pool.c                      |  10 +-
 util/aio-posix.c                              |  14 +-
 util/aio-wait.c                               |   2 +-
 util/aio-win32.c                              |   5 +-
 util/async.c                                  |  28 +-
 util/atomic64.c                               |  10 +-
 util/bitmap.c                                 |  15 +-
 util/cacheinfo.c                              |   2 +-
 util/fdmon-epoll.c                            |   4 +-
 util/fdmon-io_uring.c                         |  12 +-
 util/lockcnt.c                                |  52 ++--
 util/log.c                                    |  10 +-
 util/qemu-coroutine-lock.c                    |  18 +-
 util/qemu-coroutine-sleep.c                   |   4 +-
 util/qemu-coroutine.c                         |   6 +-
 util/qemu-sockets.c                           |   4 +-
 util/qemu-thread-posix.c                      |  12 +-
 util/qemu-thread-win32.c                      |  12 +-
 util/qemu-timer.c                             |  12 +-
 util/qht.c                                    |  57 ++--
 util/qsp.c                                    |  50 ++--
 util/rcu.c                                    |  38 +--
 util/stats64.c                                |  34 +--
 scripts/kernel-doc                            |   2 +-
 tcg/aarch64/tcg-target.c.inc                  |   2 +-
 tcg/mips/tcg-target.c.inc                     |   2 +-
 tcg/ppc/tcg-target.c.inc                      |   6 +-
 tcg/sparc/tcg-target.c.inc                    |   5 +-
 133 files changed, 1045 insertions(+), 1018 deletions(-)

-- 
2.26.2


