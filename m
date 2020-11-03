Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2EAC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DE822275
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hGh/C65A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DE822275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmUA-00015G-S5
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJq-0000pA-Fu
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:10 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72]:13281 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJn-0007gm-SM
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOZIUbdS4xo0oR3AZXlxIE8sG9Clg4sh1sKoOtMpCPuz+lGKEx2iIHNbGT9jGQj73WW2pWw7QtDzc++9+LILQB7vRefs8yggzhQrtn8G/oYsO42GjJfpJaBOdFW5g1R9K6rTpZ14ipdqSQwyzfNqRSTHJToaeB0iwFg4yKIrS1+jTYG9SvJUI6AbeetR1K/DrZK0g+QiM2EJlJ9Oym99Uzv/9aKrb436SmROqB2qQh2gZqCJTcVxw8/fmAn069bz46YM5qAlVxudVMsAtHDYNaJZWCDmqPQ6oZd+XlYFfe+iwhpMtpnPZQ6+QCWcQtTCOInFL4OW6hs5KQoScKycJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8O8TEJqM9sAjKrgZxD2Qze0Mz6pcAyVSjw/Ml6CHMk=;
 b=EWnxPX0d/IxAjiVwypF88Sl4RQyn52FlNHa1l+80LzqmP5n0q+DwjxZo8dJIugApnZOrMjLMS1ojFtvKVmehAj+R6EATBt0FD7kLxqmB79NdvLqBMB7ciOTKS9h14aXE7r/hC2qN6arvzmbayJ5eEwKbg3dcReF+WsXsyCp4eSBOWmjivDwUm+i7EupJOC++Byud6sk54OnOCo/vfjkShOycAZOmlH+SJKiyY5RQoBGJH69aXToWNdF9dLjwdz2GxYejo9iXNExBYU3lZ6uDtsnnAlGxJn0h2iuGZZoefuNwmoC6wJ91dbcY/mMQ1c4/JNYaSdG9QCIHaw3vaKwC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8O8TEJqM9sAjKrgZxD2Qze0Mz6pcAyVSjw/Ml6CHMk=;
 b=hGh/C65ArQXQsVwSdy3H19AbAtGM1bw72L42DfDYPx/sCZ8GsuDfeQxFxqpbFtJPZ3gvLpZ3nIqRY/GCYQkerlH6/6Cp5WBILFXm51GE596sfG1mtvnPTyhh71rRWy8+8aoPaCL1Y4Md0D6U92RM1cdWDJs3ShIb1a5QGWhb9MU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:45:03 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:45:03 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 02/12] qga: Use common time encoding for guest-get-devices
 'driver-date'
Date: Mon,  2 Nov 2020 20:43:34 -0600
Message-Id: <20201103024343.894221-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM5PR18CA0079.namprd18.prod.outlook.com (2603:10b6:3:3::17)
 To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 DM5PR18CA0079.namprd18.prod.outlook.com (2603:10b6:3:3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 02:45:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f199e9a6-2bdd-4978-7362-08d87fa27728
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4311F078B2EEC1470D73A0D295110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:60;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxK1Wm2MPDL9t7caED1bd+H2kbz61M/qHE2rUnDLDCpUc/X3pTrx6laHLnWczlmpLh0FNTG9CmPQqvXYoLRXOEPKHnOKFDNMfsjXcb764rC0sr1FMEZQVEFQi0rgiwoOA25GBT/TNoc/7mL76GroJfzeKLtm4AZxDIt4IkkGtkLF2sAacsSb9tc94KkhM0tkyBKykzLlsisu6IPyxB3zeZBM1uIVuSuxMLbil4hEtDPDhhB46QcQeBAHjdL7XLQrg7kiCsrPlQtkBCtZifmo030GqlQrmnfM1TalwqgcaO2RJHfLOL6oF3MJGfYUNuBYqW6KkUygYCMQC2ZQ5+zagw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(86362001)(26005)(66556008)(956004)(66946007)(6666004)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(54906003)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lRPv69uxN/avIhEaFkUgkrF7HIU58tORi5OkOOZAuH1nuoV8FhcB4wjy6Xojv0e/3X0aPb+9LoyoOwJ5Tm6si2mKVOCTVZCvIKnNGkTVbfjxEMkzbidubEM9tWebxEQ2JFSodsbzc4ZW3qUTd/k4/VByYW6NpzkAoZLGhhbuufUVSil4mMUZ890ktOt67pNugjzx7R3zFrrmOLLgGUxroEb23GPboL4VgYM/6BpX0ftZw30D9Vk+WtVnZW1A0VJ1d9t4Gpalmk+uRTQbNBqrecTLEu3gjwGnGlgniLiCAZViTx5xsY0J7u6ueYtrfli0ZK4cnx720jJ8inAjwXkuNCVZ9DtUIKwOaEYx3k/Qw81x0qCjOEbKY4Xdy88h4Wh60H30Pm0cp8OL1gUxUzXpxT3viH/oYjrqLRJz5QFjiPij2O2LQNgOLuVlRT1AnP4N/bKyhxfNxfgdtSmhfmr/ypfc6ifN0WDBie4yVKWiy0o8xFpDyh4iUyKcc0E4+0CjgDK5sXMpHx59OuSSqFeSeMT+Mrt1Qrdw6NmnESYZG1DfV2u40Vij71+QsQ0zjC25v4jMo5JXaWgaIMzsO+Q4JDQXO2lOhxg48MGCoDS1QFYWo2hMaV4/jl4R0oIhlIHdkxeDQZZN4Y/Y0QbKvckYPg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f199e9a6-2bdd-4978-7362-08d87fa27728
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:45:03.5545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvOIbANsVO3mZOpatzUfBTMnA0eu3vkYenwCvJ6U+tqTfiwRuWxMHdmowAgz4sXNvjPWaPUP+eU2BVWHfASP+Q==
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


