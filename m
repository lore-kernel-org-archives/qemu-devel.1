Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F80C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4759D208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4RnOgr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4759D208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfe4-0000TF-A0
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHH-0005Ro-6C
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42435
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfH3-0007Nu-AW
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MRi8i2BMvdEMR0cbJOTYElma8z7sCzMIKwz0QIwztLg=;
 b=H4RnOgr6mb2r0Dg5bu3Ikg60rRqbCXw6XkhYGrqdn5qz/uwfCnTv/biu7WdzL9x98yTqEO
 9hhSAXKqtO7cHku3UeXJNXZ4AsIYhKhlXz1Zz7hMPYU8FD2t/ekDK3YKYZxXM3D3sLZz27
 zersCtgJha9O6i9ZItSN3A6nDpAQz74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-zXcoKIFlON-OWQsqw_wnlQ-1; Sat, 19 Sep 2020 11:59:37 -0400
X-MC-Unique: zXcoKIFlON-OWQsqw_wnlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E65D8712D9
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 897D860C84;
 Sat, 19 Sep 2020 15:59:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/57] configure: rename QEMU_GA_MSI_ENABLED to CONFIG_QGA_MSI
Date: Sat, 19 Sep 2020 11:58:39 -0400
Message-Id: <20200919155916.1046398-21-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:59:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The QEMU_GA_MSI_ENABLED config-host.mak variable is emitted by
./configure. meson.build actually checks for CONFIG_QGA_MSI_ENABLED:

  summary_info += {'QGA MSI support':   config_host.has_key('CONFIG_QGA_MSI_ENABLED')}

Rename QEMU_GA_MSI_ENABLED to CONFIG_QGA_MSI for consistency with
CONFIG_QGA_VSS. Also use 'y' instead of 'yes' for consistency.

This fixes the feature summary printed by meson.build.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200914095231.621068-4-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile    | 2 +-
 configure   | 2 +-
 meson.build | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7c60b9dcb8..42d90cb597 100644
--- a/Makefile
+++ b/Makefile
@@ -285,7 +285,7 @@ endif
 ifdef CONFIG_WIN32
 	@echo  'Windows targets:'
 	$(call print-help,installer,Build NSIS-based installer for QEMU)
-ifdef QEMU_GA_MSI_ENABLED
+ifdef CONFIG_QGA_MSI
 	$(call print-help,msi,Build MSI-based installer for qemu-ga)
 endif
 	@echo  ''
diff --git a/configure b/configure
index 7662b3bf6f..6201e7c732 100755
--- a/configure
+++ b/configure
@@ -6572,7 +6572,7 @@ if test "$mingw32" = "yes" ; then
     echo "CONFIG_QGA_NTDDSCSI=y" >> $config_host_mak
   fi
   if test "$guest_agent_msi" = "yes"; then
-    echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak
+    echo "CONFIG_QGA_MSI=y" >> $config_host_mak
     echo "QEMU_GA_MSI_MINGW_DLL_PATH=${QEMU_GA_MSI_MINGW_DLL_PATH}" >> $config_host_mak
     echo "QEMU_GA_MSI_WITH_VSS=${QEMU_GA_MSI_WITH_VSS}" >> $config_host_mak
     echo "QEMU_GA_MSI_ARCH=${QEMU_GA_MSI_ARCH}" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 8bf696558f..5ab9a4dd1e 100644
--- a/meson.build
+++ b/meson.build
@@ -1488,7 +1488,7 @@ if targetos == 'windows'
   endif
   summary_info += {'QGA VSS support':   config_host.has_key('CONFIG_QGA_VSS')}
   summary_info += {'QGA w32 disk info': config_host.has_key('CONFIG_QGA_NTDDSCSI')}
-  summary_info += {'QGA MSI support':   config_host.has_key('CONFIG_QGA_MSI_ENABLED')}
+  summary_info += {'QGA MSI support':   config_host.has_key('CONFIG_QGA_MSI')}
 endif
 summary_info += {'seccomp support':   config_host.has_key('CONFIG_SECCOMP')}
 summary_info += {'coroutine backend': config_host['CONFIG_COROUTINE_BACKEND']}
-- 
2.26.2



