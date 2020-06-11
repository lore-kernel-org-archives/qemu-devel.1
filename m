Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0243C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7F32073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJrbvtA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7F32073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTEI-0007P9-PN
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8U-0007UB-67
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26077
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8R-0000pO-H4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e2SGOCNL6XL6xuFV5X4LrCpFwE7kT/D02iFNt5rRIl4=;
 b=eJrbvtA49kKFQdj5gsQe7s4X8skeU6d5Qj/fMk2s1ddr+R1/SmcI+krAuPmzi9iLU098D9
 OEgDF/TxlnJxpr00Wi+b67ymI9EWltwpHD/h0uXJgr9FNM05a7ciyNUWMfD5VWp7iGj0HL
 HlEQOpi1N7byj9oaYqPXRRdprLuhaH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-ImVkDhkkPf6EDYP1B91sPw-1; Thu, 11 Jun 2020 15:45:08 -0400
X-MC-Unique: ImVkDhkkPf6EDYP1B91sPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F0C461
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 19:45:08 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A27060CC0;
 Thu, 11 Jun 2020 19:45:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 016/115] Makefile: Let the 'help' target list the helper targets
Date: Thu, 11 Jun 2020 15:43:10 -0400
Message-Id: <20200611194449.31468-17-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

List the name of the helper targets when calling 'make help',
along with the tool targets:

  $ make help
  [...]

  Helper targets:
    fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper
    scsi/qemu-pr-helper            - Build qemu-pr-helper
    qemu-bridge-helper             - Build qemu-bridge-helper
    vhost-user-gpu                 - Build vhost-user-gpu
    virtiofsd                      - Build virtiofsd

  Tools targets:
    qemu-ga                        - Build qemu-ga tool
    qemu-keymap                    - Build qemu-keymap tool
    elf2dmp                        - Build elf2dmp tool
    ivshmem-client                 - Build ivshmem-client tool
    ivshmem-server                 - Build ivshmem-server tool
    qemu-nbd                       - Build qemu-nbd tool
    qemu-storage-daemon            - Build qemu-storage-daemon tool
    qemu-img                       - Build qemu-img tool
    qemu-io                        - Build qemu-io tool
    qemu-edid                      - Build qemu-edid tool

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 9 +++++++--
 configure | 5 +++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index d1af126ea1..ed0ed93b2d 100644
--- a/Makefile
+++ b/Makefile
@@ -336,9 +336,9 @@ $(call set-vpath, $(SRC_PATH))
 LIBS+=-lz $(LIBS_TOOLS)
 
 vhost-user-json-y =
-HELPERS-y =
+HELPERS-y = $(HELPERS)
 
-HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = qemu-bridge-helper$(EXESUF)
+HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) += qemu-bridge-helper$(EXESUF)
 
 ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
 HELPERS-y += vhost-user-gpu$(EXESUF)
@@ -1258,6 +1258,11 @@ endif
 				$(call print-help-run,$(t)/fuzz,Build fuzzer for $(t)); \
 		))) \
 		echo '')
+	@$(if $(HELPERS-y), \
+		echo 'Helper targets:'; \
+		$(foreach t, $(HELPERS-y), \
+		$(call print-help-run,$(t),Build $(shell basename $(t)));) \
+		echo '')
 	@$(if $(TOOLS), \
 		echo 'Tools targets:'; \
 		$(foreach t, $(TOOLS), \
diff --git a/configure b/configure
index 597e909b53..53a6dd0297 100755
--- a/configure
+++ b/configure
@@ -6394,7 +6394,7 @@ if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
     if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
       virtfs=yes
-      tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
+      helpers="$helpers fsdev/virtfs-proxy-helper\$(EXESUF)"
     else
       if test "$virtfs" = yes; then
         error_exit "VirtFS requires libcap-ng devel and libattr devel"
@@ -6409,7 +6409,7 @@ if test "$softmmu" = yes ; then
       fi
       mpath=no
     fi
-    tools="$tools scsi/qemu-pr-helper\$(EXESUF)"
+    helpers="$helpers scsi/qemu-pr-helper\$(EXESUF)"
   else
     if test "$virtfs" = yes; then
       error_exit "VirtFS is supported only on Linux"
@@ -7651,6 +7651,7 @@ else
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
 fi
 
+echo "HELPERS=$helpers" >> $config_host_mak
 echo "TOOLS=$tools" >> $config_host_mak
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
-- 
2.26.2



