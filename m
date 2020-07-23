Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AC4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFC320825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="q4ZFa6EV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFC320825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyS8f-00015a-JK
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5z-0004YD-Bx
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:35 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5w-0002Ew-Up
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyTIlUJqN8sMOd7SYN81BUhGI8K/QfgHoAFreQM4m9+wUA6ptndNXeZ1WzR0rF1bynDgUBGLyfTSR2002+u4Gn1APp7O7jB5vW+DlXTSKJhVIh3KbxtQOPe2pjCHJvZdOZuoWdrvlmTkjTJ+a9ogrShAEQjNOuzWzdZra4ym1BnL9Cl3mRZgJzQ3Ntp+nZEiV5Ym2nitVFNVSahjj+Eqh/gEjEsyb8vWoEi/QMAIcxOD1eLyJoaIdDNej/PzTwR9gXaGhpt9GGZyqY7yrwTIpuy7DmICWscyhJpgswKsuXqXtQwd1qZEbYtmtX/5wrcfqR9iz6XFD98qadju2kt21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpNZNsG6MAtW9gsCEmHuXJ48bi7crbRDQgLPRi4F5tU=;
 b=nZoBG7OibeI4DIMeWgyAGPJDDQHJUbw7r45JfatF7owpvOQbpP0s0M0mp1wHVu7kGzfjvND28c3SfBASV0i2jYDmVvHIjGfY51o/lkhEdpiSKXYVVqDZLyiwJwjf6DmfwLZXxY5liY/4Qpzwdf7qGvGITiwKAHJSPAXOxUIkxhDtyUgJgLpTB46pA5EGPayXIhCvs6VoMYU8szMnR8bXKUFUSZeQPMMK2x5mM8P1CH+RJNs0bNh4FDyUnYeO3PG6B/Bgv9x/NIcyB5wYWNXVcEr7E+17hrv1kHrXkiGPv9LTN9/bo+bb+Hjh3DTF9OskqQaFnG7UCdh1KjjVux19eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpNZNsG6MAtW9gsCEmHuXJ48bi7crbRDQgLPRi4F5tU=;
 b=q4ZFa6EVkiRbVMhFP3bVhzLvdGkcOeBxm3v4edyAf3ccToLnSxfb0sOAUxdR4NQ9jgVUrR7ODXPcA+giw3EmM69hxoOd1uemCk3dI7rzFZwi5DYNy8xnhWmpCtJF6PKcrqKnZMW/V+3gk90LXt/ntB+3azUj2Rrofe64jRiXQs4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:19 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:19 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/12] scripts/oss-fuzz: Add general-fuzzer build script
Date: Wed, 22 Jul 2020 23:39:29 -0400
Message-Id: <20200723033933.21883-9-alxndr@bu.edu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723033933.21883-1-alxndr@bu.edu>
References: <20200723033933.21883-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 03:40:18 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a85f9c0-0cd8-4357-8619-08d82eba1ed1
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3982612B6D2DDE2AFF7D7489BA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoD12aCOA8pZZkC/jrbHzn7mjPs0KGh2rQQZ8gghQnx8hI5TH4uaQIAEvthknwuk1cHDmNwlxWPCkMeXv5BKNkDqZsUc2rpyDFfNfNMWNFYNbNHs4YEd0qaQ4n2lUkn8PwBcnm+L1+CEv5xLpk9rL+oodGyL9akt5tAskVGWWdas+WbbNYC5xxnmhD0fg/mD5eU8VvCWYLkeKNP2FrzXSlL/A6MOE9EWaAoEvk+l5Jn01wBCzKQktb4DtFHjVdKKfbqUlJ85stmnPem1QwJJYArq+n2DtqP0CxqTbq9JrjL8zowfp8xjOHIDUE9Sx2pu6pejE9QiVSventp5lXi2aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rSnauaLlq9rIcA2xZu5DDRXFPy7bjffDdP5jK7ord+CTcrC2Qj3gL9Xn6r71PXMe+uvg1IhZ4hxOo7/Fc+epHUbGXNPUNGn5FbLpWZIh8yWziAo+FZwxETaPzzI8W1Smp2bpwVvwTJsYMUx/9YBMZ1ApWgdVPBJ0KXbX3EDY2U0dmYquD/zpiM2TC7nRq0CWg2e1jmvN9duyTY280WdDmf39jCkjc5OHwVovQ2HPEEdDm/QgHbFQnc2QNVLOBqLJjtui81R/rgCcqh4fiord4kD4PRJaOxryi/kyuwO5xT86XXV6jWdRgURi+3J22hMflO9MUlilWC3U3fWufCTUVe5NsIzZlZp090CYtigfjp+guklceIOd04mwid7Lus4f1QXitJiOK25+Blk9XY6a4p5Y3zUYfwV1z83wFkWqvP3jCOBL0UMa0d1UjZ6DQsJ24OjrdN3KMUxhRGDONDlsimXOqxz2ReZlA8ZdHE57X4U=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a85f9c0-0cd8-4357-8619-08d82eba1ed1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:19.2205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ys1jw2/UQLH0HfboQDHqT0gHt3/aYJ9JLibPlKGrWlYVNBI+56fTQz8IcMuVFwrE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3982
Received-SPF: pass client-ip=40.107.244.114; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:40:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: thuth@redhat.com, Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, dstepanov.src@gmail.com,
 stefanha@redhat.com, andrew@coatesdev.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This parses a yaml file containing general-fuzzer configs and builds a
separate oss-fuzz wrapper binary for each one, changing some
preprocessor macros for each configuration. To avoid dealing with
escaping and stringifying, convert each string into a byte-array
representation

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/build_general_fuzzers.py | 62 +++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100755 scripts/oss-fuzz/build_general_fuzzers.py

diff --git a/scripts/oss-fuzz/build_general_fuzzers.py b/scripts/oss-fuzz/build_general_fuzzers.py
new file mode 100755
index 0000000000..79f4664117
--- /dev/null
+++ b/scripts/oss-fuzz/build_general_fuzzers.py
@@ -0,0 +1,62 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+
+"""
+This script creates wrapper binaries that invoke the general-device-fuzzer with
+configurations specified in a yaml config file.
+"""
+import sys
+import os
+import yaml
+import tempfile
+
+CC = ""
+TEMPLATE = ""
+
+
+def usage():
+    print("Usage: CC=COMPILER {} CONFIG_PATH \
+OUTPUT_PATH_PREFIX".format(sys.argv[0]))
+    sys.exit(0)
+
+
+def str_to_c_byte_array(s):
+    """
+    Convert strings to byte-arrays so we don't worry about formatting
+    strings to play nicely with cc -DQEMU_FUZZARGS etc
+    """
+    return ','.join('0x{:02x}'.format(ord(x)) for x in s)
+
+
+def compile_wrapper(cfg, path):
+    os.system('$CC -DQEMU_FUZZ_ARGS="{}" -DQEMU_FUZZ_OBJECTS="{}" \
+                {} -o {}'.format(
+                    str_to_c_byte_array(cfg["args"].replace("\n", " ")),
+                    str_to_c_byte_array(cfg["objects"].replace("\n", " ")),
+                    TEMPLATE, path))
+
+
+def main():
+    global CC
+    global TEMPLATE
+
+    if len(sys.argv) != 3:
+        usage()
+
+    cfg_path = sys.argv[1]
+    out_path = sys.argv[2]
+
+    CC = os.getenv("CC")
+    TEMPLATE = os.path.join(os.path.dirname(__file__), "target.c")
+
+    with open(cfg_path, "r") as f:
+        configs = yaml.load(f)["configs"]
+    for cfg in configs:
+        assert "name" in cfg
+        assert "args" in cfg
+        assert "objects" in cfg
+        compile_wrapper(cfg, out_path + cfg["name"])
+
+
+if __name__ == '__main__':
+    main()
-- 
2.27.0


