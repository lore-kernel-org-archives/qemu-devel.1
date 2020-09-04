Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBF1C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EB120791
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EB120791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAPq-00065Q-Iv
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6w-00018N-Nj
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6t-0005Io-Mt
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:30 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-wBlv_b1HPyuEEepW7ltmSw-1; Fri, 04 Sep 2020 07:42:25 -0400
X-MC-Unique: wBlv_b1HPyuEEepW7ltmSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2B57902635;
 Fri,  4 Sep 2020 11:41:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F8B61002D4C;
 Fri,  4 Sep 2020 11:41:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/46] meson: remove linkage of sdl to baum
Date: Fri,  4 Sep 2020 07:41:22 -0400
Message-Id: <20200904114122.31307-47-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
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
Cc: Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bruce Rogers <brogers@suse.com>

Ever since commit 537fe2d63f744e7c96ff45b60d09486a81958e06 there
has been a 'linkage' to sdl for compiling baum.c. Originally it
had to do with including sdl cflags for any file including sdl
headers. There is no longer any such need for baum.c, but the
association has persisted in the make system, and with the switch
to meson it has now become a hard requirement, which now causes
chardev-baum.so to not be produced if sdl is not configured.
Remove this bogus linkage.

Signed-off-by: Bruce Rogers <brogers@suse.com>
Message-Id: <20200903152933.97838-1-brogers@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/meson.build b/chardev/meson.build
index 27a9a28f4c..54e88d0310 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -36,9 +36,9 @@ softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
 
 chardev_modules = {}
 
-if config_host.has_key('CONFIG_BRLAPI') and sdl.found()
+if config_host.has_key('CONFIG_BRLAPI')
   module_ss = ss.source_set()
-  module_ss.add(when: [sdl, brlapi], if_true: [files('baum.c'), pixman])
+  module_ss.add(when: [brlapi], if_true: [files('baum.c'), pixman])
   chardev_modules += { 'baum': module_ss }
 endif
 
-- 
2.26.2


