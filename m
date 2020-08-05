Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D52BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB8920792
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oadst9Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB8920792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GFG-0006FQ-Hh
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3GBW-0001A1-FI
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:58:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3GBU-0008T2-8O
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596621487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnkKxCrzj77znQ8ce8IbBK+b5Sg1sxMgeuXeBgi//kw=;
 b=Oadst9QaGYYzLLwAqM+MNmtF6sVPaSxCZkmROdUwnB+38+28IHSWFTSWLGvhD87qJEis0U
 /+1AnUlSJQvjYE9I4fCrP3rHwBtWgdtumdxQqLVQLqE2oZ1Fgq4UDx7dpkbd2/FHMdqOOo
 1mzmBmTYVF5Jfa0CceL9ILSLQckI+qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-AV6HoqsMOGK_DgEWV7zylw-1; Wed, 05 Aug 2020 05:58:05 -0400
X-MC-Unique: AV6HoqsMOGK_DgEWV7zylw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AF03106B24C;
 Wed,  5 Aug 2020 09:58:04 +0000 (UTC)
Received: from thuth.com (ovpn-112-142.ams2.redhat.com [10.36.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7ACC2DE98;
 Wed,  5 Aug 2020 09:58:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/6] tests/acceptance: Disable the rx sash and arm cubieboard
 replay test on Gitlab
Date: Wed,  5 Aug 2020 11:57:51 +0200
Message-Id: <20200805095755.16414-3-thuth@redhat.com>
In-Reply-To: <20200805095755.16414-1-thuth@redhat.com>
References: <20200805095755.16414-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These tests always time out on Gitlab, not sure what's happening here.
Let's disable them until somebody has enough spare time to debug the
issues.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200730141326.8260-3-thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/acceptance/machine_rx_gdbsim.py | 4 ++++
 tests/acceptance/replay_kernel.py     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
index bff63e421d..0c72506028 100644
--- a/tests/acceptance/machine_rx_gdbsim.py
+++ b/tests/acceptance/machine_rx_gdbsim.py
@@ -8,6 +8,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import os
+
+from avocado import skipIf
 from avocado_qemu import Test
 from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
@@ -42,6 +45,7 @@ class RxGdbSimMachine(Test):
         # FIXME limit baudrate on chardev, else we type too fast
         #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
 
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_linux_sash(self):
         """
         Boots a Linux kernel and checks that the console is operational.
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 62d2db8c64..b79fc8daf8 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -126,6 +126,7 @@ class ReplayKernel(LinuxKernelTest):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
 
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
-- 
2.18.1


