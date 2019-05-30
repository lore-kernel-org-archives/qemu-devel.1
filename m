Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA008C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B166C25781
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z92u7mgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B166C25781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51214 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWITk-00041V-1C
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:40:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFF-0001Ef-WE
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWIFD-0000Il-QB
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:13 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWIFD-0008WJ-CD
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:25:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id w13so3809897wru.11
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=pxbSV5w1/gsrwx8qszzFPSyV1J05+UPofdUUztDCX0k=;
	b=Z92u7mgnl/2wSQgta1S1HUVwByky2RwKi/PW9uUGu52frrFQGVyjBMxZwtJvdtYstb
	OJEfmgTGSMDZpwEzwH9G6WI6paDYJH9QWg7E85jOu4W3ABn20f6W45x66ZusQWk+M6Z4
	CfYS1CTr09figWeaFQUdxG6KsZbNK06ueNRrGc0wgu92QherBU7TQ6Ouz2R6NAbpu2KZ
	3SKeVVNVuyVltpKZapFUYKSvcyO9NGgJROivdwBqWVLc/R4pJy4kJL3OGTWuBsEJEC+H
	blL5E04yAWXt1aw8QRRJZT4RzEDE1h6X38OU04THCqlrgjoUQdTXtWzg1XCwov3k/yik
	/IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=pxbSV5w1/gsrwx8qszzFPSyV1J05+UPofdUUztDCX0k=;
	b=L+JOBHg6Xk0gBYS53KEO9Y1mzirwrXX4j7c41snolo74ctfG1nUfZ6sSVpJkTz0MfD
	lZDtjPANLMjUBrGHnqofCcFbX9ihfTLWS14Xb+rgpsc0xXizzFFIRkwWBn1ONdns6PGg
	xDXv1Ejqvc4UMb44idH30L6aErOzoTvDzc7A4FLdrO+1c5CJjl0j2eQipDoTsDU96JJU
	NrJD17CyDruRM8h+0ES/Gdd2TNhlzcTDOAPEhdiB34AT1bfiDBjshj2mJvEfG3SZqP64
	gtf/VEiJ112/wlaL602RoJ9hp7NwoeYtue0o86Mxwr5FKtxmrJmwU8JANRdEtRSovGvR
	MtwA==
X-Gm-Message-State: APjAAAW41oRYxM5AStV9eLZLiGc+S/ylRftj/sczNhgbPD43G4wmvve1
	VaG3S+c6F0CgBLMriOe+lKwKVQ==
X-Google-Smtp-Source: APXvYqxa2oWhUCl3s1Ssa/aWp0U26++d3BrRisemenNA9JV6StUszD+mwpPFXd5FR1dvM+AU0cFMyw==
X-Received: by 2002:adf:afd0:: with SMTP id y16mr2141025wrd.22.1559211901966; 
	Thu, 30 May 2019 03:25:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	q17sm1492690wrx.74.2019.05.30.03.25.00
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:25:00 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9AA201FFA9;
	Thu, 30 May 2019 11:16:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:56 +0100
Message-Id: <20190530101603.22254-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PATCH  v1 19/26] tests/vm: add vm-boot-{ssh,
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

For testing/troubleshooting convinience.

make vm-boot-serial-<guest>
  Boot guest, with the serial console on stdio.

make vm-boot-ssh-<guest>
  Boot guest, login via ssh.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190520124716.30472-8-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 276b870216c..e329129bd65 100644
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
 	@echo "    BUILD_TARGET=foo		 - Override the build target"
 	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
@@ -63,3 +67,18 @@ vm-build-%: $(IMAGES_DIR)/%.img
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
2.20.1


