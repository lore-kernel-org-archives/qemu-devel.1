Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF791C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8611520767
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AOodmUJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8611520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSu9-0007wj-Mq
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joSpv-0002fo-2y; Thu, 25 Jun 2020 10:26:43 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:41601 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joSpt-0005wS-FH; Thu, 25 Jun 2020 10:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeoFcjzm0NiqeTRBVCbafSWN+KNnY3h2au2zAsn+06Rubf8taw6wOSC1DHdATDn+3/SByvUjxdYuVNkUU/K0T7zJRvxdaMkllbQvB8Y2zdB0K//k9+18GTzxpoH1I8gJAL/+GKgD/TMhnKigSGZBlDW5df7UnQ2Miqp7wDWjIpFFWi3+fxuKjXyK26+CT+i20+WKH5t+t8cSwEUcIf1A8XJWH+JbVx+90zaADr+jttkMywqK1HTwFAX8RK4Oh8dWilLtdnxb0agdMywjIIrI8LZyyZAVgVQAKAeVMB6ebkOa/k9VpOhfw/Dz38iM7q4Sewinat/W53++THwKw2h7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwdvNOvaU3Z4nkWyN9DgjwhHJqsngiYCe1YrrtDxEiQ=;
 b=SoyNttiTK2kxQ4KGhSEIyhYZ1Ly6s+AYn3FqBVpCjzZvLDi9sXt4aSCjhIOIDF+VwIGgfMPot3CPyPQvtSSJGfoVzZl8N/YktuKYPhA+ToFTeXt169+eLL419Zf0suHtC2blAixw2YKkEisxIVwB+Ydhzb+saXm+uoD9KY7YjqYLOmSP1yBd3yNwd0Ss1wptx2id5LNW9qtU+k0NS25FIFCHCX42LtcZhINCgcv7RuSnIOcqvNQaOeykQSRDaiTUheoWlf8fyS/B5b68Vlo7Zu6+3vx0nmfbr6XEgFrlDwdaktD4Yb0GKBQf0ZuZmySH9bvViO1Uw4MfYavRlwkkdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwdvNOvaU3Z4nkWyN9DgjwhHJqsngiYCe1YrrtDxEiQ=;
 b=AOodmUJWqAGg1K2zr5WakyilR3+ZV7NIJ4KXeDrpYyn4AOVFQWCFxAy21A58Dxwd3hEM0jorQrh5Z5djgDCViIr6Ta6SlVvCR1iPs1DC5sASu/bA56+ueXwRlamLUFaESDFIhstTnYLmCUguQ7EDXTXXBnPmjk/+ocY4wRmkkEk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB2100.eurprd08.prod.outlook.com (2603:10a6:203:50::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 14:26:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 14:26:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/4] iotests.py: QemuIoInteractive: print output on failure
Date: Thu, 25 Jun 2020 17:25:38 +0300
Message-Id: <20200625142540.24589-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200625142540.24589-1-vsementsov@virtuozzo.com>
References: <20200625142540.24589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:208:136::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 AM0PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:208:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 14:26:34 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e8c31b3-686b-4c61-88d0-08d81913c3cd
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB210058318C49A6DE83321946C1920@AM5PR0801MB2100.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zB9Slcwe4M6wYt8bj9Sljt4/x+3ham6of1zsJYoHHhbaToCtytPPRyGjVCa7xlNP0+fcPK6zMFxg28Erv/kGWFvQgyotK4DuO/PFk4EZ3wl04W4/ua31YQStKY23ipsZVCmsf+2++Grp7Wz0DRtgUEpzYX8li1zuKqxH4iNCytEILTRlFZb5yBIs+20R3KO/wkbeUPlzfAX5nfCAnNfad0QIovjoBKEGptFkMC0PGbLan8IUTSzMzgLQMwadqQxP3kHjBKeUGy0dwkq1Nm/21cb2Y/majvqY4k5ty/UrP8wUKrETxpVQXRgLrI7gUqrIfJEvOE5txb4tzLapvRQwnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(6029001)(4636009)(346002)(39840400004)(396003)(136003)(376002)(366004)(52116002)(5660300002)(4744005)(6506007)(2616005)(86362001)(956004)(316002)(36756003)(6512007)(1076003)(6916009)(8936002)(4326008)(107886003)(8676002)(66556008)(66946007)(66476007)(478600001)(186003)(6486002)(2906002)(83380400001)(16526019)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: O2E+pvyzjEEw37nZLyyvYZ3UZ19CjMwy9FkixdQtb3WhTm4BTJkSVlQToO3R0N19zooEe2k4C1Y/3wFMmoJvjaU41z604Z4fJ7FDM/YLEwFi3T43lwPfHf37HNvoc2cNnhiZdBCeE05BedFrTGnAnFDjviabsx3YZQku50TFgvk94tK/0HUtapJNd+a0sE7eydt+ThQB8c/19LU25GRfXFNSNxdwjE6lv1X+/rwd05OsqevmVOTHEj8XYfmuO/g3ANRM/EJLVg83NzwlfFZobnTCRmmKYS1GAQcp1XsT9YWAHSHowGiu0z+czMthsx2CpOInQf2QUMi2PjPwcAw6Dm8uvxH7i3brAVuAIup4ZWQJ9DGt1lvFhwVH6VP//ERGltOEStcWLJKtieaF70iN7XEF2ijMvxboZAOxDmNnmEPcBsASFBsTa2SPIj7szZJBZlzEEcMqmSuzyRVhqWkt/KF8XhJjQk7WsqeEI0U4bew=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8c31b3-686b-4c61-88d0-08d81913c3cd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 14:26:35.4239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMn6uCGmFU1SpWdmCNqO6uk1RgxaJiJ1NTalG2uXYSUmRGxTa+WDcN91stNsykfnd69QEfyNLApvZpjbBgGSXbeQeF/RolmTDDC/MM+TCHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2100
Received-SPF: pass client-ip=40.107.6.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 10:26:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make it simpler to debug when qemu-io failes due to wrong arguments or
environment.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index efe9958f5e..ac9d199a1e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -216,7 +216,13 @@ class QemuIoInteractive:
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT,
                                    universal_newlines=True)
-        assert self._p.stdout.read(9) == 'qemu-io> '
+        out = self._p.stdout.read(9)
+        if out != 'qemu-io> ':
+            # Most probably qemu-io just failed to start.
+            # Let's collect the whole output and exit.
+            out += self._p.stdout.read()
+            self._p.wait(timeout=1)
+            raise ValueError(out)
 
     def close(self):
         self._p.communicate('q\n')
-- 
2.21.0


