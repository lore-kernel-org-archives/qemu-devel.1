Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A65AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5175620738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="2CmpsNLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5175620738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HPq-0006F2-Is
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKD-00042s-1d
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:53 -0400
Received: from mail-dm6nam08on2119.outbound.protection.outlook.com
 ([40.107.102.119]:43040 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKB-0001Ya-9S
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBLScZlvdAqhg6rsJJtm6xQuYTfJ0nQPzhbK7sE7Xr2TJOrQdaFZKanxxvE3AzgTJ0IPAzH67uvGbJIWvXtPEemBJNgF4aZYYokXtn346TulWCsQw7e6RwQo0Tvp2nDSlZ+J0G3ZAv7QmPGsrzt3jPYIaRZ2I/AhBaD4V85/xtwybmLsUlvc3mJcg9BVBF1+Zej2h2gCN4VZe00AiUZTSwtUysKBIpv7d+AZ6ADO5D7isI+sqplyUwi09CJ+AKCFDjpDxhDWuLqP3f0OjEfL4fhM4Xi5QPz+MBP77dUsAYKUP0xKpLWYKmKkO5vKgLqXztzlHe44WW/o5dNkOFKs+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpNZNsG6MAtW9gsCEmHuXJ48bi7crbRDQgLPRi4F5tU=;
 b=KntpVxqnhD0sR0tLMpUjKNfkL9qXTYV0OugvyQvsnvSYQktCLtRZ06GBK30lhDag0Mm7fB0vKKWMhxairIfjZl/hRACWo5IZKOawy7oRyim/l8PwmmdauvenFqGABCZEDQTMZLKackcZBi8iFXX3d3Xez7WKf8vASeGbGRc1x8j4nX69lRZiSckDhDK4Mjja8Jo2uxPr0QVCHVfC6Z75Y9T4GCtQex3UEVGTXEUb7C59BWlua0+fnoOc50qc8cyKrTaNHcX2yF/gdIDHX6WuBF6n+etjoeSlEgXWgfMQ6ZC6+0/crVzNJKsj3Np0lNDqIRIlYOcTrHIayoDzvLtFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpNZNsG6MAtW9gsCEmHuXJ48bi7crbRDQgLPRi4F5tU=;
 b=2CmpsNLc9TW9PZ5pbdkh4GCD1EOCG0zNvS/dlDLYVphXw3IRESgwGDVTYCU9+wPOzY7BqhfacCkH+sxrmCBe9sGmDJmz09plAJIug9zx7cI+l1yl2dLtz3Pk1HbUc2dztBmD0WPDcgIk8qqAZEYxp31iJBctuwSIFQI7jH0PQW0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3486.namprd03.prod.outlook.com (2603:10b6:805:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 06:11:46 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:46 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/15] scripts/oss-fuzz: Add general-fuzzer build script
Date: Wed, 19 Aug 2020 02:11:06 -0400
Message-Id: <20200819061110.1320568-12-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819061110.1320568-1-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0012.namprd15.prod.outlook.com (2603:10b6:207:17::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 06:11:45 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83621cc0-2bc8-4d98-0a01-08d84406c034
X-MS-TrafficTypeDiagnostic: SN6PR03MB3486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3486E436AB282B2406B2300CBA5D0@SN6PR03MB3486.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aci04U0TPCaLX08mOSAoLKNrV14PjDr8ePqEpMueuLdokkrcg6RRjAUQFdKB/pqBJuPI76Npgtp3GFqHQojXYBr14GeOQsnifFhHhuxyAbRx1vCvEzPLLQTOUUtgtL3J8BDLoDqSeBCRDJwQa9kI7u97U50ll0id6Lwfov5H3wsz68PSH5alC0hPSMDXhfusbTq+Dn22VRlXKOMtmRS+cytM/+uxjkriC0MEX3ilWzPPmlZGwn8wURrrBmXacyv9Lezp1EmiQu41ZbNEAaIuZWqizsJflVprZ8DMg5V730pgkbwmJtL0ktWqZ84cvWULMRzrUq8KW07+CV/5xXlQCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(66946007)(1076003)(6666004)(66476007)(8676002)(66556008)(956004)(86362001)(786003)(54906003)(316002)(2616005)(26005)(75432002)(4326008)(6916009)(6512007)(6486002)(8936002)(36756003)(16526019)(186003)(2906002)(478600001)(52116002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WPRDP4GhUOstmcv92wAlWaBtTZtZCK56PViEBY0rBXBJi0QU3QRucgpJbBxywJZd8VCZPJBiKGGQfQ82kqbOXfne6YfpgDmClrUhKCb0CBT5+p3kjuXvySluHW1A7D89sCPI0bv8Sd6U4MnNT6X8j3d3X6rma+WPkWLQ18W/20aNHljVUSO6uehBeV80++kxcFFX5k9JwTyYBhKzVAwTQw99Vvg0L/Bdcq08QEkEFQsqoHkCFZ+f2y2Bj2ZQ1wxKCMUfPU8rEFga8lcFkvo+Bih9QshTVQ88WWzfVecjjYhbIgU1N3/w+VwkkdzZBlrb7UTHJdelmT5DT2I6nRweCjZg2waMkGw47rC0+teIHIso9SdWAJyJ/VOVVLTsi6pm8XP8s74V3Oc8K2A1FlHGjsvUsogjr/BXFYCamp5w6p4WNPFAJN7jqYD83niPEv7kp/XxmqKxbashRiXoSFo+1SmQSMZGWfQnN2f974qQdZ1414wgy2XITfW/ZDd/fLkqIKQ7wqajTW14yJ0JHqrHxEA/7z6P3moYce4DeGOvbY6DggbgdMJBPY7WI/jqKjl/qOvY4xRt2J7t9wwoNyG5jcNcZU7KC9x8kGQYXSKdBqDksQ/PebVnDLJqJ6XMezXmrFNMlGwGqvWCm88EDqdCIA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 83621cc0-2bc8-4d98-0a01-08d84406c034
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:46.1751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rj6OxvHzaVYDf2wrwX3UGQ0iZ3kKzrTZpACHPoQSRe10cCHd3Y4eDusJlhMW4wkN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3486
Received-SPF: pass client-ip=40.107.102.119; envelope-from=alxndr@bu.edu;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 02:11:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
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


