Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6B3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74ACE2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjS5Dh1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74ACE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuQ4-00009V-FL
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxuOw-0006pB-6d
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:41:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35664
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxuOu-0000Kd-BE
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595346111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dpLBN90h8xEKXiY5MCjCwLuyZuXs/+p3jcJx1bPulvc=;
 b=BjS5Dh1R54edBL5mkf8VAVOM9FUEHZoUP6HCuFJ6so1ZzvLNbdN7Iix8ozHv4ryPgGN82j
 2lfmDATREI9nsJ+sdXk5y1rrpqq3PNHhFrZ2JFaRErNdcaq0OW/Jl6A0jnDWv5Ws0kqBQe
 47qwdrrNRVx5flVn2N/eq2fphqGJxlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-D8Ilr-FgOkC2iC8znC-3qA-1; Tue, 21 Jul 2020 11:41:49 -0400
X-MC-Unique: D8Ilr-FgOkC2iC8znC-3qA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6A341083E85;
 Tue, 21 Jul 2020 15:41:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A63A4610F3;
 Tue, 21 Jul 2020 15:41:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61927111CA27; Tue, 21 Jul 2020 17:41:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] QOM patches for 2020-07-21
Date: Tue, 21 Jul 2020 17:41:44 +0200
Message-Id: <20200721154147.1657100-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:17:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit af3d69058e09bede9900f266a618ed11f76f49f3:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200720' into staging (2020-07-20 15:58:07 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qom-2020-07-21

for you to fetch changes up to 0dde9fd12fd39762ff68fca80d2f0a735d66e7bd:

  qom: Make info qom-tree sort children more efficiently (2020-07-21 17:39:37 +0200)

----------------------------------------------------------------
QOM patches for 2020-07-21

----------------------------------------------------------------
Markus Armbruster (3):
      qom: Change object_get_canonical_path_component() not to malloc
      qom: Document object_get_canonical_path() returns malloced string
      qom: Make info qom-tree sort children more efficiently

 include/qom/object.h       |  7 ++++---
 backends/hostmem.c         |  2 +-
 block/throttle-groups.c    |  2 +-
 gdbstub.c                  |  2 +-
 hw/arm/xlnx-zynqmp.c       |  6 ++----
 hw/block/nvme.c            |  5 ++---
 hw/core/machine-qmp-cmds.c |  2 +-
 hw/core/machine.c          |  5 ++---
 hw/mem/nvdimm.c            |  5 ++---
 hw/mem/pc-dimm.c           |  5 ++---
 hw/misc/ivshmem.c          |  5 ++---
 hw/ppc/spapr_drc.c         |  3 +--
 hw/virtio/virtio-crypto.c  |  5 ++---
 hw/virtio/virtio-mem.c     |  6 ++----
 hw/virtio/virtio-pmem.c    |  5 ++---
 iothread.c                 |  9 ++++-----
 net/net.c                  |  6 ++----
 qom/object.c               |  7 +++----
 qom/qom-hmp-cmds.c         | 32 +++++++++++++++-----------------
 scsi/pr-manager-helper.c   |  3 +--
 scsi/pr-manager.c          |  2 +-
 softmmu/memory.c           |  2 +-
 hw/ppc/trace-events        |  2 +-
 23 files changed, 55 insertions(+), 73 deletions(-)

-- 
2.26.2


