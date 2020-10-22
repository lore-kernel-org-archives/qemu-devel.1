Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434E6C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCC724656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L64LAJlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCC724656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfy8-0003CH-4n
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVfll-0000sK-I0; Thu, 22 Oct 2020 14:57:01 -0400
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:5089 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflg-0007Y8-Qa; Thu, 22 Oct 2020 14:57:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYaYHx3ajRZWuHKSM4RLLLLhqdwFW8rSrj+LTR6c+M+VQlr0Hq1z5NyNsaDw5YHfm806DE6JmKkN/yeVGWjvV6l+Nbnbkwsr83NQy5eNdIItNujOoM3Jp+25z86pjbOR4644lv5a51rRREBVCzhqb78Yo+MX6RluO72iy9kDPrbFc8/UM1Ina8xBspscM1O8N8+lblTVTyvFF65dWMNYlkoaNSOh1kRFdmHCZImaj0zVgxWCJfmrjpKGMBgKGrSzgnuaf2ZSsaGbK11Cr1h5Ie7z7LhHL/2+frtIbNE7YiwFykFQsiW3y4H+68Ii8xLxJFap0ALLnEvbj3NPyOrjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0+U9mDK52F8ii/pjDHVBLK+ufhSywTTNkTfm/3rOPw=;
 b=j/63/6/URd5niGAM69/SJ7+7iuS1G2VXwiDTwgESdWwXqe19jnK6V6i8EWdcbfXFEbtsJWZCvqUhyDvieOkhCRBav4b5jb1BZ20rbYNSqOIm2i6R6/8+eC+TfTl4/+bcK2xrSzIKISaD3RFiK9k0FsMoiN/3hPc6IA6utwv5jS6Mp6QyHDQm+7D3kL9DfR6qg7XAwofWKWfvtNUdnbjwfDZuATiRO09Jc8dIYtaKm14O/95tIMP64BNbk5+SXf2OqNpasqBpeAv3HEnLb/vgCS8coWdDYKPD3WEHeikPyyVFsL3JW3W0aBHGAPGa1X2LSub10+HbJIo+VbVFCI7RwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0+U9mDK52F8ii/pjDHVBLK+ufhSywTTNkTfm/3rOPw=;
 b=L64LAJlIsg/Tf/dcoFpfEzAZ3l/8AHQAjyFgVagmD3ut2CgPQbi87e/m9iqT4L0ESHisFBCMO4dwb6vYmoP71725MLOJFHT2oOE6Hb1QVjwL1/Z3ThdcU3SQyCF11WPIO4lKHFzaEK8X5f4dA0l6+Hq5bWLCkjSJdTVDIEyIAe4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com
Subject: [PATCH v5 09/12] iotests: add testenv.py
Date: Thu, 22 Oct 2020 21:56:24 +0300
Message-Id: <20201022185627.16987-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022185627.16987-1-vsementsov@virtuozzo.com>
References: <20201022185627.16987-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Thu, 22 Oct 2020 18:56:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fed898c-c9e9-4bc8-9882-08d876bc3a0e
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB630971349985BF4CD12C604EC11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zt0PvWiOg9wjKbFm1WcmldolMKk/w74nGhq4rLAaspbKj1qlxPk1UlrYZHtUqu7te8TbyE8SqkQNbL8pGwDiPWhqBpzlL5zu6M8xZFnavBlowlUebeTRRctecTj3IA534V7wZh30CiqioMvEtR0UOYyuOOs7BQ9iqXlkRJQxyGyGQOJ7weha/psdjsngK/vNfzv/uwsu9UjbqHfhIqYno1QOcXeXSHxFrm3bkgI9mNwd1VBjY53E0xjciUXTSLVLZRvFo4Md0NacOLjqx98DKfF2+ziZGgXV00/uG8AstHT7sE8i2UvkGEUGizSYHVeC9UFGkP5F/BcmvK9zWqbmfG6fXRZSzmm/W3MoLarCjxULIfg+BuJD2dJVELoUEZx7iyRCUsv+KdO2MCZXjNnKKQFPNfLzqA6P/OhsF48VIpZjd2VDAAIB6cPIO4wQZsypJHUPbDYWsqqGVybXNgGGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(30864003)(52116002)(4326008)(5660300002)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(83380400001)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: upzRjFCvKhwskSmjTs7qNeuooBUTbli1O1rOgXlkRiw3f9EAyAO2MqahFLSHvi4SIdo5XdM3p1QiQimMX9O1TZ2G9pjxeSiUyzOBeLxoCJFJScWyVeCkYkpEX9SyfC6QNVkgMWkZeBktIo69XNB0F4yECaO9oCyKY+MZb5UWbDDujkIjAUeWlU79HCsbDwUQInWBa0N0ezUCs8iklXf8/3/KFF1N4o9XYX7/558gRiuq314ZS767ptrcDRE+1JY2FjjFMkg5zZ46g/jolsd7wU3LakCB6/jgM9KSWuftF5A/OAtpDLfYvbdU4OaW8xN8XFV+daHh4F0iDjSyQ9bQqC8Nc46zDq0iN78ZTDl2DVZRtGYliM7c1yJzmTOLgPlmhP3btgsAKbtHYs5sVloSMIVs4d68QJinxeDc23csfG04JCAMYiwGgks7jSxllsDsgcnD6V94mLkc/KtqQvaAxBbLQrArsKrSRvkgh5xr+q2+9jHjEi73KNbNoiMH3ZwbfQcf4o5MPFAhs4LeBbsViT0yljF6i7UiI2ruVzVvskFpU6xOreDoIsvdJou9BSfW9/LHonTIAp7RNAOaMKuz0NPOzRMt4+Qb0Ahfq1GfK38hVsD+CXFHnNrHbmZK5xWcQPTQHF2SEcU21jLcBfHsug==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fed898c-c9e9-4bc8-9882-08d876bc3a0e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:47.4253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CjbhUBkvfChUttxEzKVvrx/QInvRyWmBZRnI7jNvvjHDJpOaN3dPeucaIDEjANtFxsODsuQfc55xVxTWu/NMmldWrC1diLVDZthYe31b4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
Received-SPF: pass client-ip=40.107.22.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:56:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add TestEnv class, which will handle test environment in a new python
iotests running framework.

Difference with current ./check interface:
- -v (verbose) option dropped, as it is unused

- -xdiff option is dropped, until somebody complains that it is needed
- same for -n option

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/testenv.py | 325 ++++++++++++++++++++++++++++++++++
 1 file changed, 325 insertions(+)
 create mode 100755 tests/qemu-iotests/testenv.py

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
new file mode 100755
index 0000000000..97c75f70df
--- /dev/null
+++ b/tests/qemu-iotests/testenv.py
@@ -0,0 +1,325 @@
+#!/usr/bin/env python3
+#
+# Parse command line options to manage test environment variables.
+#
+# Copyright (c) 2020 Virtuozzo International GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+import sys
+import tempfile
+from pathlib import Path
+import shutil
+import collections
+import subprocess
+import argparse
+from typing import List, Dict
+
+
+def get_default_machine(qemu_prog: str) -> str:
+    outp = subprocess.run([qemu_prog, '-machine', 'help'], check=True,
+                          text=True, stdout=subprocess.PIPE).stdout
+
+    machines = outp.split('\n')
+    default_machine = next(m for m in machines if m.endswith(' (default)'))
+    default_machine = default_machine.split(' ', 1)[0]
+
+    alias_suf = ' (alias of {})'.format(default_machine)
+    alias = next((m for m in machines if m.endswith(alias_suf)), None)
+    if alias is not None:
+        default_machine = alias.split(' ', 1)[0]
+
+    return default_machine
+
+
+class TestEnv:
+    """
+    Manage system environment for running tests
+
+    The following variables are supported/provided. They are represented by
+    lower-cased TestEnv attributes.
+    """
+    env_variables = ['PYTHONPATH', 'TEST_DIR', 'SOCK_DIR', 'SAMPLE_IMG_DIR',
+                     'OUTPUT_DIR', 'PYTHON', 'QEMU_PROG', 'QEMU_IMG_PROG',
+                     'QEMU_IO_PROG', 'QEMU_NBD_PROG',
+                     'SOCKET_SCM_HELPER', 'QEMU_OPTIONS', 'QEMU_IMG_OPTIONS',
+                     'QEMU_IO_OPTIONS', 'QEMU_NBD_OPTIONS', 'IMGOPTS',
+                     'IMGFMT', 'IMGPROTO', 'AIOMODE', 'CACHEMODE',
+                     'VALGRIND_QEMU', 'CACHEMODE_IS_DEFAULT', 'IMGFMT_GENERIC',
+                     'IMGOPTSSYNTAX', 'IMGKEYSECRET', 'QEMU_DEFAULT_MACHINE']
+
+    def get_env(self) -> Dict[str, str]:
+        env = {}
+        for v in self.env_variables:
+            val = getattr(self, v.lower(), None)
+            if val is not None:
+                env[v] = val
+
+        return env
+
+    _argparser = None
+    @classmethod
+    def get_argparser(cls) -> argparse.ArgumentParser:
+        if cls._argparser is not None:
+            return cls._argparser
+
+        p = argparse.ArgumentParser(description="= test environment options =",
+                                    add_help=False, usage=argparse.SUPPRESS)
+
+        p.add_argument('-d', dest='debug', action='store_true', help='debug')
+        p.add_argument('-misalign', action='store_true',
+                       help='misalign memory allocations')
+
+        p.set_defaults(imgfmt='raw', imgproto='file')
+
+        format_list = ['raw', 'bochs', 'cloop', 'parallels', 'qcow', 'qcow2',
+                       'qed', 'vdi', 'vpc', 'vhdx', 'vmdk', 'luks', 'dmg']
+        g = p.add_argument_group(
+            'image format options',
+            'The following options sets IMGFMT environment variable. '
+            'At most one chose is allowed, default is "raw"')
+        g = g.add_mutually_exclusive_group()
+        for fmt in format_list:
+            g.add_argument('-' + fmt, dest='imgfmt', action='store_const',
+                           const=fmt)
+
+        protocol_list = ['file', 'rbd', 'sheepdoc', 'nbd', 'ssh', 'nfs']
+        g = p.add_argument_group(
+            'image protocol options',
+            'The following options sets IMGPROTO environment variably. '
+            'At most one chose is allowed, default is "file"')
+        g = g.add_mutually_exclusive_group()
+        for prt in protocol_list:
+            g.add_argument('-' + prt, dest='imgproto', action='store_const',
+                           const=prt)
+
+        g = p.add_mutually_exclusive_group()
+        # We don't set default for cachemode, as we need to distinguish dafult
+        # from user input later.
+        g.add_argument('-nocache', dest='cachemode', action='store_const',
+                       const='none', help='set cache mode "none" (O_DIRECT), '
+                       'sets CACHEMODE environment variable')
+        g.add_argument('-c', dest='cachemode',
+                       help='sets CACHEMODE environment variable')
+
+        p.add_argument('-i', dest='aiomode', default='threads',
+                       help='sets AIOMODE environment variable')
+
+        g = p.add_argument_group('bash tests options',
+                                 'The following options are ignored by '
+                                 'python tests. TODO: support them in '
+                                 'iotests.py')
+        g.add_argument('-o', dest='imgopts',
+                       help='options to pass to qemu-img create/convert, sets '
+                       'IMGOPTS environment variable')
+        p.add_argument('-valgrind', dest='VALGRIND_QEMU', action='store_const',
+                       const='y', help='use valgrind, sets VALGRIND_QEMU '
+                       'environment variable')
+
+        cls._argparser = p
+        return p
+
+    def init_handle_argv(self, argv: List[str]) -> None:
+
+        # Hints for mypy, about arguments which will be set by argparse
+        args, self.remaining_argv = self.get_argparser().parse_known_args(argv)
+        self.imgfmt = args.imgfmt
+        self.imgproto = args.imgproto
+        self.aiomode = args.aiomode
+        self.imgopts = args.imgopts
+        self.misalign = args.misalign
+        self.debug = args.debug
+
+        if args.cachemode is None:
+            self.cachemode_is_default = 'true'
+            self.cachemode = 'writeback'
+        else:
+            self.cachemode_is_default = 'false'
+            self.cachemode = args.cachemode
+
+    def init_directories(self):
+        """Init directory variables:
+             PYTHONPATH
+             TEST_DIR
+             SOCK_DIR
+             SAMPLE_IMG_DIR
+             OUTPUT_DIR
+        """
+        self.pythonpath = os.getenv('PYTHONPATH')
+        if self.pythonpath:
+            self.pythonpath = self.source_iotests + os.pathsep + \
+                self.pythonpath
+        else:
+            self.pythonpath = self.source_iotests
+
+        self.test_dir = os.getenv('TEST_DIR',
+                                  os.path.join(os.getcwd(), 'scratch'))
+        Path(self.test_dir).mkdir(parents=True, exist_ok=True)
+
+        self.sock_dir = os.getenv('SOCK_DIR')
+        self.tmp_sock_dir = False
+        if self.sock_dir:
+            Path(self.test_dir).mkdir(parents=True, exist_ok=True)
+        else:
+            self.sock_dir = tempfile.mkdtemp()
+            self.tmp_sock_dir = True
+
+        self.sample_img_dir = os.getenv('SAMPLE_IMG_DIR',
+                                        os.path.join(self.source_iotests,
+                                                     'sample_images'))
+
+        self.output_dir = os.getcwd()  # OUTPUT_DIR
+
+    def init_binaries(self):
+        """Init binary path variables:
+             PYTHON (for bash tests)
+             QEMU_PROG, QEMU_IMG_PROG, QEMU_IO_PROG, QEMU_NBD_PROG
+             SOCKET_SCM_HELPER
+        """
+        self.python = '/usr/bin/python3 -B'
+
+        def root(*names):
+            return os.path.join(self.build_root, *names)
+
+        arch = os.uname().machine
+        if 'ppc64' in arch:
+            arch = 'ppc64'
+
+        self.qemu_prog = os.getenv('QEMU_PROG', root(f'qemu-system-{arch}'))
+        self.qemu_img_prog = os.getenv('QEMU_IMG_PROG', root('qemu-img'))
+        self.qemu_io_prog = os.getenv('QEMU_IO_PROG', root('qemu-io'))
+        self.qemu_nbd_prog = os.getenv('QEMU_NBD_PROG', root('qemu-nbd'))
+
+        for b in [self.qemu_img_prog, self.qemu_io_prog, self.qemu_nbd_prog,
+                  self.qemu_prog]:
+            if not os.path.exists(b):
+                exit('Not such file: ' + b)
+            if not os.access(b, os.X_OK):
+                exit('Not executable: ' + b)
+
+        helper_path = os.path.join(self.build_iotests, 'socket_scm_helper')
+        if os.access(helper_path, os.X_OK):
+            self.socket_scm_helper = helper_path  # SOCKET_SCM_HELPER
+
+    def __init__(self, argv: List[str]) -> None:
+        """Parse args and environment"""
+
+        # Initialize generic paths: build_root, build_iotests, source_iotests,
+        # which are needed to initialize some environment variables. They are
+        # used by init_*() functions as well.
+
+
+        if os.path.islink(sys.argv[0]):
+            # called from the build tree
+            self.source_iotests = os.path.dirname(os.readlink(sys.argv[0]))
+            self.build_iotests = os.path.dirname(os.path.abspath(sys.argv[0]))
+        else:
+            # called from the source tree
+            self.source_iotests = os.getcwd()
+            self.build_iotests = self.source_iotests
+
+        self.build_root = os.path.join(self.build_iotests, '..', '..')
+
+        self.init_handle_argv(argv)
+        self.init_directories()
+        self.init_binaries()
+
+        # QEMU_OPTIONS
+        self.qemu_options = '-nodefaults -display none -accel qtest'
+        machine_map = (
+            (('arm', 'aarch64'), 'virt'),
+            ('avr', 'mega2560'),
+            ('rx', 'gdbsim-r5f562n8'),
+            ('tricore', 'tricore_testboard')
+        )
+        for suffix, machine in machine_map:
+            if self.qemu_prog.endswith(f'qemu-system-{suffix}'):
+                self.qemu_options += f' -machine {machine}'
+
+        # QEMU_DEFAULT_MACHINE
+        self.qemu_default_machine = get_default_machine(self.qemu_prog)
+
+        self.qemu_img_options = os.getenv('QEMU_IMG_OPTIONS')
+        self.qemu_nbd_options = os.getenv('QEMU_NBD_OPTIONS')
+
+        is_generic = self.imgfmt not in ['bochs', 'cloop', 'dmg']
+        self.imgfmt_generic = 'true' if is_generic else 'false'
+
+        self.qemu_io_options = f'--cache {self.cachemode} --aio {self.aiomode}'
+        if self.misalign:
+            self.qemu_io_options += ' --misalign'
+
+        self.qemu_io_options_no_fmt = self.qemu_io_options
+
+        if self.imgfmt == 'luks':
+            self.imgoptssyntax = 'true'
+            self.imgkeysecret = '123456'
+            if not self.imgopts:
+                self.imgopts = 'iter-time=10'
+            elif 'iter-time=' not in self.imgopts:
+                self.imgopts += ',iter-time=10'
+        else:
+            self.imgoptssyntax = 'false'
+            self.qemu_io_options += ' -f ' + self.imgfmt
+
+        if self.imgfmt == 'vmkd':
+            if not self.imgopts:
+                self.imgopts = 'zeroed_grain=on'
+            elif 'zeroed_grain=' not in self.imgopts:
+                self.imgopts += ',zeroed_grain=on'
+
+    def close(self) -> None:
+        if self.tmp_sock_dir:
+            shutil.rmtree(self.sock_dir)
+
+    def __enter__(self) -> 'TestEnv':
+        return self
+
+    def __exit__(self, *args) -> None:
+        self.close()
+
+    def print_env(self) -> None:
+        template = """\
+QEMU          -- "{QEMU_PROG}" {QEMU_OPTIONS}
+QEMU_IMG      -- "{QEMU_IMG_PROG}" {QEMU_IMG_OPTIONS}
+QEMU_IO       -- "{QEMU_IO_PROG}" {QEMU_IO_OPTIONS}
+QEMU_NBD      -- "{QEMU_NBD_PROG}" {QEMU_NBD_OPTIONS}
+IMGFMT        -- {IMGFMT}{imgopts}
+IMGPROTO      -- {IMGPROTO}
+PLATFORM      -- {platform}
+TEST_DIR      -- {TEST_DIR}
+SOCK_DIR      -- {SOCK_DIR}
+SOCKET_SCM_HELPER -- {SOCKET_SCM_HELPER}"""
+
+        args = collections.defaultdict(str, self.get_env())
+
+        if 'IMGOPTS' in args:
+            args['imgopts'] = f" ({args['IMGOPTS']})"
+
+        u = os.uname()
+        args['platform'] = f'{u.sysname}/{u.machine} {u.nodename} {u.release}'
+
+        print(template.format_map(args))
+
+
+if __name__ == '__main__':
+    if len(sys.argv) == 2 and sys.argv[1] in ['-h', '--help']:
+        TestEnv.get_argparser().print_help()
+        exit()
+
+    with TestEnv(sys.argv) as te:
+        te.print_env()
+        print('\nUnhandled options: ', te.remaining_argv)
-- 
2.21.3


