Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F57C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514CB22CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIq0Zgdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514CB22CAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hII-0001Ms-F1
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gLC-0003cH-CU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:42:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56360
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gL8-0006vj-Oq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wT3++EskC3IekWaJAeSwmjipHmASvlsc4QydG7Qjtk0=;
 b=HIq0Zgdy2FqtV/GHw+ijY9Px1gYB7kdhoWxQXN88vjxNnst9VJSzowWKXqw2AsiQSeAaEM
 WBpk+kzABmZke7f+xRY+d62XY7JV3TSrY+sBcMkDMZa1e+qllBCLa7nnaKaekWM+Ru6iZg
 mMitt4/3ncfzsZZdlWaC7fmDpN0aFgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-j57h_ZV5P5Oceu9c9K9cLw-1; Mon, 17 Aug 2020 10:42:19 -0400
X-MC-Unique: j57h_ZV5P5Oceu9c9K9cLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C974801AAE
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:42:18 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 878E4756AC;
 Mon, 17 Aug 2020 14:42:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 135/150] rules.mak: remove version.o
Date: Mon, 17 Aug 2020 16:40:38 +0200
Message-Id: <20200817144053.345107-40-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:13:21
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
index 9c8fb91f45..e6ede40f51 100644
--- a/Makefile
+++ b/Makefile
@@ -230,11 +230,6 @@ recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 $(addsuffix /install, $(TARGET_DIRS)): all
 
-$(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
-	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o")
-
-Makefile: $(version-obj-y)
-
 ######################################################################
 
 clean: recurse-clean ninja-clean clean-ctlist
diff --git a/Makefile.objs b/Makefile.objs
index 5295c3a623..c351b59641 100644
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
index b983c7f83f..6d89001f0a 100644
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
2.26.2



