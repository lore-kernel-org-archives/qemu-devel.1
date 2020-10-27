Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187EBC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E37B2225E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UJKbPKZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E37B2225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJoY-0001QV-FT
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvk-0007K8-Qg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:00 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvj-000447-A0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSgjNeQpNVwuJ+o4ylSZ1EmVOQn5SeY92T3h27fjisAOiRHgiTRy+0wtHKjgM3mEYmkOYTntW+7T5RstFORfM7bB1HWQP0fEHmaGGisXs+5m0/auvIb4KwnxWI6o46jQ6k4VoYmuo1mekL7/dDXLuQRMSeyv5oRfvwzz4tiJlT5ajJxTqtUEP2sksE9V+skSrOM7XdlK69Y9Wo30dfpH3wHrw6WIxRaG7HJchY6hl8hNKzL1/VoOKUAZHgydq4B9rz01FG+Iqo4uWA5psFP4Kz5WBxamoZIPmZ39ah8cuIeLMQzuJBIb5Nz7CykiZvCToNyaOvAh2K69bPKfdWEszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVOT+Ji/XN+UthHk4J8n5dOXuOASmrPvPQAuUjq7el8=;
 b=HL0ghsKEkeCz3XbAid8p89NyEpsk4DOmN5sAtb/yxtegDElaHgE4fFRMUwV7XQtb5wFy/cYjx2hju6RXbThkOicndQDSBvHs2dk6Cv8XZYp5OMiX9v9JbWVPcUaDXk8Am7wbB8jB6LfOjkWv3iSTIIZ2pfUR79nkrAUJmZhqwtPhEqMvMXstWi2/asF75bcDzUoAxY+I5LD4X386e+2XdT6Ws9MtCUFazhR0gbHJhuUgujGbF8XqblPgmrvJ4Y2O6nCktIcbASVPlBR+SFN9hQMmIJVyGdsg3FF7aHX5YOgMiPLDwAm41R73+qR9vjwZH+r85CWX3FJ6Nma0ERJ7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVOT+Ji/XN+UthHk4J8n5dOXuOASmrPvPQAuUjq7el8=;
 b=UJKbPKZ+3xDWQBPzP1+TKXR+HJkBqXwGMsSnjxKy+DqBCiGgUkHEvOPObsl7F7qHqIhBMsK13Y356pkP965Jz3x00zuTMQSZFxfnkKS86Gb6BAI02KcfkLbrnnfhrAlRU01Bh4A4oKKnbeOxPH2bZFy4SzHV+ZyZ1yCaYpbNEbc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:46 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:46 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] qga-win: Fix guest-get-devices error API violations
Date: Tue, 27 Oct 2020 00:53:08 -0500
Message-Id: <20201027055317.351868-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN1PR12CA0091.namprd12.prod.outlook.com
 (2603:10b6:802:21::26) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN1PR12CA0091.namprd12.prod.outlook.com (2603:10b6:802:21::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 05:53:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de5cd4ca-fd0a-4756-6b11-08d87a3cab48
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5004BBD98B79D11BE543E22695160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt5w/XGFAN8DnRnE0MJQG3p68PHxXEeoUeowe99ycGxyPuMG613Y0HVheJ9P3zgQkUHVWzBKlZs3IZPfiumq3slHAEjgZlnx6jzHCeq3FSwhor2k7pJpgf7mJXpbx7lyQD7E07kz8Lz/gF4w9ymYkv8GW2yisQa9wARnDOsuXj6GjxMN0LD/D76JLEbgUkhrn3swFZ96nFFrJzgI0eL1P3aQz3dmxCa5NRjcNytSPC8RBut8SpuGilKgahUJIQ148lvDJZtUmfKcv5xSlgLMo32xpFfqckunnsJp3OAzfjLYGNYQPe6hflILKMma6mkS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(54906003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SsRRWHhjRj6vxl5mQtao8Vh2PsA3GxLS1qS2A2oaokD6cbi4SEdWUQ82sz8ajoTh4Lux+88DHBPmTupka6CCEhYU9ECdo0SBfqQ2QSvCX0Q7jCR3vsA6OdiUsUi5JcbhHOSRg7kyt9XqxWhxCEw1cA2teJjA4THqdxPycxusPdSgPgn3qRWPyIICkiIQ7B6FHi8nsT3LbvUzPHLvm4FtjIcqvfJ84+XRLfIH4XlRiPyTyfTZNks/KRVMLlm6UbCYuw6PS6Z33Us24rvNe+AUZDpp89097fwhNCokemQO6X169m0C8aOax5kzlIExa8IOWxLNyc0ZR4W+pItmJb/TmpKl6HprI9fRqKhwB1KOmxBH/AxnymrccZHc0xJ2L2Zg+SOGz+qsiHmVaWaOwqeXy8ac85/0pzvl8MmlcBFzay1daGIUH0zFB7cZzs8VX5hl6EH/c02nUxIo95UaHp5W30hLXpOiUMAeSz1xO/KqL8QqJhYpsiGDDY3KWjUBevbRa5RmQn3OxSS7v7h0c5XOpBQDS35QnKcG4ng2xWrHcUxxe2GBXYHK+zbbn+y0homkEUP9DzqE0KoiAdbc+wzrzmCCFu8X6RhC36Py+43G4GusbwPYHD310lBG9WUdFWnbDTZUkNq7vS/VTV06NJ8vLA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5cd4ca-fd0a-4756-6b11-08d87a3cab48
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:46.5142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/6JTYljWsdm29w7hVZFoKScV9K5rUxRNuaqEp98AIsw4Ydnh9L2BkVEYqGwlu3fmq45gB9rWPJTJASrk7an4Q==
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
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:45 -0400
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

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

qmp_guest_get_devices() is wrong that way: it calls error_setg() in a
loop.

If no iteration fails, the function returns a value and sets no error.
Okay.

If exactly one iteration fails, the function returns a value and sets
an error.  Wrong.

If multiple iterations fail, the function trips error_setv()'s
assertion.

Fix it to return immediately on error.

Perhaps the failure to convert the driver version to UTF-8 should not
be an error.  We could simply not report the botched version string
instead.

Drop a superfluous continue while there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-win32.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index b01616a992..1efe3ba076 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2385,7 +2385,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
         device->driver_name = g_utf16_to_utf8(name, -1, NULL, NULL, NULL);
         if (device->driver_name == NULL) {
             error_setg(errp, "conversion to utf8 failed (driver name)");
-            continue;
+            return NULL;
         }
         slog("querying device: %s", device->driver_name);
         hw_ids = ga_get_hardware_ids(dev_info_data.DevInst);
@@ -2428,7 +2428,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
             NULL, NULL);
         if (device->driver_version == NULL) {
             error_setg(errp, "conversion to utf8 failed (driver version)");
-            continue;
+            return NULL;
         }
         device->has_driver_version = true;
 
@@ -2452,7 +2452,6 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
             cur_item->next = item;
             cur_item = item;
         }
-        continue;
     }
 
     if (dev_info != INVALID_HANDLE_VALUE) {
-- 
2.25.1


