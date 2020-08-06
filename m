Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53164C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5854322D73
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiRNwBdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5854322D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3leF-00055C-90
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOa-00056y-Ho
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOY-0006Ug-J2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l7dlmo4CUP9fRAb0wYf5v1xWP+Vmo9+ilKkdaCF/7YY=;
 b=eiRNwBdqhfGNTdGPGofSxz374UgLA9ddwLp4i9sRHxvvfbiYgsiutaibANlGftZUxsNd44
 K/j8DZpWgRRDd8FrcYRaXqJXe8l0OZmPxkLaxzxK1HnXmaKNrrFhiMUKie05mO0vWHQHeR
 i3mLgzX16JlFOeMjKJUJnc/4USAhRHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-gCvCmL45PTmqD4D2HA65iA-1; Thu, 06 Aug 2020 15:17:40 -0400
X-MC-Unique: gCvCmL45PTmqD4D2HA65iA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DEC41DE1
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:17:39 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 977EE5F9DC;
 Thu,  6 Aug 2020 19:17:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 041/143] meson: keymap-gen
Date: Thu,  6 Aug 2020 21:14:37 +0200
Message-Id: <1596741379-12902-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Makefile       | 38 --------------------------------------
 meson.build    |  1 +
 ui/meson.build | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 38 deletions(-)
 create mode 100644 ui/meson.build

diff --git a/Makefile b/Makefile
index 2fbbc0a..3837f80 100644
--- a/Makefile
+++ b/Makefile
@@ -125,44 +125,6 @@ generated-files-y += module_block.h
 
 generated-files-y += .git-submodule-status
 
-KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
-KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
-
-KEYCODEMAP_FILES = \
-		 ui/input-keymap-atset1-to-qcode.c \
-		 ui/input-keymap-linux-to-qcode.c \
-		 ui/input-keymap-qcode-to-atset1.c \
-		 ui/input-keymap-qcode-to-atset2.c \
-		 ui/input-keymap-qcode-to-atset3.c \
-		 ui/input-keymap-qcode-to-linux.c \
-		 ui/input-keymap-qcode-to-qnum.c \
-		 ui/input-keymap-qcode-to-sun.c \
-		 ui/input-keymap-qnum-to-qcode.c \
-		 ui/input-keymap-usb-to-qcode.c \
-		 ui/input-keymap-win32-to-qcode.c \
-		 ui/input-keymap-x11-to-qcode.c \
-		 ui/input-keymap-xorgevdev-to-qcode.c \
-		 ui/input-keymap-xorgkbd-to-qcode.c \
-		 ui/input-keymap-xorgxquartz-to-qcode.c \
-		 ui/input-keymap-xorgxwin-to-qcode.c \
-		 ui/input-keymap-osx-to-qcode.c \
-		 $(NULL)
-
-generated-files-$(CONFIG_SOFTMMU) += $(KEYCODEMAP_FILES)
-
-ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
-	$(call quiet-command,\
-	    stem=$* && src=$${stem%-to-*} dst=$${stem#*-to-} && \
-	    test -e $(KEYCODEMAP_GEN) && \
-	    $(PYTHON) $(KEYCODEMAP_GEN) \
-	          --lang glib2 \
-	          --varname qemu_input_map_$${src}_to_$${dst} \
-	          code-map $(KEYCODEMAP_CSV) $${src} $${dst} \
-	        > $@ || rm -f $@, "GEN", "$@")
-
-$(KEYCODEMAP_GEN): .git-submodule-status
-$(KEYCODEMAP_CSV): .git-submodule-status
-
 edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
 pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
 	$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
diff --git a/meson.build b/meson.build
index eec72f5..4448bfe 100644
--- a/meson.build
+++ b/meson.build
@@ -265,6 +265,7 @@ subdir('trace')
 subdir('util')
 subdir('crypto')
 subdir('storage-daemon')
+subdir('ui')
 
 # Build targets from sourcesets
 
diff --git a/ui/meson.build b/ui/meson.build
new file mode 100644
index 0000000..cad9763
--- /dev/null
+++ b/ui/meson.build
@@ -0,0 +1,34 @@
+keymap_gen = find_program('keycodemapdb/tools/keymap-gen')
+
+keymaps = [
+  ['atset1', 'qcode'],
+  ['linux', 'qcode'],
+  ['qcode', 'atset1'],
+  ['qcode', 'atset2'],
+  ['qcode', 'atset3'],
+  ['qcode', 'linux'],
+  ['qcode', 'qnum'],
+  ['qcode', 'sun'],
+  ['qnum', 'qcode'],
+  ['usb', 'qcode'],
+  ['win32', 'qcode'],
+  ['x11', 'qcode'],
+  ['xorgevdev', 'qcode'],
+  ['xorgkbd', 'qcode'],
+  ['xorgxquartz', 'qcode'],
+  ['xorgxwin', 'qcode'],
+  ['osx', 'qcode'],
+]
+
+foreach e : keymaps
+  output = 'input-keymap-@0@-to-@1@.c'.format(e[0], e[1])
+  custom_target(output,
+                output: output,
+                capture: true,
+                build_by_default: true, # to be removed when added to a target
+                input: files('keycodemapdb/data/keymaps.csv'),
+                command: [keymap_gen,
+                          '--lang', 'glib2',
+                          '--varname', 'qemu_input_map_@0@_to_@1@'.format(e[0], e[1]),
+                          'code-map', '@INPUT0@', e[0], e[1]])
+endforeach
-- 
1.8.3.1



