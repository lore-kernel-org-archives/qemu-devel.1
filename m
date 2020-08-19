Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C6C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7934320738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="J94n7b7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7934320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HO5-0003Zx-NO
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKB-0003xc-1X
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:51 -0400
Received: from mail-dm6nam08on2119.outbound.protection.outlook.com
 ([40.107.102.119]:43040 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HK9-0001Ya-AD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS/k08ZyqNjppf9hBYHzRUdvMjvNeWEcL25vKQ1RwdApUidURJ+ds0OHLuEXUXv6B0YtLFlpL68Ypy4/ctYZJK292ZklTJdpcsFxgRJr1OfNVruwfRlv9G3WkMAJ271ZB6VoMovzT85Rh++UkZjW6QmAGCrjs+YyYA8OuOVp/cQKGUy2QnzVNnGWwJgAZF7eF2AS6e57fYlsEYYRLYMlUmzOUF6Rew4NLYFjFmVHqpKO2Zrit2bqIqeqUvpIXlKGHZiMnLtIMDbFKav3uMVhf9FWImZ3ovYxB1ArJojZPisHVgyvB17g7ZBZ0D3pWYftM5buTetyof6fBcpceqUgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktyxUGnYf+LmUVRdpxI0BGBhgpxPWQEYle6Jaz1ifws=;
 b=jiSK+ygIRl7raRxAtzPu6XE8oh/Tm1uYpUFW/nd5SN31m1PL1h69LvvGhVQOA6CuAuuDEE0Q6Q5vLICR5X4X4RR9vcI1624WMiczpITWm9OOZB9Voy1LdjC3v6ghPqZEnYLu9FQ8Fl04SOhHOZhgSCHCyuI3FGXM0VzZ4eg/FlKFzeaEzFpV/5OC7BfYTesCLeb+82LZconMuQ7fnLc6HeBOhPoBD8J/tA0Qqfipew4NLQIJH+q1vOHTnMGBU5gYNG+NiMVPCHEFLYrivKOT4vayMTanSMKZvau768Rht4bOy6iytqs7b/KsdSQXlbaLpi7aKu5TllxaLt75WjlHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktyxUGnYf+LmUVRdpxI0BGBhgpxPWQEYle6Jaz1ifws=;
 b=J94n7b7GHEDfO95LNXrGtcaXIhp6nlch9QUKxnBzi/9CGlId7O7sHdk5TIyacgI2NG7DKiNurhtyIjFW+0Bq7agCsACB20M2o9xxmXMctsNg3LKGmGBViXOAnHVeV4c1v0cJHpg6z1kSMOy5NY1gkXvMrk1QEneTYnlCe1UKXjM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3486.namprd03.prod.outlook.com (2603:10b6:805:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 06:11:44 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:44 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/15] scripts/oss-fuzz: Add wrapper program for generic
 fuzzer
Date: Wed, 19 Aug 2020 02:11:05 -0400
Message-Id: <20200819061110.1320568-11-alxndr@bu.edu>
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
 Transport; Wed, 19 Aug 2020 06:11:43 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844b34a6-8a2a-4217-094a-08d84406bf40
X-MS-TrafficTypeDiagnostic: SN6PR03MB3486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3486A98FB1500D03C8ABA3CDBA5D0@SN6PR03MB3486.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27kycPXM8crZb46y0My1PPbmaJiYcc3XIMU9+m40d1aqrI0NPD80XHZPz+9tDckQtjSCO2ydiEWL3VWz0TXCV8hiNvwGwoeyVZcDkCDU3N7sifB7M7p0Lk1hujxGdIDGLdUoZZftn9DSsmYbtXR+0SGpZtU57NAgBQads6mGnoqc2YZolwd3oQX/4xz9xyvhTvT8jycAXWmLCxp7dUY/DpZR+hx7JjWqvDLG9Xx2Ufnac/FOpYUSQHEEzWCwUz2aKEwxgKITyAKpSgg/Xj6MaZ8ecn92cJ9QFJ2A3EuJ2ignEES7EI4kTNV1h3tpkItOG46RU9r4cjghPzfF1fmtUxGy5DESFTt2VqR9lNhftHJ0YsnmPqrit194OXYufh2J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(66946007)(1076003)(6666004)(66476007)(8676002)(66556008)(956004)(86362001)(83380400001)(786003)(54906003)(316002)(2616005)(26005)(75432002)(4326008)(6916009)(6512007)(6486002)(8936002)(36756003)(16526019)(186003)(2906002)(478600001)(52116002)(6506007)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 36LV42fjSiIjwcGPQTUoXUnutpeNHmJAxjBa0t0ynsiF5OrPGIlQvbk0CXU+8oRgRN4QrsWFSAJTzNPyDKNAGxQVfi30+U8DQFSE4TqoHE+T2hD4AjURdDPAm0I4evwRzVwR/ZZoEvzoRN5fhXgVtm0Ff16zNwmrLW1VvP600XCOWMQiYKqAsLEFirloJ1I8gztARvTbvhORwUJh1vxsD6EB8Evpjf+9v49HV+hdKUL1IxtaWOu8cIsXGLIEaRwF9fhnqTq1419KWCZAeT5Y58TXCANRlVwpL/ovqmiqHLsPogJS2rhrLMVfhlnoJ1eeLMXOFYItZJcVPXBnvfBsVHrlRuE356B2Xhurvp6qU5OmLDO7/LgJW1vLh+QrBtrrAbUr1OjeSBUVbAAOuJn1j2YZh5y7kU2mvgG+ih21qK4kUdHyVi6m5jTIaNm6m+eV7GuUnfoX6G8VaJ8lZ489pwuM8exyu1i0JKYpMSvPs7Gv8H2j58A2C0Wpr2GjIJ7hjfRHg2c5LyjjQQUxi8ii79vhmzfckjteEfkBAdukVkH4ceogQFoB3cOAxdKTmg5vNKCvmIfxeyTnPfT5v3e+omz4L6rwEkwxoUIBkz/DMzRpa0Tm6mCf9r2F0UQgwMbILs2NlElvpD9npy1eqb6umg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 844b34a6-8a2a-4217-094a-08d84406bf40
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:44.6110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dmba6IlgrQoERGfUXqsDn2+qRF7jEfZh40XzpvAGWxCBAkC1Nci72I8qz7hG64fc
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

On oss-fuzz we need some sort of wrapper to specify command-line
arguments or environment variables. When we had a similar problem with
other targets that I fixed with
05509c8e6d ("fuzz: select fuzz target using executable name")
by selecting the fuzz target based on the executable's name. In the
future should probably commit to one approach (wrapper binary or
argv0-based target selection).

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/target.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 scripts/oss-fuzz/target.c

diff --git a/scripts/oss-fuzz/target.c b/scripts/oss-fuzz/target.c
new file mode 100644
index 0000000000..4a7257412a
--- /dev/null
+++ b/scripts/oss-fuzz/target.c
@@ -0,0 +1,40 @@
+/*
+ * Copyright Red Hat Inc., 2020
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <libgen.h>
+#include <string.h>
+#include <unistd.h>
+
+
+/* Required for oss-fuzz to consider the binary a target. */
+static const char *magic __attribute__((used)) = "LLVMFuzzerTestOneInput";
+static const char args[] = {QEMU_FUZZ_ARGS, 0x00};
+static const char objects[] = {QEMU_FUZZ_OBJECTS, 0x00};
+
+int main(int argc, char *argv[])
+{
+    char path[PATH_MAX] = {0};
+    char *dir = dirname(argv[0]);
+    strncpy(path, dir, PATH_MAX);
+    strcat(path, "/deps/qemu-fuzz-i386-target-general-fuzz");
+
+    setenv("QEMU_FUZZ_ARGS", args, 0);
+    setenv("QEMU_FUZZ_OBJECTS", objects, 0);
+
+    argv[0] = path;
+    int ret = execvp(path, argv);
+    if (ret) {
+        perror("execv");
+    }
+    return ret;
+}
-- 
2.27.0


