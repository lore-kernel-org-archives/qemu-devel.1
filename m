Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6D3C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0A7206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0A7206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7RX-00009B-9m
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kD795-0001z7-CV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:20:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20892
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kD793-0005BP-Ky
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:20:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-KJqd5laeNCGggcmv5okXgQ-1; Tue, 01 Sep 2020 10:20:18 -0400
X-MC-Unique: KJqd5laeNCGggcmv5okXgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0810E801AF2
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 14:20:18 +0000 (UTC)
Received: from bahia.lan (ovpn-112-6.ams2.redhat.com [10.36.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF865C1C4;
 Tue,  1 Sep 2020 14:20:17 +0000 (UTC)
Subject: [PATCH 2/2] Makefile: Fix in-tree clean/distclean
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 01 Sep 2020 16:20:16 +0200
Message-ID: <159897001659.442705.15538955005543395950.stgit@bahia.lan>
In-Reply-To: <159896923655.442705.11922948674073863022.stgit@bahia.lan>
References: <159896923655.442705.11922948674073863022.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Doing 'make clean' or 'make distclean' in a freshly cloned tree results in:

make: *** No rule to make target 'ninja-clean', needed by 'clean'.  Stop.

Make the fallback rules global. While here, change the ninjatool recipe to
always have a zero exit status and thus prevent make to emit a warning.

Fixes: a56650518f5b ("configure: integrate Meson in the build system")
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 Makefile |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 8ffe2872915d..08f4d3eb5c3c 100644
--- a/Makefile
+++ b/Makefile
@@ -54,13 +54,6 @@ export NINJA=3D./ninjatool
 # enough to prime the rest of the build.
 ninjatool: build.ninja
=20
-# Only needed in case Makefile.ninja does not exist.
-.PHONY: ninja-clean ninja-distclean clean-ctlist
-clean-ctlist:
-ninja-clean::
-ninja-distclean::
-build.ninja: config-host.mak
-
 Makefile.ninja: build.ninja ninjatool
 =09./ninjatool -t ninja2make --omit clean dist uninstall cscope TAGS ctags=
 < $< > $@
 -include Makefile.ninja
@@ -115,6 +108,13 @@ ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)=
),$(if $(MAKECMDGOALS),,fa
 endif
 endif
=20
+# Only needed in case Makefile.ninja does not exist.
+.PHONY: ninja-clean ninja-distclean clean-ctlist
+clean-ctlist:
+ninja-clean::
+ninja-distclean::
+build.ninja: config-host.mak
+
 include $(SRC_PATH)/rules.mak
=20
 # lor is defined in rules.mak
@@ -195,7 +195,7 @@ recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
 ######################################################################
=20
 clean: recurse-clean ninja-clean clean-ctlist
-=09-test -f ninjatool && ./ninjatool $(if $(V),-v,) -t clean
+=09if test -f ninjatool; then ./ninjatool $(if $(V),-v,) -t clean; fi
 # avoid old build problems by removing potentially incorrect old files
 =09rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h =
gen-op-arm.h
 =09find . \( -name '*.so' -o -name '*.dll' -o -name '*.[oda]' \) -type f \



