Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EACEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5854C2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="p21kOQvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5854C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97uc-0006qD-LA
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lu-0005dQ-RM; Fri, 21 Aug 2020 10:11:58 -0400
Received: from mail-eopbgr50124.outbound.protection.outlook.com
 ([40.107.5.124]:48515 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97ls-00053q-HP; Fri, 21 Aug 2020 10:11:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4sktRGvMGJTlpD/HvJe5Ya4argZLV6aEIV/jjYsaq4qebPM5R0gIKDCQKvQdUa8oHvICRWNVMajXKehXrFj3sfL4pX5oJ2VYzZEJR9pFTdKPc0bqSHFD4XR74o+G4tY6Nk0IYVKL4gMrlN3kW/Sy4cS8q2Y5tb66o+dgHl7rlqDQOMQv2zh/uPHjhOAvXl9UE54aENtCz6vjcPnmp9AhShtdsHd6vmFYQzDi4p2v54umeFC/FRhWhMtFZy0O1XoYbJywS9pjPxG+2GmxhvrAwLw4EutRme6eZmhVj3PHMyxcAuyGAyUa3v9nJVyDQmVbw+JLOsFZD0mPRJKuSX/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHDE0oMfdz7fwIrU9FLt+uCfg+Dztbzf6ECJwUYmXEo=;
 b=meYc1t4W+hSkc5nhr+o0gaFODAxuUNYifdjoPoPJvWIjJgIoQ1/aLg9znLIsugepbk0NMYFfdzUBXQ0utV3v4rjGpMN9AfepU3pewuvj9et8fl81sPXuuRH2pj2BL9oaMPmRAY4GU8MoivsNF07H0/T10wkZMe8V/cAXVVTdlukpjzkT3X4VCqJPBSlubsnJzLXXuIBIl3XV1CrwFEnJVrvew6W8t58nzXflRs5IuIu3oFRgFXSJotwiuKgs82rlPntzAovOJdFoHRe4neQ0bM41V/1O8m8K4fVWskzDsZkXHc/zHkhgReet2HpfwqTDohUFuUnLWuJ+M1GiipK4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHDE0oMfdz7fwIrU9FLt+uCfg+Dztbzf6ECJwUYmXEo=;
 b=p21kOQvlx5NwA4ESDzZZMHiOJtXRjdcZQKSyZOq1CIY+AnqvGO1IUyJiILUeUJ/oofioLTvC86sKl2FZ70tbmZDjCxvzyte7FJ9D0T7pyJUTs+MbjRTjTO25BbQxy/Rtr6zCY7k3TAFU3c7sEV4jdXaJOrAxcenBLPP9rKaLmx4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 14:11:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 14:11:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 09/10] iotests.py: add filter_img_check
Date: Fri, 21 Aug 2020 17:11:22 +0300
Message-Id: <20200821141123.28538-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200821141123.28538-1-vsementsov@virtuozzo.com>
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:207:3::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM3PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:207:3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 14:11:45 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d9ac4cc-61e3-4612-cd95-08d845dc237f
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5253EAFCAAA00EC2120213AFC15B0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PiaJs49r/WkP1bwR1qSl2Ezr6gaUb5PDErfBWHhdBmRGHRlOmQKyZc8v+VGJQq7Xz4bIdoFEdYhyQhhEaKOCsTybr/pb/ffPfmQDHHEScWpW9oYaZwglMurX7OTOZ2+s5V32WXlkAwsc76YTo28qjv7yy3591T2xetm72wC7rKqgcHD/yOerIemPEnWr6wnErX1sZ5cxHUyNClfD9zbuAzZBD9UdLCGCLjfuGcIekU4FFBsV50o7yNXr8NTVA7PoLn+01jghjtRt6rD3RPCxi7De3mGREyHhOHAUwMtMfD1YwwVPikcsJAvuD3Csw1HKgZXZRwoQvPFvX6RwKJNTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(346002)(136003)(5660300002)(2906002)(2616005)(186003)(1076003)(316002)(6666004)(26005)(956004)(16526019)(66476007)(6486002)(6512007)(66946007)(66556008)(8936002)(4744005)(8676002)(6506007)(36756003)(52116002)(478600001)(4326008)(6916009)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 69+mnTj+g0v6Q5123EDE6kQKU3GB2V/7zD9tDHQiPi6LbNl1GxhGLYy04U/Qg2LFHS8H+XQR//Z6ZXom+cyg5KVbLDxBWk5j49BGlHr21sSFNtdzk2zU8bsgi65x+b9IniEhMtFVxc0zzRHcMqEZPRNoykxKwEHKmnayipBlhW9ctVJ5N/T/0x3QziKaA88iBl8z3zxawP2OuTz2+7fZVihEnRBQRo+e0ytnvopng52Vex4iQ1fHfqYWvJrMQ0rk0sQyzi3ADl1OChA8WrzqtPSbFTJ77c2qZsvsCsZ0OwcWlyyIj56rp1vMZIv2UVkmNQ1lQzw13LFcAMSNmQmtdNrwdADfQcwZulNiGmg5hhqvXdXPJIu6ex5tyxEnFqE9eQjJyvKZM3OKJeJpyTwoplT4vKzys1V/6qU7pL/DHWhhNPVtx4iic6i3xyDE6iwWo21WRqcsOgHluiXaq+QAQBCYW3jk6EBiqiXxiPofJhOrx04mL8W8hHAHutPN+yjyZ73DyKl9hzXWQjVszShzEH6rqSwpvCA1yYgLqs8D0C1DAIP/Amxt4pP9kz7OkTfKKLG3moQ5kHN1Auo8CnXbrXhxLgqQhYIwuSXGQg8aEOPTzyD5lI8pqwjJ3oqeIAESa75A09JZT3vKzV/2OLmGEw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9ac4cc-61e3-4612-cd95-08d845dc237f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:11:46.5048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDDochQ+Qc9k/KGrlE1e41p8dAEcYuLHNkPvREypoRccVr+jxmGOqFv4X82hN664vdLmH/Ey89AXQSvLWzSp2/FIOwWGwP+BVDr885VsKZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5253
Received-SPF: pass client-ip=40.107.5.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 10:11:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add analog of bash _filter_qemu_img_check to python framework.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/iotests.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7f1aa187a9..14f1d47d52 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -403,6 +403,10 @@ def filter_img_info(output, filename):
         lines.append(line)
     return '\n'.join(lines)
 
+def filter_img_check(msg):
+    msg = re.sub(r'.*allocated.*fragmented.*compressed clusters', '', msg)
+    return re.sub(r'Image end offset: [0-9]+', '', msg).strip()
+
 def filter_imgfmt(msg):
     return msg.replace(imgfmt, 'IMGFMT')
 
-- 
2.21.3


