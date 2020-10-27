Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185ADC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1EA20738
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h2YAOLRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1EA20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJiW-00024H-Ad
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvj-0007Hl-5Q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:59 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvh-000447-KL
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8FeFhKgTzWmtdhQa2LA/CwsvuFv6vAl9uVUmEQVhnTRWi4HIPPZDXrmfjNvO5pj3FE/k16zryErqPyLVM5lEid+IfvWvd4a+ymfeysJVM4MaZr7kxfiiXlalAiQ5IIv/+qKIlO6NtD/HoQbTq6lqxwz8Eo0nUuEuhWu4sI/2diSQ7qkZBxfXob6Lz98TyAaHsvK7gRPqTCnbtaA+9aVTqcsFzMkVKp7Uxi2NaDzuW+80p8oT4yNWeB+gh9kW/ZIExk1VX+hXrxPevSoITiGFsovpmFQUszwvDKKtG1cyMqFjMs0vLg4PFhsVq7Afx34Swfx74+znZuIsKA7/U5jkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8O8TEJqM9sAjKrgZxD2Qze0Mz6pcAyVSjw/Ml6CHMk=;
 b=jztV5kZ/g3tKUVr9cjtitKHtLEMLwn+YhvMXYG296L/ALh3HJI3WB3NkXjbQ6iXbb7pIvzOcpY7d6GYpq2sWxjIcn1Hmk7j3YykGpU5ufygFTOy6JZLvosxZ9xYWm6AucsCpS4tKjf0hUHOeEn6ky3I5gze5ESJEFkWSbbhNBsAOb7hkzurVCDM6kSEEfRndIxCNs5IyADBq/JGgBtPxQH9Fdr4d0P0QczYb3MhHxRIcHcchY91nqVSNGJ77A8Rk31qQuNJByd1opYSIzB7j9B+Jm5YU9cjtU6tdMKveKNsQkOcSs04oPGL6PBUO2KY/oiA/RWSfc7f8HtuMsW5BLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8O8TEJqM9sAjKrgZxD2Qze0Mz6pcAyVSjw/Ml6CHMk=;
 b=h2YAOLRRcEVwIoknvxYgGYPhDIkgdJypqBeU6+fMK8whYRNyU522LBdwur+wNbSEeSgERT5EkaoccwffP8uyp/sNNSckz4bsoaiuvMQbH169hHHbq58IsX/g/Gn3YGgTq27Fd1/uyLINYE9shGQWdysFUCo96Hj749Ov78EXomk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:45 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:44 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] qga: Use common time encoding for guest-get-devices
 'driver-date'
Date: Tue, 27 Oct 2020 00:53:07 -0500
Message-Id: <20201027055317.351868-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN1PR12CA0101.namprd12.prod.outlook.com
 (2603:10b6:802:21::36) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN1PR12CA0101.namprd12.prod.outlook.com (2603:10b6:802:21::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 05:53:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09d38608-5b6b-4015-8353-08d87a3caa4e
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50043D46BC6A226B3EBC44C495160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:60;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUqyjglyUViEPjaKS4GD0wNENPkwtf/ZJWRI6gZWRUcdMoip76OSF9pBdxCNMl2HHbZG+G3Fx5PnTB0BE0JXFGh/uCTXAtiE7lmMiv6AfD0NzGmadJYOd8oCN+HDWDDhkseoNGgudPkULiKWRyuSxyyk8QgP2cAkI2Top8VNfeGBK+QyA/Oz2g7odyf7bx8CYZHMEYIHSdr8pA2Yjwhd9vYbEwMEXiozyBgZe4sxuIUIb1CUyhyDrejyfTKQfEiC10jS+pL0FzQ9S3KudymwrshoflrybeThmYerylBazBk1/3ujZTOTwCKnhotCLt+07d6KMzW9Z0kfLUqrEFUcUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(54906003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: u+QLjzSCtHPuQfjMHXJI8Yd1qpbNJdA0eAuBSMF7kaRZ17WlvKo04HdjjBXOLZjS63tggzK1SFC546bPig1VpOSXlseCeV8wy4d280IMzsfi2j9gYPmz5OYYg+ZYoiCKMEKDkyn0H445KofTVQEO5ZgJXK4DgLx6VYSxaYUuW6TD6WKnYsVS/30ZjGoALWHfCB0b/fmadgBv6NNJLsc18AB9/lC+QMdJk4XSza5w8GoferJcd5tjl+RzO6y8MOFpxtVf3uHNMgPgi1BGYjU7Y/x12b3A2zf9AMNwPQopGK65P60rsYUU8dQfnRwECFPoinMRWUnpqsJfw/k68EQBLuJBYGQpAfjY8HhwVdk8Fk1H10+cJQRzScQEraWsr69CPcI80TleqGXfdlqwPtATeLT2M4bpDQE2eCV63yPQ+1yY4M9s4TaXLdRkX0sH33n8igs9Q5Fc4O3iTk4ZAemwq1YguUWW+CW8NRnfxM9/whiBW8x73rhpMMX8s8ArmNggBO0XKWFAWqV7oufjXxprkPSg8eKQyzkrjffuyQEYFOxvplhu4gThSbkz0gnD7an+hG7TabR2rxjVtPObYJhrMZSZbzQmZ3PW+7zAaG79OQ+KlUh0ImZWyALFHPHCMpjcW6sf+tbaljmt0t5dkG26Lg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d38608-5b6b-4015-8353-08d87a3caa4e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:44.8775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ALpX/kV6YaiWMH1aQbRIMGV7bT3YCNK2wWVdaAxpOJy/dsqIZgCS1U4HQCu594+ee7DCGINhIxKfNTBkg+Q6Q==
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
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:44 -0400
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
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

guest-get-devices returns 'driver-date' as string in the format
YYYY-MM-DD.  Goes back to recent commit 2e4211cee4 "qga: add command
guest-get-devices for reporting VirtIO devices".

We should avoid use of multiple encodings for the same kind of data.
Especially string encodings.  Change it to return nanoseconds since
the epoch, like guest-get-time does.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-win32.c | 19 +++++++++++--------
 qga/qapi-schema.json |  4 ++--
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 879b02b6c3..b01616a992 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1641,6 +1641,12 @@ out:
     return head;
 }
 
+static int64_t filetime_to_ns(const FILETIME *tf)
+{
+    return ((((int64_t)tf->dwHighDateTime << 32) | tf->dwLowDateTime)
+            - W32_FT_OFFSET) * 100;
+}
+
 int64_t qmp_guest_get_time(Error **errp)
 {
     SYSTEMTIME ts = {0};
@@ -1657,8 +1663,7 @@ int64_t qmp_guest_get_time(Error **errp)
         return -1;
     }
 
-    return ((((int64_t)tf.dwHighDateTime << 32) | tf.dwLowDateTime)
-                - W32_FT_OFFSET) * 100;
+    return filetime_to_ns(&tf);
 }
 
 void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
@@ -2363,7 +2368,6 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
     slog("enumerating devices");
     for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
         bool skip = true;
-        SYSTEMTIME utc_date;
         g_autofree LPWSTR name = NULL;
         g_autofree LPFILETIME date = NULL;
         g_autofree LPWSTR version = NULL;
@@ -2434,13 +2438,12 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
             slog("failed to get driver date");
             continue;
         }
-        FileTimeToSystemTime(date, &utc_date);
-        device->driver_date = g_strdup_printf("%04d-%02d-%02d",
-            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
+        device->driver_date = filetime_to_ns(date);
         device->has_driver_date = true;
 
-        slog("driver: %s\ndriver version: %s,%s\n", device->driver_name,
-            device->driver_date, device->driver_version);
+        slog("driver: %s\ndriver version: %" PRId64 ",%s\n",
+             device->driver_name, device->driver_date,
+             device->driver_version);
         item = g_new0(GuestDeviceInfoList, 1);
         item->value = g_steal_pointer(&device);
         if (!cur_item) {
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index f2c81cda2b..c7bfb8bf6a 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1282,7 +1282,7 @@
 # @GuestDeviceInfo:
 #
 # @driver-name: name of the associated driver
-# @driver-date: driver release date in format YYYY-MM-DD
+# @driver-date: driver release date, in nanoseconds since the epoch
 # @driver-version: driver version
 # @id: device ID
 #
@@ -1291,7 +1291,7 @@
 { 'struct': 'GuestDeviceInfo',
   'data': {
       'driver-name': 'str',
-      '*driver-date': 'str',
+      '*driver-date': 'int',
       '*driver-version': 'str',
       '*id': 'GuestDeviceId'
   } }
-- 
2.25.1


