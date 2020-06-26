Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828D2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50833212CC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50833212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jokbF-0004sw-EC
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1joka9-0003MS-Fh; Fri, 26 Jun 2020 05:23:37 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:34172
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1joka7-0004J0-4Y; Fri, 26 Jun 2020 05:23:37 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1joka1-0007bz-Kw; Fri, 26 Jun 2020 10:23:35 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, laurent@vivier.eu, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Fri, 26 Jun 2020 10:22:55 +0100
Message-Id: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 00/22] qemu-macppc queue 20200626
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 5acc270a355120ce967ca1f1eeca0abbdb9303c8:

  Merge remote-tracking branch 'remotes/xtensa/tags/20200625-xtensa' into staging (2020-06-25 21:20:45 +0100)

are available in the Git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-macppc-20200626

for you to fetch changes up to e590e7f01479a1d4544aac062fe9fdb986502294:

  adb: add ADB bus trace events (2020-06-26 10:13:52 +0100)

----------------------------------------------------------------
qemu-macppc patches

----------------------------------------------------------------
Mark Cave-Ayland (22):
      adb: coding style update to fix checkpatch errors
      adb: fix adb-mouse read length and revert disable-reg3-direct-writes workaround
      cuda: convert ADB autopoll timer from ns to ms
      pmu: fix duplicate autopoll mask variable
      pmu: honour autopoll_rate_ms when rearming the ADB autopoll timer
      adb: introduce realize/unrealize and VMStateDescription for ADB bus
      adb: create autopoll variables directly within ADBBusState
      cuda: convert to use ADBBusState internal autopoll variables
      pmu: convert to use ADBBusState internal autopoll variables
      mac_via: convert to use ADBBusState internal autopoll variables
      adb: introduce new ADBDeviceHasData method to ADBDeviceClass
      adb: keep track of devices with pending data
      adb: add status field for holding information about the last ADB request
      adb: use adb_request() only for explicit requests
      adb: add autopoll_blocked variable to block autopoll
      cuda: add adb_autopoll_block() and adb_autopoll_unblock() functions
      pmu: add adb_autopoll_block() and adb_autopoll_unblock() functions
      mac_via: move VIA1 portB write logic into mos6522_q800_via1_write()
      mac_via: rework ADB state machine to be compatible with both MacOS and Linux
      adb: only call autopoll callbacks when autopoll is not blocked
      adb: use adb_device prefix for ADB device trace events
      adb: add ADB bus trace events

 hw/input/adb-kbd.c           |  42 +++--
 hw/input/adb-mouse.c         |  65 ++++---
 hw/input/adb.c               | 210 ++++++++++++++++++++--
 hw/input/trace-events        |  27 +--
 hw/misc/mac_via.c            | 411 ++++++++++++++++++++++++++++---------------
 hw/misc/macio/cuda.c         |  60 +++----
 hw/misc/macio/pmu.c          |  47 +++--
 hw/misc/trace-events         |   3 +
 hw/ppc/mac_newworld.c        |   2 -
 include/hw/input/adb.h       |  26 ++-
 include/hw/misc/mac_via.h    |   2 +-
 include/hw/misc/macio/cuda.h |   4 -
 include/hw/misc/macio/pmu.h  |   4 -
 13 files changed, 620 insertions(+), 283 deletions(-)

