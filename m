Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A564EC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCE32137B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX7yNfUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCE32137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWNV-0003Xg-Ig
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWLv-0002A7-4k
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWLt-000721-MM
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:57:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTWLt-00071m-7D
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588103827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YG29TrIWeASelkGLb7pYGxcqH4u5qSi3WPtcNG4ILRo=;
 b=eX7yNfUk3TFVFEgsWa+tnxjJYmJ6GU6kH8wMX0K4CnL0CBqMZnQgCv3wRjES8guu/2PnE0
 /vO6R/wbSO3DLGhRQhRUkzLhBgis0uxCIDqK0GFvouPGS4DCl1MsD22G7LoS6BSigwMh5A
 TG8UVG1k1RO0EgD+COST+amDLW/9lGA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-EJ31nYasMtCxaonWNkbyZA-1; Tue, 28 Apr 2020 15:57:03 -0400
X-MC-Unique: EJ31nYasMtCxaonWNkbyZA-1
Received: by mail-qv1-f70.google.com with SMTP id x26so19264030qvd.20
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 12:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kTMrzSiQi1185W++51/EqepfDhkzFPBWPDUy1hmnxdc=;
 b=ptAgZjXeP5+9puvOKfWYHYY0qt5MrjYociu3uErtBE+ZrUvyeun2u6U8Ul2mUOeTkl
 FBYbgqmCXuY0kHqVBhjhCISA/mHjdkzK8lEtrRRz1FWmx5czhEfljneZJTuM5H8ld4+l
 v3247WKTg+633MoJjjasx7LhcjEa1vjMIuFrw4qwU3ew5P26St08iVyMCxLI2SUqBJrQ
 RR5U4Iifwxu7zw5CSoqNqmN1XplRYRgJqy2hJApFYoGd7USgxCEnqKxqak4tlxyZ0Hfi
 yR0+Iotd27RJ3IlLMVQw948CsHAgsQy8eityS2hhkkwaYOX3ZsocYuYrcgU8bqLyPGR6
 QISg==
X-Gm-Message-State: AGi0PualyvB/meaUjcOIBHnsLSHUfphro60OfgX10HTmIQUhcrtGoumo
 MQnmI+23o3DgSyOwkCf2i7cvQW726qhcz6ybB8Td1fp3IwV+g+tkveorFyObm/EdqfYzppvzl/D
 f17rmoRpwwWPOSh8=
X-Received: by 2002:ad4:4a27:: with SMTP id n7mr30222668qvz.80.1588103822384; 
 Tue, 28 Apr 2020 12:57:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypJVotCDjg6zP0bTetZs0yZ8l90jFMkVN3m8YoD+vXH8jPehlXfuTuEVqrhmdrinDxTY3FDcZQ==
X-Received: by 2002:ad4:4a27:: with SMTP id n7mr30222638qvz.80.1588103821955; 
 Tue, 28 Apr 2020 12:57:01 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id o22sm14376588qtm.90.2020.04.28.12.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 12:57:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 0/9] KVM: Dirty ring support (QEMU part)
Date: Tue, 28 Apr 2020 15:56:58 -0400
Message-Id: <20200428195707.11980-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Still RFC.  Firstly, the kernel series is mostly stall recently... Secondly=
, we
still haven't settled on how we should handle the dirty sync in kvm mem
removal.  This version is based on the other QEMU series:

  "vl: Sync dirty bitmap when system resets"

Another major change of this series is that I tried to simplify the last pa=
tch
by allowing the main/vcpu threads to directly call kvm_dirty_ring_reap(), e=
tc.
Many of the eventfds/semaphores are removed (so less LOC in the last patch)=
,
hopefully that could make the last patch even easier to review.

v2:
- add r-bs for Dave
- change dirty-ring-size parameter from int64 to uint64_t [Dave]
- remove an assertion for KVM_GET_DIRTY_LOG [Dave]
- document update: "per vcpu" dirty ring [Dave]
- rename KVMReaperState to KVMDirtyRingReaperState [Dave]
- dump errno when kvm_init_vcpu fails with dirty ring [Dave]
- switch to use dirty-ring-gfns as parameter [Dave]
- comment MAP_SHARED [Dave]
- dump more info when enable dirty ring failed [Dave]
- add kvm_dirty_ring_enabled flag to show whether dirty ring enabled
- rewrote many of the last patch to reduce LOC, now we do dirty ring reap o=
nly
  with BQL to simplify things, allowing the main or vcpu thread to directly
  call kvm_dirty_ring_reap() to collect dirty pages, so that we can drop a =
lot
  of synchronization variables like sems or eventfds.

For anyone who wants to try (we need to upgrade kernel too):

KVM branch:
  https://github.com/xzpeter/linux/tree/kvm-dirty-ring

QEMU branch for testing:
  https://github.com/xzpeter/qemu/tree/kvm-dirty-ring

Overview
=3D=3D=3D=3D=3D=3D=3D=3D

KVM dirty ring is a new interface to pass over dirty bits from kernel
to the userspace.  Instead of using a bitmap for each memory region,
the dirty ring contains an array of dirtied GPAs to fetch, one ring
per vcpu.

There're a few major changes comparing to how the old dirty logging
interface would work:

- Granularity of dirty bits

  KVM dirty ring interface does not offer memory region level
  granularity to collect dirty bits (i.e., per KVM memory
  slot). Instead the dirty bit is collected globally for all the vcpus
  at once.  The major effect is on VGA part because VGA dirty tracking
  is enabled as long as the device is created, also it was in memory
  region granularity.  Now that operation will be amplified to a VM
  sync.  Maybe there's smarter way to do the same thing in VGA with
  the new interface, but so far I don't see it affects much at least
  on regular VMs.

- Collection of dirty bits

  The old dirty logging interface collects KVM dirty bits when
  synchronizing dirty bits.  KVM dirty ring interface instead used a
  standalone thread to do that.  So when the other thread (e.g., the
  migration thread) wants to synchronize the dirty bits, it simply
  kick the thread and wait until it flushes all the dirty bits to the
  ramblock dirty bitmap.

A new parameter "dirty-ring-size" is added to "-accel kvm".  By
default, dirty ring is still disabled (size=3D=3D0).  To enable it, we
need to be with:

  -accel kvm,dirty-ring-size=3D65536

This establishes a 64K dirty ring buffer per vcpu.  Then if we
migrate, it'll switch to dirty ring.

I gave it a shot with a 24G guest, 8 vcpus, using 10g NIC as migration
channel.  When idle or dirty workload small, I don't observe major
difference on total migration time.  When with higher random dirty
workload (800MB/s dirty rate upon 20G memory, worse for kvm dirty
ring). Total migration time is (ping pong migrate for 6 times, in
seconds):

|-------------------------+---------------|
| dirty ring (4k entries) | dirty logging |
|-------------------------+---------------|
|                      70 |            58 |
|                      78 |            70 |
|                      72 |            48 |
|                      74 |            52 |
|                      83 |            49 |
|                      65 |            54 |
|-------------------------+---------------|

Summary:

dirty ring average:    73s
dirty logging average: 55s

The KVM dirty ring will be slower in above case.  The number may show
that the dirty logging is still preferred as a default value because
small/medium VMs are still major cases, and high dirty workload
happens frequently too.  And that's what this series did.

Please refer to the code and comment itself for more information.

Thanks,

Peter Xu (9):
  KVM: Fixup kvm_log_clear_one_slot() ioctl return check
  linux-headers: Update
  memory: Introduce log_sync_global() to memory listener
  KVM: Create the KVMSlot dirty bitmap on flag changes
  KVM: Provide helper to get kvm dirty log
  KVM: Provide helper to sync dirty bitmap from slot to ramblock
  KVM: Cache kvm slot dirty bitmap size
  KVM: Add dirty-gfn-count property
  KVM: Dirty ring support

 accel/kvm/kvm-all.c                           | 517 ++++++++++++++++--
 accel/kvm/trace-events                        |   7 +
 include/exec/memory.h                         |  12 +
 include/hw/core/cpu.h                         |   8 +
 include/standard-headers/linux/ethtool.h      |  10 +-
 .../linux/input-event-codes.h                 |   5 +-
 include/standard-headers/linux/pci_regs.h     |   2 +
 .../standard-headers/linux/virtio_balloon.h   |   1 +
 include/standard-headers/linux/virtio_ids.h   |   1 +
 include/sysemu/kvm_int.h                      |   5 +
 linux-headers/COPYING                         |   2 +
 linux-headers/asm-x86/kvm.h                   |   2 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/kvm.h                     | 100 +++-
 linux-headers/linux/mman.h                    |   5 +-
 linux-headers/linux/userfaultfd.h             |  40 +-
 linux-headers/linux/vfio.h                    |  37 ++
 memory.c                                      |  33 +-
 qemu-options.hx                               |   5 +
 21 files changed, 714 insertions(+), 81 deletions(-)

--=20
2.24.1


