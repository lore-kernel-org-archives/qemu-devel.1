Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A57C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA572225C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uAuaBMYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA572225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6Xl-00053E-16
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69Q-00081U-3y; Mon, 26 Oct 2020 13:19:21 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com
 ([40.107.21.92]:44161 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69N-0008QM-Ar; Mon, 26 Oct 2020 13:19:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4jdWGMGmvCbW+pW6xQ96ToyimGu2qwURL4rYFjol8ZsvuzRdJOtGBNeooeKdVHfn+4scsgQ56u8/59I5fFQcWQ6eYwCBCa5si8ylB0rmegD5YRmcnRwm3YjraIee/afoWUkFkxoqh3FoOOIOdaFhzsuwC16fR8cUvHsh72FqCqVrj/L+5S9sRR6VvyZraa4nvAHje6qNTfUXOKnkppRpDvmCfsMFUCH/0hIqn2bSH1QJA4PpunlOSM0QSvj+Br4ZlFPKewNgVJdK0N1XVKxYnSUz2+z9Mz0RhE5mouW7kOkzHmffX2gr0q1tNidERN5x8EMCQqrnqYxw09V/B2IyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvTnlUID1+MP8eU4q23oGmqOml3VYTl7KaiWOCgKhec=;
 b=BJNsz3acgVBVmrU3JxG1f82u3NJxFVGgeU7bo7uIIATAIyl+VSsFVLBMP0h03AsBh2bwlj+JaIA+HBQbxJuO2Nffq728wB70EYQd+AX5chTX6ZImhMMWKkvFEN30yt7D3YDxtyezO/HqHavXfrWBtL+IDGW59pqR/9nwTnYJRucpx/+z+Ly4kzYe0rbc0anWoCMzgOXH1lJfni7QIMlHsmbif4ZUDmFTSIVvru1deH3f32764zT6h84TY7gz4BpQzuOVQXebkOZhM5FOhJKkPF3Zpsyf2w3od2Z98lTiCFYg/GjQBBMueM/Sw+06HVi7U6t20L+u+/VM3Cy8T5dLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvTnlUID1+MP8eU4q23oGmqOml3VYTl7KaiWOCgKhec=;
 b=uAuaBMYSEHx3HCN3bhV5BGjliqV66zlXi+PSSTCe4R33gKmFz0vrTPueVCIEJY+/YcxCzxT2g+VN85D857sx3M9Oj1rUqbzCPy9MURZkBOKni/iEEVhmQMyohxvC+JHewFgVvk7Ah5gNb2lVG+Rzct6RFbCJmk2GP7YQCyZsbqs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 23/25] simplebench/bench_block_job: use correct shebang
 line with python3
Date: Mon, 26 Oct 2020 20:18:13 +0300
Message-Id: <20201026171815.13233-24-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95a0bf16-d186-489b-74ef-08d879d334d9
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30327DCEADDC180380F1029AC1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3i2TacPQ/Ipjmg6mdLGiHpvOgTbWqewjTlBMUJzydcBHOPTAppZFQOMUGDsVovjFTj6rPt0CYHj6ja7iT85xK0mkShDDCq1aSj96mngpPFo8v8dPW+EeJsvvp3La4rWqtgSlfwptzsh89ztTExY9fCt3A9a7pRvA5Lh7LXsyY2AwgRtKxni0THfwXXjZYnnkzOxKzy4dFbus4lCggM3QxTFpcMDOFJjRPoL+qrmYcceTgbk4UzP2Ga1daEZlhifNolndrzHSQrj3p/DUIBtriM2WRfsWRo/GeIFjHffD9WF2hHHl2ASWO766tKsmX+PaN2gtsot9xlbLxAV3vj/nhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002)(4744005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: thouj5NNAaoE1PdRV7Z7CFn2eNilTkhSTL/WLaYqfsu2ZqoNF+n7OUEQhbTg0x17SJ8SXDOpKOWmsOhp8DPuEv2G//UMdzbqy84keVI7nz+guXHLsw4UvEuK/UDYeGBPsraQH1WNuqpNWbVzs1l2rR+O6UqLAMRzOhNw18qFK4xTmjg4V8z7nyKW/yz4Y4ecR5ZnpMviweFecHjYqCypIlC1tXgoWhWOMtqjt2LV3j3eGxkL2qr2yCYG6uIxg4e1xFoxwpJKGly+rufW90hbaGA8PjHVdakxBMyUUDHHq68IX9JM4FOLA6tNQtQlMMrYz+qRhfB+Ht+R4yblx62V/fAcP2FtcQkAi1XNUWow952M81z0jEe6Ek6fbBVTI6on9+oIxFyREugzyndXvi6CAGUmw/Wd8D1zA6tFNYN8ZxP+mlsMnK4CAvuHMej2ldYg9I0nubFHusG+u9nlNlVCzDXues5fcB3DEai0Ol2psK4CUzFy6eX2WAYpkOXC9TPGGqkavEnqR83pp6/Tv99c3Dqlx18v+1ux7M8WcGiUiDMCgvgJA6pac0F0jki+sIRvbO3k2iIOP0C3vLnLIF22t8uMk8YgS/jUZndTaDldNWfbUUGP0/xjaZUhw5/7s/N1qBzBImzfXI7gVZb0czqOwQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a0bf16-d186-489b-74ef-08d879d334d9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:50.7180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWD/F5OmbZwTW3JhLS1GanxGxSGcbu+Y1B4Yw7CFBwzx1DZ/gDM7s1WOik4qhexBxk+jnqIWlWLcdcwut4E9wKQGhInXp7kD+WdoGNB7i0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.21.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/bench_block_job.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
index 9808d696cf..a0dda1dc4e 100755
--- a/scripts/simplebench/bench_block_job.py
+++ b/scripts/simplebench/bench_block_job.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Benchmark block jobs
 #
-- 
2.21.3


