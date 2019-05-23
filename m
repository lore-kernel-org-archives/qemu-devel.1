Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E66C04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BED220862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BED220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59788 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTj7g-0006k0-NV
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 04:30:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTj2W-0002Lm-Fk
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTit6-0000sd-HV
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:15:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTit6-0000rm-Aq
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:15:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D3E46439B;
	Thu, 23 May 2019 08:15:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E05A45B683;
	Thu, 23 May 2019 08:15:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0404C11329D3; Thu, 23 May 2019 10:15:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 10:15:38 +0200
Message-Id: <20190523081538.2291-8-armbru@redhat.com>
In-Reply-To: <20190523081538.2291-1-armbru@redhat.com>
References: <20190523081538.2291-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 23 May 2019 08:15:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 7/7] tests: Make check-source cover generated
 headers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

FIXME Computation of generated target-dependent headers

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-headers.mak | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tests/check-headers.mak b/tests/check-headers.mak
index 589c62d66b..16a5f4e214 100644
--- a/tests/check-headers.mak
+++ b/tests/check-headers.mak
@@ -4,16 +4,26 @@ ifneq ($(wildcard $(SRC_PATH)/.git),)
 
 # All headers:
 src-headers := $(filter %.h, $(shell cd $(SRC_PATH) && git ls-files))
+gen-headers := $(filter %.h, $(generated-files-y))
+ifeq ($(generated-files-y),) # FIXME empty when included from Makefile.target
+$(warning warning: working around empty generated-files-y)
+# Work-around: hard-code the generated headers that are actually
+# target-dependent
+gen-headers := qapi/qapi-types-target.h qapi/qapi-visit-target.h qapi/qapi-commands-target.h qapi/qapi-events-target.h qapi/qapi-types.h qapi/qapi-visit.h qapi/qapi-commands.h qapi/qapi-events.h
+endif
 
 # Third party headers we don't want to mess with:
 excluded-headers := $(filter disas/libvixl/vixl/% include/standard-headers/% linux-headers/% pc-bios/% slirp/%, $(src-headers))
+excluded-headers += $(filter trace-dtrace-root.h %/trace-dtrace.h, $(gen-headers))
 # Funny stuff we don't want to mess with:
 excluded-headers += $(filter tests/multiboot/% tests/tcg/% tests/uefi-test-tools/%, $(src-headers))
 excluded-headers += scripts/cocci-macro-file.h
 
 # Headers that require -DNEED_CPU_H etc.
 target-header-comment := NOTE: May only be included into target-dependent code
-target-headers := $(shell cd $(SRC_PATH) && egrep -l '$(target-header-comment)' $(src-headers))
+target-headers := $(filter qapi/qapi-%-target.h, $(gen-headers))
+target-headers += $(target-headers:-target.h=.h)
+target-headers += $(shell cd $(SRC_PATH) && egrep -l '$(target-header-comment)' $(src-headers))
 
 # Headers carrying a FIXME about this test:
 bad-header-without-linux$(CONFIG_LINUX) := | without CONFIG_LINUX
@@ -28,10 +38,11 @@ bad-header-without-x11$(CONFIG_X11) := | without CONFIG_X11
 bad-header-without-xen$(CONFIG_XEN) := | without CONFIG_XEN
 bad-header-comment := FIXME Does not pass make check-headers($(bad-header-without-linux)$(bad-header-without-opengl)$(bad-header-without-posix)$(bad-header-without-rdma)$(bad-header-without-replication)$(bad-header-without-spice)$(bad-header-without-system-emu)$(bad-header-without-win32)$(bad-header-without-x11)$(bad-header-without-xen)), yet!
 bad-headers := $(shell cd $(SRC_PATH) && egrep -l '$(bad-header-comment)' $(src-headers))
+bad-headers += trace/generated-tcg-tracers.h trace/generated-helpers-wrappers.h trace/generated-helpers.h
 bad-target-headers := $(filter $(target-headers), $(bad-headers))
 
 # Checked headers (all less excluded and bad):
-checked-headers := $(filter-out $(excluded-headers) $(bad-headers) $(target-headers), $(src-headers))
+checked-headers := $(filter-out $(excluded-headers) $(bad-headers) $(target-headers), $(src-headers) $(gen-headers))
 check-header-tests := $(patsubst %.h, tests/headers/%.c, $(checked-headers))
 checked-target-headers := $(filter-out $(excluded-headers) $(bad-headers), $(target-headers))
 check-target-header-tests := $(patsubst %.h, tests/headers/%.c, $(checked-target-headers))
-- 
2.17.2


