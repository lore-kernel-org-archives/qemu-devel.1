Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C073C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C15227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C15227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqCtx-00022A-SV
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 04:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34204)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqCse-00059P-Ec
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqCsZ-0002Cr-JZ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:44:08 -0400
Received: from mail.ispras.ru ([83.149.199.45]:58966)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqCsY-0002Bj-SK
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:44:07 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id BC71F54006A;
 Wed, 24 Jul 2019 11:44:04 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Jul 2019 11:44:04 +0300
Message-ID: <156395784459.510.4803952583406884224.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
References: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.2 09/14] replay: document development
 rules
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch introduces docs/devel/replay.txt which describes the rules
that should be followed to make virtual devices usable in record/replay mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgauk@ispras.ru>

--

v9: fixed external virtual clock description (reported by Artem Pisarenko)
---
 docs/devel/replay.txt |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 docs/devel/replay.txt

diff --git a/docs/devel/replay.txt b/docs/devel/replay.txt
new file mode 100644
index 0000000000..e641c35add
--- /dev/null
+++ b/docs/devel/replay.txt
@@ -0,0 +1,46 @@
+Record/replay mechanism, that could be enabled through icount mode, expects
+the virtual devices to satisfy the following requirements.
+
+The main idea behind this document is that everything that affects
+the guest state during execution in icount mode should be deterministic.
+
+Timers
+======
+
+All virtual devices should use virtual clock for timers that change the guest
+state. Virtual clock is deterministic, therefore such timers are deterministic
+too.
+
+Virtual devices can also use realtime clock for the events that do not change
+the guest state directly. When the clock ticking should depend on VM execution
+speed, use virtual clock with EXTERNAL attribute. It is not deterministic,
+but its speed depends on the guest execution. This clock is used by
+the virtual devices (e.g., slirp routing device) that lie outside the
+replayed guest.
+
+Bottom halves
+=============
+
+Bottom half callbacks, that affect the guest state, should be invoked through
+replay_bh_schedule_event or replay_bh_schedule_oneshot_event functions.
+Their invocations are saved in record mode and synchronized with the existing
+log in replay mode.
+
+Saving/restoring the VM state
+=============================
+
+All fields in the device state structure (including virtual timers)
+should be restored by loadvm to the same values they had before savevm.
+
+Avoid accessing other devices' state, because the order of saving/restoring
+is not defined. It means that you should not call functions like
+'update_irq' in post_load callback. Save everything explicitly to avoid
+the dependencies that may make restoring the VM state non-deterministic.
+
+Stopping the VM
+===============
+
+Stopping the guest should not interfere with its state (with the exception
+of the network connections, that could be broken by the remote timeouts).
+VM can be stopped at any moment of replay by the user. Restarting the VM
+after that stop should not break the replay by the unneeded guest state change.


