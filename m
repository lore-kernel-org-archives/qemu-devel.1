Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A321AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676272080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+6EFpv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676272080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CCb-0000PM-HC
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLy-0003Tf-7o
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50362
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLw-0003ND-An
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCWQsqaYkXE5O2PZN9SLzgeF6lcVZ+ltbOpsodxa3rQ=;
 b=P+6EFpv9NTvmtEVleIuo80kn+yeXr5z3MlXZ4TMZoaYlSlJAjYh5M5U1uuCv9JeBN9ALHN
 TNcS1VmMHw9/+dcDhlFrqgbteujezJBC3a2BDDkey9WMN6TOfr9L2x9+d2D1eSxwHQDLTN
 /Y32EAdmQbMPbIsUVf+BuWgmZeQepkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-aknlCe4fMOWp4WBv6et2cw-1; Mon, 10 Aug 2020 13:12:49 -0400
X-MC-Unique: aknlCe4fMOWp4WBv6et2cw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06CC680183C
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:49 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 143F987D61;
 Mon, 10 Aug 2020 17:12:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 133/147] rules.mak: remove version.o
Date: Mon, 10 Aug 2020 19:08:51 +0200
Message-Id: <1597079345-42801-134-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile      | 5 -----
 Makefile.objs | 4 ----
 rules.mak     | 4 +---
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index ebda912..2962a41 100644
--- a/Makefile
+++ b/Makefile
@@ -225,11 +225,6 @@ recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 $(addsuffix /install, $(TARGET_DIRS)): all
 
-$(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
-	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o")
-
-Makefile: $(version-obj-y)
-
 ######################################################################
 
 clean: recurse-clean
diff --git a/Makefile.objs b/Makefile.objs
index 5295c3a..c351b59 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -32,7 +32,3 @@ crypto-obj-y = crypto/libcrypto.fa
 io-obj-y = io/libio.fa
 
 endif # CONFIG_SOFTMMU or CONFIG_TOOLS
-
-######################################################################
-# Resource file for Windows executables
-version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
diff --git a/rules.mak b/rules.mak
index b983c7f..6d89001 100644
--- a/rules.mak
+++ b/rules.mak
@@ -77,8 +77,6 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
 	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
 	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
 	       -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-%.o: %.rc
-	$(call quiet-command,$(WINDRES) -I. -o $@ $<,"RC","$(TARGET_DIR)$@")
 
 # If we have a CXX we might have some C++ objects, in which case we
 # must link with the C++ compiler, not the plain C compiler.
@@ -86,7 +84,7 @@ LINKPROG = $(or $(CXX),$(CC))
 
 LINK = $(call quiet-command, $(LINKPROG) $(CFLAGS) $(QEMU_LDFLAGS) -o $@ \
        $(call process-archive-undefs, $1) \
-       $(version-obj-y) $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_DIR)$@")
+       $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_DIR)$@")
 
 %.o: %.S
 	$(call quiet-command,$(CCAS) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
-- 
1.8.3.1



