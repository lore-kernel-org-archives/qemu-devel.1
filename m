Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FBAC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A062A20702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv9NTrVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A062A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLZu-0001mc-Sk
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1izLVO-0001ad-1F
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1izLVL-0004n7-Fk
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52112
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1izLVL-0004kX-Av
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E7erb1J71XnkOrU1ffNBRRJNNXjpKQp5cTlWksxFItc=;
 b=Tv9NTrVs1XVKoRliuBMSxdL9D3DPs3i2HTSJDwun8jS3cT4cC5ApZQvjv7wXJ8bibiod4X
 udZcYzDgdpVulOX9L8NzS0VYWFvJ9YE++R/W3KkhNHH6WnU1m9wQeR8UAR+y8LAUpT3t7n
 /4Xw6/43nhCElnOs2zMJpkyiJYgwyjQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-jsgX-0x3PeeadvcydanSOA-1; Wed, 05 Feb 2020 09:17:55 -0500
Received: by mail-qv1-f72.google.com with SMTP id g15so1534900qvq.20
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IW1U/1qPgfny3TWJIyE/Niz4Ac6a9EPVOrq0M0aNuyY=;
 b=Z+qgqwvC3p8sVzEjepYMw43Q78l+LLn9Sy92SXeNCJ9GGcsLfSzHSiLAi+1CttoXHN
 ozCZmF5p7ta3xnqyZyrxltJv8WEvvj7Vyqlj6yym7mdOlIvszcZPsWBcufPaGRtuVN3t
 mA1qZGloCxtNrNaQPjiPTbbtCTuPMHUmibZcPetkx77TOreDKbDJkrI3PQz3bX68w+MF
 9SsRvtX/KrmovE4YNJWhXoQCVLeoomOv1Onm2JFeK7BR6DX9ti5N2xHMYa0l27l3uEYs
 sLWe77hSkPHxYLZzqI+qcfYu2ukGMe20lGC/xpDBcSdGLvOZJxf5TCB6yuMgoxt5WG1t
 /v9A==
X-Gm-Message-State: APjAAAWbBTXb1wufM0h3f/8rZeNoFJ39u76Me8Ai3oPjxaC7YwkWFO+W
 qSWJvkVourB7SoJgQ7Pbydf79eu+2bSOpzyhYYPet/7rPUBRtkoN3xw1Fnp+du7D18xgXrDmGFi
 85OZsT+jgatheyZs=
X-Received: by 2002:a05:6214:14a7:: with SMTP id
 bo7mr31152074qvb.132.1580912274476; 
 Wed, 05 Feb 2020 06:17:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdY5YHp4Vn0GspsvKtzE7zQMCk8ZAxxfZAPoUvHQAI4NpqThglL2LSysJi9pu0/B7srPKmyg==
X-Received: by 2002:a05:6214:14a7:: with SMTP id
 bo7mr31152047qvb.132.1580912274159; 
 Wed, 05 Feb 2020 06:17:54 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id q5sm12833489qkf.14.2020.02.05.06.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:17:53 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 0/9] KVM: Dirty ring support (QEMU part)
Date: Wed,  5 Feb 2020 09:17:40 -0500
Message-Id: <20200205141749.378044-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-MC-Unique: jsgX-0x3PeeadvcydanSOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is still RFC because the kernel counterpart is still under
review.  However please feel free to read into the code a bit if you
want; they've even got rich comments so not really in WIP status
itself.  Any kind of comments are greatly welcomed.

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
  KVM: Add dirty-ring-size property
  KVM: Dirty ring support

 accel/kvm/kvm-all.c         | 591 ++++++++++++++++++++++++++++++++----
 accel/kvm/trace-events      |   7 +
 include/exec/memory.h       |  12 +
 include/hw/core/cpu.h       |  10 +
 include/sysemu/kvm_int.h    |   5 +
 linux-headers/asm-x86/kvm.h |   1 +
 linux-headers/linux/kvm.h   |  44 +++
 memory.c                    |  33 +-
 qemu-options.hx             |   3 +
 9 files changed, 638 insertions(+), 68 deletions(-)

--=20
2.24.1


