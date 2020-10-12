Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4681DC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1BB2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKaIDeIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1BB2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4na-0001UN-Nr
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WR-0002rc-E9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WM-0002iq-5Z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amCd8MPJ5JbVAyhyBDOKUGF3E7N6O6LgOOnFLyzDDJI=;
 b=OKaIDeIlit3UbBzwSoTJrS5C6mgR8GOwsRmUCIU1RU3eZTDH6rH2spIGdXAdpTiaSMYy3p
 VjzVbtGufkY9l71LFbss/GfNGzj4OIAY72OD54r+YhhCEWyLlWR0qvXg/wiif2DJffUBpi
 JIbdqwe9Z92yjMds83AXMfL1sed2RLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-EFTn3PNuMdCVwHisPWh0uA-1; Mon, 12 Oct 2020 16:34:11 -0400
X-MC-Unique: EFTn3PNuMdCVwHisPWh0uA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EFC5D68A3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:34:03 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6B796EF59
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:34:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/38] meson: identify more sections of meson.build
Date: Mon, 12 Oct 2020 16:33:43 -0400
Message-Id: <20201012203343.1105018-39-pbonzini@redhat.com>
In-Reply-To: <20201012203343.1105018-1-pbonzini@redhat.com>
References: <20201012203343.1105018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add more headers that clarify code organization.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index 0c676af194..652c37cceb 100644
--- a/meson.build
+++ b/meson.build
@@ -614,7 +614,9 @@ if not has_malloc_trim and get_option('malloc_trim').enabled()
   endif
 endif
 
-# Create config-host.h
+#################
+# config-host.h #
+#################
 
 config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
@@ -660,6 +662,10 @@ foreach k, v: config_host
   endif
 endforeach
 
+########################
+# Target configuration #
+########################
+
 minikconf = find_program('scripts/minikconf.py')
 config_all = {}
 config_all_devices = {}
@@ -866,7 +872,9 @@ config_all += {
   'CONFIG_ALL': true,
 }
 
-# Submodules
+##############
+# Submodules #
+##############
 
 capstone = not_found
 capstone_opt = get_option('capstone')
@@ -1105,9 +1113,11 @@ config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_FDT', fdt.found())
 config_host_data.set('CONFIG_SLIRP', slirp.found())
 
-genh += configure_file(output: 'config-host.h', configuration: config_host_data)
+#####################
+# Generated sources #
+#####################
 
-# Generators
+genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
 hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.pl')
@@ -1182,7 +1192,9 @@ sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
                         meson.source_root() / 'docs/sphinx/qmp_lexer.py',
                         qapi_gen_depends ]
 
-# Collect sourcesets.
+###################
+# Collect sources #
+###################
 
 authz_ss = ss.source_set()
 blockdev_ss = ss.source_set()
@@ -1320,8 +1332,6 @@ if enable_modules
   modulecommon = declare_dependency(link_whole: libmodulecommon, compile_args: '-DBUILD_DSO')
 endif
 
-# Build targets from sourcesets
-
 stub_ss = stub_ss.apply(config_all, strict: false)
 
 util_ss.add_all(trace_ss)
@@ -1409,6 +1419,10 @@ specific_ss.add_all(when: 'CONFIG_LINUX_USER', if_true: linux_user_ss)
 subdir('tests/qtest/libqos')
 subdir('tests/qtest/fuzz')
 
+########################
+# Library dependencies #
+########################
+
 block_mods = []
 softmmu_mods = []
 foreach d, list : modules
@@ -1443,10 +1457,6 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 
-########################
-# Library dependencies #
-########################
-
 qom_ss = qom_ss.apply(config_host, strict: false)
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
@@ -1797,6 +1807,10 @@ if host_machine.system() == 'windows'
   alias_target('installer', nsis)
 endif
 
+#########################
+# Configuration summary #
+#########################
+
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
 summary_info += {'BIOS directory':    config_host['qemu_datadir']}
-- 
2.26.2


