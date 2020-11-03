Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B742EC55178
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A3F22243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EyQ8vyNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A3F22243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZkwB-0000Ch-9x
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZkso-0006mU-W5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:11 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55]:25952 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksn-0005Yp-95
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFlNtRSW1pELxC7OHNHZoPXB+FoiG9pCz/2iar1vGFLLh8b7AEisvVxpNdzAPOIe/EGHJHolXY/NJy4fT21AceHjiw8NIV2rtuSOSEUAT6McThytDIRUrg/a31Ek85nDD7ar1tWGoZCYOjsGKxCGe+8XeoWCqgyAnpVS7hOunVwV6ubwvyPNc1cHg+8k0ynH1fGfWdEuyroeEVBUlBwRUbbsYsK/fgfR2Ei7I5U+vdD6XcgQB2KG9/aocT30SYitKVKDG8o+7kwz3GvW1FAsuAiibOI7AOEyr4GGuqjSSE/MTkxxdFvHIxCgCDKsBSAA2Q1eXjNUFmKS1fGKA+7WNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE2J8ejvlIA4aWrHVkoErkL61tROkH+vRjXCeNj3n7A=;
 b=I8hp3bk+dHZzpO18qV7BAS24+5PQP5awVGJeW3xIKeufVTKBViZO9kIbJoODAxdpm+T2Ej5sc/osVGCN3DOXpLdsFjnslhN+sonixt/6UhOqYc5RrvCWj7AbgsWXmWSC33UWSwtb4KfzMo/DJCNkuuKzWHWWB6CBXbqgBzlNNbHC0Az2lambVgYxTN6XOxrfWOtL4gjLNEIqsTzTArmuzD31X6hkKWLk+qfP+IK3xr7rNhrWMwc4aQrx8+nr4BwgDVVgSnaDK5j6BRe0hvmbMa7+ldU6NP3VowhDpxfBteRN2CcWYh8pa6jiDWfdn5QlrkvkgNX1KnWX7Nbhe6XyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE2J8ejvlIA4aWrHVkoErkL61tROkH+vRjXCeNj3n7A=;
 b=EyQ8vyNoYQWyDpKP0oJH2OquX1ynpwQsmqR9MQFOCiRk2PUnhouif4kdreNF+frnJinwrbtAVY5Dsm64EDgAiQYVH9oq/fPe8iILTcCrMyqpHNNgtbPhMYrUj2iHAqjRr6AlgVBvDeK2L014+dXQE8mhprE55tZktmlJ2V7DLNM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:38 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:38 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/12] qga: add implementation of guest-get-disks for Windows
Date: Mon,  2 Nov 2020 19:11:29 -0600
Message-Id: <20201103011134.887744-8-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN4PR0801CA0001.namprd08.prod.outlook.com
 (2603:10b6:803:29::11) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN4PR0801CA0001.namprd08.prod.outlook.com (2603:10b6:803:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 01:12:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7aac0bd-af8b-4a47-84fd-08d87f958e03
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50019BE97A075576F553303495110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRO5KFRcCbynh4n7k7JyMPY4alPucktAUgm41AFwdHlOqVgZReJj3Xj+1cS4K/ofZ7230QRGUleAqFQvbp/VIuhg7rvwBRYiNT8W1zq/e8DRuTYYWKvYxbortK6dH+myMKmP+LgqXL0RLF3S/O1imGIQqybMv1CL9z8QZGVVrb+14jSMaD4SrWSXGYDKNBbvsRCmOD8PM6CxKWyeqTrIowyiuA+zF7NzK76VKAZhCj4wqw1smOaX+afo0P7v7XUabW9zYerKYIzIDvhejEr0ES70QUNtWWQWkf/4DZLmaftEcRJ6H8nAQQ7FJMBX4bypPJthQjPnQlOzNQ3VdZEQfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(6666004)(83380400001)(4326008)(36756003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +D/ubJtEsraa+sq1FrE+vYdXzUvlT04uSUMbX17dnGl0ux9QPWMnXZE0n/EPrkbGBbDjBDuAWx+c6l++igHZ7jDJvpLnU0/+OHcvozX30ue+3m50tvTTNcPSXmzfEbryyC+Ov+J6wxzzISQYiMsRK8U5pfUGhlCFWB1OLAW0ENHDutglxHFs/PQgXkKQFpmKtuJmVUNfitWcgr7Yk7cQw2D+0hBUKkckSCcBXnquikPAKaxtZQSeDoo9oEhueGERGjY957pi007bUrWhKo7ASm4I8L3LoNhtYPcJS+Ug+hy+Ji6C4kXGyOn+ptT30UNzuxIkT9POfv7hiXMQcp/daDnjOR69Pev+jvp1ddnBHY1O6OQFBN/NkFHQSQLLtqXyQ2ofoCXVOg1iGStVNqhLCsq4Bua9U3bebEA2h2d1yzzaE6p2Be26cWC4juZV5QkZSFa5UtyZZ/3EMNTXwz8ITCF0JjXuF0XUhTqiry+EuHn7p0CdI5/tKts7LQfxG7PESxAQapBHiLZOYj6iwzGsgSmRYw3b0Hg10yM2C4xIYNrW3iX4vkczUbSgz0kdCIZdE48FRR8YfKaijxTZcvl3AYP2JAE8CwkgTLZPjlKQWYB+U13Onjf5fj2j+U8GE41U4uvgQiIu2I2cL+S5xl64xw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7aac0bd-af8b-4a47-84fd-08d87f958e03
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:38.4744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLScvA6wPkZnOG9QLV0GVurHgtuZhEMTk9OByaTexs37LGbHfu4S5qpTg0221bJOmKAt7Aacl+WdTg9q62umLQ==
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


