Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0724C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE3820870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rQljEs4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE3820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZkw6-0008P9-AU
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksX-0006c1-JX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:53 -0500
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com
 ([40.107.94.58]:64832 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksW-0005WU-2S
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTqY3kRWKh2Dgh5mBuLPfTGsWMsD48ATck8O2qQsa2c5xIRV8mTXqsxiSGb/vlRIhHc7vZeI7xdS0ZUToIr51TLa7oOnHrP/EtVLumPr2FqZ1s0bXHn/faHAP0miTo1as9a29b7mhF+IeOzkiHaltvV9GNpfZ6BH8whj7An1AzzThfyVt7e/XN0jsAX0P4UqQaUVicnZui7LoU8u1ngpldnA7ONWZIQ5wj9FpCOiHkpEpgJUaESz0LfDYnaRCZDusxoXW4HWzN0YC6aSRyCkdLZ/SsPvgZDCJHMmPpvgeADDrxqTTx/jvDBvIc80CLHCSCqjCiLiegSI9pMocF0Xgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8O8TEJqM9sAjKrgZxD2Qze0Mz6pcAyVSjw/Ml6CHMk=;
 b=PxHLEw8a7v01EP75fQB+gFUWaGUiFYQirn0MayZDz2HeAiTM/NmJ7taAWGvlhoQO6RzeIVnvhE99mCWZWXkOiotSNWVZWGIwpMfU11PP8kg7gupYS4VCbaHFhO0xoLfwpJLJ4rwPBwAgfqBs8ndSMH28lrRXs2E0qch9CLqEnYPSNjycnocwVufmI6sk7bTTSIbrLCbF4Gb8WB99//RwdI8EuR/SS6bX0dFT3IUbVp3yqas8ms1SLZhfZmup55W3onwc4Huo7tIlPcSFfGxrZtgKGyc/mo/0qD0r3YLMaqiEX+yWK7Uz2Mgf6mQZLTc8Tocl8vQDKTMT4QG/Q6eH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8O8TEJqM9sAjKrgZxD2Qze0Mz6pcAyVSjw/Ml6CHMk=;
 b=rQljEs4IpQD2cUiY6OyDPpHNrXzMScfVthK8ETbCQ4c+gvjvnQDjCJC1IVShatlwRyRHU6jrr0Zl9ti8WhsPQ/MUjw3owFEMQEHEv3Jm6B/NcaRS7s+wvZG6mkW/VNVPnLdIyWq6HHJeWpvt0uUpZkMBlAopZC/B8ydNrsLeN2M=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:24 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:24 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/12] qga: Use common time encoding for guest-get-devices
 'driver-date'
Date: Mon,  2 Nov 2020 19:11:24 -0600
Message-Id: <20201103011134.887744-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:806:25::21) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SA9PR13CA0226.namprd13.prod.outlook.com (2603:10b6:806:25::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.10 via Frontend Transport; Tue, 3 Nov 2020 01:12:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b64cbae6-7eaf-4652-f9f6-08d87f958598
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50015C99BEDCF20AE4077F2895110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:60;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EV0LKqNhghtYIgFCL4mbqB8Pd7dr+lnZXOC7ksfVqhljxs8M3K5ANO1FW+55oimE0C+IEMYIBsPB2FaGjOWAbucm9LMOEo3uYXw3ST5Fk1h0oG6CUfNPmXDQaqHFBMqqJtlRtXrB/701EBMf/47SOYdutHWHDI02oj/VVx3fHlzlRtc6hGGm/RQkXWRggMZe13gPXOg+YEksrsH+CFAQD0XTDOoCsQZkQnNxjxsayEqvMo9PwH8ngnSPx6LLLCSvK/sETUhokK/c55kI1+2fZRiTwZr/xwDfJ23zgJbpvSbC7P9SS/3lnmdygywgD54vsHR1shB7sRxn5EjPaECnpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(83380400001)(4326008)(36756003)(54906003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HsVhfMtcvLbJZySQE5nw7C14PvDjhXCyG/96Bv3FG8H/oWRa7azCiB7BeAysStwkYuXJqBmulPuVQuTfBf2GO5v5b5quN9rOE7e9O2TQ1uYGI8AwCN1Nl5WO+Qf72AoP/ChBfQ7bs8Jkn1qGw0jFLHAv3bSBAIrDoKPeZEDy/d5gIMmC6adMNhwfrrSJlssBc+HFB2oKe+EogZHUiFh0ods+PcfYMquLe0x8xXxV24rQEzETYJoHzM4DoS3R1dss+VnCnvRAbPdEpNszAzBmivJvsCDOE5l6jPZDklfCLLQA/FFIOe3nsorUA6sdi4/BVSP5N/12MOg7c8qtdtgK1zb6AewrNhK2c17g1Owm/169Xr+CyOHbVtFR/jAIpMOZEXNWDnZuHi5fQB1dPk8KYawhje5WMXF0JuBIhOgfmPL/IOk/ck0irxR6Svwi5edf0uAchqc5uTScENxI8FuxSP/6zaFMwEom1qUl2pI5I7sOJAcfRBdxaiRDjv9p+j+AUNf0y7pi1+AGGgSYVAdJNvVL2+arOo2C/vgJEwezkE2DSyrPRRWoThSQTqyf7HEf+t70+GLSV7MK0+fWA2K1EK1f8xutYKsRG78VcG4AKR3UmMk8qcjvSNYcZJQ+MneTEFsTb+iUSkgJyNMSPLoduw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64cbae6-7eaf-4652-f9f6-08d87f958598
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:24.3435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYnXiv8rogEWI+xD1gy5DolQOXBHrJFbW4BK5BgGmJUTJRElzfi6tyDq9CS0ObtdjmbtxKj2mjO0Q7dnnTv1Cg==
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


