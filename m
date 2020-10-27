Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9FC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479D42224E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J5STsBI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479D42224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJr0-0003Du-AY
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvo-0007OK-80
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:04 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvm-000447-Ku
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFbKKI0aPt8AB236yeSHdxOECJHhvUXT53wZbxWZY3OwZRbz4QqBE3ksr9vb4P01GnrjBXVAjS57FvIs9dw4xNpNht7TeF+NJtQGP2SqmE7hSV1ihG4pasaWmTcHD7XdUAaeaCJ1sAOi/rsTo1/UjPNeu5xluHTndWRn1Eiu5Hz0Lvqdvkp9iIYA5o+mhRA/nr8xR4srwsM523el4iTq5lyD0ImTyPN2t8adX9KCJ1J16LWsfLVhNP/0HHmsfv7clSW5qAwUQuMqrxE0kAt+gZt0g3bL1MVvEd+xzCJqLcu10AJfvstGnLoq4Hk9f4lybY0MUhOnX28tIlfv1TwHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waizySm79FyW0klesiTXmFKAcmtlT2Hov5IiZncGR9A=;
 b=TbrXdO3kSE51A803kAlXYfRNJat0MPWQjUrI0I3G1xQF+DhFtSZJnQGzGc/Fy/xP7LDyvsp2z76fLmUQtPFDyLHhVDl3Vw7jB5q2gfDxy7fFRB+nf+uE0QvgDyKkdOtoUKT9h/sE03hUsZqptlnk+QDShHPYCYj4O6njBDsgkNkK5GU6S0Lkf2JojxB07FhRkpluQaVP0LRZosGejLoSwVN7Q88c1dssvAhSR+f8aZSul49+UVh5zKmsKFQAioc1kxEIn46uHW/Ebv/tpeXi6j/CAREfAR1yO22peBzAQ2lXWoY2E0RXBoBsIiUE0JYPwyvJpb+hvUWKj506XiFUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waizySm79FyW0klesiTXmFKAcmtlT2Hov5IiZncGR9A=;
 b=J5STsBI5F9ek1ZyZ11ZvuvQgdyDMo377I2O5oYQY46rtavAKuUt8Ih2Zgs1mhfU+twRXITU9AZpSHGzUsgpb9pwsgs0CW4dKsO7PUrz1M1UMNTCj/nC0grhjVMKJ5cFHbVTgug3ib+WlnGqKnDlCPN0PrlyfAzJtSDjjCsTcxi8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:49 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:49 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] qga: add command guest-get-disks
Date: Tue, 27 Oct 2020 00:53:10 -0500
Message-Id: <20201027055317.351868-6-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN1PR12CA0114.namprd12.prod.outlook.com
 (2603:10b6:802:21::49) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN1PR12CA0114.namprd12.prod.outlook.com (2603:10b6:802:21::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 05:53:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 699d58ae-8556-41a8-d567-08d87a3cad24
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB500460521D1FC7AE47BE943F95160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbjniElAQN5vU7LE2vCmYFiGU+TM/fWGE2EM9z813eiZO5+08/d5IeudJo4fqOlOMvSg1nlEchZ5whosRm8CkcHOqxc9+OmFtGvt/4gRnJxE/MEU/yVKX51RiRK8V0vLpPneTe2fTGsYLISgATw/gjkVxH7Q3SmA90e122nccmDaeuK1mN+DAXMFupouEnrQuA2SoDi7zJWgz2lZ/O1o4JtuzhBUPdG0Sw9jy4OydYiUAf9YlLjN4APKuqXGK7B69z+B+fKXJMBcaMudwGplA8FaUg4SUo9is4Xu+HLybvLep7KJJHmqz34EtkRvp2ll4ZIRsqRYP74WggAvXW7Umw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(54906003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7OuE/6AgdGBTlWK3uLZhdytdG89VD2S9dLznVaVar4R/jL3xY4Qhpa5JmoTkNQeUw9bHHHU3vwKt/c7A1IVvuTmTLMsv3NRg4w6B2W3kcb9diE4EBfIkECYJ+PMapn1hGzLXkxmx47TxYUl5ClqA58WQVd/bA//NFUteC4rNtxgHpZlTEtYkqzsb0CpJd+yP4kuxzd/rv+vFm60I6Lb8tqbH53jVLkDMtzf6DW9QUFLeVsN4DXONf4aU/y5dbpS/sLvwVVqSFsnnT+4gJf98/ynR4oPPNT5yjfyOIbfz8e/v+Ya0FITv9iMYda6oC2OzZN2rQAWa1i8gieiuyAS/O2XJK90nAkYtqOlyeUO889KwuKw45VO4e/OhUWzAOYpaEbFjrULJEvsOpq0lHcuVvZkdZbSzLM28JRTbvzgQmWPnJ3ma/I6Cj0YvO4t0R8zFgQGS2qCu9xQMF6PS4RB78JQbLtYt9UFz6O0Cbrwu4TPUybjv9nE+3UqE7Yf4Qc1DkEGSBiHqZPzGWZl7nZJRCcAAsQNQFP3KJb0h91ATFFCgauVj4erKRTX5HRJLq7a3azkMugkbRxStyio+FJJ9nrPR0+Dcgh//jeSsO6ZdzMlX6sjopTKjHcRlsPXpEATGIun7Uac173mTFSTdV+nAWg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699d58ae-8556-41a8-d567-08d87a3cad24
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:49.6634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl4/k5AewjNdTMnbShBPj3jDgo3u+C7MIufpaNG+C+FMYJCWIFrR5xaI/EigTsG8i9Z62+XuekLVkcHT3RVf5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
Received-SPF: none client-ip=40.107.92.50; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:53:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:49 -0400
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


