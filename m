Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7BDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF9920734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MhY+2Ftf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF9920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixgh-00081o-Ng
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixad-0008GS-2n; Wed, 10 Jun 2020 06:04:11 -0400
Received: from mail-eopbgr130098.outbound.protection.outlook.com
 ([40.107.13.98]:48772 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jixab-0005xX-6h; Wed, 10 Jun 2020 06:04:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4fSmejt9s/z7Go00cWWQrE7xQfjzDi1StdPp6YhgXEtivAVH14pJiXH0OmMDix8cF5TpHC8N4OmJDN/opv6dri+13d3pJQw6NwWooszxGDdev6SCORjlXv4LOuwFcQluGpjDpZ0hr7vnWARzlFSxt9466LdzQHaj1tRHNwND3sI7b05nteN31DpDeKyLpG2GQ10Q6/UYF2aAbXtWDpkj4h3+3pepy4KNJWKt7eatV13eIYmk60UKuYfJ/r/U3YmGmYUD5dsyLJF1UO2OWXxrTt9+Y0kFfXJ7wTsC0Tz+EOmiwaVeaPyMXoiyhRyKwAsycJutuEheho5K98MkyCWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJJi2loRZgPaPIorUhGFO4frr4iSoysFAZrh0Vbw1ro=;
 b=cBWIRgL3GMBwBupAzetFERZH+hQWt8TI1yWIfdwrVgtNU3QqIbV1HiXboRuXuG5sQ0eidhpPa0CFmrzuHhAe2F/nSN+1WbnCxtfGYukaZXhL/CYMmi1UiU3dJhZiITGla4x6FqKva6vsZQDAoXzkuKumH0hW0XfNAFzsyd1W6m36YOu0QbcckW8JjjIoBwstpK1qdY5Cc6zaO0dPUN8b8LEfwmqw986YvSdfevcPo3n0Kknr1sxo7IMYqLPZSzh4EFnfMgeST0mBkZn9uJmRK7OEDhrN6yrkSfmC3KHtovGwXqmW8dwbNfSf6TwaqS6/rZP+YMB9BpAEu6PdEWGH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJJi2loRZgPaPIorUhGFO4frr4iSoysFAZrh0Vbw1ro=;
 b=MhY+2FtfjtzVTUZdtskQjnaJRwQyXwp9nOGQmY1dp74Oz301EUmrfrO7SqtavFHzdtvOUyy2mSXJV0zHYWQi+kDvUSulImpeUdO32BPSLV9APmmyN2hxhMyfJWd0FLOTUsGiGuL8caOpAZydnxQf7o/3+yGG3FEdaEWED14lj7U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5525.eurprd08.prod.outlook.com (2603:10a6:20b:107::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 10:04:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 10:04:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 4/7] scripts: add coroutine-wrapper.py
Date: Wed, 10 Jun 2020 13:03:33 +0300
Message-Id: <20200610100336.23451-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610100336.23451-1-vsementsov@virtuozzo.com>
References: <20200610100336.23451-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:208:14::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.166) by
 AM0PR03CA0005.eurprd03.prod.outlook.com (2603:10a6:208:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 10:03:59 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36cb3ada-c893-446e-1ea8-08d80d259899
X-MS-TrafficTypeDiagnostic: AM7PR08MB5525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5525B8F14259E4859D6F0E8CC1830@AM7PR08MB5525.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7mHr5kjuIEtv4EF/+WQdSc6rym59MirBxbgEDDYt8Bs46sYyesZnBWjGDJj+kK9XbCpF89QpPCCgLdLzxfeb+aBNDbYlM+uiOtPZtPbP4NTqKhkc3CMf4aQbnLEBHUp5TQ9czzF9EXpuwFoukTtE5vZX2wXXgnZWLEBeh7XQ12McRJ1D39cb70Szwbum0iWsiTsD2CsPC88ut6T/ofQEY54hlZhGWgUqK1xa9Xe/rFwYAQCCn+YotzvGj+6B0v1rlN6K1Dqp25cRw9zKV/3K2+mf7IEtRJpjDAS07rVxN0RiqjzeZKBQe97XZE10PPMfUHscL2LGkA7HM1OzCElla+OPbkUwV/mjIJp7njd6tLM17aiXPag7y2+m2PMQWjI2C5JUmzYUIXEbHfuDq5PAz/VjpfklqUnDwXGrWsCufJovk92bKVnok9TS8oVT/dtxGObpivnXCztV52oxCGa0wjRvUep4jEzvtmUdu3jgqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(478600001)(83380400001)(66556008)(66476007)(956004)(6666004)(316002)(5660300002)(6512007)(2616005)(36756003)(8936002)(107886003)(69590400007)(6916009)(6486002)(26005)(4326008)(66946007)(186003)(8676002)(6506007)(30864003)(52116002)(1076003)(2906002)(86362001)(16526019)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cgVsW83kNch4BBmogti01uozCkV/AMQmsZIcOE6OdEE+pXOfCtTVZxiitcxkLczWytVRWC2wqg5J3Bha9L1n3VYAWOQdSORrNIsanuWF/SM5WVaBGp8pEnsLlPseQ7yn3/Kblcgt4AG/BX1HPp/GTlYnNboYDoWKiG2LL4jGcrxPH5W2+xV5M6y2YDruaxR2UIDDlXaSwhk9tmdrQpYQON6YvgrdIsHSkUen8j+1tuvUyP2RJacgW7L8TjfoboHLK2EUgJ43zujEYM2seeAYk2IPaBJ3XjJkRRamiNacPBRfqXTsgXIcsCp/P5CwcMSyYww6puKwdTkd6s39n5iRFzXH2UUHBjsrZip8B4Si3Cgl66MFRCLgRjDhP3gIicDM76MDFhTy2A6+TnGHHzTimnW3i+IPR7U6lE7Yn64wmGvDzaa4UiAxEjTNCU4bKdLzfy3twYiOz7pNnt+/0yfrG035bDNAGvcm49oEekJV4tg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cb3ada-c893-446e-1ea8-08d80d259899
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 10:04:00.0965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jbKL4qBkkwGqykyfZGKKoOAImwzYKgNMxtYqWr1dFODfTE9HSv0iikl9YFnfJN4n8aWCax5MNY8WxG5N3NaWU9V4XMR+oKl8KuuTFc1ihk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5525
Received-SPF: pass client-ip=40.107.13.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 06:04:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a very frequent pattern of creating coroutine from function
with several arguments:

  - create structure to pack parameters
  - create _entry function to call original function taking parameters
    from struct
  - do different magic to handle completion: set ret to NOT_DONE or
    EINPROGRESS or use separate bool field
  - fill the struct and create coroutine from _entry function and this
    struct as a parameter
  - do coroutine enter and BDRV_POLL_WHILE loop

Let's reduce code duplication by generating coroutine wrappers.

This patch adds scripts/coroutine-wrapper.py together with some
friends, which will generate functions with declared prototypes marked
by 'generated_co_wrapper' specifier.

The usage of new code generation is as follows:

    1. define somewhere

        int coroutine_fn bdrv_co_NAME(...) {...}

       function

    2. declare in some header file

        int generated_co_wrapper bdrv_NAME(...);

       function with same list of parameters. (you'll need to include
       "block/generated-co-wrapper.h" to get the specifier)

    3. both declarations should be available through block/coroutines.h
       header.

    4. add header with generated_co_wrapper declaration into
       COROUTINE_HEADERS list in Makefile

Still, no function is now marked, this work is for the following
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 Makefile                     |   8 ++
 block/block-gen.h            |  49 ++++++++++
 include/block/block.h        |   7 ++
 block/Makefile.objs          |   1 +
 scripts/coroutine-wrapper.py | 180 +++++++++++++++++++++++++++++++++++
 5 files changed, 245 insertions(+)
 create mode 100644 block/block-gen.h
 create mode 100755 scripts/coroutine-wrapper.py

diff --git a/Makefile b/Makefile
index d1af126ea1..517a29810f 100644
--- a/Makefile
+++ b/Makefile
@@ -175,6 +175,14 @@ generated-files-y += $(TRACE_SOURCES)
 generated-files-y += $(BUILD_DIR)/trace-events-all
 generated-files-y += .git-submodule-status
 
+generated-files-y += block/block-gen.c
+
+COROUTINE_HEADERS = include/block/block.h block/coroutines.h
+block/block-gen.c: $(COROUTINE_HEADERS) scripts/coroutine-wrapper.py
+	$(call quiet-command, \
+		cat $(addprefix $(SRC_PATH)/,$(COROUTINE_HEADERS)) | \
+		$(SRC_PATH)/scripts/coroutine-wrapper.py > $@,"GEN","$(TARGET_DIR)$@")
+
 trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
 
 tracetool-y = $(SRC_PATH)/scripts/tracetool.py
diff --git a/block/block-gen.h b/block/block-gen.h
new file mode 100644
index 0000000000..f80cf4897d
--- /dev/null
+++ b/block/block-gen.h
@@ -0,0 +1,49 @@
+/*
+ * Block coroutine wrapping core, used by auto-generated block/block-gen.c
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * Copyright (c) 2020 Virtuozzo International GmbH
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef BLOCK_BLOCK_GEN_H
+#define BLOCK_BLOCK_GEN_H
+
+#include "block/block_int.h"
+
+/* Base structure for argument packing structures */
+typedef struct BdrvPollCo {
+    BlockDriverState *bs;
+    bool in_progress;
+    int ret;
+    Coroutine *co; /* Keep pointer here for debugging */
+} BdrvPollCo;
+
+static inline int bdrv_poll_co(BdrvPollCo *s)
+{
+    assert(!qemu_in_coroutine());
+
+    bdrv_coroutine_enter(s->bs, s->co);
+    BDRV_POLL_WHILE(s->bs, s->in_progress);
+
+    return s->ret;
+}
+
+#endif /* BLOCK_BLOCK_GEN_H */
diff --git a/include/block/block.h b/include/block/block.h
index 46965a7780..59a002e06f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -10,6 +10,13 @@
 #include "block/blockjob.h"
 #include "qemu/hbitmap.h"
 
+/*
+ * generated_co_wrapper
+ * Function specifier, which does nothing but marking functions to be
+ * generated by scripts/coroutine-wrapper.py
+ */
+#define generated_co_wrapper
+
 /* block.c */
 typedef struct BlockDriver BlockDriver;
 typedef struct BdrvChild BdrvChild;
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 3635b6b4c1..05e4d033c1 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -45,6 +45,7 @@ block-obj-y += crypto.o
 block-obj-y += aio_task.o
 block-obj-y += backup-top.o
 block-obj-y += filter-compress.o
+block-obj-y += block-gen.o
 common-obj-y += monitor/
 
 block-obj-y += stream.o
diff --git a/scripts/coroutine-wrapper.py b/scripts/coroutine-wrapper.py
new file mode 100755
index 0000000000..57ae6aed20
--- /dev/null
+++ b/scripts/coroutine-wrapper.py
@@ -0,0 +1,180 @@
+#!/usr/bin/env python3
+"""Generate coroutine wrappers for block subsystem.
+
+The program parses one or several concatenated c files from stdin,
+searches for functions with 'generated_co_wrapper' specifier
+and generates corresponding wrappers on stdout.
+
+Usage: cat FILE.[ch]... | coroutine-wrapper.py > generated-file.c
+
+Copyright (c) 2020 Virtuozzo International GmbH.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program.  If not, see <http://www.gnu.org/licenses/>.
+"""
+
+import sys
+import re
+import subprocess
+import json
+from typing import Iterator
+
+
+def prettify(code: str) -> str:
+    """Prettify code using clang-format if available"""
+
+    try:
+        style = json.dumps({
+            'IndentWidth': 4,
+            'BraceWrapping': {'AfterFunction': True},
+            'BreakBeforeBraces': 'Custom',
+            'SortIncludes': False,
+            'MaxEmptyLinesToKeep': 2
+        })
+        p = subprocess.run(['clang-format', f'-style={style}'], check=True,
+                           encoding='utf-8', input=code,
+                           stdout=subprocess.PIPE)
+        return p.stdout
+    except FileNotFoundError:
+        return code
+
+
+def gen_header():
+    copyright = re.sub('^.*Copyright', 'Copyright', __doc__, flags=re.DOTALL)
+    copyright = re.sub('^(?=.)', ' * ', copyright.strip(), flags=re.MULTILINE)
+    copyright = re.sub('^$', ' *', copyright, flags=re.MULTILINE)
+    return f"""\
+/*
+ * File is generated by scripts/coroutine-wrapper.py
+ *
+{copyright}
+ */
+
+#include "qemu/osdep.h"
+#include "block/coroutines.h"
+#include "block/block-gen.h"
+#include "block/block_int.h"\
+"""
+
+
+class ParamDecl:
+    param_re = re.compile(r'(?P<decl>'
+                          r'(?P<type>.*[ *])'
+                          r'(?P<name>[a-z][a-z0-9_]*)'
+                          r')')
+
+    def __init__(self, param_decl: str) -> None:
+        m = self.param_re.match(param_decl.strip())
+        if m is None:
+            raise ValueError(f'Wrong parameter declaration: "{param_decl}"')
+        self.decl = m.group('decl')
+        self.type = m.group('type')
+        self.name = m.group('name')
+
+
+class FuncDecl:
+    def __init__(self, return_type: str, name: str, args: str) -> None:
+        self.return_type = return_type.strip()
+        self.name = name.strip()
+        self.args = [ParamDecl(arg.strip()) for arg in args.split(',')]
+
+    def gen_list(self, format: str) -> str:
+        return ', '.join(format.format_map(arg.__dict__) for arg in self.args)
+
+    def gen_block(self, format: str) -> str:
+        return '\n'.join(format.format_map(arg.__dict__) for arg in self.args)
+
+
+# Match wrappers declared with a generated_co_wrapper mark
+func_decl_re = re.compile(r'^int\s*generated_co_wrapper\s*'
+                          r'(?P<wrapper_name>[a-z][a-z0-9_]*)'
+                          r'\((?P<args>[^)]*)\);$', re.MULTILINE)
+
+
+def func_decl_iter(text: str) -> Iterator:
+    for m in func_decl_re.finditer(text):
+        yield FuncDecl(return_type='int',
+                       name=m.group('wrapper_name'),
+                       args=m.group('args'))
+
+
+def snake_to_camel(func_name: str) -> str:
+    """
+    Convert underscore names like 'some_function_name' to camel-case like
+    'SomeFunctionName'
+    """
+    words = func_name.split('_')
+    words = [w[0].upper() + w[1:] for w in words]
+    return ''.join(words)
+
+
+def gen_wrapper(func: FuncDecl) -> str:
+    assert func.name.startswith('bdrv_')
+    assert not func.name.startswith('bdrv_co_')
+    assert func.return_type == 'int'
+    assert func.args[0].type in ['BlockDriverState *', 'BdrvChild *']
+
+    name = 'bdrv_co_' + func.name[5:]
+    bs = 'bs' if func.args[0].type == 'BlockDriverState *' else 'child->bs'
+    struct_name = snake_to_camel(name)
+
+    return f"""\
+/*
+ * Wrappers for {name}
+ */
+
+typedef struct {struct_name} {{
+    BdrvPollCo poll_state;
+{ func.gen_block('    {decl};') }
+}} {struct_name};
+
+static void coroutine_fn {name}_entry(void *opaque)
+{{
+    {struct_name} *s = opaque;
+
+    s->poll_state.ret = {name}({ func.gen_list('s->{name}') });
+    s->poll_state.in_progress = false;
+
+    aio_wait_kick();
+}}
+
+int {func.name}({ func.gen_list('{decl}') })
+{{
+    if (qemu_in_coroutine()) {{
+        return {name}({ func.gen_list('{name}') });
+    }} else {{
+        {struct_name} s = {{
+            .poll_state.bs = {bs},
+            .poll_state.in_progress = true,
+
+{ func.gen_block('            .{name} = {name},') }
+        }};
+
+        s.poll_state.co = qemu_coroutine_create({name}_entry, &s);
+
+        return bdrv_poll_co(&s.poll_state);
+    }}
+}}"""
+
+
+def gen_wrappers_file(input_code: str) -> str:
+    res = gen_header()
+    for func in func_decl_iter(input_code):
+        res += '\n\n\n'
+        res += gen_wrapper(func)
+
+    return prettify(res)  # prettify to wrap long lines
+
+
+if __name__ == '__main__':
+    print(gen_wrappers_file(sys.stdin.read()))
-- 
2.21.0


