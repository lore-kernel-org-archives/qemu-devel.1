Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B467C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62552075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cxgbygE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62552075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8ME-0002W6-VQ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Ki-0000FM-ID; Tue, 19 May 2020 15:55:24 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com
 ([40.107.6.98]:52740 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Kh-0003c9-CA; Tue, 19 May 2020 15:55:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgSes2OI3IWbwcR7xns4iUX2z+GScty+Kec7/yajCxoIREBo+qMiZt2BIAHwBNWX0VTTAedqamB6OQ72hfF8M1xtIjaFgoxGid+3NINR4F6N6vPah3wI7szhQLeCQ1zJYR7OXEsMKVJqYJ/i6JJG/xVJ/DeZvkfbgVhvqUEOGp3QMtdNROnUcvY49YayqjnPMoh8eBmWIthaxtoZaNiD2XY286VJEqVsrkX2Qyl4pLd8lxLs53uIlxYacCcQWZYTDjSlVaamx/msmPwuDAFq36bbC7/pYJjRUTjrjc2fUKYBklahV0TFaR8FuEzWN2H8wn6sJzK0ptHJOgOgB1bkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHf5IMEnmyc5hsszpdVIeXhTvgdnnsPN/Qy6PjYq/JM=;
 b=f4mb3k7lGU0XH5IbnBUpSSI4hncLsPRYLyMdOjYiBf72gTr/zpJ8njFH3McXZduv0BaK/Gp3ISuCfmSXGB+zs7v7ciGt9MykGFR+9EK3G8Ba3Lsesu6iokCwk/Owx457bm4bisD5UoiLxaVrm1J6nfsGxhvM1S9yheXJiABtU8zcd1ZQDcIvj0TyzdqCVACyELGXTxLEQC9qRhe1wHphYOBsIpDMZiBDNUv6Y9YYekVoaUSNFwEL1wIWaGwmGPspTxBzdPTGBDCt/8We72KlZ6wOac8AMauoykJLH/0+zPDKrajkeWQLbNNaXjNsX0QZ0uV6Y8S1JLko8EgxOh1pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHf5IMEnmyc5hsszpdVIeXhTvgdnnsPN/Qy6PjYq/JM=;
 b=cxgbygE4HGPodF1dh+/Qe52r0MjqHgLUIuTTCd5lLCaN30Q1d2MdTuhTioHoFc+E056PLgBEp1tdRExYkKJ9599+w4TUAYxB69BV3NLC/MlpZ2Sc6fmG9yMs9ZpNzvcQt1QHU7yXS4BRqoP2TJL6njtU90/7ScNHwbtB+MF8Q08=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4542.eurprd08.prod.outlook.com (2603:10a6:803:fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 19:55:17 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 19:55:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/5] block/io: bdrv_common_block_status_above: support bs
 == base
Date: Tue, 19 May 2020 22:54:59 +0300
Message-Id: <20200519195501.29071-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200519195501.29071-1-vsementsov@virtuozzo.com>
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::34) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 AM0PR06CA0093.eurprd06.prod.outlook.com (2603:10a6:208:fa::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Tue, 19 May 2020 19:55:16 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3ecc832-0b4d-4f72-f782-08d7fc2e8d78
X-MS-TrafficTypeDiagnostic: VI1PR08MB4542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4542E8BFFE202BE99EEF173AC1B90@VI1PR08MB4542.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pe8IY4d6B4AIMxBW9nUE2IrRBC8JilMTl0apG9/ufCpZukK+xYzw7ZwzsX6zRfIXPWi0skKXd0AaGOkVPSCTikdu9E9tPs1+p4G2zLtcPLZX4r6scIVVB2gEStePnv6XLPnTXyRnjLhuZFibhIStrIyc6q21iIS434Ul0/kG/XemqGeJBqi6SVCad+SlTC1KThNcAuSu81Jx1VuFwB/CSSCnphCmhBgt+8uUUHNgnwV7rQSCoxymAjbgtba2/CrFJKUoVjyEWQ/T0xx5RR04NFKaWNrmUQxDbqZ1OOHPoR2N0+Yazgx/KplBlxEfvONi/cLdF+Ok3nFZbJhR0bl8RM2mbXwf9ZBQYf9MgcDMr0nHTLxWgqmhdF6R98TtyR8MlAOkfPi/TeSbrfunISyovMbFB0DOiTokM6oB/ZPS0QrQHUiNEsM/jOyQemHDkyHvWiboHeWskNCqIKqHYd/Oz5W9U1C8yfwNw3DL0xjlHZekCthFWsXEi591TMdxVsSn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39840400004)(346002)(366004)(376002)(6512007)(2906002)(69590400007)(5660300002)(52116002)(66946007)(36756003)(6666004)(107886003)(316002)(8676002)(16526019)(956004)(6916009)(186003)(8936002)(26005)(6486002)(86362001)(66556008)(66476007)(6506007)(4744005)(2616005)(478600001)(4326008)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: I7Z6hUFYmGas40qYoimnKKzkfMuhK0TfGi/lHFZJy6ixIf8XPBG0VC2+nyygCC1SR4Nsyz6OxoiKJFm2NFOSJ8niggmxklqUZm9DLkISVMgmmSVP6RxBwv9fCr13RksqYP5CJetbrzQdDVwFeJ1RriTKMYO3XUM+YVHacRGOVImQCBQyOoeOtgtHkKPHmZF7MY9FaAIi4aDKfrnLAa7vpTCwywvdv+LoS8on2aSJ550+KeGSRXobRNtbsJnnZ6HY4rmu7qowJFD5ULkfFv3ks0WOCr36IqrlfC1i+5Ut6CiujkZTlRi+sD90+IZzkOyitk4y67vybCvziEuM3g/RsDJW+JsjRaJJnXy+HLt7mpVYe/36eVSilWiGUcO0KxdymvuahAThK3KUwfETdhpYjMMe2BRr6eM9uY266l7Q+2kFYZahcUdF6a+2hKBJXJ0o7k+Qo4C196OFsr41lUiYTbt5IKrlCJfEwgewCqkreYPOykJAgmIyUkz+m43/dILd
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ecc832-0b4d-4f72-f782-08d7fc2e8d78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 19:55:17.0356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OfrTRr3mzYoZ0KhjJqcyN2W9KoC0HOPDd97+4/n7TlVCIr9zIpvZDAInEnP37bJecIyh7MVX+BKf0NO0tYGUs1qafvwvrCehdB0x4GClRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4542
Received-SPF: pass client-ip=40.107.6.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 15:55:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to reuse bdrv_common_block_status_above in
bdrv_is_allocated_above. bdrv_is_allocated_above may be called with
include_base == false and still bs == base (for ex. from img_rebase()).

So, support this corner case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index cdc0e6663e..df44e89b7d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2458,7 +2458,11 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     int ret = 0;
     bool first = true;
 
-    assert(include_base || bs != base);
+    if (!include_base && bs == base) {
+        *pnum = bytes;
+        return 0;
+    }
+
     for (p = bs; include_base || p != base; p = backing_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
-- 
2.21.0


