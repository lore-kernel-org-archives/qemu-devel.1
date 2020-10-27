Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D863C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CD9206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IbveM5vK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CD9206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJml-000860-QN
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvh-0007Et-GB
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:57 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvf-000447-QQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwIj1aAbvAKpQVPVoFMqj8hFI04KQv6e8rPeEiC8zHBMY9hDKagn3WzmSlQM0xk066luNJI67sooA3NbZ6GcY8loF/dcPKRgNemCzV+403829QguQBU0FKCWfxC8Eh3OjXD5qvQ4IsUQhbynu/gunJCwDv9xU1O+MyKmkw5HORjdcVgRKJMiQJX9aDlWVgWAAnTZDqgiJcuTJwRr7DM7ApWnpa5u/JpgYZ0eY35TF1WuGJgenC1xslY5gLMe+J6wRgwm1/DSIo2b4YC64VRSIscuj67Vr7mpGpdMC6RzeZ9aeOT9VPF3OrlqVACO70zPykbq3Zp6z77gMQ6JOW2zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sIAs+TJldLQL+HX0R1AdIOP64eRzzVdoUrAbd0UWjo=;
 b=PUfjMX1iKDsM7ZCePmg+s3x5SxbP6F/fTp9cbFBMa4AhdlrynTIreJmXwg0YM+A4mUEpQISRw5CZba/R5B0JcdA4E13l7uOCADuePah6DIuCjFSf3gkLtwUtNyIvFFKD7cpFgXOSuhJCc00+HW99oGmYwcYRP37IBDtL5J1YhhsNJVudYJHFXyMBvdvNqjQ3Cefxo6z7zWNC+eVW74h2/w/3Y0PMRijOm9Nf+xzd/hDb8gFu2ZyWT3/LHZpBBhjQHlsOvrI1Nu0r8nsnajq2VfHSWkfiHkg2roamdMhLZt4dlNp2t8sI+jnhKqbZWoZTIzrrZRC9JPoxD3pw11cPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sIAs+TJldLQL+HX0R1AdIOP64eRzzVdoUrAbd0UWjo=;
 b=IbveM5vKrLShqiwCeNaJVpfshYpOZ+caCmQvXWnDijYX6CTZXspnklVDYX/Xmw8/wdCHUgLKwekMBZZ+povD26BhGZ//x6XlbTiT4nbill6KD1rN4Bg2SbOm2cMGRSkMxC/a2LCoVM454EUT7cYxF7OO+9LvsLrGuLq2nc1QG4Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:43 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:43 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] qga: Rename guest-get-devices return member 'address' to
 'id'
Date: Tue, 27 Oct 2020 00:53:06 -0500
Message-Id: <20201027055317.351868-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN1PR12CA0103.namprd12.prod.outlook.com
 (2603:10b6:802:21::38) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN1PR12CA0103.namprd12.prod.outlook.com (2603:10b6:802:21::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Tue, 27 Oct 2020 05:53:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25bb597c-0e92-4c4a-9651-08d87a3ca97a
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50045CB6E12C8E864561C3AA95160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gk/QIje3EgZnKcYoFX9gEEl+FwUn83LjnuiKjUUGFl7TKCBVBXiZNQ9NJgYnvTraI/vMLAB7q77d4HECXVpg0agzqeujTNXtVmkdd7NtAXkv9lt6sYf/vAMbumQ1sd8LEcUGPauby9qAA/GOu/+VL1zOoG78v7yL4MJT8AP9O45GvBd8pji8oni0MK7nKXzduPhhAhLnQ+51W9c0qw5i1/LlvAG9CIiYllBGmwvRejr6o5479WvtkW2crCIYp4gpc1UUZJeXh82hWXDHy4n1oAk21kaR0yIK4AcduPNZObu2p/EGZ3R8oqF/k/bKimbEi4XCPwSyawHcA/vu+qcozQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(54906003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CuF3pb/twRrROZ5jdvqCKGaisTtguL7JvQ0h0vBhL/k1pOGiPgofqF+gzgu9UVrJr1uRsr/jfN7bFAXbE5XHyPx6Mpm9cmT/KRQahxKQz7KeP8w5avITqK+wc4k1fPkUXtw2mIMf7ZUm2kIns2XRjx/zVOeQIy15p24Y4JFUIF4hY00cpWIY4LKBMtuvYSzTxz2AAJ0hIozPCMMZTRciW5pT9iaG7Fp2Eq4oXWX+hjqlwR7LZ2dgM7LlC3pRt/IDJbfAEQBKV2BqynXiPXLa/1vZdZS59ohkYstTx1KZsiNGLssJIZ6LbsV7ffjnpa00PwrESn+tsRKqKCQdjkeeLzI6xiIo6lJFvk5SaugujBjnA8Bx9GvGzBy5a6SPNSi/J+92tefirkcXyyb3f+ZWr7MHycvCCQvgB3Kj5yhu6iqY4h+h3gof36OQCb98oM4tCuqmdY+Mrju6ZsiyciILWntetweJYh8SrEN2xqUaj8P4p237xc9bj+s0aJxq8dGye/HmJHBRPs+AmcPlpj6zDRnp3RIqcaDCDHkRxvvKfOJUIJtZNo6ZsqX4KdrFHDO1EZQ6XvbY+7pOhmUB8ViBx4ZTZpZOHR5MLJKPf7cJcxV/sYvx+FU1i1s7vG5MVX3BLe8QCz9Siq5ANLVXQERfDA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bb597c-0e92-4c4a-9651-08d87a3ca97a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:43.5075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTSombhVo62QXCeRG5n3d5hJaSqO4EfVzZUpajzC/HgZlrqfdF4L5/wuoycAi6wpE877S3Io88ciQxigRNy+ug==
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
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:43 -0400
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


