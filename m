Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7435AC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB1620731
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ETI+pb7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB1620731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmWJ-0002s9-26
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJw-0000zM-Ky
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:16 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72]:13281 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJu-0007gm-TT
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+g7Cow+neqE7eaXCvd8DJuFzpJRP+sx2Uqix44olaLCAKfSDf1eIBR1CPq8Q5YpezRw53D4lDrO1yLn0MDSDV6BRS3yuprfUw2TiNQY+0BteUp4H4QPsVJGeoEfOR2ei1s/GOxL2Z9lIYUOE34Z4ScbOcbtw0Mqe5sSrm1cpkgNlkTetcWz6MwMQZz7KCkx96et0S1QsAFqPnnD15HbY3+T4fdCA3v9Czeigt/FkCiljDAGd/6sVzNBe3NmXK9Ks+z8qZu06ySu5Z+R0E2dfd+9gqN0OVLXDBFsOAZcmsVzF3lTgBid4X39B3n9ivrET7H68P6Cx17Vbs8mHjhXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waizySm79FyW0klesiTXmFKAcmtlT2Hov5IiZncGR9A=;
 b=Hh0ZYEXouCPimBgZk3jGuhpgg2laZrNM9SOMexI07P3DSkbT93MbWxBrZZWZHcWWbvOWXqwoez3QOfeIjEkHv/kQeYrMFUjLjfpOdQsHL2J1RyKk4tsVdoyUaA7tJvVGzfqjLTRBTUsZNvoP2Q12NqzwOgCXGKHa9KR+i3xytt4tBlxYzi6vOLS2OEZlCNIoXYgQ1Fiuyu2qDXmpPohgXOinBvnripDFjcgUPVVQwJstmQeW0zYdl5vmlqFeGnv5ROoNuFkHNmXQ/bby6IC3rMCCUXPbMkd1vjTnrd0u1209DwOANXXfLjbbOG6vKDoM+V3yfkrsJ427Mx8eZPtFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waizySm79FyW0klesiTXmFKAcmtlT2Hov5IiZncGR9A=;
 b=ETI+pb7zHQom2suL2sAoUVDJQVuI0p42vAZrQ3YY9T5KWtX76b+a7zX0gMZWMa/DFoGJKm9iq+Aifrro4W5O+daEBMinUuZJSO8ceZJTOp6gOrfOevzVbo+LZnNnstfSVtKiIFGsl9QRsrcFSTizmslDCVVioNjvfMqmfDCpl7Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:45:12 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:45:12 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 05/12] qga: add command guest-get-disks
Date: Mon,  2 Nov 2020 20:43:37 -0600
Message-Id: <20201103024343.894221-6-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN4PR0401CA0021.namprd04.prod.outlook.com
 (2603:10b6:803:21::31) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN4PR0401CA0021.namprd04.prod.outlook.com (2603:10b6:803:21::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Tue, 3 Nov 2020 02:45:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2a6a157-8e1c-40ce-37a4-08d87fa27cc1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB43117F4AFCBD95EF4BF991C595110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7kgLaOmUxLutgM84GrENOJzpjN35orhiS7Gtsl4L7n/EX5WF2qPJU29MWuIuzgPbUyBn+NSwbuFV8p2V6MMT6V9uNgaKme2gdpCZM9fdHXzKWtJPfrPMGWLqyaJNkxTsR93VRiUNsD9QfT4GrGJyV5VB+tCdq81UAtMebWspLkjinJDdyGOeQv3vcH6KfCGt3WM+N8inAzk1JRo1UhzuG63zqM9GYYLAGBOFa2WMUuTHEc6J+1nsE7bq/266O5rIx6mLCYPtof4ORznVJ9JDhYeVaOPbl8GMrsaEEIwX9MMjrcvmvmyRNoD2pwqITrieM2q5sFjrBi32Fz8xXSiA8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(86362001)(26005)(66556008)(956004)(66946007)(6666004)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(54906003)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: as8mNHfZxwp8WPbjrw8NDc5aybnWn4o0KMDogwi8sxYyiA3fEANMVuAxhbTrRgwCz/hF4tI8XEtN/w9D++evVV20A3BB2L1tpfAClY+onVXzHs/Mh6M7LG7FG9Y9vSx7SVJ9UIiX46rpdwTw+ZtDR8kQTFJrTcmMQzpOJp4rlNRvXTEAz6fmkNkferlx8OYgJ6lC7JDIHrc6jLZA8CrQ5iJSYII5RRRSEOz4bySZzzRFx3+qFSJJs5qLvlGpa5dTTrwxIyR6+XZyR/MajQqGv50qR/m6oy4xnsMUYx8wo4tVKwcILBB/cHXO9IZNILS3dqz1ynv0eWdGQa/yvhV7x8pEuJ5hRRQcR80qnbIZKjamyFQjKK2CcGvFb6OHkScQkCY28g/dyiZakqD3Lau6hkgTDVGh2J3W/8IRNcl5kTu5nTRZb8EndO9Rk/W+ek/6NxhsjHKvf6Hf/QCFoR4LZa2EI8VhV7aDwxKxdguCyooWGbMSKcLYA4t7OdXODsi7YeiqJVfuNL0oLME4B7eHdlAnks2jr5Q7SDdyESqOU9jBz2F4gJOvNCt1gnebhlTJL7iqpBLm2xFoYXhn2doRb63UaZOw8SENPp2MAaZtn80jAvsKgieObXs573dJjFS5OjLJqXCiz4b3+WoWhfYJog==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a6a157-8e1c-40ce-37a4-08d87fa27cc1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:45:12.8387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqkxi2ApmYk6jjjkQQ3YSEZXPtGHeA/YmGo1yM/tQc871AcGijVsE87c1n/t2fETO1Ir/kP1rKFc/bSvD/tm8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
Received-SPF: none client-ip=40.107.244.72; envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 21:44:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tomáš Golembiovský <tgolembi@redhat.com>

Add API and stubs for new guest-get-disks command.

The command guest-get-fsinfo can be used to list information about disks
and partitions but it is limited only to mounted disks with filesystem.
This new command should allow listing information about disks of the VM
regardles whether they are mounted or not. This can be usefull for
management applications for mapping virtualized devices or pass-through
devices to device names in the guest OS.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-posix.c |  6 ++++++
 qga/commands-win32.c |  6 ++++++
 qga/qapi-schema.json | 31 +++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 3bffee99d4..422144bcff 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -3051,3 +3051,9 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
 
     return NULL;
 }
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0c33d48aaa..f7bdd5a8b5 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2458,3 +2458,9 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
     }
     return head;
 }
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index fe10631e4c..e123a000be 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -865,6 +865,37 @@
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str'} }
 
+##
+# @GuestDiskInfo:
+#
+# @name: device node (Linux) or device UNC (Windows)
+# @partition: whether this is a partition or disk
+# @dependents: list of dependent devices; e.g. for LVs of the LVM this will
+#              hold the list of PVs, for LUKS encrypted volume this will
+#              contain the disk where the volume is placed.     (Linux)
+# @address: disk address information (only for non-virtual devices)
+# @alias: optional alias assigned to the disk, on Linux this is a name assigned
+#         by device mapper
+#
+# Since 5.2
+##
+{ 'struct': 'GuestDiskInfo',
+  'data': {'name': 'str', 'partition': 'bool', 'dependents': ['str'],
+           '*address': 'GuestDiskAddress', '*alias': 'str'} }
+
+##
+# @guest-get-disks:
+#
+# Returns: The list of disks in the guest. For Windows these are only the
+#          physical disks. On Linux these are all root block devices of
+#          non-zero size including e.g. removable devices, loop devices,
+#          NBD, etc.
+#
+# Since: 5.2
+##
+{ 'command': 'guest-get-disks',
+  'returns': ['GuestDiskInfo'] }
+
 ##
 # @GuestFilesystemInfo:
 #
-- 
2.25.1


