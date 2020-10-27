Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1C0C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692492224E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P0nAb5SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692492224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJtf-0005E8-GG
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvw-0007QR-1N
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:12 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvq-000447-H4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSIOgVu0Zqff1ekTPruj32xvzyugRexUiXZCcY3XE4q78kkcPoILL4QTKYhV1gGtrkC9GNON8xHet9VIEFg+MEAb9Sok95pmgzlJ3IqAcnpsS6fXnDy0rVJepdes88HvrgCM0uEgNdTnthk/llC0YD1BXsbFwbGjHRE0RAFK2nVgZu8s2plG81VCyS3FqUSzZKc4/tpQZOm1EXhXT4pg7vdPico4710skuka5n3LRFHuRElUHOoENyZ/p1apwCihcGA1G4S4UVkK85DhP1Gy1mRtSw3dUTc/PBNGXEb5V9LVdmM952g44O4ofDqwTHo4HLtmS5FW7gxAo13vLun2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE2J8ejvlIA4aWrHVkoErkL61tROkH+vRjXCeNj3n7A=;
 b=Pkbf2E3mefRNZbsTn7ks+2gp+Azft97r6MHCJkDvnfucDZZh7ZobjwTRTm1AxD4J7nlBuDQoZIXOZ0mHPVf3AU4o6qER2FNhOHrtvN9VHUX+25I0tKim7deSwzaTqkUuXvgyMIe1EBeJh4MgcaZ5DvrHIOhFdUcYNLopcua75PPs5qwlzjeswGZAlWEk6ylet41FxiBm6uXxi5+mUKGaSsqeOsUohPA6EmARteOCOUhdmsrYbq9QZnu3SA28L8P+O3pm6dNJQqNWc8TG02xl5jEIQskVwL6wJWiO/0eJkDwWtIIP5JPjzg/iOqYxiiGNgOiEe2bsYorupfo9xGuNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE2J8ejvlIA4aWrHVkoErkL61tROkH+vRjXCeNj3n7A=;
 b=P0nAb5SIazDKO+ou1VK4eE+gFDkGtmlJ7sMB8sj1atVlvCMWEJpmOrkeE58+QNbvi4Z6CKMe5bsGHz5v5SnM4DNfJoMGn9RvZxfxCFy4SARXgBl7twGdLACUg1J4bAUTYDyMOcaTaAYADRD9q6WZyjEsdGvzAJtFJgIdnxHXW5w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:52 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:52 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] qga: add implementation of guest-get-disks for Windows
Date: Tue, 27 Oct 2020 00:53:12 -0500
Message-Id: <20201027055317.351868-8-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: DM3PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:0:52::26) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 DM3PR08CA0016.namprd08.prod.outlook.com (2603:10b6:0:52::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25 via Frontend Transport; Tue, 27 Oct 2020 05:53:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9b15ecd-7b9b-42c8-ef36-08d87a3caeac
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5004EFBA36B1F3548567863E95160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wN/gUgN+xtGNWpaPgvZZE3JFQ1o1f1ZLi4QvGySXB3yYnPuNoEJ7JZkDLSYjrpjwzb9iBgkWHqrFZozMPoZkwIit1g16DkQx3b5pq9bC9TZjnCJeFwmOdqjSCElaRXjSH5ClClCzGviAOWfnQO5qEH/aSDpdu06C7SWx0+TCff4QZEK7r3c1hFi5Tp5G0yESN9O8gstWD0y0PwTJmGQYOE+cxUSIzxZAV4KVPYv0V34oTOqNMkieyOBrMW9F9ezV2DeqA3FL1FkM8NoPmzlfP0Qld0SN7dGnJIubw6tRyAgST3+eCrbfiXEhfYAl4y3RhfbZF992UoxkIKuQS3QAHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hzWPWGZ4EyBh4rA2cjyDLLOWKWo9YAVhjI1LNCOexpF/tpA2OP2qf6SuTV+r79BoSzjgh+o6zvI/M5PBN2FG6tFmUtR+fpPtOGmnCcLl7K2KfuvtSY5LhePTYd9OeIqNRXeLyJL5X6cxThvg0STS0JBXjMpotdQ+A4L0sVzQw7HWQVMgoSP1ZVkke+ImxNWVNOH1ei7MczxDlSm2pPvSzAHGMY/3txkuK4OgryDrqPcZp88Ld/PiSfAS2yTRcNL75O/JWohUpA2DUrZTlozLPoSrNAp/KBWli12QxFz0r33QNfLj/9FwE2zAMFY/mVQjjPx/+azT/61I5D0ALwFV+kGN5R3q/oQA29bnt8ZUVaFlZuQ6DTVqguBHj12aHPyy0D4j3w9ZHeMJ/P1b4DAFZf+VYXCtbn85fYx1lH04+v6FEjjW6a2dVUrMZ673uqdSeNiOQy8o0Kx34bPS8uzQ1hDsGBlCdBTQs5VhrYa4hQmuqB6EwOyTVE/A7iHDy4COnnZFC7MYk1639kmlT/Zyjc5hH39Joqt61Qw5kPRmMDaXCFWjW1rUer8mRkVGFk9fx3QRSDr+ZpCTVBSfz2I11O5buoBlWnHMkf67sTMq4mB84Ek9Z35NwL+BIGuC+i+z1cKrVKgPBb1jTAfn3QkUTw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b15ecd-7b9b-42c8-ef36-08d87a3caeac
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:52.2052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qewXis3gS5rIUORLs6gKQGtW61QOgLHboV5bd5c0jfX89ZDC97i7UhVIkpLm0qEjvi9rWGfGf/LgkNtWo9XLww==
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
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:51 -0400
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
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tomáš Golembiovský <tgolembi@redhat.com>

The command lists all the physical disk drives. Unlike for Linux
partitions and virtual volumes are not listed.

Example output:

{
  "return": [
    {
      "name": "\\\\.\\PhysicalDrive0",
      "partition": false,
      "address": {
        "serial": "QM00001",
        "bus-type": "sata",
        ...
      },
      "dependents": []
    }
  ]
}

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-win32.c | 107 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 6 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index f7bdd5a8b5..300b87c859 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -979,6 +979,101 @@ out:
     return list;
 }
 
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    ERRP_GUARD();
+    GuestDiskInfoList *new = NULL, *ret = NULL;
+    HDEVINFO dev_info;
+    SP_DEVICE_INTERFACE_DATA dev_iface_data;
+    int i;
+
+    dev_info = SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
+        DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
+    if (dev_info == INVALID_HANDLE_VALUE) {
+        error_setg_win32(errp, GetLastError(), "failed to get device tree");
+        return NULL;
+    }
+
+    g_debug("enumerating devices");
+    dev_iface_data.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);
+    for (i = 0;
+        SetupDiEnumDeviceInterfaces(dev_info, NULL, &GUID_DEVINTERFACE_DISK,
+            i, &dev_iface_data);
+        i++) {
+        GuestDiskAddress *address = NULL;
+        GuestDiskInfo *disk = NULL;
+        Error *local_err = NULL;
+        g_autofree PSP_DEVICE_INTERFACE_DETAIL_DATA
+            pdev_iface_detail_data = NULL;
+        STORAGE_DEVICE_NUMBER sdn;
+        HANDLE dev_file;
+        DWORD size = 0;
+        BOOL result;
+        int attempt;
+
+        g_debug("  getting device path");
+        for (attempt = 0, result = FALSE; attempt < 2 && !result; attempt++) {
+            result = SetupDiGetDeviceInterfaceDetail(dev_info,
+                &dev_iface_data, pdev_iface_detail_data, size, &size, NULL);
+            if (result) {
+                break;
+            }
+            if (GetLastError() == ERROR_INSUFFICIENT_BUFFER) {
+                pdev_iface_detail_data = g_realloc(pdev_iface_detail_data,
+                    size);
+                pdev_iface_detail_data->cbSize =
+                    sizeof(*pdev_iface_detail_data);
+            } else {
+                g_debug("failed to get device interface details");
+                break;
+            }
+        }
+        if (!result) {
+            g_debug("skipping device");
+            continue;
+        }
+
+        g_debug("  device: %s", pdev_iface_detail_data->DevicePath);
+        dev_file = CreateFile(pdev_iface_detail_data->DevicePath, 0,
+            FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
+        if (!DeviceIoControl(dev_file, IOCTL_STORAGE_GET_DEVICE_NUMBER,
+                NULL, 0, &sdn, sizeof(sdn), &size, NULL)) {
+            CloseHandle(dev_file);
+            debug_error("failed to get storage device number");
+            continue;
+        }
+        CloseHandle(dev_file);
+
+        disk = g_new0(GuestDiskInfo, 1);
+        disk->name = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
+            sdn.DeviceNumber);
+
+        g_debug("  number: %lu", sdn.DeviceNumber);
+        address = g_malloc0(sizeof(GuestDiskAddress));
+        address->has_dev = true;
+        address->dev = g_strdup(disk->name);
+        get_single_disk_info(sdn.DeviceNumber, address, &local_err);
+        if (local_err) {
+            g_debug("failed to get disk info: %s",
+                error_get_pretty(local_err));
+            error_free(local_err);
+            qapi_free_GuestDiskAddress(address);
+            address = NULL;
+        } else {
+            disk->address = address;
+            disk->has_address = true;
+        }
+
+        new = g_malloc0(sizeof(GuestDiskInfoList));
+        new->value = disk;
+        new->next = ret;
+        ret = new;
+    }
+
+    SetupDiDestroyDeviceInfoList(dev_info);
+    return ret;
+}
+
 #else
 
 static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
@@ -986,6 +1081,12 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     return NULL;
 }
 
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
 #endif /* CONFIG_QGA_NTDDSCSI */
 
 static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
@@ -2458,9 +2559,3 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
     }
     return head;
 }
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-- 
2.25.1


