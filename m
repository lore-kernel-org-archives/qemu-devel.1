Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF577C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9582222B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N1vI6kQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9582222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZl9F-0002AL-4g
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksV-0006Yz-PH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:51 -0500
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com
 ([40.107.94.58]:64832 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksU-0005WU-6T
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxmDMFLEnwCQsSFjTKmI7rwvLbtY8K6ULEqlJYJnUGtPGq9GXKOkzq/+U3iti165pTjMfVqoxpo5/1uxyE6WYpstJ8SlYGr5EFLQJWByCcpWoOYL/WXuSiytFFqjWGoVZd/B1A45IjNweiSe+n2fyScZY0CloguKLqgo5gVjt3TbSCLARVaoI97UWPRawAcsDY+Ax6gtSqQ/P9p7lOoQynb4cVE+EY9KHdGtO0AmYhNtKhBm67ZYuwouLoQgPOugowimCOe8egKgo/Iw4SkwAuMYkYpJxeJPEK/fZdXI3H7VLL5t53oE3/P8zSeYoYcwmgCR1DHnop7NxS1OstjKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sIAs+TJldLQL+HX0R1AdIOP64eRzzVdoUrAbd0UWjo=;
 b=LILiTc7Lti37a7lIsXhnnonbRcUf5lW16Ir5ikj6W2TbHUir4JHG+VKSPqS7PlkXnEdHIsU9EdUKyn53MqAR4BQak+Zj3dYSDqgcg9goFIjJfBmbx1V9DQBq6cgHqT12y5FIcufBwqAmGXkSkFLYjNlhMzir3awWsGJ8ogVxBvPzvBy6v6P9cFp2dfYaMHxDoq9YtwD2CNE3J4IuDJoRr9GJlBoY97uSw+IPyV6c3R2dp9sa2TjW95GUVEdWIshz2Fwqr18ZB7wohq9KD7rgtszrOoUt4SwbEjSJo/BtJYtZZ1cVUIsv+euukJZoKo1ZeoyNY30Shng2pSYOe3o3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sIAs+TJldLQL+HX0R1AdIOP64eRzzVdoUrAbd0UWjo=;
 b=N1vI6kQ0BiMPQNLhBaT6cm68lwgXlmlVm5jt4NEjwc6OzTxhDGzqn4uc6848jlrk/GPuJXe08cWHfoN/Ye0K7bOSRNv+d+8gQmFzTDwPA02xGC5JSPXwecDzub9WqwW5e/SzyjZUK1zs5SaTan3UG+Q+txEGY31J4SBNgTupPWU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:21 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:21 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/12] qga: Rename guest-get-devices return member 'address'
 to 'id'
Date: Mon,  2 Nov 2020 19:11:23 -0600
Message-Id: <20201103011134.887744-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:806:25::24) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SA9PR13CA0229.namprd13.prod.outlook.com (2603:10b6:806:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.10 via Frontend Transport; Tue, 3 Nov 2020 01:12:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9fc71738-e445-45fc-533e-08d87f9583c2
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5001524AD343312F65AEF6FF95110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE66Qskuo0zQDcSd/13q965q7dAkLJpXqpWdU3Q60g7GVVxA4sBGdscsgXdeH5PfqHaFwEgnmgYskZCeC9niDKoCEsjArQ290cc6ZRmU7QmA7SBvMnp/zQOx5goJQdlNE1URRouYdw54YFsmEBW47vkpJ1DzbpjXkO5L2eNo3XETn93LdGXO8MpSLuVOrJQCuVDWy3eW8Gjy1lTcR+diM4G7UCuL/ld4lZ9ChLULE3NfOuIoW1ffKywQ+Wn4lwHbtZJw2n7p+RaAy+X8zA2apLV0UDxJUtfAtdO8DGO0alA1xgVD25Khpx2ghTOGzE4QSwvb/uVAXsj0x+JhhxWIzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(83380400001)(4326008)(36756003)(54906003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CovVqaiv5DMleMjsQ6LHcd2nUrDhFUjbyM7EjUPTdlmUBYUFrJ68P/0WUFLTlKChu3I8RkGyxZ5WgygHwnXMVuwbLMMK2PCZlhJ3ZfzjjMX+fSOsrzlpybJjM8FFu9hntMQ2AtoSM0EvBswBnyeNCA85pXK8yYf5u8qD6640xLhO3bpKBOcwJutEBnNSjro3gV/H37ucA4H32iGmmxvoYw0Kw6+++0SYOdoJNYxkzO9ZYhVUsNfPP8o1LnBVv39NneB5EoSAZiIZjDp5uK2WfuowP+iGS2i35O9y877DiTwFw9xnpv4PnoYKchsDfju1VzHzCM73Mkqpx4HFrbhx9wT8np7lRzXJWDPRIkvJI6480fMBlKOp0uwxXXewwo7la+l5Y+mkLr++kTmTTyd2qZVAL8fAGJwM6aWB5vZJs5N6tYQv266RXiamqOVAajaRB5tap6JVetMS9gmMvXFUG5wMK3WoXlMJk1jFxbNX72A2N3aeQxyvd/p+cgrNgfOUCQ5+Gz+gpyoLKwi9icJAMZYVvEUgHEtFqyPznyBycQ+U8twlFdkwtew7P6gOQy2qZKI1je/FBU6rQhA2nOxCZVbY6hl4Hyt32UxHTWgXHLb/UvTFHSNZLL2v6LctCtcKtX+hU7nc1l9M0aB6FH7ZlA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc71738-e445-45fc-533e-08d87f9583c2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:21.1923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8qqt2klFEa6FKHIoctakupewKNOuxDpli3AulP5HNbD2WWNnmYx8qkcW2NUkS2TUoY0OWURd36AnccmFionRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
Received-SPF: none client-ip=40.107.94.58; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:12:23
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


