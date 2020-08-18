Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234CCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A9D2076E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvDx/QUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A9D2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82hs-0006V4-5I
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Kh-00040y-6H
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41387
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82KZ-0007PF-4T
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gk0WYaKP+qzL75B7tm557kxSj+SjpicpV/yNk/Xgxro=;
 b=gvDx/QUodsogj66GAe67cc2J5de+h1ISaamcIKLRKL4HnP4vRldacRmH+d77YExh2mEKK2
 0q4Jp456Zto4oPLjU4D3Uauws6JNPafIZM9yh3qrp/SxfZKvaSAFGU3dsAMFDnYviBFYzV
 6Tr9L7431+9939XeDCKD3sQzZAb25uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-QFiZ4LwoPmmHxma2XnAx7Q-1; Tue, 18 Aug 2020 10:11:12 -0400
X-MC-Unique: QFiZ4LwoPmmHxma2XnAx7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6243E100CA9A
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:11 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FAD4196B6;
 Tue, 18 Aug 2020 14:11:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 050/150] meson: generate shader headers
Date: Tue, 18 Aug 2020 10:08:45 -0400
Message-Id: <20200818141025.21608-51-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
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
 Makefile              | 19 -------------------
 meson.build           |  1 +
 ui/meson.build        |  2 ++
 ui/shader/meson.build | 15 +++++++++++++++
 4 files changed, 18 insertions(+), 19 deletions(-)
 create mode 100644 ui/shader/meson.build

diff --git a/Makefile b/Makefile
index 9abf7be598..0732886563 100644
--- a/Makefile
+++ b/Makefile
@@ -384,7 +384,6 @@ clean: recurse-clean ninja-clean clean-ctlist
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
-	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f config-all-devices.mak
 	rm -f $(SUBDIR_DEVICES_MAK)
@@ -609,24 +608,6 @@ endif
 	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
         done
 
-# opengl shader programs
-ui/shader/%-vert.h: $(SRC_PATH)/ui/shader/%.vert $(SRC_PATH)/scripts/shaderinclude.pl
-	@mkdir -p $(dir $@)
-	$(call quiet-command,\
-		perl $(SRC_PATH)/scripts/shaderinclude.pl $< > $@,\
-		"VERT","$@")
-
-ui/shader/%-frag.h: $(SRC_PATH)/ui/shader/%.frag $(SRC_PATH)/scripts/shaderinclude.pl
-	@mkdir -p $(dir $@)
-	$(call quiet-command,\
-		perl $(SRC_PATH)/scripts/shaderinclude.pl $< > $@,\
-		"FRAG","$@")
-
-ui/shader.o: $(SRC_PATH)/ui/shader.c \
-	ui/shader/texture-blit-vert.h \
-	ui/shader/texture-blit-flip-vert.h \
-	ui/shader/texture-blit-frag.h
-
 # documentation
 MAKEINFO=makeinfo
 MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
diff --git a/meson.build b/meson.build
index 73660bafc1..648c7456d9 100644
--- a/meson.build
+++ b/meson.build
@@ -156,6 +156,7 @@ have_block = have_system or have_tools
 # Generators
 
 genh = []
+shaderinclude = find_program('scripts/shaderinclude.pl')
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/commands.py',
diff --git a/ui/meson.build b/ui/meson.build
index a6aa7f2b36..35da0d8d26 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -32,3 +32,5 @@ if have_system
                             'code-map', '@INPUT0@', e[0], e[1]])
   endforeach
 endif
+
+subdir('shader')
diff --git a/ui/shader/meson.build b/ui/shader/meson.build
new file mode 100644
index 0000000000..f69e44ed89
--- /dev/null
+++ b/ui/shader/meson.build
@@ -0,0 +1,15 @@
+shaders = [
+  ['texture-blit', 'frag'],
+  ['texture-blit', 'vert'],
+  ['texture-blit-flip', 'vert'],
+]
+
+foreach e : shaders
+  output = '@0@-@1@.h'.format(e[0], e[1])
+  genh += custom_target(output,
+                output: output,
+                capture: true,
+                build_by_default: true, # to be removed when added to a target
+                input: files('@0@.@1@'.format(e[0], e[1])),
+                command: [shaderinclude, '@INPUT0@'])
+endforeach
-- 
2.26.2



