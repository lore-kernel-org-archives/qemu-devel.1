Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA3FC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A255A21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A255A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41188 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3K3-0006Vv-Ly
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:04:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP334-0008J4-29
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP333-000440-4C
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP332-00043L-VA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:46:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 230E16696C;
	Fri, 10 May 2019 10:46:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CAEB31001E81;
	Fri, 10 May 2019 10:46:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 8FCDFA212; Fri, 10 May 2019 12:46:33 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:46:26 +0200
Message-Id: <20190510104633.9428-7-kraxel@redhat.com>
In-Reply-To: <20190510104633.9428-1-kraxel@redhat.com>
References: <20190510104633.9428-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 10 May 2019 10:46:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 06/13] tests/vm: add vm-boot-{ssh,
 serial}-<guest> targets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For testing/troubleshooting convinience.

make vm-boot-serial-<guest>
  Boot guest, with the serial console on stdio.

make vm-boot-ssh-<guest>
  Boot guest, login via ssh.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/Makefile.include | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index d628e0a986f6..47084d5717c6 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -20,6 +20,10 @@ vm-test:
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
 	@echo
+	@echo "For trouble-shooting:"
+	@echo "  vm-boot-serial-<guest>          - Boot guest, serial console on stdio"
+	@echo "  vm-boot-ssh-<guest>             - Boot guest and login via ssh"
+	@echo
 	@echo "Special variables:"
 	@echo "    BUILD_TARGET=foo		 - override the build target"
 	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds."
@@ -59,3 +63,18 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
 		"  VM-BUILD $*")
 
+vm-boot-serial-%: $(IMAGES_DIR)/%.img
+	qemu-system-x86_64 -enable-kvm -m 4G -smp 2 -nographic \
+		-drive if=none,id=vblk,cache=writeback,file="$<" \
+		-netdev user,id=vnet \
+		-device virtio-blk-pci,drive=vblk \
+		-device virtio-net-pci,netdev=vnet \
+	|| true
+
+vm-boot-ssh-%: $(IMAGES_DIR)/%.img
+	$(call quiet-command, \
+		$(SRC_PATH)/tests/vm/$* \
+		--image "$<" \
+		--interactive \
+		false, \
+		"  VM-BOOT-SSH $*")
-- 
2.18.1


