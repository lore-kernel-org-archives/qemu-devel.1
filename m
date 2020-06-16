Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D07520734
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EunwKH16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D07520734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5Om-0003By-9j
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5M9-0001T7-Nt
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28564
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5M6-0005XQ-4J
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592289954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=of9ENQ9gExj1RylS4N9QXbNk3ZPFMujVS9VLg/uC98E=;
 b=EunwKH16OB4bwXtiUd6AWrhp8fSKOKpyy9sYtb1sxTugr3p+zokx3/cRnw6g/YbnhlzkwJ
 0GmnFzhRZIhMp4PdvJSDzyTQArxqZCp/gbB8dTKvVZxtkH+hUylfI7UzqsN4H0Gkq2KUv0
 4tBykTOkI+3GnPVIfQTjoVFhYnEVWIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-SjXHGl9VMqCVY4OdY9bqEg-1; Tue, 16 Jun 2020 02:45:51 -0400
X-MC-Unique: SjXHGl9VMqCVY4OdY9bqEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27F408035E4;
 Tue, 16 Jun 2020 06:45:50 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-222.pek2.redhat.com
 [10.72.13.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABA8D8202D;
 Tue, 16 Jun 2020 06:45:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 00/33] Net patches
Date: Tue, 16 Jun 2020 14:45:11 +0800
Message-Id: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 955aab203f932b8a7c23ff9c58ba036997cb3ed8:

  net: Drop the NetLegacy structure, always use Netdev instead (2020-06-16 14:40:40 +0800)

----------------------------------------------------------------

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
 18 files changed, 904 insertions(+), 449 deletions(-)



