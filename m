Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC19C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 02:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC582089C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 02:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC582089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJTRk-0007X4-80
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 22:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJTPl-0006Gf-Ps
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 22:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJTPk-0001pI-N9
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 22:15:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:49573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iJTPk-0001o0-Em; Sat, 12 Oct 2019 22:15:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Oct 2019 19:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,290,1566889200"; d="scan'208";a="199076874"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga006.jf.intel.com with ESMTP; 12 Oct 2019 19:15:12 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: pbonzini@redhat.com, ehabkost@redhat.com, imammedo@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 den@openvz.org, marcandre.lureau@redhat.com, kraxel@redhat.com,
 mst@redhat.com, rth@twiddle.net, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mark.cave-ayland@ilande.co.uk,
 david@gibson.dropbear.id.au, yuval.shaia@oracle.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com, armbru@redhat.com, sw@weilnetz.de
Subject: [PATCH 0/2] cleanup on page size
Date: Sun, 13 Oct 2019 10:11:43 +0800
Message-Id: <20191013021145.16011-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch 1 simplify the definition of xxx_PAGE_ALIGN.
Patch 2 replaces getpagesize() with qemu_real_host_page_size. This one touch a
volume of code. If some point is not correct, I'd appreciate your
notification.

Wei Yang (2):
  cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
  core: replace getpagesize() with qemu_real_host_page_size

 accel/kvm/kvm-all.c            |  6 +++---
 backends/hostmem.c             |  2 +-
 block.c                        |  4 ++--
 block/file-posix.c             |  9 +++++----
 block/io.c                     |  2 +-
 block/parallels.c              |  2 +-
 block/qcow2-cache.c            |  2 +-
 contrib/vhost-user-gpu/vugbm.c |  2 +-
 exec.c                         |  6 +++---
 hw/intc/s390_flic_kvm.c        |  2 +-
 hw/ppc/mac_newworld.c          |  2 +-
 hw/ppc/spapr_pci.c             |  2 +-
 hw/rdma/vmw/pvrdma_main.c      |  2 +-
 hw/vfio/spapr.c                |  7 ++++---
 include/exec/cpu-all.h         |  7 +++----
 include/exec/ram_addr.h        |  2 +-
 include/qemu/osdep.h           |  4 ++--
 migration/migration.c          |  2 +-
 migration/postcopy-ram.c       |  4 ++--
 monitor/misc.c                 |  2 +-
 target/ppc/kvm.c               |  2 +-
 tests/vhost-user-bridge.c      |  8 ++++----
 util/mmap-alloc.c              | 10 +++++-----
 util/oslib-posix.c             |  4 ++--
 util/oslib-win32.c             |  2 +-
 util/vfio-helpers.c            | 12 ++++++------
 26 files changed, 55 insertions(+), 54 deletions(-)

-- 
2.17.1


