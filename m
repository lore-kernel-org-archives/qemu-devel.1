Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5140C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024702396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H1ygsUK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024702396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWXQ-0000Tm-K1
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOY-0001TH-AN; Thu, 24 Sep 2020 14:55:06 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:8257 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOV-0002O2-8F; Thu, 24 Sep 2020 14:55:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMSorFXEletaDkiglIcqvIeMAq2gFo/HrmJRY3xKsYfvu4CYRAKe1hhKayVMqZ68WjRzde89/gOKoIAx6fqgmBeyXFXtl7EJh1BWBl+1rlk+wMo4tfjvXEhWlgBUDfD+Vt5HZkENl1xukj4Ub8fs+9wnsyY2+fQ7rHf2cTQI5SLg5YUAdhlykV9Mlf+niBuTh9jU+rg9jUtAkpR0lxLbzuakootOs273w2ha6E2StA7o9MdbQBLOnj+26AKi44o5iXW5DfMasNppTqeu/+V1xwlLAQI0ZInFE+jFPlQge5nmjKo6sarYcAIK4sO5/ngf2yPswHAXTUbOLAcx54g6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbaM5n3KLXdAwn6sS+GyjAMrwvGQDJwjtDo5Psu5LYY=;
 b=S3pD4ZXmX4PIARa17P3Tdchyv2T9YsyzXJmKwFY0hLsElxceuED09GvkFhnLJlQ499y1rnk3xIvPgOkE801tDoL7oQL6D5vVgJ/QxPkPiV0QC3ckO0r7JXK4htal/mvoofxZLObKy30FS39K2jpEvXdI5xOqvc2XixoEJ0yOKBsXc2Q/WHEJxB64oI5ucQubsizsmupbHkc+PU1ziGt84m9TlD+zXjGwPufvthMcAfor/RzDc1fOaIompI/czqycrUsQ+HzTL9xh4Yqt9uQnS6s7S6ZSTT0vWxGZdAVS+JQr3KVxqHH71kOuXWuROlGC0miRRcDwiWJ4IK+V31OzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbaM5n3KLXdAwn6sS+GyjAMrwvGQDJwjtDo5Psu5LYY=;
 b=H1ygsUK5rNJsG9UwN6yMJpSstv7EqL6IdIfN0wErZQVcLHP1yL39ZhH6otuVbFSpvlaHh+H9NWWVxwmHbmLwUoxG4UeyXhfBjSn/XK39eADLGtwKSu4kXGuiuFd9oZzSV0nqvGC80k3npNGdt+QNuzAIUIWxq51kYKUgpyc2muY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4341.eurprd08.prod.outlook.com (2603:10a6:20b:b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 18:54:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 18:54:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, eblake@redhat.com
Subject: [PATCH v9 4/7] scripts: add block-coroutine-wrapper.py
Date: Thu, 24 Sep 2020 21:54:11 +0300
Message-Id: <20200924185414.28642-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924185414.28642-1-vsementsov@virtuozzo.com>
References: <20200924185414.28642-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0082.eurprd05.prod.outlook.com
 (2603:10a6:208:136::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM0PR05CA0082.eurprd05.prod.outlook.com (2603:10a6:208:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 18:54:36 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5474063-a302-4865-de55-08d860bb48c5
X-MS-TrafficTypeDiagnostic: AM6PR08MB4341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4341131CC58CF0E608E4DBF1C1390@AM6PR08MB4341.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CL9I4sVrqT9S1RujFaCyr7GINwL0pBZgP05CINRVgjgPSQiWFOXdM7dMFLKTeIK0oSEBBZ+7D/IkTD4f4g7FymoEIE2iqgALVBKizYe9gIZapsrDh7RWNl7g4DwmTMOHq1WDhuwBp6XnxmqvJl9XrBGZAi9lsayFZm5Pe/ZoLyvHjqLM/QGbGqYSSaetmrKPjh94eGG/kQRbtuioHzL9+vjwHm23RNVEOCozAUsbYiWO9R8CvXkDKC5kgis3d6bdovv3Pvgej8sYHMK+R2QpNzAcjx9e+1nyrxUQkXCijyok6hCMx9SscLmRwfwrnsOUNNHvITCv2dWH4cuRuL3sd/oZ3slJucHWlvD8oSTtAVHSfLfZR/DikfUZSQzS1KxQIySyB/ybfmWi5K4/cMt/c09ypRPm2YAZGtnxnnug4NBCXMg2NRgaZbFGtA8ag9xrBFaILhzeVgj/qO8kk9SAU90DGrTch5vwyNxWXD5s6sgWNlkedhCbwvW0RyYlZrp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39840400004)(316002)(83380400001)(66476007)(6506007)(186003)(16526019)(5660300002)(2906002)(36756003)(6666004)(8936002)(8676002)(66946007)(2616005)(956004)(52116002)(6512007)(66556008)(86362001)(26005)(4326008)(478600001)(6916009)(1076003)(6486002)(30864003)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Y80rEh/FGLuaXoAEfaKkatJKsSEsnLOHIT9yQAibUtxfaphlmcLNeJvuQ4zoGS0m5FPUnpAKfTF5K2Ahod68USt1M4obhp3WvDoJXmU7DzbbLlhIQaUEmyi1i15Ty5SHhVE4IoYhGW6TpJAoMxjUlIZds6YrH8waM3wgnQnusbjdYKIJwvVASWiQJGBQfxzRDaaEVL2/4zU4jiAQpB+9z6hUg/TkcaXeCVQXBq2QInmfdoKphMvfkbROaRjxIvA16sROYbiTVHMm9ozLLhRuhI2XEfBWsj7fYQJyxEgZ/BvnbtUP0n3giv1hQlRMo+G9q5I5mfCzEynd+ZCBM7DFggms9qNKlRLFffVhk21TzeGfTO4ekwaAeJzIrisV7gJDP8H+oQwBJ6qW+wF6lWASkuTWBqoMkjKCZkb69oVSWDGdO0CedQOSkTzIdt0h+Ppf4C8+IRgGbR2m7Hrkesl0PuKNL0zECaXXt7GN76dbJvNK5f+F24kbdKYt1Afl0vr9xxzAvO3VeOT3kMsoS0hiO2s1PF1m7vzgiRwFgXVNFHfTB+jX0TA6cLZWgwzXSS+9hK4DrxK2r+ndbpRi5uM1W0WkTYRSCsKwCelhkPprqvOjkCG/yULG47NLnZJBstD4wpMQeL2EZBmFmQhAdCOZHg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5474063-a302-4865-de55-08d860bb48c5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:54:37.1004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kK/FAq98eK8P45dR+Qif8lC1uSrsYPTSkBzTGrfjFCMstOlS1DPLj48yfdemV+t2F9o09y0HawoJjrRDkKcYFqZRJacN54gORWU/oSC8o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4341
Received-SPF: pass client-ip=40.107.13.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:54:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We have a very frequent pattern of creating a coroutine from a function
with several arguments:

  - create a structure to pack parameters
  - create _entry function to call original function taking parameters
    from struct
  - do different magic to handle completion: set ret to NOT_DONE or
    EINPROGRESS or use separate bool field
  - fill the struct and create coroutine from _entry function with this
    struct as a parameter
  - do coroutine enter and BDRV_POLL_WHILE loop

Let's reduce code duplication by generating coroutine wrappers.

This patch adds scripts/block-coroutine-wrapper.py together with some
friends, which will generate functions with declared prototypes marked
by the 'generated_co_wrapper' specifier.

The usage of new code generation is as follows:

    1. define the coroutine function somewhere

        int coroutine_fn bdrv_co_NAME(...) {...}

    2. declare in some header file

        int generated_co_wrapper bdrv_NAME(...);

       with same list of parameters (generated_co_wrapper is
       defined in "include/block/block.h").

    3. Make sure the block_gen_c delaration in block/meson.build
       mentions the file with your marker function.

Still, no function is now marked, this work is for the following
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/devel/block-coroutine-wrapper.rst |  54 +++++++
 docs/devel/index.rst                   |   1 +
 block/block-gen.h                      |  49 +++++++
 include/block/block.h                  |  10 ++
 block/meson.build                      |   8 ++
 scripts/block-coroutine-wrapper.py     | 188 +++++++++++++++++++++++++
 6 files changed, 310 insertions(+)
 create mode 100644 docs/devel/block-coroutine-wrapper.rst
 create mode 100644 block/block-gen.h
 create mode 100644 scripts/block-coroutine-wrapper.py

diff --git a/docs/devel/block-coroutine-wrapper.rst b/docs/devel/block-coroutine-wrapper.rst
new file mode 100644
index 0000000000..d09fff2cc5
--- /dev/null
+++ b/docs/devel/block-coroutine-wrapper.rst
@@ -0,0 +1,54 @@
+=======================
+block-coroutine-wrapper
+=======================
+
+A lot of functions in QEMU block layer (see ``block/*``) can only be
+called in coroutine context. Such functions are normally marked by the
+coroutine_fn specifier. Still, sometimes we need to call them from
+non-coroutine context; for this we need to start a coroutine, run the
+needed function from it and wait for coroutine finish in
+BDRV_POLL_WHILE() loop. To run a coroutine we need a function with one
+void* argument. So for each coroutine_fn function which needs a
+non-coroutine interface, we should define a structure to pack the
+parameters, define a separate function to unpack the parameters and
+call the original function and finally define a new interface function
+with same list of arguments as original one, which will pack the
+parameters into a struct, create a coroutine, run it and wait in
+BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand,
+so we have a script to generate them.
+
+Usage
+=====
+
+Assume we have defined the ``coroutine_fn`` function
+``bdrv_co_foo(<some args>)`` and need a non-coroutine interface for it,
+called ``bdrv_foo(<same args>)``. In this case the script can help. To
+trigger the generation:
+
+1. You need ``bdrv_foo`` declaration somewhere (for example, in
+   ``block/coroutines.h``) with the ``generated_co_wrapper`` mark,
+   like this:
+
+.. code-block:: c
+
+    int generated_co_wrapper bdrv_foo(<some args>);
+
+2. You need to feed this declaration to block-coroutine-wrapper script.
+   For this, add the .h (or .c) file with the declaration to the
+   ``input: files(...)`` list of ``block_gen_c`` target declaration in
+   ``block/meson.build``
+
+You are done. During the build, coroutine wrappers will be generated in
+``<BUILD_DIR>/block/block-gen.c``.
+
+Links
+=====
+
+1. The script location is ``scripts/block-coroutine-wrapper.py``.
+
+2. Generic place for private ``generated_co_wrapper`` declarations is
+   ``block/coroutines.h``, for public declarations:
+   ``include/block/block.h``
+
+3. The core API of generated coroutine wrappers is placed in
+   (not generated) ``block/block-gen.h``
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 04773ce076..cb0abe1e69 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -31,3 +31,4 @@ Contents:
    reset
    s390-dasd-ipl
    clocks
+   block-coroutine-wrapper
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
index 81d591dd4c..0f0ddc51b4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -10,6 +10,16 @@
 #include "block/blockjob.h"
 #include "qemu/hbitmap.h"
 
+/*
+ * generated_co_wrapper
+ *
+ * Function specifier, which does nothing but mark functions to be
+ * generated by scripts/block-coroutine-wrapper.py
+ *
+ * Read more in docs/devel/block-coroutine-wrapper.rst
+ */
+#define generated_co_wrapper
+
 /* block.c */
 typedef struct BlockDriver BlockDriver;
 typedef struct BdrvChild BdrvChild;
diff --git a/block/meson.build b/block/meson.build
index a3e56b7cd1..88ad73583a 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -107,6 +107,14 @@ module_block_h = custom_target('module_block.h',
                                command: [module_block_py, '@OUTPUT0@', modsrc])
 block_ss.add(module_block_h)
 
+wrapper_py = find_program('../scripts/block-coroutine-wrapper.py')
+block_gen_c = custom_target('block-gen.c',
+                            output: 'block-gen.c',
+                            input: files('../include/block/block.h',
+                                         'coroutines.h'),
+                            command: [wrapper_py, '@OUTPUT@', '@INPUT@'])
+block_ss.add(block_gen_c)
+
 block_ss.add(files('stream.c'))
 
 softmmu_ss.add(files('qapi-sysemu.c'))
diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
new file mode 100644
index 0000000000..505e070660
--- /dev/null
+++ b/scripts/block-coroutine-wrapper.py
@@ -0,0 +1,188 @@
+#! /usr/bin/env python3
+"""Generate coroutine wrappers for block subsystem.
+
+The program parses one or several concatenated c files from stdin,
+searches for functions with the 'generated_co_wrapper' specifier
+and generates corresponding wrappers on stdout.
+
+Usage: block-coroutine-wrapper.py generated-file.c FILE.[ch]...
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
+            'MaxEmptyLinesToKeep': 2,
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
+ * File is generated by scripts/block-coroutine-wrapper.py
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
+def gen_wrappers(input_code: str) -> str:
+    res = ''
+    for func in func_decl_iter(input_code):
+        res += '\n\n\n'
+        res += gen_wrapper(func)
+
+    return prettify(res)  # prettify to wrap long lines
+
+
+if __name__ == '__main__':
+    if len(sys.argv) < 3:
+        exit(f'Usage: {sys.argv[0]} OUT_FILE.c IN_FILE.[ch]...')
+
+    with open(sys.argv[1], 'w') as f_out:
+        f_out.write(gen_header())
+        for fname in sys.argv[2:]:
+            with open(fname) as f_in:
+                f_out.write(gen_wrappers(f_in.read()))
+                f_out.write('\n')
-- 
2.21.3


