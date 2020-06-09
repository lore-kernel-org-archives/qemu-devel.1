Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF11C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91F0206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WXkEr3s2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91F0206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif4t-0003sW-Sj
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0p-0006qf-FF; Tue, 09 Jun 2020 10:13:59 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:27969 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jif0n-0007gx-MO; Tue, 09 Jun 2020 10:13:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeCOXhWiEq3HFKzIt8O8T34nrD1Zx70H7jh/WGZcrQBfVQchMcF/BBi7zZ1V9BNssMYuiv3T35raxoRyyKzIrGIO3o1xdlQfLppZeFpOrBO8RCWUTF1LiUplGw2nJG2ayEH+bfRv2SLWQCM9560WWFsye4NuAffvF3/xcY8hBPfhrEtvYXcWqGzatvnjtWAy7affZy0A4jeTY+gGxi0yHynce+mTzkAVb11t9hDoR1CAQW0UQMqAkGJejrTNUayQbkRlAW3zTkz84OL7XEMrA7HfOvk+yaPchhriqPo6crRnLEyCTrgnee+4qcWbAWwwDfCUweOfNXN9+vHyjNBUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGeEa/tG+Uhdcvr3hUZQEhZ4NR9pDdo25ndUBd5AObc=;
 b=IYYUeGoa2m7ITxIhvmLbw8Gf9p7vG7EM59fXkKSFt0jFym/fBliZHaPjdNOwVYoQ81swLVxZ7F78sBIMp/yEL0Mkpf7TTJZmfgxQqXd0Pks8Qsvun+/LF10N0fuEizLc4yC4IDz8SE0ZwYFUx0Qo70KOLB2wY9nG8761QlGw1moMGGx2WwGBwfnP/TB1QaQpwkefReFPdRT2DDw8D/n3IKu5ZGKZNpTKZ2p+7IJlK9EJsIvfpsfIYW2+0154aFCl6+ifciBWaTUN0q132gm955BE9Jr1Z/UnkSNGHzgvlS7XE63SNZGnysxs/HsnoQUlnZjM0LPn+34kiNV+OYR7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGeEa/tG+Uhdcvr3hUZQEhZ4NR9pDdo25ndUBd5AObc=;
 b=WXkEr3s26sk+Fl/lxCZV4TFgNgG7xu4avpMh3k6ASaDvohSLS3FyFnYOYFv1kL5ebAy6EN6VBBTWd8fzWL16tx1Ik9t5vqLyutppKN19llhzNsVCZBYyyBqIOkUzEYbOLcOFAG+1OH6sy9tUsHlRGzRX25VwSKlOuObfVvgZkAY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 14:13:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 14:13:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 4/7] scripts: add coroutine-wrapper.py
Date: Tue,  9 Jun 2020 17:13:26 +0300
Message-Id: <20200609141329.3945-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200609141329.3945-1-vsementsov@virtuozzo.com>
References: <20200609141329.3945-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.180) by
 FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.20 via Frontend Transport; Tue, 9 Jun 2020 14:13:49 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bed8c52-e180-44df-8f9e-08d80c7f5567
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5494176ED13F16F4EBD6A67DC1820@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/L8d78OXgsVrisgeeeZkOue54BAOGIn0DSJYt/AYK6FG+qprywX1YJmxPBmVpN7tHl/3cUcKFHFl2u32oMDC4wJoZbfdEZfNvll9VUHl3yzYU+YuZNa7ipyGg4P8Ad6Xp86XkrJyBYCdwXKy5kkJrkxpWGHXwemz/Fs+9wVk7ave1jSOU+KZX/ZUWREQ2zMPqpGV5rn4a+FmxzMK3Ho/sGyvg3E3qAQOTHaiD5WqnXriJyKUoreYvHukvSDUrSHAElK95pmrNL8Rsta/lYnl7EX1/GBxVWEG+VcrpLanUfpzCGFR+x6yXX9s5JSeKNL64GiXwZAeTYaA9zaYQULQvqh7HnqFnewLLa6R+zZGRZvoVjUpDS9pS4rBSGnbixhcQzD4l5Q3h3ls3I7ELEMZ4JnNcLmrfXaZv3qZGd1INern8I90pOJ7mcVlyemPId3Lfogm2n4QazKh9mpqRV6s8ZLpozZPYRtSUfL4Mo7np8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39850400004)(346002)(2906002)(6512007)(8676002)(83380400001)(6506007)(16526019)(186003)(26005)(6486002)(478600001)(36756003)(69590400007)(6666004)(8936002)(52116002)(6916009)(30864003)(66476007)(66946007)(5660300002)(66556008)(1076003)(86362001)(4326008)(2616005)(316002)(107886003)(956004)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: chyrnUu2MBUf8YFeCx2Qz6jaCkoYwunl9I6diZ7ZcjfiiJDZ4yZzTN5o5eAOiVfUIaOvo+udoMDamXpmhKR8+NgQ0PvSwwAdqKH8MwknTUjaevTDbgtYb0Vu0MkavvFRDNiJkMu063h5FkCMh3lMQNV0RJw9EdpEb5Euxac/ttqEfEazk7qlTFODGlnGgWhR/JlYv3ohQ9TlWorkBSEbDHzekIGr/fljzxiHBOOEruxcw5xkz8wcNQsQl9u2qs1HZ8wHtuIRWcmzGCYw70Pyc3Yneo0oevD3vW8O6cdpbKY+QddULYyxntdvSsSa2lKjGy7SjvsOwTCthTI/KHyUF4oGSODltWWaHYuZmv/1bawEpSJu6SgPSz0YPD1gOMZMTEb7NG3NBQ44YmKn8TwftTlBGmR4rApnAUIC5uwRQWDHi4ursYGR5B9SnklP8JzfxgLdb5fXSBKDTfxrcDVU2hguukWKI9vg+d7VUwKY4kM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bed8c52-e180-44df-8f9e-08d80c7f5567
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 14:13:50.7559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGs3LVJmvZmAhnzsybEkWm4y7Qp5KQjNbD8NSKiNF81Ok2FhS+tdKz+JFNBTAdJPKZ1xT+9ui4eX+0RsVY08dh3R2cffMdZ2H2z423bw1YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:13:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
    EINPROGRESS, use separate bool for void functions
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
 Makefile                             |   8 ++
 block/block-gen.h                    |  55 +++++++++
 include/block/generated-co-wrapper.h |  35 ++++++
 block/Makefile.objs                  |   1 +
 scripts/coroutine-wrapper.py         | 174 +++++++++++++++++++++++++++
 5 files changed, 273 insertions(+)
 create mode 100644 block/block-gen.h
 create mode 100644 include/block/generated-co-wrapper.h
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
index 0000000000..482d06737d
--- /dev/null
+++ b/block/block-gen.h
@@ -0,0 +1,55 @@
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
+/* This function is called at the end of generated coroutine entries. */
+static inline void bdrv_poll_co__on_exit(void)
+{
+    aio_wait_kick();
+}
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
diff --git a/include/block/generated-co-wrapper.h b/include/block/generated-co-wrapper.h
new file mode 100644
index 0000000000..62c6e053ba
--- /dev/null
+++ b/include/block/generated-co-wrapper.h
@@ -0,0 +1,35 @@
+/*
+ * Block layer I/O functions
+ *
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
+#ifndef BLOCK_GENERATED_CO_WRAPPER_H
+#define BLOCK_GENERATED_CO_WRAPPER_H
+
+/*
+ * generated_co_wrapper
+ * Function specifier, which does nothing but marking functions to be
+ * generated by scripts/coroutine-wrapper.py
+ */
+#define generated_co_wrapper
+
+#endif /* BLOCK_GENERATED_CO_WRAPPER_H */
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
index 0000000000..dbe6fb97d9
--- /dev/null
+++ b/scripts/coroutine-wrapper.py
@@ -0,0 +1,174 @@
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
+from typing import Iterator
+
+
+def prettify(code: str) -> str:
+    """Prettify code using clang-format if available"""
+
+    try:
+        style = '{IndentWidth: 4, BraceWrapping: {AfterFunction: true}, ' \
+            'BreakBeforeBraces: Custom, SortIncludes: false, ' \
+            'MaxEmptyLinesToKeep: 2}'
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
+#include "block/block-gen.h"\
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
+    bdrv_poll_co__on_exit();
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


