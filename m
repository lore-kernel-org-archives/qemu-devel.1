Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D703C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641452146E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641452146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihCQC-0005FG-K7
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 07:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1ihCMV-0000OZ-9V
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1ihCMU-0001Di-1E
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:54:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:49328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1ihCMT-00018a-Mv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:54:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 04:54:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; d="scan'208";a="209689654"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga008.jf.intel.com with ESMTP; 17 Dec 2019 04:54:00 -0800
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V4 5/5] docs/awd.txt: Add doc to introduce Advanced
 WatchDog(AWD) module
Date: Tue, 17 Dec 2019 20:45:54 +0800
Message-Id: <20191217124554.30818-6-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217124554.30818-1-chen.zhang@intel.com>
References: <20191217124554.30818-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

Add docs to introduce Advanced WatchDog detail and usage.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 docs/awd.txt | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 docs/awd.txt

diff --git a/docs/awd.txt b/docs/awd.txt
new file mode 100644
index 0000000000..0ce513be5a
--- /dev/null
+++ b/docs/awd.txt
@@ -0,0 +1,88 @@
+Advanced Watch Dog (AWD)
+========================
+Copyright (c) 2019 Intel Corporation.
+Author: Zhang Chen <chen.zhang@intel.com>
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.
+See the COPYING file in the top-level directory.
+
+Introduction
+------------
+
+Advanced Watch Dog is an universal monitoring module on VMM side, it can be used
+to detect network issues(VMM to guest, VMM to VMM, VMM to another remote server)
+and do previously set operation. Current AWD accept any input as the signal
+to refresh the watchdog timer, and we can also make a certain interactive
+protocol here. Users can pre-write some command or some messages in the
+AWD opt-script as the notification output. We noticed that there is no way
+for VMM communicate directly, so we engaged with real customer found that they
+need a lightweight and efficient mechanism to solve some practical problems,
+for example Edge Computing cases(they think high level software is too heavy
+to use in Edge or it is hard to manage and combine with VM instance).
+It make user have basic VM/Host network monitoring tools and basic false
+tolerance and recovery solution.
+
+Use case
+--------
+
+1. Monitor local guest status.
+Running a simple application in guest for send signal to the local AWD module,
+if timeout occur, AWD will notify high level admin or do some previously set
+operation. For example send exit command to local QMP interface or qemu monitor.
+
+2. Monitor other VMM.
+AWD module can be connected to each other to build heartbeat service.
+
+3. Monitor other remote service.
+In some cases, remote service have certain relationship with current VM. If
+network connection have some issue, AWD can do some urgent operation like reboot
+local VM. etc...
+
+AWD usage
+---------
+
+User must "--enable-awd" in Qemu configuration.
+
+1. Monitor local guest status.
+
+-chardev socket,id=detection,host=0.0.0.0,port=9009,server,nowait
+-chardev socket,id=notification,host=127.0.0.1,port=4445
+-object iothread,id=iothread1
+-object advanced-watchdog,id=awd1,server=on,awd_node=detection,notification_node=notification,opt_script=colo_opt_script,iothread=iothread1,pulse_interval=1000,timeout=5000
+-monitor tcp::4445,server,nowait
+
+qemu_opt_script:
+quit
+
+Guest service need connect to detection node, admin can check notification node
+to get message when timeout occur.
+
+2. Monitor other VMM.
+
+Demo usage(for COLO heartbeat service):
+
+In primary node:
+
+-chardev socket,id=h1,host=3.3.3.3,port=9009,server,nowait
+-chardev socket,id=heartbeat0,host=3.3.3.3,port=4445
+-object iothread,id=iothread1
+-object advanced-watchdog,id=heart1,server=on,awd_node=h1,notification_node=heartbeat0,opt_script=colo_primary_opt_script,iothread=iothread1,pulse_interval=1000,timeout=5000
+
+colo_primary_opt_script:
+x_colo_lost_heartbeat
+
+In secondary node:
+
+-monitor tcp::4445,server,nowait
+-chardev socket,id=h1,host=3.3.3.3,port=9009,reconnect=1
+-chardev socket,id=heart1,host=3.3.3.8,port=4445
+-object iothread,id=iothread1
+-object advanced-watchdog,id=heart1,server=off,awd_node=h1,notification_node=heart1,opt_script=colo_secondary_opt_script,iothread=iothread1,timeout=10000
+
+colo_secondary_opt_script:
+nbd_server_stop
+x_colo_lost_heartbeat
+
+3. Monitor other remote service.
+
+Same like monitor local guest except detection node and notification node.
-- 
2.17.1


