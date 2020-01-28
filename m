Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDAC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF2B2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjAHQdB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF2B2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWT0-0004ww-RF
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV90-0005Wx-HJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8z-0002Ly-4P
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:22 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8y-0002Gy-RH
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:21 -0500
Received: by mail-wr1-x443.google.com with SMTP id w15so17152268wru.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lgNRwyidMU7K+miZX6dbhVYSfKW8FDVklt6gtRnkk/Q=;
 b=CjAHQdB7VFTd3ROa42Y367A+jxP89MkU96vOkeP+1ziMqBTtJ1TCCmFxUkj2088pfj
 x7cc3wo6O2gBctlKek+fxKolOlYFqOYGQGYS+ZXHBUw7xG0MghAAeSlKlweSAOvFn8yD
 Md5Jt2QTtHWIdwkQhhPtWvfLRQ11vIAO3VKfi+1vS2F8VRPl0DsRIMtHr1aVoAuEQq5Z
 0OGxThg/mLnHLJ3Eb7pf+MHOZENVYyBLbmzdPfb2dmQ3jySsbnTMqFvQn05jkq03wAVH
 SsaHeev3XPw+orfBOcFTTqdGu7RIYsm0lnB6O4nuKm/epoRoD4j2QIlAct9px9LusyI5
 R+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lgNRwyidMU7K+miZX6dbhVYSfKW8FDVklt6gtRnkk/Q=;
 b=LxdzSbKoiCuDq4ooVRgW3oGZh0YLOTAtwNWlMkbKFKIT8Kz7ef+UXxD/7lunILdGJF
 93w8KPn6YZUiu7m6PYf0xUu/T5wpPJ/arAXLbW/B1GDCwruzIq3LttsJ/3tes0e6K/Kw
 xMjE8lQ2Is+YCuH9CCXH2wtkb7QU/QMwFx0aR1ltgZC6yoRvGTxsX2Vk5a7blN8Twtov
 A1Mpi00A4ronPSJ12VM7vuObNMdG5vHcA80C68G9EeBLPY2s4t1pRHVzITDAvZK3SfRn
 G87ZyT/n26aAq5oi5HYrlAv5Fc7nWJGydYWskVWFqQ98QaGHiUNf3tcbeyf9P1hChV7J
 vRFg==
X-Gm-Message-State: APjAAAWR9C5o0SJzrhFEiUo6ThJb12wV5hOzlX1I1+NbnT1KA83l54nU
 SxqhHx7fpxHFTnp8dUTmBbfG2VRG
X-Google-Smtp-Source: APXvYqxS/y1GBzxWHL64IKtGWSmLweFKMfY5kNCToWJS5aMWBV0x9OgPNZGqta0DnyOWxDzTB8PziA==
X-Received: by 2002:adf:e483:: with SMTP id i3mr2149103wrm.215.1580234356083; 
 Tue, 28 Jan 2020 09:59:16 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.59.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:59:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 139/142] meson: convert check-block
Date: Tue, 28 Jan 2020 18:53:39 +0100
Message-Id: <20200128175342.9066-140-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

---
 meson.build                    |  1 +
 tests/Makefile.include         | 24 +++---------------------
 tests/meson.build              |  3 +++
 tests/qemu-iotests/meson.build |  8 ++++++++
 4 files changed, 15 insertions(+), 21 deletions(-)
 create mode 100644 tests/meson.build
 create mode 100644 tests/qemu-iotests/meson.build

diff --git a/meson.build b/meson.build
index 6083897fc7..af25a130f2 100644
--- a/meson.build
+++ b/meson.build
@@ -1093,3 +1093,4 @@ endif
 if 'CONFIG_GTK' in config_host
   subdir('po')
 endif
+subdir('tests')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index d40e666311..86da369aa0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -147,8 +147,6 @@ check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
 check-unit-y += tests/test-qapi-util$(EXESUF)
 
-check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFTMMU)) += tests/check-block.sh
-
 # All QTests for now are POSIX-only, but the dependencies are
 # really in libqtest, not in the testcases themselves.
 
@@ -827,7 +825,6 @@ tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
 tests/cpu-plug-test$(EXESUF): tests/cpu-plug-test.o
 tests/migration-test$(EXESUF): tests/migration-test.o
-tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
 tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
 tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-qapi-obj-y)
 tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-block-obj-y)
@@ -1118,14 +1115,6 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
 # Other tests
 
-QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
-
-.PHONY: check-tests/check-block.sh
-check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
-		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
-		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
-	@$<
-
 .PHONY: check-tests/qapi-schema/frontend
 check-tests/qapi-schema/frontend: $(addprefix $(SRC_PATH)/, $(check-qapi-schema-y))
 	$(call quiet-command, PYTHONPATH=$(SRC_PATH)/scripts \
@@ -1182,25 +1171,18 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 
 # Consolidated targets
 
-.PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean
+.PHONY: check-qapi-schema check-qtest check-unit check check-clean
 check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
-ifeq ($(CONFIG_TOOLS),y)
-check-block: $(patsubst %,check-%, $(check-block-y))
-endif
-check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
+check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
 check-clean:
-	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
+	rm -rf $(check-unit-y) tests/*.o
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
 	rm -f tests/test-qapi-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
 
 clean: check-clean
 
-# Build the help program automatically
-
-all: $(QEMU_IOTESTS_HELPERS-y)
-
 -include $(wildcard tests/*.d)
 -include $(wildcard tests/libqos/*.d)
 
diff --git a/tests/meson.build b/tests/meson.build
new file mode 100644
index 0000000000..a546d91c17
--- /dev/null
+++ b/tests/meson.build
@@ -0,0 +1,3 @@
+if have_system and 'CONFIG_POSIX' in config_host
+  subdir('qemu-iotests')
+endif
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
new file mode 100644
index 0000000000..6509b18044
--- /dev/null
+++ b/tests/qemu-iotests/meson.build
@@ -0,0 +1,8 @@
+dep = [qemu_img, qemu_io, qemu_nbd, emulators]
+if 'CONFIG_LINUX' in config_host
+    dep += executable('socket_scm_helper', 'socket_scm_helper.c',
+                      build_by_default: false)
+endif
+test('qemu-iotests', files('../check-block.sh'), depends: dep,
+     suite: 'block')
+
-- 
2.21.0



