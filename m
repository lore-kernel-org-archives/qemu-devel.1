Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6445DC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DDD2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeaUOPqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DDD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5li-00072z-16
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5kZ-0005WD-CH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5kY-0002YS-3L
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:44:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38653
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5kX-0002OS-LO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xeSlNIqBo+3bOKM0BS7ymnQOyYt8toh1YBmQ3QGhz4E=;
 b=TeaUOPqDt94ySrV8LY1OBdu6uGYcodJNHqlLPUtn2qJa2sAxzt6DYyz0SHSulSHWoCDmiK
 TxOdKVPsZzxWwqqZ5DsLTdAqS6YrorXpNe80PknEQL+z5wH6YN5EwA5Z4wKdS6wlBtoJVT
 PCqvYuLq1qnkgLl2E7NinwwVxm/zYes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-SpGXIEYtOIaPb1pKnbI5PQ-1; Thu, 30 Apr 2020 05:44:52 -0400
X-MC-Unique: SpGXIEYtOIaPb1pKnbI5PQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BEDF107ACCD;
 Thu, 30 Apr 2020 09:44:51 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D17A710016E8;
 Thu, 30 Apr 2020 09:44:50 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/20] first set of s390x patches for 5.1
Date: Thu, 30 Apr 2020 11:44:25 +0200
Message-Id: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ee573f5326046223b6eef4ae7fbfec31d274e093=
:

  Update version for v5.0.0-rc4 release (2020-04-22 17:51:35 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20200430

for you to fetch changes up to fbc1384ccd48fa7c0c38f950adf7992a4fb6042e:

  s390x/s390-virtio-ccw: Fix build on systems without KVM (2020-04-29 14:36=
:19 +0200)

----------------------------------------------------------------
- update Linux headers to 5.7-rc3 (and virtio-net fixup)
- support for protected virtualization aka secure execution

----------------------------------------------------------------

Christian Borntraeger (3):
  s390x: Add unpack facility feature to GA1
  s390x/pv: Retry ioctls on -EINTR
  s390x/s390-virtio-ccw: Fix build on systems without KVM

Cornelia Huck (2):
  virtio-net: fix rsc_ext compat handling
  linux-headers: update against Linux 5.7-rc3

Janosch Frank (15):
  s390x: Move diagnose 308 subcodes and rcs into ipl.h
  s390x: protvirt: Support unpack facility
  s390x: protvirt: Add migration blocker
  s390x: protvirt: Inhibit balloon when switching to protected mode
  s390x: protvirt: KVM intercept changes
  s390x: Add SIDA memory ops
  s390x: protvirt: Move STSI data over SIDAD
  s390x: protvirt: SCLP interpretation
  s390x: protvirt: Set guest IPL PSW
  s390x: protvirt: Move diag 308 data over SIDA
  s390x: protvirt: Disable address checks for PV guest IO emulation
  s390x: protvirt: Move IO control structures over SIDA
  s390x: protvirt: Handle SIGP store status correctly
  docs: system: Add protvirt docs
  s390x: protvirt: Fix stray error_report_err in s390_machine_protect

 MAINTAINERS                                   |   2 +
 docs/system/s390x/protvirt.rst                |  60 ++++++++
 docs/system/target-s390x.rst                  |   5 +
 hw/net/virtio-net.c                           |   4 +-
 hw/s390x/Makefile.objs                        |   1 +
 hw/s390x/ipl.c                                |  59 +++++++-
 hw/s390x/ipl.h                                | 103 ++++++++++++-
 hw/s390x/pv.c                                 | 113 +++++++++++++++
 hw/s390x/s390-virtio-ccw.c                    | 137 +++++++++++++++++-
 hw/s390x/sclp.c                               |  56 +++++--
 include/hw/s390x/pv.h                         |  58 ++++++++
 include/hw/s390x/s390-virtio-ccw.h            |   1 +
 include/hw/s390x/sclp.h                       |   2 +
 include/standard-headers/linux/ethtool.h      |  10 +-
 .../linux/input-event-codes.h                 |   5 +-
 include/standard-headers/linux/pci_regs.h     |   2 +
 include/standard-headers/linux/vhost_types.h  |   8 +
 .../standard-headers/linux/virtio_balloon.h   |  12 +-
 include/standard-headers/linux/virtio_ids.h   |   1 +
 include/standard-headers/linux/virtio_net.h   | 102 ++++++++++++-
 linux-headers/COPYING                         |   2 +
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/kvm.h                     |  47 +++++-
 linux-headers/linux/mman.h                    |   5 +-
 linux-headers/linux/userfaultfd.h             |  40 ++++-
 linux-headers/linux/vfio.h                    |  37 +++++
 linux-headers/linux/vhost.h                   |  24 +++
 target/s390x/cpu.c                            |  27 ++--
 target/s390x/cpu.h                            |   7 +-
 target/s390x/cpu_features_def.inc.h           |   1 +
 target/s390x/diag.c                           |  75 +++++++---
 target/s390x/gen-features.c                   |   1 +
 target/s390x/helper.c                         |   6 +
 target/s390x/ioinst.c                         |  96 +++++++++---
 target/s390x/kvm-stub.c                       |   5 +
 target/s390x/kvm.c                            |  79 +++++++++-
 target/s390x/kvm_s390x.h                      |   3 +
 target/s390x/mmu_helper.c                     |  14 ++
 41 files changed, 1116 insertions(+), 98 deletions(-)
 create mode 100644 docs/system/s390x/protvirt.rst
 create mode 100644 hw/s390x/pv.c
 create mode 100644 include/hw/s390x/pv.h

--=20
2.21.1


