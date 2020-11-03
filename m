Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7E5C4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FDC22275
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="grKFi/Ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FDC22275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmOC-0004fY-7l
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJn-0000mz-2n
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:07 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72]:13281 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJj-0007gm-Gr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpXZWxQSB8tHyeSOA1YWlTLUcRDGJ6/gt9wEh3JtRpaFbFdBK1JQpdNttPcRk9Uc2lqUW2tQvkz/O6b0jx8f5V1qtCOuc8idSNArZcVMxiTEmG0YOZZ42BrK/owzehTdvoASx0KCHHddkPM6ye4QuEFuZh+sCjPUqc3YAXdSn3Nvychg1ejxxchP2+jiuGVs0wWz5BxVySPPA+HwGR67SVRg2DtZ91eswFqCp4e8JwquQkMF7oe2FCX39RaAss7g5uK49xbNk4Yytzk9oyyIv4PbDa3ytkytN8kCBhnFI49HkEUZgzfsJn2u0iCNQkV1w70tW6S4AQR0XlnfiEx2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sIAs+TJldLQL+HX0R1AdIOP64eRzzVdoUrAbd0UWjo=;
 b=MF8uJHV+kvQdtUUN80DCojNAYyI5id7fHEdWb+4CgOIm37NkTIO20EB6TlTYAByaqfzJA6wI4BZsSxLda+h8usaU39Ye9pivCa0EMH1sCpo2hAIa0l8L1x2udT4uah6p8lkeYu10+ogDYPdYlHmK99PQheb6MH/5rUXSGvNb8mnKHsysoQsPMDCLFOxhscFON5uZWnB++nubqwinvlY9XjgTEyScyW73A2pvlXdJ5BHZEmhPxAMlLkCS8/Hq8Z9qLd5F7ogWk8oTZnuzJphQtsnf5x9VKB0+51aGqixMIYW1NM7nhGdEGm3aEAjy965Cehzbp16VX+B4apV4iYDlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sIAs+TJldLQL+HX0R1AdIOP64eRzzVdoUrAbd0UWjo=;
 b=grKFi/EajUKDGR8/SNfZTPZbiiqyD+w5K03Z9ImBKJMWEXNaAUUdCbWP0tnm1LevgQeGGLGu8Vnh6Iy/fDU8hhQ1d7fuSlucm05NFETfQPE/7iTz6jtRcg1mpxmDa0kmULJqBQbE1uaukXO3oL96TjLbHnNHoubSDCxoXg3LqSc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:44:45 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:44:45 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 01/12] qga: Rename guest-get-devices return member 'address'
 to 'id'
Date: Mon,  2 Nov 2020 20:43:33 -0600
Message-Id: <20201103024343.894221-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM5PR18CA0084.namprd18.prod.outlook.com (2603:10b6:3:3::22)
 To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 DM5PR18CA0084.namprd18.prod.outlook.com (2603:10b6:3:3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 02:44:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a563f12d-0903-48a9-a170-08d87fa26c13
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4311848AD384525A8607C9C595110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuDHr5LzKAxszBHdSNT5aPNk+mjQl0tHN9KFE36adNE2pq7wwG9xqTg2llk2FcRmAviVMPclk6xf2oNbKiSqUn3QlAhQ3XFLPIq24Jxetg00D4bsAh8fOU5HtviihkNs7pT+RRpY2EByLtmkuUaMGwqUiNvbSG55fQHOa1UhDtmkPfKzh+UPGRKwq3/cwcSXRf2TrwHdDGkrJZwcgTD5cnYWk9gMl7fCfeFa7CXYFdyZ2URIecaA0bKODHv1sr0Cu0TUWALC418Vs1zSqLNdGJj7szOcigQQE1qRuYPssK0F9OeHykSyUP2inP1zx+nxfx8MrwhEy8HV+9aonsj9jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(86362001)(26005)(66556008)(956004)(66946007)(6666004)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(54906003)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JgHDInxqoDjZYve+ZIXvrjxDXgTPNv4HlkK+myyuhd1eKhc4PxlT0i01m1SsdvwB4qF9v4CZexOuxznhsiPPJgJ8OahruoZOOa0kU+t/D0zxr7aXUv2hRt+mwF3ygnxviSoXd0ztSkWyfWwsjgQqQsniPW75HW3IQWTaFgr8VM2ahBnvMq76d49Ef8OXAZv2kVjGkAzFWEfzfQxLBfVl0jnRXbe48hPDzduDtj5iXoFMukppMmYlQgbFPrHcLjzD6hEAIl1dAs9yBDkDk4uT3rYEjcNM4/nkCHprTi0h5GYxhAoFw4YfqQ1sq4FlaHqvaCkvzkJ7xOX3UDGlKJvGUtAaX/LStUYRZJDAKczsmWEdJMnsv4pmdjgLNTt9gcRxsd1HxfQByOWGyaySrAcm9UFnvQKZWn+RBhOEJKQmqWA+SMuL+uil3nXbofHH/qjrN/ihbMl0u+0aJPE9/+xsmd8awLjzN3bY+fFn+lxwLvbXlCWwVEE7Fimf+8a7GwKa4gUPj0YA/0FUtHSLkg3G/mdSZi+L7TQikz6O+RhhyVp6EwMAwDp/6TTIZhfFhC0nGi/aC8YM7dcor0GbPhqdj5KSYTDg/k9ZJshsbyO0BsyhJgcimddGK8y7xH4qK+lo2xZFnUSFESGQh7EENsg+GQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a563f12d-0903-48a9-a170-08d87fa26c13
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:44:44.9502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8W7FPWN9FcfigvLbVoQvknmKs/LnC4nkCYlUB4G3f9roa+ZJTFJUVDxjddvyUn8aU2ao/SL2l1yYHyawYfxug==
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Member 'address' is union GuestDeviceAddress with a single branch
GuestDeviceAddressPCI, containing PCI vendor ID and device ID.  This
is not a PCI address.  Type GuestPCIAddress is.  Messed up in recent
commit 2e4211cee4 "qga: add command guest-get-devices for reporting
VirtIO devices".

Rename type GuestDeviceAddressPCI to GuestDeviceIdPCI, type
GuestDeviceAddress to GuestDeviceId, and member 'address' to 'id'.

Document the member properly while there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-win32.c | 16 ++++++++--------
 qga/qapi-schema.json | 17 +++++++++--------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0c3c05484f..879b02b6c3 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2390,22 +2390,22 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
         }
         for (j = 0; hw_ids[j] != NULL; j++) {
             GMatchInfo *match_info;
-            GuestDeviceAddressPCI *address;
+            GuestDeviceIdPCI *id;
             if (!g_regex_match(device_pci_re, hw_ids[j], 0, &match_info)) {
                 continue;
             }
             skip = false;
 
-            address = g_new0(GuestDeviceAddressPCI, 1);
+            id = g_new0(GuestDeviceIdPCI, 1);
             vendor_id = g_match_info_fetch(match_info, 1);
             device_id = g_match_info_fetch(match_info, 2);
-            address->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
-            address->device_id = g_ascii_strtoull(device_id, NULL, 16);
+            id->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
+            id->device_id = g_ascii_strtoull(device_id, NULL, 16);
 
-            device->address = g_new0(GuestDeviceAddress, 1);
-            device->has_address = true;
-            device->address->type = GUEST_DEVICE_ADDRESS_KIND_PCI;
-            device->address->u.pci.data = address;
+            device->id = g_new0(GuestDeviceId, 1);
+            device->has_id = true;
+            device->id->type = GUEST_DEVICE_ID_KIND_PCI;
+            device->id->u.pci.data = id;
 
             g_match_info_free(match_info);
             break;
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index cec98c7e06..f2c81cda2b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1257,26 +1257,26 @@
   'returns': 'GuestOSInfo' }
 
 ##
-# @GuestDeviceAddressPCI:
+# @GuestDeviceIdPCI:
 #
 # @vendor-id: vendor ID
 # @device-id: device ID
 #
 # Since: 5.2
 ##
-{ 'struct': 'GuestDeviceAddressPCI',
+{ 'struct': 'GuestDeviceIdPCI',
   'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
 
 ##
-# @GuestDeviceAddress:
+# @GuestDeviceId:
 #
-# Address of the device
-# - @pci: address of PCI device, since: 5.2
+# Id of the device
+# - @pci: PCI ID, since: 5.2
 #
 # Since: 5.2
 ##
-{ 'union': 'GuestDeviceAddress',
-  'data': { 'pci': 'GuestDeviceAddressPCI' } }
+{ 'union': 'GuestDeviceId',
+  'data': { 'pci': 'GuestDeviceIdPCI' } }
 
 ##
 # @GuestDeviceInfo:
@@ -1284,6 +1284,7 @@
 # @driver-name: name of the associated driver
 # @driver-date: driver release date in format YYYY-MM-DD
 # @driver-version: driver version
+# @id: device ID
 #
 # Since: 5.2
 ##
@@ -1292,7 +1293,7 @@
       'driver-name': 'str',
       '*driver-date': 'str',
       '*driver-version': 'str',
-      '*address': 'GuestDeviceAddress'
+      '*id': 'GuestDeviceId'
   } }
 
 ##
-- 
2.25.1


