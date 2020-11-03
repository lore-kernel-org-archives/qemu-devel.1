Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841FC4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49AFC22277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TIJwx6HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AFC22277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmRD-00075e-5V
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJs-0000sd-ER
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:12 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72]:13281 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJq-0007gm-Px
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdrdTrHXkhiLpOegsCIhAYtjf3m94b9ji4JvAaYCXElqYiv7xCVRMfzNfQi5+5vIKSSlW2IW8BEw0sb7H9JRBuERuv9JlLoBboJjPBekRF+8NZoEcLZ3DH7K7GbHzhWRZEqqmX8oGa2ZDN9wP94umE6q9R5ewRr7K4UeoFs7rfHPvqOKjqIU7plUxBi3bYclYEqTgyWF1xGUcjfVqbbLmbblvW2/QyOOOYl/DG1PlOoTkB1yBGfelmQsyogVQhALlxUl2Dl392t14rJntct2ZySUPbWqEGjTRvizzdcfouTir++n09VcVnGzOsknSKv0jlYYt2SGH0j7q7Cx3zsbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVOT+Ji/XN+UthHk4J8n5dOXuOASmrPvPQAuUjq7el8=;
 b=K5X65DiPYi8QRL1OzvKEi3bge6PulJ74X63qH37ukVP62OYQss48ZVmyDWjrcNtsAWpYjIBPM4XnVNd0uVAtmoIXlEN4mCTwQ+EOn7wp0rkUC3LYu0CeCPvYDqQjMdzGpwi8x3qkWgNaeGDnC4My9gas5SyNslgIhmTWj/pZoprzNzTbzbhkpHhR/lTCS4u3mbMBGTUITFMBIYnmJhQ/k+Jy6GsXhckbM+1tt/EoY05tr5hsKLZ4+4mqJCCZ2xRAKoILcsvexHYdCIr1UnFnDpnmkvRoXcbbr2B+MlpMwk8r3Eml75eb2W/P1xXyHcNh0YUzHK3VL+vyi95GEIcaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVOT+Ji/XN+UthHk4J8n5dOXuOASmrPvPQAuUjq7el8=;
 b=TIJwx6HDzeSXwmcFcXUamek1yIids8qt8/hdwtoaTbhO18OoHlZX39Bicp9FNytECafdtHA6njGI5C+NlcVwUyNxdiE4xjTyfMewL7n/yVJAeljJw+SVSPCJ3APHeyVltetwc+xHcrZkmhCJElXdDG5AU/mwHWdv2FkTtxnf33A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:45:06 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:45:06 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 03/12] qga-win: Fix guest-get-devices error API violations
Date: Mon,  2 Nov 2020 20:43:35 -0600
Message-Id: <20201103024343.894221-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN4PR0501CA0070.namprd05.prod.outlook.com
 (2603:10b6:803:41::47) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN4PR0501CA0070.namprd05.prod.outlook.com (2603:10b6:803:41::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend
 Transport; Tue, 3 Nov 2020 02:45:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6312fa0-85e6-4f76-9825-08d87fa278f6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB43110D3B7F44794FF7CC876295110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qroMHNzFJXn5XshgiiPsYybM6YGdombIzd5ne4maAnVgSzJ3zIts5JWKg2JwtzCfBcuFPdpmuChUegwAhMz9jsYzIVt/Gs6FkZ4RRju2fLvoCmzi29nM8kXxX6I/6g0rxS9rn9jC2SF+U7DP4fE5ECo+FCJpbJkjUsICFBEOEOPH1RCDADBaGNqXhcDr+rCqAE3tts4KTs071/z+279EvbvGViLdpLgFuWS45SnHwvfH6dHohARzM/9jxrxaOm2syxDVq6049Eqar86B0/GnTlf0v2PfZ+q7WS8kcqRIqTcpAVyvSweH/6+wfOab7So
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(86362001)(26005)(66556008)(956004)(66946007)(6666004)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(54906003)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xlttWwYbdO5gjZz49GEwXfVhtACLNpWnskV3Q2nxsKgmWPakscgCAYF1V4y3ysUnKVwGIQTotak0zGWgLA0lReMYzNtzdyuV4beO8c1Sxhxfq5kjxY+T5MCYvs0ajlLNMlFDRO4IeWC5SrS4oMKXYh/4mdny0QYtrF5z+mEpxTddmuasa3romJyv2JfiMn/TEzDRdkovGlwGK/AA4YSkqKcbU89wHQRj6SJpb3VvxrjZdzPWiy35Q/Ml7QAPoh9fmWpz3Mt9c18dye0oPmRfaY8MQweAmXYDsqr6LyyaawoB4ZfxdYsBmsT5VSeO/Jb1YCK5nZIgaW7O2abrtjujSyvgak71bJPFGQCFzmxApb6RYYtnhs0Nx+WbXras4PzsSbtlyRvH/wfscJ94fw/d8+dNbaJMQ9b4imQZ1okqKeKVlmDC5nym97pwTT4F22S/wUr9XOLty7J8djDMdTfORnPrPA6HwxNeBRnlXqNl7LRfnzvuxeGpAZ8kXwDmpmTPyKMUK1q1mUH2GR5a6mfJMe45yH8dYni2p2ls58QeaTz/kkUwb29/eFN7ghzStZX7zZd4vWLlp5Y0TmaXPzqwI6pF8bo1Tr6EzzKzrvXfmZpnW/L/LRyR6Gn0r1waeIp4XwtlZFo4m+YDIxJSkAElBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6312fa0-85e6-4f76-9825-08d87fa278f6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:45:06.4806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4CYyFUhJAslXEH3yRUi3yb5GIBqEcnzN6IJWOGlB7pyejv3BWqFR8a9XQq1rXia4Aj3So/+//pumheUTIaEhA==
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


