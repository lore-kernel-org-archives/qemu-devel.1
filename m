Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003BEC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF3020829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gwIlLeCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF3020829
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIE8Z-0005ia-Cm
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4Q-0000Gs-Bi; Tue, 15 Sep 2020 12:44:42 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com
 ([40.107.0.131]:27107 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4N-0007he-Mt; Tue, 15 Sep 2020 12:44:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmaW1FBmNCz7Uh/YtghHX1gWW4VojhEhyVxIQYS2FkVU7KjwUsCMdY5oR6vcXeMTu29NYaqe9MiL7sapejuftDBweJQgoqZ3KDQRUu/t53QDuRb4wgQ1KOlyiqh6kXBKz/WaICnpiP1M1Z1eDuodC4UzMWsW6rmpcB3py2w0IRLsx7YqJTjgvStyDZ6axQkjY+qTjYtEQE82ClU5wvl8ZQJZyKzxvtTMKXXyjzz3R72h9/187UzVY6OhadNkZ1GUnXhw/Jx/tuF1H/ygIjWA9WBZ0uplCP9tvFovA/z4aqV+fjNxet3uPab4um1nQpB74CuIeQxHif6P7ErLJgZw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unNBHlAe+kvtIF5BIgGOFmx9QPiUaLHMbnEElQNDjHY=;
 b=Yf007BcSVhmpD4jhwaH8i+oqYxuBxlkzBW02oM35jFHo2EtIPzT34X+FC6X5c6urkhJE+SGQR8diqFhM8ILhJ4KEMJETV+PpFimFdqsViPBI4zhZ/xBIoDJcKo6cL8CamV/bxwHxsrdlPLEmu7No+QHWrWov14ljW4xwVVILjuvF68L+q1ZOjXkGtdNPWOdMpIkJ4Bu9dOa98lrOezoMjpCVgZjJGGs3VrbG3qjoNB6ghta5w++qtu4Li7scii143MELUXypsyRCI7HW2TGSHCiwif8ylxTmsaO79IO5Pz7vhtYX/6OUPAn932Zz6BjnEh5bo9Z80Gki2tqHupl44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unNBHlAe+kvtIF5BIgGOFmx9QPiUaLHMbnEElQNDjHY=;
 b=gwIlLeCt1ts2QOj9nsipzZ0Gu8GwptoD4inBvn8aCf1VzypMvs+6r5eWVYg6aEMZVtdc4qgiO0ki4/wTcO+Uplkl7m0l7oYKzKtVr84lZSk8wpJGlA7cfejJhTD1JtFuUFfBpNBFbW35+aDhKiyYNwnmzMflcNFC8VZSDIwNclI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 16:44:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 16:44:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com
Subject: [PATCH v8 4/7] scripts: add block-coroutine-wrapper.py
Date: Tue, 15 Sep 2020 19:44:08 +0300
Message-Id: <20200915164411.20590-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200915164411.20590-1-vsementsov@virtuozzo.com>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM0PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:208:ac::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Tue, 15 Sep 2020 16:44:26 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fddb59d2-27b4-44ef-476f-08d859969bf0
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1652416116D80CCA121E0F73C1200@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoLyegdtXVcskPnBIWN6E3siAXmi3H0nO+TaLirKEC6Ct+FRIqbtmZa+2xvxQtpqkvdAPL3oi/F/ebasq2rYtzk72uDpi3WR8Wd7u4r+cVYK7ZzkyUVnzJzFfrhObo6LsHKFVep/zWjEdNYpS2xyDs2sqaYwsfJX2NOsE9OFkodro2Ju+RFYUlkRqd2JX3pz5EULWlSVOyTvnKZkJ63isMWyNHo73LC7JEEyQifUzjyhHBJl8/fbwUdBk7eXm+2BuwnjRkaC9NXcqDXRddwCD1QVH0DB9/M8Gy8p5/1HZ4T+XSUFxbuhnIjYq2ocrVT//48j9DdCbyQpxR5WO/6FFj6iHUCEqWa4ypeyBJSEltuShNT+PxoNkVzlJ25H4ADvZYHqqYI9eVbKQAkc6VyRHfD8CCYj7UVg33My1Oh4zGNX6Cp/v41oEEAITP7VUaLX2sZq6IhVDrxckXLF2OtfOtBmDYqkeaiZBnxaSUrdexFxQpwGgV/oL9NoY1xgP/Wq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39840400004)(6916009)(6512007)(2906002)(83380400001)(36756003)(478600001)(30864003)(1076003)(6486002)(86362001)(2616005)(956004)(8676002)(316002)(186003)(16526019)(5660300002)(66946007)(6666004)(52116002)(66476007)(8936002)(26005)(66556008)(6506007)(4326008)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8KgAi5M1HGAptQbESIohHDU0ryO2BY9qA5i0cpEX3ycq1ir51Bx/7FUuUNuJgsAEPl27h90qgBp/X8PuijRBSwl0uGlcfv9XNTb9zoM1qBoC1V/C+d5nIbNsXxJwbmNuyPUwECKKdBy1MCQtIA99y6asGV0bDpTIfw3bHKoP7fNQ5hudO9OBUrm3+Jwro8dd9pTHFIUeamANWQgWiXlXM7HaK4V/oOCpJA4uWNGyA1oK5bQfrtrLqOLbXDc9hjRB8JU28A/skimIMZmFz74EfiqDHm3dOxqkP4+InXCCcNakTJR7E24eC49Nb+4PMWeiansSBiZE0Kogh/O3NxumRZAkvRpoOcP/A/9JHRA74Al1BXnx8P42H2GYV0u17oKnVVPyD7KuAtL0G563yDyQ1LQr2+XDtT+l/RJaZCp/hAEp2HOKMs0v1Tc+EOLMZJEDIRJkkQLdkQdX/IaR9SUp0ueAKlUwqd8BqVvKfXspOiukjciuT4VgY3E4MvuHgG1zL2w9rNWOubTJ1A8H1zPmx7lDIh+z7wFqlPR1qsEAC9VH9DVXsgI7XiJaGJJ3mATWycQbcWfKiW+vyWoooRHnHX49crKiBQ0KcC7PoRx+m2OGG3goHUp2aRWax+W9fMuu2CnxUHkA5WJ54hG6tMN0kQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddb59d2-27b4-44ef-476f-08d859969bf0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 16:44:27.2034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZHzmNQFWn+maKR8gH8T8eL+NwS/+lrxaMmL4XOPNg4DpHXzVFUeUEg5yVLEZN1oREFNXDNS567V1v3hkq7ZOAZHxdMvONAamXC8T67ueuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.0.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 12:44:35
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

This patch adds scripts/block-coroutine-wrapper.py together with some
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
 docs/devel/block-coroutine-wrapper.rst |  54 +++++++
 block/block-gen.h                      |  49 +++++++
 include/block/block.h                  |  10 ++
 block/meson.build                      |   8 ++
 scripts/block-coroutine-wrapper.py     | 187 +++++++++++++++++++++++++
 5 files changed, 308 insertions(+)
 create mode 100644 docs/devel/block-coroutine-wrapper.rst
 create mode 100644 block/block-gen.h
 create mode 100755 scripts/block-coroutine-wrapper.py

diff --git a/docs/devel/block-coroutine-wrapper.rst b/docs/devel/block-coroutine-wrapper.rst
new file mode 100644
index 0000000000..f7050bbc8f
--- /dev/null
+++ b/docs/devel/block-coroutine-wrapper.rst
@@ -0,0 +1,54 @@
+=======================
+block-coroutine-wrapper
+=======================
+
+A lot of functions in QEMJ block layer (see ``block/*``) can by called
+only in coroutine context. Such functions are normally marked by
+coroutine_fn specifier. Still, sometimes we need to call them from
+non-coroutine context, for this we need to start a coroutine, run the
+needed function from it and wait for coroutine finish in
+BDRV_POLL_WHILE() loop. To run a coroutine we need a function with one
+void* argument. So for each coroutine_fn function, which needs
+non-coroutine interface, we should define a structure to pack the
+parameters, define a separate function to unpack the parameters and
+call the original function and finally define a new interface function
+with same list of arguments as original one, which will pack the
+parameters into a struct, create a coroutine, run it and wait in
+BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand, so
+we have a script to generate them.
+
+Usage
+=====
+
+Assume we have defined ``coroutine_fn`` function
+``bdrv_co_foo(<some args>)`` and need a non-coroutine interface for it,
+called ``bdrv_foo(<same args>)``. In this case the script can help. To
+trigger the generation:
+
+1. You need ``bdrv_foo`` declaration somewhere (for example in
+   ``block/coroutines.h`` with ``generated_co_wrapper`` mark,
+   like this:
+
+.. code-block:: c
+
+    int generated_co_wrapper bdrv_foor(<some args>);
+
+2. You need to feed this declaration to block-coroutine-wrapper script.
+   For this, add .h (or .c) file with the declaration to
+   ``input: files(...)`` list of ``block_gen_c`` target declaration in
+   ``block/meson.build``
+
+You are done. On build, coroutine wrappers will be generated in
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
index 8aef849a75..a0655b84d6 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -10,6 +10,16 @@
 #include "block/blockjob.h"
 #include "qemu/hbitmap.h"
 
+/*
+ * generated_co_wrapper
+ *
+ * Function specifier, which does nothing but marking functions to be
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
new file mode 100755
index 0000000000..d859c07a5f
--- /dev/null
+++ b/scripts/block-coroutine-wrapper.py
@@ -0,0 +1,187 @@
+#!/usr/bin/env python3
+"""Generate coroutine wrappers for block subsystem.
+
+The program parses one or several concatenated c files from stdin,
+searches for functions with 'generated_co_wrapper' specifier
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
+    if len(sys.argv) < 3:
+        exit(f'Usage: {sys.argv[0]} OUT_FILE.c IN_FILE.[ch]...')
+
+    with open(sys.argv[1], 'w') as f_out:
+        for fname in sys.argv[2:]:
+            with open(fname) as f_in:
+                f_out.write(gen_wrappers_file(f_in.read()))
+                f_out.write('\n')
-- 
2.21.3


