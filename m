Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C9BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261C3208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261C3208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAE6-0006u7-Ak
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6J-0008Ik-C0
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33107
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6G-0005EL-Sf
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:51 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-HnyjGU-mMwGooPE4Pj59wA-1; Fri, 04 Sep 2020 07:41:47 -0400
X-MC-Unique: HnyjGU-mMwGooPE4Pj59wA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 076E910299C4
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C75938BA03;
 Fri,  4 Sep 2020 11:41:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/46] meson: move keyutils dependency check
Date: Fri,  4 Sep 2020 07:40:54 -0400
Message-Id: <20200904114122.31307-19-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since there is not minimum version specified, and it's a test-only
dependency, it's fair to depend on a version that ships with a .pc I
suppose.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200828110734.1638685-8-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 25 -------------------------
 meson.build |  7 +++----
 2 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/configure b/configure
index 35dedaf803..3372a43a4f 100755
--- a/configure
+++ b/configure
@@ -6305,28 +6305,6 @@ but not implemented on your system"
     fi
 fi
 
-##########################################
-# check for usable keyutils.h
-
-if test "$linux" = "yes" ; then
-
-    have_keyutils=no
-    cat > $TMPC << EOF
-#include <errno.h>
-#include <asm/unistd.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <keyutils.h>
-int main(void) {
-    return request_key("user", NULL, NULL, 0);
-}
-EOF
-    if compile_prog "" "-lkeyutils"; then
-        have_keyutils=yes
-    fi
-fi
-
-
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -7510,9 +7488,6 @@ fi
 
 if test "$secret_keyring" = "yes" ; then
   echo "CONFIG_SECRET_KEYRING=y" >> $config_host_mak
-  if test "$have_keyutils" = "yes" ; then
-    echo "CONFIG_KEYUTILS=y" >> $config_host_mak
-  fi
 fi
 
 if test "$tcg_interpreter" = "yes"; then
diff --git a/meson.build b/meson.build
index fc46273491..7c714bb49c 100644
--- a/meson.build
+++ b/meson.build
@@ -410,10 +410,8 @@ if 'CONFIG_TASN1' in config_host
   tasn1 = declare_dependency(compile_args: config_host['TASN1_CFLAGS'].split(),
                              link_args: config_host['TASN1_LIBS'].split())
 endif
-keyutils = not_found
-if 'CONFIG_KEYUTILS' in config_host
-  keyutils = declare_dependency(link_args: '-lkeyutils')
-endif
+keyutils = dependency('libkeyutils', required: false,
+                      method: 'pkg-config', static: enable_static)
 
 # Create config-host.h
 
@@ -424,6 +422,7 @@ config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_PNG', png.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
+config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
-- 
2.26.2



