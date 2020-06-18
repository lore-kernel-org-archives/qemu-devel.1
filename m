Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255F4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AEE207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLCKFuuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AEE207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluVL-0005gl-4t
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluUU-0004RO-DT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:22:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45663
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluUR-0005hM-MG
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZEQzIL1Z9G66aOHdTTzR8GRP2bAEV4o8DzXYntx+S3c=;
 b=ZLCKFuuh/81jYz33NeirPLmCW+6CWc6RQ3hOtV4wdLJPMSlPx8GRcnYuSfskhzcbrl/wMO
 fXASaTEaSXJMpBeOxApx9RjTgMUbGIGgBXrTXKmTqIMoHus4zoEtpsXIuH4kzKlqt1jBqy
 hOGrsA1hIc2/hevefW5As1RRyLdROqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-nR1tnrBbP-SpXwp0y3Z6-g-1; Thu, 18 Jun 2020 09:21:54 -0400
X-MC-Unique: nR1tnrBbP-SpXwp0y3Z6-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 876D18005AD;
 Thu, 18 Jun 2020 13:21:53 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B6715BAC4;
 Thu, 18 Jun 2020 13:21:50 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 00/33] Net patches
Date: Thu, 18 Jun 2020 21:21:15 +0800
Message-Id: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3f429a3400822141651486193d6af625eeab05a5:

  Merge remote-tracking branch 'remotes/kraxel/tags/microvm-20200617-pull-request' into staging (2020-06-18 11:23:15 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 71830d8430e65dd20aec4765d87e60336148e1a6:

  net: Drop the NetLegacy structure, always use Netdev instead (2020-06-18 21:05:52 +0800)

----------------------------------------------------------------

Changes from V1:
- Fix build failure for virtio-net

----------------------------------------------------------------
Derek Su (1):
      colo-compare: Fix memory leak in packet_enqueue()

Helge Deller (1):
      Fix tulip breakage

Jason Wang (1):
      net: use peer when purging queue in qemu_flush_or_purge_queue_packets()

Lukas Straub (6):
      net/colo-compare.c: Create event_bh with the right AioContext
      chardev/char.c: Use qemu_co_sleep_ns if in coroutine
      net/colo-compare.c: Fix deadlock in compare_chr_send
      net/colo-compare.c: Only hexdump packets if tracing is enabled
      net/colo-compare.c: Check that colo-compare is active
      net/colo-compare.c: Correct ordering in complete and finalize

Philippe Mathieu-Daudé (3):
      hw/net/tulip: Fix 'Descriptor Error' definition
      hw/net/tulip: Log descriptor overflows
      hw/net/e1000e: Do not abort() on invalid PSRCTL register value

Sai Pavan Boddu (11):
      net: cadence_gem: Fix debug statements
      net: cadence_gem: Fix the queue address update during wrap around
      net: cadence_gem: Fix irq update w.r.t queue
      net: cadence_gem: Define access permission for interrupt registers
      net: cadence_gem: Set ISR according to queue in use
      net: cadence_gem: Move tx/rx packet buffert to CadenceGEMState
      net: cadence_gem: Fix up code style
      net: cadence_gem: Add support for jumbo frames
      net: cadnece_gem: Update irq_read_clear field of designcfg_debug1 reg
      net: cadence_gem: Update the reset value for interrupt mask register
      net: cadence_gem: TX_LAST bit should be set by guest

Thomas Huth (2):
      net: Drop the legacy "name" parameter from the -net option
      net: Drop the NetLegacy structure, always use Netdev instead

Tong Ho (1):
      net: cadence_gem: Fix RX address filtering

Yuri Benditovich (7):
      virtio-net: implement RSS configuration command
      virtio-net: implement RX RSS processing
      tap: allow extended virtio header with hash info
      virtio-net: reference implementation of hash report
      vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
      virtio-net: add migration support for RSS and hash report
      virtio-net: align RSC fields with updated virtio-net header

 chardev/char.c                 |   7 +-
 docs/system/deprecated.rst     |  15 +-
 hw/net/Makefile.objs           |   1 +
 hw/net/cadence_gem.c           | 458 +++++++++++++++++++++++------------------
 hw/net/e1000e_core.c           |  10 +-
 hw/net/trace-events            |   3 +
 hw/net/tulip.c                 |  12 +-
 hw/net/tulip.h                 |   2 +-
 hw/net/virtio-net.c            | 387 ++++++++++++++++++++++++++++++----
 include/hw/net/cadence_gem.h   |   6 +
 include/hw/virtio/virtio-net.h |  16 ++
 include/migration/vmstate.h    |  10 +
 net/colo-compare.c             | 277 ++++++++++++++++++-------
 net/colo.c                     |   7 +
 net/colo.h                     |   1 +
 net/net.c                      |  89 ++------
 net/tap.c                      |   3 +-
 net/trace-events               |   1 +
 qapi/net.json                  |  49 -----
 19 files changed, 905 insertions(+), 449 deletions(-)


