Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A14C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AAA21534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MQoCDPG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AAA21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLG6-0006O6-UE
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL0I-0007eA-Bu; Fri, 18 Sep 2020 14:21:04 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com
 ([40.107.4.122]:8096 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL0E-0004bq-0y; Fri, 18 Sep 2020 14:21:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezcDu3StcuB8nXXQtp8pPoZZCUl0L/Gqxqb026H0mpN7K4XtzGQaJL8Gc69LJGW1Sy5AfxAj62vOl0b0HF9jORAKL8IWuUaoWB41Co+bJ/7hsO7DjIv1EtXzyftBx/6ZQe6Frxo4vSbMyU1eF0g7vjSbd27EtpBhNpqYBYGM0PJaaR8PTOcoSRON8CAcaI3nRhJ39pbo5srA0ghLmHdwq0iPdi0oTX+e6oneEAZQt6p0j04sX186wEUMEzNMu4IwpweAo1F0TXAZtueSNMMDU7/weSnkuqG00D1ulr9NEKVjEMY99QIpzkhCpddxoffWq9ChhQFfqAJnM/pT9Do9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87uttaqzpRth4x7YWAAH+SS7sM4DtM54/AUpU+tyQa4=;
 b=S65XFbKLU4yrTOsEAxfOD98ybJZ1fMm+Km0m6RuZs9rB5hl0XQ0shkrTOqauIshdiMwJeYG+tH8Ls/Z45Af8wWnP9I1QJi1W4Bd6it9u2yQ1I5Q5xexZb3hVEZwiZiIrzRkyPgDaIKjML2uMt6Zpqkz2hNETmfCiTPkO5Yiad7uScZQafplQMjJ/3T1UevdznhPuRQo0j6wo+xF95DCa+cjUHlGbYSKwlhZkxbCnnx5tTwqOg2DsoN0ULm6W0MHb+80qkZLAhdi7d7qeYqaFfHyfdqIlrtoZ7CT2vxIrYTrMjwaosvWV267oavU9BcPrAqbYPt4+5ibVwbFTmouuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87uttaqzpRth4x7YWAAH+SS7sM4DtM54/AUpU+tyQa4=;
 b=MQoCDPG+AcEiQT84+/ddBa3QhswBDJ1zC+2ZNxteUe43szCf3twr3oM1SQAz3+ckiCAWxszV4wpX1eJXdvZ2GqaeXbKC/ZClrSbwR5ylP5Nb8Mh8GQPwC1sY9oeokrWGSQBvR4re/CuDK5u4qaA/r0vEjeXdDowe1NKyoYAjzoY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 13/15] scripts/simplebench: improve view of ascii table
Date: Fri, 18 Sep 2020 21:19:49 +0300
Message-Id: <20200918181951.21752-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:17 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba5d1928-aaee-4702-a862-08d85bff7edc
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB190547BDF92A5459FE8A8A4FC13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8CnixacOim1Me1FIDGO74woI78IRTQ1KDHUUDKXCFRs+4MfE4Ybp3pu6T12MCcg6Hjyz7MxsHxrORqT8Mlava5APwnOT7YpTvZLgfSm69hslZb1s7Y2zSZjP7CRsWBiMsdt+MD+MWXjUf/b6AJEkjP34e2Lot+YSIV/Ek7s8Mmt1ZbwqCGobxZth/ma6gzkLSNC5gAg/mNq+jgqODpV8TfcN9nLgBKMLPaSyLKyLHMSn7zwhWrZrpk3yCH2dfVAFjS50xvkAdcT+Zz3Ik05F8bEeEn/+WCc8ex/1rm+XIVhuI1Y7FxfEh6kNrJIIdlAcolfi062wuO3kedTxia3ri7a5hJxBc6GEA4BrBTe9YfNO6bNtXT90SxHjBalsVLd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: I3HrnPRDRoufleOqSvowF39Bw1L6tGiZWxB6JiElDJkByC6an1ppmLhNQBmTHLi5civG1aAnxrjot7tP412Yba4fRu3jLDvR0NiQ+rZsfGF6+FCx7DvBMMQLnnAUhi+0G7TbG2o9NhcRUMGD7K+8gvbOsHi9ggYRjFhUtdmALGC5LAg0/BB52AoQ2JJhkmp8AnzBGVykj8gjpsYKa7+iNxpWz+SzrzHQ6EP6mL95waN/iW12HIfY85Lr3S4ocnS4zjT24N7NKYKLPbfJnA6GfMlGNrNn0uqbmfEzRXaCJ9lC/u0ZmCsJGDKuh0ll2hXVW9SWG8akAy+kq7vxibdR+V7HVIgcx2lEHVtMhhdcMnI+MeqaJQGlz1l7HbAuWiP5UDncJkHcr5mgfi8yjAfCDQPXTgnXIj48asJiKEPjmD7coN/k1E5fBNw7/1gCA/YmmBvCQwOZwYM7MSsR47x05va7PIf+C5uHZyulaLCV57NWDpzDmrsrD7Xc0+i9h44I3+w89QFU1T7E0ebqUdAVbBiZSVxJhWUzrJTpk/gLxjQRUmIzdbtqif13XpcANOVpDA/RD11p5pHXJ2nhjnO+M2+kgKFdYkmbaCo3RA4PQVZQOLn+85sQnRZbrR3JbWxGvt2N2btImjddHKWZWBYSXQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5d1928-aaee-4702-a862-08d85bff7edc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:17.8791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFl/sUFdEDmV/5pZKdBSy1B9R8mToliPwiO2uGUTjNpq8CJH3cqdi2OCl3PHQTvc807CX7yR4omuc0moyOim0oa6ugFUXB6HytLhv6pTenI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:06
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

Introduce dynamic float precision and use percentage to show delta.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/simplebench.py | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
index 716d7fe9b2..56d3a91ea2 100644
--- a/scripts/simplebench/simplebench.py
+++ b/scripts/simplebench/simplebench.py
@@ -79,10 +79,34 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
     return result
 
 
+def format_float(x):
+    res = round(x)
+    if res >= 100:
+        return str(res)
+
+    res = f'{x:.1f}'
+    if len(res) >= 4:
+        return res
+
+    return f'{x:.2f}'
+
+
+def format_percent(x):
+    x *= 100
+
+    res = round(x)
+    if res >= 10:
+        return str(res)
+
+    return f'{x:.1f}' if res >= 1 else f'{x:.2f}'
+
+
 def ascii_one(result):
     """Return ASCII representation of bench_one() returned dict."""
     if 'average' in result:
-        s = '{:.2f} +- {:.2f}'.format(result['average'], result['delta'])
+        avg = result['average']
+        delta_pr = result['delta'] / avg
+        s = f'{format_float(avg)}±{format_percent(delta_pr)}%'
         if 'n-failed' in result:
             s += '\n({} failed)'.format(result['n-failed'])
         return s
-- 
2.21.3


