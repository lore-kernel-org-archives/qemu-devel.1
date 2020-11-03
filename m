Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2F3C4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68F42063A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RfxoJ30o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68F42063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZl1j-0003jP-OT
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksc-0006eO-F4
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:04 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55]:25952 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksZ-0005Yp-C1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXlsDg3xH5BwYboSh02F0yS2JQfoubi3HyxRdFD7AFUUnRp6qlmvacXnQr4TzoHW9TuHYp9adCQipC+kcr1E3ZmuytlurBsq8RzC0+GGV3f4EBd5YKzqqGL6WzI9tlaPIa4jhYEVHNislkmj/MAWGUCLrujnBGYdb3S3EF+BfZftRJADnXYhP9tfItxY7S7stpoUhnEu+ePFl+Vd10j8GOp8LJr2YUEPwerVZvrHX1JHFEc8N8qbLjuj1WAQ6bGWKV1ui47XPlzYSnjD1xDA8vA126iOqlg3qZolYIrpi0TvZRlBS/kRQFFspW2bozRTqM/Pqsn1ZUKyjcgXriCTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVOT+Ji/XN+UthHk4J8n5dOXuOASmrPvPQAuUjq7el8=;
 b=JMJyTisuSzJvVplPp01WwYaPgSeGouJibjVqNCLPMTy/pWEObvfAHk/XL+vUnY+rOHTi6tTJWOsQUN/gIj6EMo9K9dJqPT1DiLyY8QmOJeph/n9RYqvGCZxheg7Suog4kxd075o+MY5D0JVe/4PyqfQQpEPtsIWRJ5RQO0DFWrlQ9BtzfWxntifEtgiBEqRGOa97tojkpKrJsoP3yr6krsA9epqwtsE1AharYJ76kBL1d5bgaVAh0ugn7++tRNCBVYMFefTyhky8cj/sDEjfZaXI+9yamaH/Cfj0VYZU4ccIe5RTQ70LKv9wDnMjn55MdukIBotNJ5/lr4TxDQz2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVOT+Ji/XN+UthHk4J8n5dOXuOASmrPvPQAuUjq7el8=;
 b=RfxoJ30oeDw6UoRQYIN1fArZxeqkrv1Ztv6JdC4mJySkknZfF6quKEnd1Qef78ZarmLGEMSyBNfASpd2w++3GzXs2S4yoxm8pONo/9pO0SJzQGUnSA9xiY2J133YTYENh5V3KeYotJUaQxpkgElhcGSdMVbh7QkLG2BQGzTsMEM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:27 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:27 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/12] qga-win: Fix guest-get-devices error API violations
Date: Mon,  2 Nov 2020 19:11:25 -0600
Message-Id: <20201103011134.887744-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA0PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:806:d3::13) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SA0PR11CA0008.namprd11.prod.outlook.com (2603:10b6:806:d3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 01:12:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2f5fac4-1329-471d-54eb-08d87f958750
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50010DFA2E97538AC7FF2EA995110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKjG9BhYFo4MsueLZlWV5x4KKb8CfXbtL/mqw2o1goTZipNAg2NSFHwX4MO4M3bx2sDFJcwftfd4doTjL/7CiTVMgmHnONHvhphkf76dyMqPIVgEFIE3sZZgI+/IMrxNBZA8eIci5kjIj05rvRz0kLCJofVQDsAiWn5gFkRNFMsVJ7EBSR+7dHLUlEDcdjJzS02w6nAsgJmhfU5sgmq5zbQ5L+C1HhmLxKE9I7srG5ONvOXaISpQNwCKjMreLWFdYTjFk5K2kznq3Bh8xEU4Pjid4gPFIP0WcX4GKB4657tWhW6NWts4D4PcXqs1QqX7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(83380400001)(4326008)(36756003)(54906003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: q9Z3p1E0V14ps5mD/AIV6dNmb7AwQNE/H5inB6z6tuXe0XeREkMRT8gg5Q9fn9ujyVw7oHA3qaOPH7taBR3q1XnRCK25IZm6p0CXQa4LRDkAx94AAakyUPI7Yv7BuAG02B0wCAHepiOjJVi+REk6LDmjvgTf7Z68c8G9lD4A7stx5oT5hj7X0MOcmtTYM4Uj2n/uTHaNSw0opjcMv42qI92SPdFWhcwzgnAJCctwrA3nOjLtvgt8tpK5T4Komj9l5LdZ8mTuyPOE87K9xWjzefWpbv89CpsLG1wVZSbvEBUjs4IyZR2evQezBC9b+Fq046WjluS5HMeRWGErxU+1eCAdpofgIyy8uXpmNmpuHAuKQFuj7tB9dLcCb4KlDEYh99v9COqzMJ3asfJs/MfmX4jQP5cJ1eHr6BHkQtKVeEGFYsyA6GcQiplMJ96NuiK777Q8+UwkXQ/vIR968ojBOlc6UPKQZ3UtoE9rhw0mnWXRhXE7AOn+zN0sX3ld6R58OpFcdhhKJeQ1EOQklGWMybVz3+cAhBly68c1ATnU+VV7hOKvbFEvWCVfNY/MIAjpOGyg2pOMMM3A43oprRCemB0razrMceF80+fQfcPFuy9vPJSpACJvbyRNJQLC1rC54LapeN0RJrbS6K/DQq1YFA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f5fac4-1329-471d-54eb-08d87f958750
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:27.2149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpJ86uVZeHDfKvdDBYzoM0sF0Vg5xztX79mrlMl+wo6p6i1Rp20WqAqEWFM1FVYU9i7Vp+MyAU7Cqna9t9jPmg==
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


