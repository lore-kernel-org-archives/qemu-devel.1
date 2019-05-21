Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B146FC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FB520863
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FB520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48639 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSzuK-0001Aq-AJ
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 04:14:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSztQ-0000pj-UW
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSztP-0003NI-0b
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:13:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:64183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSztN-0003L4-S6
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:13:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 May 2019 01:12:59 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga006.fm.intel.com with ESMTP; 21 May 2019 01:12:58 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 16:12:27 +0800
Message-Id: <20190521081227.30799-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.120
Subject: [Qemu-devel] [PATCH] Makefile: simplify qapi-py definition with
 wildcard
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
Cc: berrange@redhat.com, philmd@redhat.com, kraxel@redhat.com,
	alex.bennee@linaro.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All the python script in scripts/qapi is used to generate qapi code. Use
wildcard to simplify it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 Makefile | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 155f066a20..38b74782d9 100644
--- a/Makefile
+++ b/Makefile
@@ -541,13 +541,7 @@ qemu-ga$(EXESUF): QEMU_CFLAGS += -I qga/qapi-generated
 qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 
-qapi-py = $(SRC_PATH)/scripts/qapi/commands.py \
-$(SRC_PATH)/scripts/qapi/events.py \
-$(SRC_PATH)/scripts/qapi/introspect.py \
-$(SRC_PATH)/scripts/qapi/types.py \
-$(SRC_PATH)/scripts/qapi/visit.py \
-$(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
+qapi-py = $(wildcard $(SRC_PATH)/scripts/qapi/*.py) \
 $(SRC_PATH)/scripts/qapi-gen.py
 
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
-- 
2.19.1


