Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1B5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38EA820738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqzFg+kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EA820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94VC-00044f-CF
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dm-0001yg-HD
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dc-0001bt-Vw
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0jd9sKuKAb7V/yjtnUThtjmAauTKkKXhYRHMf2YlLX8=;
 b=KqzFg+kqhftGyIbAQQSNgp8Hh5iY+AF3xDBSE57KkrnS1c7E2cIgKX3PRlBwIvzN1oMf6S
 FRPcINMJ9HZqKnrAATUt/71bOO4X2teyNEIraJ+t4AqYcnLU5539AFlzRaJdNhrFARO3Q8
 1lHgtNkSxtB4EdPaLBNxazbJJh4Y+pY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-PRC-pj86N_2x3TDP-W1-rw-1; Fri, 21 Aug 2020 06:24:17 -0400
X-MC-Unique: PRC-pj86N_2x3TDP-W1-rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 359EE873157
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E735260BF1;
 Fri, 21 Aug 2020 10:24:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 051/152] meson: generate shader headers
Date: Fri, 21 Aug 2020 06:21:48 -0400
Message-Id: <20200821102329.29777-52-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
index 0b86e3a981..e7394e748d 100644
--- a/Makefile
+++ b/Makefile
@@ -393,7 +393,6 @@ clean: recurse-clean ninja-clean clean-ctlist
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
-	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f config-all-devices.mak
 	rm -f $(SUBDIR_DEVICES_MAK)
@@ -618,24 +617,6 @@ endif
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
index e8df2a6fb0..2fb209b228 100644
--- a/meson.build
+++ b/meson.build
@@ -159,6 +159,7 @@ have_block = have_system or have_tools
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



