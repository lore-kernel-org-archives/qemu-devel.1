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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3BDC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451A220731
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bcE6SFc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451A220731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmVa-0002FP-Cs
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmK1-00017o-HI
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:21 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72]:13281 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJz-0007gm-GS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndXcBJjCamVeglkm+ZHdMVYNV9Nq/C1ppGEu/8OVsjjP5W1T6p4gIWMSc58xO6OueNgHPV7yoc42MzM8f65RxzpYvfwddT4+Cjl2rdV1e3D7LxMrXOTfBu9kK84RzB9Q/1QAEohHq2h79Uu+Wzxb3FLopnH9f2k/sLu1YgZi0D1ZIwZ7qaIG7G5TK82YFLIkXHRR3x7Wvoye4qsp2AHywoMY3E1t5tAmcWI3/GTE4rDjx5hOSyQXz53/TucqS9kKDJ+NPCMPLAs//97RlqeuUVJgOLrW4pmMtX3b7DiBItmGfHza5nkEwM5C1qU0pklQNEiOJVuHqdsJyuwiRL0rYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE2J8ejvlIA4aWrHVkoErkL61tROkH+vRjXCeNj3n7A=;
 b=DKOR+ErNMDoprABGGegS7uOuyVgFphuQZHX7S1JGNuMhKA5Ix0ehHg8GLG/TRM9oWLl+6WqkXObkCvEnjI2lMUK6ZqIE2+GTCBrisvbFHCv7/gBp6lg9dVHo09sCAbJ5QdBkMTaJzfAVKPAXuCb9OOqFuQDApuKnR7+87/wF5WkPEXGtQXU2urKvZnaR5HJgLOnZJCxHFQGvpuiy5e4sf1WjekD8NJ8IyBbGCX4GhBTx9EgKFqR3khwrJb6Qab3pW7rFWVo6zG7+JFCnTXeuIXRGBzYS+usFuNwBzACexSuxWS+E5Q3ocDr7xVFs7YCU3tj1ZGk6kQMKKoiJtjYQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE2J8ejvlIA4aWrHVkoErkL61tROkH+vRjXCeNj3n7A=;
 b=bcE6SFc3CZ0S8pEoIS2alSpzPoGH/M8cs/dZ8O8hzpdRVTNJF7KzxRsvx9rrGSKDOKIpLzRXVa3P5dyIxtvOhtszeAYTkzwm99IB9bBPQa03BVMKty+Y7jns7nX+XYer7lhiSV1/SE5/jpOvhzt+tvBtovyndS4BIR0AxUBzJjw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:45:18 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:45:18 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 07/12] qga: add implementation of guest-get-disks for Windows
Date: Mon,  2 Nov 2020 20:43:39 -0600
Message-Id: <20201103024343.894221-8-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA0PR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:806:d1::12) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SA0PR11CA0097.namprd11.prod.outlook.com (2603:10b6:806:d1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 02:45:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fb4c1ad-efaa-42f7-b94a-08d87fa27fcc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB43119B14F879C6175EA8C83995110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrE8WTKQhqOcr4kU4OLMUKVttEoVUXV8qodOaf9DbgdAzOY8VYfnyGbX2254p7DDiJp0Gn2TBN0p5q9kkr9txrP+cRcZgNiS2wJD3nepS568LLNm2Ko5QR/nnBHgDObRu6e6Ncoll6H5b5zoMaNAZugIk6XzVmpqtUBvf88Kb1gci3i6pBLKD26ZAac6K+kH5SeyOsB42DkkBNCN/vDE1y3zTlUN6fXWiqlAEkLRF5TaVd9n61YxZgmjL2sWPxKkQc6YcJsdyYh12SrjA7eQ+PSYfnWlK9+K1xR8GSEDhzhKumIOZwV5FB2+ewy64Ep/qVDEtcHT/XMkV0+RgR3J4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(86362001)(26005)(66556008)(956004)(66946007)(6666004)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: U+mgMudajkWm9ecz0gOJ7HgLTZjGFPFjMbSRJi5LlqmL1ADm/lRYXOHpWAYVVOeCGetpPKtLXMlRZu1QsH2ZuLYTCwnMWGcdTEGbPZsPYnppo+cRaydYm4YV3YO8nJdcTrnJsvqD+vX/zbwe5wd68uKPEExkKpys0SqyVsX8g7M6ifKiZt5Lz005LjYWtg9Yn8btn0a71a8SPd9G+YrfS/fX2Owb2gjMpssNqvU9v71WToE6PdkhSOVu561eKWSq9Rt9qE39N8sjHDVgS04uWdqZ/y4pKYCaJ1SqAP5o6CHCOmuPPTxaUUyMmPX0Ka/4jdtww26beOrcckLakRBUqN94RjAu+mi2daCZZwB0KAsetMUfKm307xdAcLuo8GJMGDsGpfeqhHPEjyHHoaFVs//wq/q8S+xwBu05LwONw6eHLFOgzjIFNKdVeyTrGOYl12dT/2Fpo+NWu80c9xqtJOmgrFilWYHhnY2cPO6Eto8vvZ+xNgEi47I/DzE8HKVMS2ZlnxuZXNuURGp/0KY1VIWhF7VoghvUuRwGiCuGSYO/gb1+lNdjjknQTLUXBLcadsaO39YwkZ7vnPIuAFZ3Q0RCqk7HDBLU8F5U5KEML95KLqNXmyBAv1In/dqfQ9zYpItMllM46hjy3A+4OQ78+Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb4c1ad-efaa-42f7-b94a-08d87fa27fcc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:45:17.9473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urEhWIMUbGl8EoaR24Hiprc2KEuX9StdMYenXKUG539q8mltu5x+SlntA/mL9BnwNdMqy+Z/mwjn9H+oUl/2Wg==
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


