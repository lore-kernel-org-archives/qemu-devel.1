Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ED9C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8232084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8232084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAO0-0003Bd-Ms
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6w-00017h-FE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60284
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6u-0005Iw-KD
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:30 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-QiKz7tUoNwSx3FO5Pp-qwA-1; Fri, 04 Sep 2020 07:42:26 -0400
X-MC-Unique: QiKz7tUoNwSx3FO5Pp-qwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4D2496E54D;
 Fri,  4 Sep 2020 11:41:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63FDC1002D4C;
 Fri,  4 Sep 2020 11:41:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/46] meson: specify fuzz linker script as a project arg
Date: Fri,  4 Sep 2020 07:41:19 -0400
Message-Id: <20200904114122.31307-44-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

With this change, the fuzzer-linker script should be specified outside
any --start-group/--end-group pairs. We need this on oss-fuzz, where
partially applying the linker-script results in a linker failure

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200902173652.307222-2-alxndr@bu.edu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                  | 9 ++++++++-
 tests/qtest/fuzz/meson.build | 3 ---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index a10239cfa4..9473b42da3 100644
--- a/meson.build
+++ b/meson.build
@@ -56,6 +56,14 @@ add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
                       language: ['c', 'cpp', 'objc'])
 
+# Specify linker-script with add_project_link_arguments so that it is not placed
+# within a linker --start-group/--end-group pair
+if 'CONFIG_FUZZ' in config_host
+   add_project_link_arguments(['-Wl,-T,',
+                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
+                              native: false, language: ['c', 'cpp', 'objc'])
+endif
+
 link_language = 'c'
 if add_languages('cpp', required: false, native: false)
   cxx = meson.get_compiler('cpp')
@@ -1094,7 +1102,6 @@ foreach target : target_dirs
         'gui': false,
         'sources': specific_fuzz.sources(),
         'dependencies': specific_fuzz.dependencies(),
-        'link_depends': [files('tests/qtest/fuzz/fork_fuzz.ld')],
       }]
     endif
   else
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
index bb0a3f271d..bcc393828e 100644
--- a/tests/qtest/fuzz/meson.build
+++ b/tests/qtest/fuzz/meson.build
@@ -6,11 +6,8 @@ specific_fuzz_ss.add(when: 'CONFIG_I440FX', if_true: files('i440fx_fuzz.c'))
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio_net_fuzz.c'))
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuzz.c'))
 
-# unfortunately declare_dependency does not support link_depends, so
-# this will be duplicated in meson.build
 fork_fuzz = declare_dependency(
   link_args: ['-fsanitize=fuzzer',
-              '-Wl,-T,' + (meson.current_source_dir() / 'fork_fuzz.ld'),
               '-Wl,-wrap,qtest_inb',
               '-Wl,-wrap,qtest_inw',
               '-Wl,-wrap,qtest_inl',
-- 
2.26.2



