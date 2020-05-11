Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE05C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BD0206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hycloud.partner.onmschina.cn header.i=@hycloud.partner.onmschina.cn header.b="lWBWRaA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BD0206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huayun.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY99b-0000TY-GW
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quweijie@huayun.com>)
 id 1jY5U7-0005qd-MZ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:16:31 -0400
Received: from mail-bjbon0148.outbound.protection.partner.outlook.cn
 ([42.159.36.148]:18982
 helo=CN01-BJB-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quweijie@huayun.com>)
 id 1jY5U6-0001wP-Oj
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:16:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAmIIv8JBodU1p3SLqwRy8NHv1LVGjCQIoy5q2f9QwhBBoK1ylOcSg833QgDBDWYtMICruMNQ0QlAXrOFEy3ubOs4VuuDyA3tOk11NixiUCC4tLgMqo1UT649pNhx+jmPAP5MEVUsL6JrBASnyRZI69a7uKwJqkU5wiw2CnUYlXXt9bUCeqYkGon+11iMQmIkhA+FHQ3NXR/b8ANS+G1uR2Ias/7Wfbx3rF42O1lyJJN1tu5PqQrJdNISgRWeAmeF5XRliDfqBLV1ARb8XUOn3Kyc61BQ9PB4GxYnh8nHM5VXZEGtztTR0lyYRRPsXSpL+/UASFxOgLTDRS/pYYocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WtlHJG0eGmoPYvwW7AqxBu6rC/JQVz153onHaEUCq4=;
 b=Ws+B4ppMpboACrxl00SF/lCySUe2s7PBpQmv2y7aVx7sOqJiFYYGmfhCSqmgV52Mb5heqvpUlFZQG3r9rrtzOMGN9lCnNohk+U14p8aQrSQLxGJ4p1e2OTAf/4a+JitauEqeMqGQWPC6BpmqNcdAFz316DaMNBcDUA6qMKt5tPOy6seDHZUKaFX5BWv5WsN1tDUnxGCULfGUCAqgCstQIweOPMDwdTvD0Nv0hh4aA2sEdbvqP5lb2EeCTcjz3Q37hHaQazGOjHtuC7lV/E/BK+136rR1VwP+XlXKj1E20nhnrxZ4mWCtmYUC4XLb4wcaORCvxEPqcTqN65porxNX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=huayun.com; dmarc=pass action=none header.from=huayun.com;
 dkim=pass header.d=huayun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hycloud.partner.onmschina.cn; s=selector1-hycloud-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WtlHJG0eGmoPYvwW7AqxBu6rC/JQVz153onHaEUCq4=;
 b=lWBWRaA+tqMK+/mMZhhbLV/lKrj00Fdrq5sHcSX8URYuhsYWws1q+RUMGp9JShijuo4xAbFN5FasIE1Bj8r4JlKXc7CTB7zrEVE60Y0ZNej263JiBifIlYtJ72x8o1pRDVdsb9u6NVy2MktjmQNMhNU1to+gX892Is+rZEvyCrg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=huayun.com;
Received: from SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn (10.43.110.78) by
 SHXPR01MB0525.CHNPR01.prod.partner.outlook.cn (10.43.109.204) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Mon, 11 May 2020 10:01:08 +0000
Received: from SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn ([10.43.110.78])
 by SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn ([10.43.110.78])
 with mapi id 15.20.2979.033; Mon, 11 May 2020 10:01:08 +0000
From: quweijie@huayun.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] If we have more than one colo-compare,
 we can only destroy the lock when we delete the last one.
Date: Mon, 11 May 2020 18:00:31 +0800
Message-Id: <1589191231-18876-2-git-send-email-quweijie@huayun.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589191231-18876-1-git-send-email-quweijie@huayun.com>
References: <1589191231-18876-1-git-send-email-quweijie@huayun.com>
Content-Type: text/plain
X-ClientProxiedBy: SHAPR01CA029.CHNPR01.prod.partner.outlook.cn (10.41.244.36)
 To SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn
 (10.43.110.78)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.localdomain (116.228.45.98) by
 SHAPR01CA029.CHNPR01.prod.partner.outlook.cn (10.41.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 10:01:07 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [116.228.45.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2e4fd7d-1cd1-4bac-c43c-08d7f59239c3
X-MS-TrafficTypeDiagnostic: SHXPR01MB0525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SHXPR01MB0525DE47F97AA54D26431DCFB2A10@SHXPR01MB0525.CHNPR01.prod.partner.outlook.cn>
X-MS-Oob-TLC-OOBClassifiers: OLM:6;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KHG3QiLeW33x/Vmg+FxkuTePPxLE/r4Um0RhsBcaQEZlLfhYSw33dbMevjRKCr2P84h6oqPpDwQObZwPyUB6laklwJcdmW/t8Cche+p1nqYd34kcnoK8YLVQWlfGTkkZ4bPqsFwFAmGZkHbnbzSU2FSNeWEyvyhxj4LmlMcEfksAnIc8NoaIFnLVaDchXEHrVPD8qu76Rd7zdVBFTPqVSv3qeMP9dC4dtYKSIK2k9+Y2sTB4utR5KGe/X3vdbOATMOkr30rQQ5YiDzqE9hBbbw7haeQE9aPFn4F3UUOeZilwPSR1yCA2StqUp+VkOnm8rpc72pgo0movfiQhFCPG7IFx0yFieJT/DfPu1BMoUhohNbsaXuPlXgzvh9ERKRRwFth7FklT60ESGG6eyS/hPfheAaFrj9Y+Ty+jq+tMD6ms570rW6+DUiUmAHJqPH0HtNuKB7zx7CD7J5BUNGncgIQsOT/0aalPZXiYXsejt2TwgFf3L8mG8IJFvj0zH/QGMM1EQmbkY9vzBj0jFlK0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFTY:;
 SFS:(366004)(346002)(376002)(329002)(328002)(33430700001)(8676002)(66476007)(508600001)(95416001)(66946007)(4744005)(6916009)(86362001)(9686003)(36756003)(8936002)(186003)(33440700001)(26005)(2906002)(66556008)(54906003)(956004)(2616005)(63696004)(52116002)(6666004)(4326008)(16526019)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Zw02TXaf7ViOSuxtKTfenpO/MvSpGoWekCbBoplGMHdH/GUoI0gxQr8y2cj/8xDqEGEnFpy6azx3JUCEIvWElI4HK1qn4TXtH92Yu7Ize5w1Bh1E0iOYL5Rc1GnsMgEQUAwuAmDTBxBfS17P7Ff3I5vQDUwNY/moqx6l0ARw8/UBFvHoxAR9vjObri2KyzCJTQKecjbzL5sG3RPfQerpyy9MD8ySRNFEdJE5Q6G7zNzyTfzsLtjrK1lFiWCiHg5TMZaFk50JJchy0K9Zi+DlSdWoSb+WMh5zMBNihBOMWwFNnyGG5rqYsHGbDHFfF4GwDIRaPiGFrdSS+4BpQ4PxR5S2V3gd8NGRzk9Bej1Q3ElB/mjquKj/hn+KrYV0ITMJDxesObTbi6YsuCBY6iWkrCWvY2GqlD0aUqe465XnMEI=
X-OriginatorOrg: huayun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e4fd7d-1cd1-4bac-c43c-08d7f59239c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 10:01:08.0635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a674a363-98d5-4f2d-95da-d54302c8edaa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqpC/Zjy21QFje9TlKB76y1aU1iFVPbD6/khHNXqmCSidJcj4SbWrB77yFeRpo7j2qSsqH6rwa+/4vlIvhKooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0525
Received-SPF: pass client-ip=42.159.36.148; envelope-from=quweijie@huayun.com;
 helo=CN01-BJB-obe.outbound.protection.partner.outlook.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 06:16:27
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2020 10:09:20 -0400
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, quweijie <quweijie@huayun.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: quweijie <quweijie@huayun.com>

Signed-off-by: quweijie <quweijie@huayun.com>
---
 net/colo-compare.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 10c0239..ee878f6 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1313,8 +1313,10 @@ static void colo_compare_finalize(Object *obj)
         object_unref(OBJECT(s->iothread));
     }
 
-    qemu_mutex_destroy(&event_mtx);
-    qemu_cond_destroy(&event_complete_cond);
+    if(QTAILQ_EMPTY(&net_compares)) {
+        qemu_mutex_destroy(&event_mtx);
+        qemu_cond_destroy(&event_complete_cond);
+    }
 
     g_free(s->pri_indev);
     g_free(s->sec_indev);
-- 
1.8.3.1


