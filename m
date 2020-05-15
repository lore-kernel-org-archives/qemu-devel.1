Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE450C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C42205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ol8lirdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C42205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhiI-0004Fr-Kb
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhg9-0001pB-5m; Fri, 15 May 2020 17:15:37 -0400
Received: from mail-db8eur05on2132.outbound.protection.outlook.com
 ([40.107.20.132]:46772 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhg7-0005cY-Aj; Fri, 15 May 2020 17:15:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0vP3DpTIq9avLXKd2tL73YFAIewRS1J042LgCzE8CbWBc98aiVuUr32qlVAMgQOXsdvESIFBsq0h2mn6e9mPqCgtON6HEoS3Syr0JpY9xc1A1EkD4gvZeBVdqZmqXmX8kbkFgHsZfWiVj5toJD+8bw9b/DL4H2koRjTfdTWqnZV0YHZT0LL+fd1PrtSPYC8UZJs5stmjwH+5R87Lc1iprVfoXrVSjwY979Mk+j0b068YxsqOJfVh9ZNLuUdCo4YICLeXlpDA8IKP1AopstW5medGiRZXBuzLLvii2JVYbZb/SBsWyzGosYJ3IxdU62fULyRj9AgUiGNyiSxrmWo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLFv9b4Tj9to4QoK63eGfhVl1lZJvDRCWaAE0Zo8Eok=;
 b=jJoyjKYa46dyadyOvmvBxrnaTBDzK/GpEYQjpEvGKAZ5/EGVnuE8Lvs/p/N4tGJJ0OJ2LGP07gMb/4Ag8LrMWBBu1RiBJWwAYRJFAJDLrVVxQW7gKORjy95q9kXS4FWzmVE/lmNLaX8YzH0m+BbSgU2QfZLF7O/kdNAtjgRZ1TO/qxO1YXXO/0Fih92Li2KZTtXeQDgYsCyN2NJFG6Bxjpu9QotIhkXt8qJUeqoG41ypVZDzN8b68R4/rXEiSEnvxKpPrDR1BdJPb/iis+VDmD9d3VZq1ZoNbrOylPMbKGwMcPociP2coXYPEfqgEKqJ5mrbjK/Odd2r/yGDzhmNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLFv9b4Tj9to4QoK63eGfhVl1lZJvDRCWaAE0Zo8Eok=;
 b=Ol8lirdW5fXoHKQmKziNGaZodx+IjBzva4dZwhl77CeIbqt9q8USqDw3c31KuNEz21gaV6/yone0rKKkXSg6swddEBlEK6oNyvFpJ+Kt0jOvYwrAwVRC/z0nlC9e15wfq6Qme7BP1DZK3jkDj3jlqBYyNDpqh6VR8cSLhrvFZpk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 21:15:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 21:15:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 6/9] iotests: add testenv.py
Date: Sat, 16 May 2020 00:15:02 +0300
Message-Id: <20200515211505.3042-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515211505.3042-1-vsementsov@virtuozzo.com>
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 21:15:23 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83757aa9-b9fd-4bab-f0d4-08d7f915153d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478961B003A257A089C5193C1BD0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV9xLuuP36OmKsEVWfg90MZIYwDxWPS+GPmLR/9SozZSfHaDTVW7TSYB7p4sZ7EItIbbQq3OKEDzyS7SSY1rigPuNCBNCmLDtULi6yydSvLEZym/iKBloh6aH2YEZzujMzMx1ZdeCeKkkZBGfowLy9GXCjyNU+SkWomA2+w5fxae6zMQfBRUF4lDMovBq1nsxjdA8IRfx+Vakl3KRUD4lnxirkyHEO79ihqaT5jeTRCPMn/MvV/osNroiA3jmegn8PS326HTtFuwhPumQEPUdmnZEKNmSMPB5ZNeIgGSkERYq6CwIHDT/rmOsla5G/0w/O6/9QxjXfXqfSr6g3/Vyl1IoYNF9xfuC+3FI+Dyofe6Fn/G9wm86+8wnQELFo4bfBxBtsCdgwT3gM2t2zGqTTdMg4+JfUq9jpNoSHXbAyfgQIvmk+iuIkcp97rwH4uNJI+pTXo9nOxXoi1kcMJ4B/DocWSckwr+WeG5dLoKItbO47ta0UKu/qy/AvRNnSDizz2E3dze+o+Q+q6jiaqmO8FZCMR2kSlJYqbmQkTui8FBaAG5i5upTZ0UKDonE0zP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(26005)(86362001)(6486002)(2906002)(6916009)(36756003)(30864003)(8936002)(316002)(8676002)(66476007)(66946007)(1076003)(66556008)(956004)(52116002)(4326008)(186003)(16526019)(478600001)(6506007)(6666004)(6512007)(2616005)(5660300002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cb9xqLBTgP/CPH77CgE4gg3+BJwaEqDnRv9XelNtoe81c191UCozGojz5t1MMMJUfD15dE68fpyLnEuJ0DXYN0n8IR1BLH9H3Iq8UiK8pLyT+xd/r1ZCC8AvJU6uUO4EQ/mPvDaA1Pzwki/PQWDgZ/QnqpuMvYCTK50JB/lobUrkLXGGkgCK3US+QRRr98P+2nmL6pviI80p0i9jQchvzgjxuJiOYsr4LHtTx6GqifZUF9Pw1QX4ouDT0+ZnSv1dhUMtUlCQ6zmlDz+GttPSYhdK/9YqojttfFbwuStj4K428QDnm/SgiMB7URWAq4t9giuRq+4h9MoFYHwo8F4BWAp+eq2LOhIk8kU5OFogItQy2tZXrlzffdeFnilNDseQQjmb5088EjD4C4EZOsAvdX+aUGTB/n9dgFpMQYcD4auryWqa82DJxi0lrQq857KwaymMn1aaw++WVf+LXv8ekFP4Xxv/zyO11DYBIZsxlr4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83757aa9-b9fd-4bab-f0d4-08d7f915153d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 21:15:24.3857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74yJKOUe1DOw8ObPYzhixRlamYWNeOEcWOgqFV/Rvcjx3Vqyw0VSzQgtGBD3UIcNo9A8Ql4JqeJGM3foWE2d19hOJ9/1Ywz7WzJWeH+4/30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.20.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 17:15:28
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
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
index 0000000000..ba396d5a97
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
+                     'QEMU_IO_PROG', 'QEMU_NBD_PROG', 'QEMU_VXHS_PROG',
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
+        protocol_list = ['file', 'rbd', 'sheepdoc', 'nbd', 'ssh', 'nfs',
+                         'vxhs']
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
+             QEMU_VXHS_PROG
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
+        self.qemu_prog = os.getenv('QEMU_PROG', root(f'{arch}-softmmu',
+                                                     f'qemu-system-{arch}'))
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
+        vxhs_path = str(shutil.which('qnio_server'))
+        if os.access(vxhs_path, os.X_OK):
+            self.qemu_vxhs_prog = vxhs_path  # QEMU_VXHS_PROG
+
+    def __init__(self, argv: List[str]) -> None:
+        """Parse args and environment"""
+
+        # Initialize generic paths: build_root, build_iotests, source_iotests,
+        # which are needed to initialize some environment variables. They are
+        # used by init_*() functions as well.
+
+        self.build_iotests = os.getcwd()
+
+        if os.path.islink(sys.argv[0]):
+            # called from the build tree
+            self.source_iotests = os.path.dirname(os.readlink(sys.argv[0]))
+        else:
+            self.source_iotests = self.build_iotests
+
+        self.build_root = os.path.join(self.build_iotests, '..', '..')
+
+        self.init_handle_argv(argv)
+        self.init_directories()
+        self.init_binaries()
+
+        # QEMU_OPTIONS
+        self.qemu_options = '-nodefaults -display none -accel qtest'
+        if self.qemu_prog.endswith(('qemu-system-arm', 'qemu-system-aarch64')):
+            self.qemu_options += ' -machine virt'
+        elif self.qemu_prog.endswith('qemu-system-tricore'):
+            self.qemu_options += ' -machine tricore_testboard'
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
2.21.0


