Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F8EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149F320679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sni6kUeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149F320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxWs-0000sq-5h
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHV-0003VY-Ub
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHU-00049A-CS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHU-00046V-5o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxyXzd1+M78f5LJXGIa385OSe7uymUkxw4jDQcSJ+g4=;
 b=Sni6kUeg/FOBQ1yN0m6DtjXe7ucUybWGM4pMGU0Oq4aUpOy5twoAh32Ww8XoV5barni7iO
 vohIxJ1aeRt5KefK/va3LoGXGn1eYVuy6wIkzeCCACSM+o8KKKBL2Vj2AAHfkskIOGIMjG
 WoHG9EplOusNNHP7aZjWVfVcV3GCYdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-cBKrsaOQOWC41H6eCOXiQw-1; Mon, 16 Mar 2020 17:28:14 -0400
X-MC-Unique: cBKrsaOQOWC41H6eCOXiQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 302E2100550E
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:13 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BE9E19C4F;
 Mon, 16 Mar 2020 21:28:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/61] Makefile: Align 'help' target output
Date: Mon, 16 Mar 2020 22:26:50 +0100
Message-Id: <1584394048-44994-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The 'help' target is displayed unaligned. Add a print-help
function and use it. Now if someone want to change the
indentation, there is a single place to modify.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index 7df22fc..6ec19f8 100644
--- a/Makefile
+++ b/Makefile
@@ -1235,50 +1235,52 @@ endif
 include $(SRC_PATH)/tests/docker/Makefile.include
 include $(SRC_PATH)/tests/vm/Makefile.include
=20
+print-help-run =3D printf "  %-30s - %s\\n" "$1" "$2"
+print-help =3D $(quiet-@)$(call print-help-run,$1,$2)
+
 .PHONY: help
 help:
 =09@echo  'Generic targets:'
-=09@echo  '  all             - Build all'
+=09$(call print-help,all,Build all)
 ifdef CONFIG_MODULES
-=09@echo  '  modules         - Build all modules'
+=09$(call print-help,modules,Build all modules)
 endif
-=09@echo  '  dir/file.o      - Build specified target only'
-=09@echo  '  install         - Install QEMU, documentation and tools'
-=09@echo  '  ctags/TAGS      - Generate tags file for editors'
-=09@echo  '  cscope          - Generate cscope index'
+=09$(call print-help,dir/file.o,Build specified target only)
+=09$(call print-help,install,Install QEMU, documentation and tools)
+=09$(call print-help,ctags/TAGS,Generate tags file for editors)
+=09$(call print-help,cscope,Generate cscope index)
 =09@echo  ''
 =09@$(if $(TARGET_DIRS), \
 =09=09echo 'Architecture specific targets:'; \
 =09=09$(foreach t, $(TARGET_DIRS), \
-=09=09printf "  %-30s - Build for %s\\n" $(t)/all $(t);) \
+=09=09$(call print-help-run,$(t)/all,Build for $(t));) \
 =09=09echo '')
 =09@echo  'Cleaning targets:'
-=09@echo  '  clean           - Remove most generated files but keep the co=
nfig'
+=09$(call print-help,clean,Remove most generated files but keep the config=
)
 ifdef CONFIG_GCOV
-=09@echo  '  clean-coverage  - Remove coverage files'
+=09$(call print-help,clean-coverage,Remove coverage files)
 endif
-=09@echo  '  distclean       - Remove all generated files'
-=09@echo  '  dist            - Build a distributable tarball'
+=09$(call print-help,distclean,Remove all generated files)
+=09$(call print-help,dist,Build a distributable tarball)
 =09@echo  ''
 =09@echo  'Test targets:'
-=09@echo  '  check           - Run all tests (check-help for details)'
-=09@echo  '  docker          - Help about targets running tests inside con=
tainers'
-=09@echo  '  vm-help         - Help about targets running tests inside VM'
+=09$(call print-help,check,Run all tests (check-help for details))
+=09$(call print-help,docker,Help about targets running tests inside contai=
ners)
+=09$(call print-help,vm-help,Help about targets running tests inside VM)
 =09@echo  ''
 =09@echo  'Documentation targets:'
-=09@echo  '  html info pdf txt'
-=09@echo  '                  - Build documentation in specified format'
+=09$(call print-help,html info pdf txt,Build documentation in specified fo=
rmat)
 ifdef CONFIG_GCOV
-=09@echo  '  coverage-report - Create code coverage report'
+=09$(call print-help,coverage-report,Create code coverage report)
 endif
 =09@echo  ''
 ifdef CONFIG_WIN32
 =09@echo  'Windows targets:'
-=09@echo  '  installer       - Build NSIS-based installer for QEMU'
+=09$(call print-help,installer,Build NSIS-based installer for QEMU)
 ifdef QEMU_GA_MSI_ENABLED
-=09@echo  '  msi             - Build MSI-based installer for qemu-ga'
+=09$(call print-help,msi,Build MSI-based installer for qemu-ga)
 endif
 =09@echo  ''
 endif
-=09@echo  '  $(MAKE) [targets]      (quiet build, default)'
-=09@echo  '  $(MAKE) V=3D1 [targets]  (verbose build)'
+=09$(call print-help,$(MAKE) [targets],(quiet build, default))
+=09$(call print-help,$(MAKE) V=3D1 [targets],(verbose build))
--=20
1.8.3.1



