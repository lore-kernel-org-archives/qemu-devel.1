Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BBBC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392E72225E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kSbqQ0qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392E72225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlF4-0004fh-5m
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksk-0006h8-Lf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:06 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55]:25952 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksj-0005Yp-1s
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq7SrpjLZlMXt+3Og0l8OV3crfp/2u8zzg73wQKSx02/LUBgyP3sc5hALgVwOOC48R4fCjGjkAJdz/iEwfgzNxAPFUQ/OUKEegTpMF5NLZsUWZH2TbkofTZKh2P0UGmud0VdI7Mi2OLYKv2rCzhWzoVcN/PIkWe3iAvBUX44VpazF/W9UmDpmcLR/2YZVfnzwL8fNZmo7VOatLoc4hDpQDiCYyJphYg1xmHlUOq6hTC6G4fIYJ1IdXeGMncsQYXdoUgZID+PtQ7w+o7SxUZ2eDI3ioMzhFp0koL/Aqq+oy9FjFJsTEaaaDvRbwT4GVBGmdcDzg9H4d5LzQtLlMyL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waizySm79FyW0klesiTXmFKAcmtlT2Hov5IiZncGR9A=;
 b=fH3uOCrGQQ+Kxs1bEgKEBMM/DbLdyvuwi809qyiXgfM86GfC9QfdSM+ARWbiz0d3x5JjrnIzYRN2NV+yue3yPCEqVYlXUajHYqmTW/fWIn1Cyw+h2U7nvWyJKpj0L7nG7PEnZHDtAeeghEv60NNUpHvIrTm4aYqVmKu4ojnkAglNskpSbm7Ie6WzRe0W4v5Tubfw1PFgcErGYI/Zfdy2BLSrmNwxaeFh6XAZSNb8x6ohAGF/opauRyria0HVjcvgRwyXs84qzw+zzh6CLQTJEo0pQtDteXH/2LWu2b5rWg5+GZ2yFJN3D0Q9vikyaPzAlU0jOIbKW+TSz3W3RqXcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waizySm79FyW0klesiTXmFKAcmtlT2Hov5IiZncGR9A=;
 b=kSbqQ0qoOJZ/2fQO2XW7+UQOEVD/MVk4te0R183qWlK4tpu5QF2Ij/u5nNtCT0b8tKI06pWK/OCRCwrINeFt3GuR9K/rGaOcRlxv60IEipzepKKmHMivGBYljZ/8vl2VG1NTWKqrPhFibpuQ2CYtm/VdFYcztskN8reTK2CMhOI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:32 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:32 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/12] qga: add command guest-get-disks
Date: Mon,  2 Nov 2020 19:11:27 -0600
Message-Id: <20201103011134.887744-6-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SA0PR11CA0003.namprd11.prod.outlook.com (2603:10b6:806:d3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 01:12:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 123f4b29-4b33-4b92-3c65-08d87f958a7f
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5001E5D56006C54FF2962CDE95110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7JkmyECrmYdqUnANEps6J/OVj/MVx6L3m8EOQbKTabmJWwCwttlIwiqc3ymslnZzKWvtIfWZXy/AgaUY8azVrSES3asgnZ2LYONV2TFp48qepgFZ+c9ArKGDJSqZqnJtOGnfWZyMwGJSOTYf+j7kSE67hDSD9XPm41ZxJCGzXH7/ba6YgzrfhOVsd0o1NIa76iHc5sjEyRZvzY1ClVOBBTx9++X4x+RIwVMV2ZdSl+6Fl+2TmX/Be5U9gUvysUmiMGQMaP/1fLwxfzzzkyL1eDgeQb909+K9ttJTlgLng0So9qjlRSMU+WQ/NYp/uN3s0pYaICbbaf/JqdY+1YJlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(6666004)(83380400001)(4326008)(36756003)(54906003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: U/+frQjJgB3IaFmO5tFZM6WQG8OsHpF+fw1u605LhPfIRQRX+jh0jRgrO4lIpD3DGA6zZt/YYrKZaf4Er7sVxAuJ2nCeDNWWR1I3vihrJLY5JhINqMjr5sNtAOfsdxWOd3rhJiIVsCsyUPEaRD1pHEIFxZSZCvrXRbtvfMPqVSKP9z5MYA4AmYK9DcmsKSa3sARzYPiqOv1xLdPr7UxMYObxq4t/DzTHrKmj0E3L6NLKDiZglf6zljsJTteTwaBshl5kW2UCL7KWPDe1Cdt8UcPyQUE4FZd7JEWRFI9UAJP9vdLeOxNf0g5FzSZz5W5tU5EbxDPwi1tLvCsNnWF/ueTUDQET9CZM7ebHNzW/Fu/4ZIunpo3lFHXDfBLInFcoBcgVRrYsHJ3FoUH9z9xPkWcXbAaCi565jyvjGrv1RdhBNUFprhONhtGR0lodeZtZa4m9ALQ00Ar7feynzMhuv1vU5Cv9Vr9Zn60vXUa4uF5R+d/0JMpHLJZ6OIFBW5k6ERegLJzNK8ipdgL6FtWF9yZHIkBvJhL/hHH5TAdAq5HD8Q0g0KlbKYEz3F6359N+zSYYgc49KmPISzxgzkWA8twsmJSFaxZCsOAhxzqeUAIgHq2rcHsuXNwyFtOBdRF2ZD9k8aLaWqRTUD/wZr/WQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123f4b29-4b33-4b92-3c65-08d87f958a7f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:32.5016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjsIvBLPsBne6Qck/OZtXK4qldrUqS0TtM6Z/pxtVrpDG0y4BIULC83tODuFP1IG0zNlmOFf7Yxfa/wsJ1wiWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
Received-SPF: none client-ip=40.107.94.55; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:12:53
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


