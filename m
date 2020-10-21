Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E7C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20A22177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SvqiCEqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20A22177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFs3-0002fL-GF
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaL-0005vT-2P; Wed, 21 Oct 2020 10:59:29 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:36743 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaJ-00085a-Am; Wed, 21 Oct 2020 10:59:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYfcZN38Mda6xfAI1a8Yl7pQwqc3GdOCGqwn0EV3Hn4NA6zT5h+1CmdAVfYrE+hSwQx7n5BUWVV9suNtd1Kthi1JNsRTLOpvE8ttAAksPVJ9dKAjW/WeIN3iP8DXcDnzUtvAU6UWvHCUZJD4Uk1VjXVmLiXRjryD1jSVqFB+vacwpkKG9FwIMYaUMygOMIGrZf/5PkT3eiKI7r3ffnBuJSA43DLf4wNWHhq6vlBSTqohE/9YKIUx9mBvMLcTWRzxg/U65VMBKu86qoqnjz1QOpg8STa6YVpvV0SHsXlG35ZNyAe4aZxy0u++8nNaGZlpvUuIlhPv0sWQTlITaOWq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRM09K46Sm9w2OXUgAXBZcu9+8TO9U9eGahMz8wpPjY=;
 b=QzeWLO4J1sQ1VvCInwNkjZ8DP4xxjXW9zB1G5trfjWOD8mVMaNA54UGIi6nYs8QlSEA7kR8BSwH7k0HJvDpRfFJGFIztEjmih7mPTmu847mTWRGm794KFln7dqN06ui8Dpf5omgdFrkwTUJbrfbt5PPqB1y56O8r4gl49wxoygse8H9ip/pMlFqI9ZCFKczE/poxsrkcC4hzjeXgO6uKktZxG+joUGYOuaDUaH5WG/s5vW16Opedd88/yPEPaVpGuq3qGor/DMOXQ8w+QjH1/FPTH8b6zqSK/99VRw9X6Jj1tiodR0y7nQjspBURUIXwuKRd/zg1STOY2DNyxsRs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRM09K46Sm9w2OXUgAXBZcu9+8TO9U9eGahMz8wpPjY=;
 b=SvqiCEqxbphODQMWCDZrEJK+o5r6BnckCC+F8vyjPx4vv4X9mZSFfK4Xerac8XdJAPc8wSOD0R0KRUT7iEqbpTRh9I9vCkLmmv/Obf+xJbCItOdkFiQkS5J0M9kyJruOnwFHNIIGLaijrxmba/RqKLCR5w3+TO6r8Fc34l7dBB4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 07/21] block: bdrv_check_perm(): process children anyway
Date: Wed, 21 Oct 2020 17:58:45 +0300
Message-Id: <20201021145859.11201-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5299bfc-104a-4c4c-78b7-08d875d1e2dd
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44723D5778F5C5CECEA21C49C11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTMdm3NBw/fU0cpWXfFKe5DB/Imujr6MykdMTACqLg52XHG2bJuREXkt4XtcaNgHNYDI7hMf2rmR2XRSmUMH3OGBWEbfeYTQAXh74jtunPC0N25NAXw15KhkQZN6rohoSKG0Kg5irofQrWj3Ksrw6JAPtYN/Yl8+xrs5SiT5MAxRk3OU8bJD/MZEJvnzMyu8EaLYfdGcKBbtETmqCIyGH8JYvOPlFmiPsihF3tDOHvnIFOzHBOJSwbfbnK0kXbAvHH+fX60EW+0VO3QpGWSSjHCj94MRNdXaJdPavYs3PPFzXZUzXRnwQQctUWOLVkzxD5dA/BJPlT/sr+gsoo2ryg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cZyAVU3pqPpaKjrYSfvZuuEFndGK66CF6mqNs31TqaD3iJAyDEpV7ZOVxm7vIyWgf0POlvnDqzdmI2qyelTaWMajr9H+teFpbbMQ791GXtDigwKzSXm7nnNlUOo3mgSoXFZ9KCavQYOmmn5ORGcQMhKqo1b4EwLsCzhPTVbjVVs4y/vAg7sVrNaR9dD34UG83y2YRmA8pBJQwShOFf5qKr6WJPoXwgZm1vn+ufm98VM4CpO8qxI+x7GmTVD0sCKBFtATrQwc0KYoY5Q7Qjn9+ZJDj03SO/f7nUht5FIYj1m8qZokhVKthWUMYAesROkmIa3xs2QI9pCZ8H80cqAV6gqI+sK2UDQiUkJ2JmE8c0QX4HC5v1akPqDES9Uzh+NHTXAwHS/zkS0HxQ2+je5jIkEqoviuLM3iPFRKIA/LzRNvEt0AsUdkk7MFOFVxEslLsLCYo0qKC8O6atedhs/DucDGwrjXoGtUplJ0WelFZqfLZh1pob2MbsyVIJAlRe5G6JEv2HM3CWj/rVEHtTsQvQ8m/umEa3LT2bZw5CgQr1xrWUbDcqWZoyMaEGSHEOTLB8n/6qFdSatay2om0xZ38h0BL1LJBDI3i2PIKxLLF5RFhPniJbpER8fKhJU3XXrFzlZu3g2fWyvilnZBZwCQSQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5299bfc-104a-4c4c-78b7-08d875d1e2dd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:18.9248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4fq/VftzF1RC2BuPjPag9BFF8eHvGfsX5pEXT3xhv/JKUipNOGx6cVBXcPi+p+DwRX21veKSdoHrJY2GSEBDpX6IveMbMF5NH/ll4xbkVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.7.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do generic processing even for drivers which define .bdrv_check_perm
handler. It's needed for further preallocate filter: it will need to do
additional action on bdrv_check_perm, but don't want to reimplement
generic logic.

The patch doesn't change existing behaviour: the only driver that
implements bdrv_check_perm is file-posix, but it never has any
children.

Also, bdrv_set_perm() don't stop processing if driver has
.bdrv_set_perm handler as well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 430edf79bb..4f7c27aa6d 100644
--- a/block.c
+++ b/block.c
@@ -2048,8 +2048,11 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
     }
 
     if (drv->bdrv_check_perm) {
-        return drv->bdrv_check_perm(bs, cumulative_perms,
-                                    cumulative_shared_perms, errp);
+        ret = drv->bdrv_check_perm(bs, cumulative_perms,
+                                   cumulative_shared_perms, errp);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     /* Drivers that never have children can omit .bdrv_child_perm() */
-- 
2.21.3


