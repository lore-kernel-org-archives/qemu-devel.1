Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924EAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BBF20735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCZwVFEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BBF20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcdSX-00008t-I2
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 19:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRe-0006se-Vp
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40919
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRb-0000Oa-5J
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590276041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b08QrLnU9jv2ozncKQ+OlJbMdES6zeJZb8AxCljwpaU=;
 b=fCZwVFExMyFox5NsAd7q14pXfm3evBZYFPtccoxx35zb4BTC0rSDmHuJ2mwZ78W6K9V2rX
 mi7n2FglEz4H5cXXPJxp05uChtfTm/NTrsp6pGdjEs6caoYb4++hrAJ7GE7YkwfAOOh39p
 gJ/1CKaAv8dmYhhrIWSXMgukMwr29qQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-_w18AnAQOguiSdBhbExrbg-1; Sat, 23 May 2020 19:20:39 -0400
X-MC-Unique: _w18AnAQOguiSdBhbExrbg-1
Received: by mail-qk1-f198.google.com with SMTP id 25so14826380qkc.3
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 16:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b08QrLnU9jv2ozncKQ+OlJbMdES6zeJZb8AxCljwpaU=;
 b=VZcM/MOzfwlYtDjY9qzaqTNlfkCQvAgJKiKdlj5AswN+nRA/wmpATcjs3zrN/G97IU
 pb1FY1Jobqx44VY71FseROVK4kbKW/06uFj1cLEmitgD1Rizw5PqrWtN540vifgkhOe3
 +28JXz8VA6Q/xFPVPouObEvl3i3aBP5CCM0+9CVOPBKweRkIXyNhZw+saUESITXOuO6j
 cpLT9MS+t6PLo1H4qpWHkWncypiS4sz3Stjx4IK76GGVjEcJt1bEwzgaUBcCuccJX+yD
 YhLngaRtSUDYuXINJRb8UDvR1xMq0/wczJwFS8QoAzYx5dgqTcYiC8C0enFqRhGMOB1v
 kdUg==
X-Gm-Message-State: AOAM531dQGSLrh2eTfCM0cVyi3NWMe57apJfgDPrQhXnCggOheuIkaba
 k4H/2cLX0XKuFCEnkvDKBy+jGR+/zQYErTqjvoG3p49nenQlZQpafTJ3co8rVTB+1Yaf4+5TGJ2
 9vGP/hIPF0zqhMm4=
X-Received: by 2002:aed:3949:: with SMTP id l67mr21415197qte.313.1590276038886; 
 Sat, 23 May 2020 16:20:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTGJZ45ZTseidPTcao2ucc1A7EVSH9PH7q0juo3owOJ7Im2AfMMTUTmotGYvZ72i4a82oqrg==
X-Received: by 2002:aed:3949:: with SMTP id l67mr21415179qte.313.1590276038518; 
 Sat, 23 May 2020 16:20:38 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id m33sm11974235qtb.88.2020.05.23.16.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 16:20:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 00/11] KVM: Dirty ring support (QEMU part)
Date: Sat, 23 May 2020 19:20:24 -0400
Message-Id: <20200523232035.1029349-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 18:49:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I kept the dirty sync in kvm_set_phys_mem() for kvmslot removals, left a
comment on the known issue about strict dirty sync so we can fix it someday in
the future together with dirty log and dirty ring.

v3:
- added "KVM: Use a big lock to replace per-kml slots_lock"
  this is preparing for the last patch where we'll reap kvm dirty ring when
  removing kvmslots.
- added "KVM: Simplify dirty log sync in kvm_set_phys_mem"
  it's kind of a fix, but also a preparation of the last patch so it'll be very
  easy to add the dirty ring sync there
- the last patch is changed to handle correctly the dirty sync in kvmslot
  removal, also comment there about the known issues.
- reordered the patches a bit
- NOTE: since we kept the sync in memslot removal, this version does not depend
  on any other QEMU series - it is based on QEMU master

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
- rewrote many of the last patch to reduce LOC, now we do dirty ring reap only
  with BQL to simplify things, allowing the main or vcpu thread to directly
  call kvm_dirty_ring_reap() to collect dirty pages, so that we can drop a lot
  of synchronization variables like sems or eventfds.

For anyone who wants to try (we need to upgrade kernel too):

KVM branch:
  https://github.com/xzpeter/linux/tree/kvm-dirty-ring

QEMU branch for testing:
  https://github.com/xzpeter/qemu/tree/kvm-dirty-ring

Overview
========

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
default, dirty ring is still disabled (size==0).  To enable it, we
need to be with:

  -accel kvm,dirty-ring-size=65536

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

Peter Xu (11):
  linux-headers: Update
  memory: Introduce log_sync_global() to memory listener
  KVM: Fixup kvm_log_clear_one_slot() ioctl return check
  KVM: Use a big lock to replace per-kml slots_lock
  KVM: Create the KVMSlot dirty bitmap on flag changes
  KVM: Provide helper to get kvm dirty log
  KVM: Provide helper to sync dirty bitmap from slot to ramblock
  KVM: Simplify dirty log sync in kvm_set_phys_mem
  KVM: Cache kvm slot dirty bitmap size
  KVM: Add dirty-gfn-count property
  KVM: Dirty ring support

 accel/kvm/kvm-all.c         | 540 +++++++++++++++++++++++++++++++-----
 accel/kvm/trace-events      |   7 +
 include/exec/memory.h       |  12 +
 include/hw/core/cpu.h       |   8 +
 include/sysemu/kvm_int.h    |   7 +-
 linux-headers/asm-x86/kvm.h |   1 +
 linux-headers/linux/kvm.h   |  53 ++++
 memory.c                    |  33 ++-
 qemu-options.hx             |   5 +
 9 files changed, 581 insertions(+), 85 deletions(-)

-- 
2.26.2


