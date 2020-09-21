Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF41C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB3E2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Q322wDJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB3E2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBfM-0007VS-HX
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWe-0003Lv-Ld
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:56 -0400
Received: from mail-dm6nam12on2117.outbound.protection.outlook.com
 ([40.107.243.117]:28256 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWc-0000b7-U8
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giscUlcdGilV4/eXV2ke0SzANvsSd5JkFvlaF9++i1hNOcOBOaruOzBasR83L6PSg43fZX5nUnddtvRcQnC62KjN8+E3LBoWUUoKeyU21z3G4fXwTT61/ooDA1moIxbgdKgIQ0o3okfIdbX1EaOQBE28/n/ur6YtY22qvdMOMGrGfYqKlugSCZn1wwgexw9PnZnVtf7U3DzFluZd4q+CspRSrn8kiOmYP+iNDZZ7MTcP3ZGVU9zujrsngFSzI0oal8vbKmJ9oR79fybkFse2jNHssaYZtDDcesEUL0Hc3lYPcPg2Qp3m1NCVR9ALoSZbZhQ/O5kbnBKlv5vnaM9IYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92Pi8V0q/CvMNhMCwNiYCwCGdchrZHzjQakpHWWY51Y=;
 b=UXbvOPKUXY20fiFNHr+PdTwNf+SQKXLbb21uRjiztjEW0n1Ygc7d2auBwwxGybLdf++Yc3RryGqJnDKOFF0JdCbWsU+P+sfN+7+CObvPwXO+dc2pPKk+mT8qCHM+AFwd0vdLuH4rJIxiQX11z8OV1Y8JXLe/kcZUuk0CtR93mcTH8pci1xvVoo9wk4GXFNLsDNNHtiue5c2fdGRpdKicaK0EF4etcyH9+TGdMZ33lpQJHZa7LmvGF2fO7cX5TuT0Tv73wwOm/rPgKB4rkOUdVpMeDCd7wAaR2NdzcgEh5qFzMYi8DMUmZEFnisectN00JaXHdXUttWyOeS8Y7dmeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92Pi8V0q/CvMNhMCwNiYCwCGdchrZHzjQakpHWWY51Y=;
 b=Q322wDJ0P2DyrDyFW1hObTzvJM/XWpvJ9EcZvuV025HVvR7l2T+0XjTS5+J6RuNMbEkb01ghPssEntLWw9c9y3XtPslFcqK3JQM6+zBqJXYyaxcwDA4mhk1hEQA5dfO34bmzenVp0SuLfLsBPuk3DbpuFX6ZhAEuLzu78DiR+5o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:40 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:40 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/16] scripts/oss-fuzz: Add general-fuzzer build script
Date: Sun, 20 Sep 2020 22:25:01 -0400
Message-Id: <20200921022506.873303-12-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921022506.873303-1-alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0034.namprd15.prod.outlook.com (2603:10b6:207:17::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Mon, 21 Sep 2020 02:25:39 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb742b7a-fa79-4ff6-f694-08d85dd5a1e9
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB22377949AF46DCF1FA3E4834BA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sndoy3h70Qh0ocEFJ/ft11zMAFUBjqXZidM0azWKaWn4a0nowQalkkPDGuv1cR8i2c/P1ru2of8c7f/iCudJzZwUybcGKp7CAHgrfH2LH3WPnOtGdnNiRI1tXY35C3JA9We5zk1POwng6vCjmuaWJJ/tVE2/LBkeeEzd+mgbByeNC1Qj8XVvUbATTtcVZVo5mNKteT+ILyU2k0C6Gya1NIlJN9dhlNGaEplGD86YZlX43R/xB81Tq0i5D+XlSh8flWm+26rcPO3g4JTk5N53eOMVyzUnpnldP3H8KMz4D5kOEuTsqElx4TEK6wS5ZWOZ+xsFpItf7O9lSHGcKvsVl124U7J6a2AkRV7yxyxzDl7vAAiHpdWBT38/zeXTC3ja
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5YsHwUdBFNC6PNHxdlTMfAMSwQnDxLqFcaQcZJQjVjPGMSA3tZWPgtuRov8FnwqlqxBrfeMvnIcZxlZo41tP0r7Ejw5d4x/NcJjxrYdwrcaDYdzFSNrDN3681J9slNCfHJkdV225EUTbUUTwPQqcra+h9m3FBPAFFWr4Gkr1Yp2px9Jad+Tih1tvJ9CxW25kQMIxXyDDRwevd1AXTaIwb+ou1lqrtt3ioj1oqU+Lmj9u2Je3+oVBYj1Fl8Y8awxYequGMwAsBjANNmMihE/EaH9XxvhFHPpbo7Q+yNmej+l/fJVarQ09iUvS3VNFSncGiI5RNocWjqewoLi0/HlVlh5/m6Lh4KDLBSdc8O/c4yExTW0HhLpRtnZrMI0RSVJCTTGtiw1ev39KPnldLiapqz6ITIuWKCtxckrgKcofK0CHoIVbKqJzurakIz482vtWN242INSeUuLLaXqcCxVWC3XoIgE6Kzlmjimm+DLua2pEamUG9sgvhhlq+P+yqQWluDl5ly1CCbFWy7xhXSLIp20zcqUQnLL/4i8t+hoTC2JPMOz2OHprytp8BBfkTl3rKXUmWCkf8ZPQ8RjJx62x4y0ZTcJVfn7Cv8HvShTFtINMmpro34+6aNv+7EP0pD7Wj6P4+i2aoEh4DB6tbwlEsA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb742b7a-fa79-4ff6-f694-08d85dd5a1e9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:40.1125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8/SuRFsmU4C/N6e2U8iYSE5V0Tf/lnrzL1lai5bKGpqwVH36sM3cvh4SO00aun/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2237
Received-SPF: pass client-ip=40.107.243.117; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:25:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
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
 scripts/oss-fuzz/build_general_fuzzers.py | 69 +++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 scripts/oss-fuzz/build_general_fuzzers.py

diff --git a/scripts/oss-fuzz/build_general_fuzzers.py b/scripts/oss-fuzz/build_general_fuzzers.py
new file mode 100755
index 0000000000..918f1143a5
--- /dev/null
+++ b/scripts/oss-fuzz/build_general_fuzzers.py
@@ -0,0 +1,69 @@
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
+TEMPLATE_FILENAME = "target_template.c"
+TEMPLATE_PATH = ""
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
+    os.system('$CC -DQEMU_FUZZ_ARGS="{fuzz_args}" \
+               -DQEMU_FUZZ_OBJECTS="{fuzz_objs}" \
+               {wrapper_template} -o {output_bin}'.format(
+                   fuzz_args=str_to_c_byte_array(cfg["args"].replace("\n", " ")),
+                   fuzz_objs=str_to_c_byte_array(cfg["objects"].replace("\n", " ")),
+                   wrapper_template=TEMPLATE_PATH,
+                   output_bin=path))
+
+
+def main():
+    global CC
+    global TEMPLATE_PATH
+    global OUTPUT_BIN_NAME
+
+    if len(sys.argv) != 3:
+        usage()
+
+    cfg_path = sys.argv[1]
+    out_path = sys.argv[2]
+
+    CC = os.getenv("CC", default="cc")
+    TEMPLATE_PATH = os.path.join(os.path.dirname(__file__), TEMPLATE_FILENAME)
+    if not os.path.exists(TEMPLATE_PATH):
+        print("Error {} doesn't exist".format(TEMPLATE_PATH))
+        sys.exit(1)
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
2.28.0


