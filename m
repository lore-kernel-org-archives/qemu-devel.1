Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E65C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17998206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="lpdUJ6tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17998206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtGIT-0007bN-CT
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 16:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtGG8-0005NP-Vo
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:01:37 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com
 ([40.107.237.125]:6304 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtGG7-0007qY-5j
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNPTzG5rtNVyoS0EbaQ7lU3pRZkADIK8sT2GElSR+PyM1ArX2edCdUhqR36MP+PJrka99aOcdvAkqjEvkI9frB6AFAPgtV8ikySfjZ8SbEf9r5a6LpgmRUlhn0glcha2RuD+uBFhbBhy/gEluo7/5GEhLTez5H9zB3QkBJysdxJ2yKJwgzBFMP5KdEMWx1zEh2FISBE/o5lNModMs8m3yIiebHaVzz6f2mosMiBu3JRKhgL/n9ISfhNoPxEjjwPz0OrYo4nWhTkVaPp4KQSoPlFLLwnZ64v79XHhBsGvW0txyFOrqOGdPilXkJwMYlOH+80XTpvHSUMlIP9UfTc0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3YAXBmV0A4wRguCFKGHXiCDOt7Ejm/c0u0DYQMDdpU=;
 b=MMeH87xy4Y1BiFOiIzsF2VzkoKy4rJKE7Vu6BzIuYcljTOunRQ1+t8sg7QOxGlab5uaEJ4YTnoKUYEXnwtL57w7LO/4tA6oHT7kZgFYMXnDGLTCT9qkEwB5UDm4Diyb6nUVNUBQRdqzjyAYW0vnGsnvtfT/jJapBZQpmESWe2D/TzdFIgat07Zo0FOnuXAOyecE+Lbnpu+QjXNDp5DtHhALdzQzuLf25u4Cxp3OWz+VGvRuE4x091EhcOaZf8Qw7hmbAtn4A2LknS9mnTyXgvbgFY0ductRQ1l+C6/+1B0ze8bmBIN3Fwf9ly2JxUH/41CSktvBqv/dX3OZKvoGmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3YAXBmV0A4wRguCFKGHXiCDOt7Ejm/c0u0DYQMDdpU=;
 b=lpdUJ6tnhdZVHxsqNe2sfxwVwKts0Q/Svr2ldB6nFMjDd7FlDOLH4Q8QEbnjaJJWdxn3DDUhZLGWyw6kI7g2iNCc41XK0Fbl6DJZVf+RqLu9QSbVTHRR3Es9RDx3OntklLrxT9RtKQatm/1QlxFVtwoIeIjln/tQLAbE8W1NnmI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4272.namprd03.prod.outlook.com (2603:10b6:805:c8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 8 Jul
 2020 20:01:28 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 20:01:28 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 2/2] fuzz: add missing header for rcu_enable_atfork
Date: Wed,  8 Jul 2020 16:01:04 -0400
Message-Id: <20200708200104.21978-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708200104.21978-1-alxndr@bu.edu>
References: <20200708200104.21978-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:208:23e::9) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:208:23e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 20:01:26 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb1b0f83-8938-400c-2506-08d82379b2fd
X-MS-TrafficTypeDiagnostic: SN6PR03MB4272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4272C2EBBBB2FA29B2E24A3FBA670@SN6PR03MB4272.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNKGi5F3jw8bqEYslInSUffx76TrYpXL+Qk9aYXZODwjED8bcHli7grRtJ6eFxzE+T7FK5HBDWEbNxo7kdSz6mpcK9TJEXdZhc+KZTl69zO5VDnerC1Amot4DG9pP2a8ipL7ROeQWWtfxAO9YJK5SanCTsAvsty4Ft9scm/V4/XSh44fvc/aEK+BtmPFzHMTfYgl6RRU/evqt0pFH6RfDcgk5F+sq2Ia3pFQnsn0pND60zLUJrElatySLAD7vl+UeSPFntBxDNMeo8Ep3afVIn6buHCiHP68NJuqq0o78h0BgJmfZtqqXDZxfebDQfm2B1dsM0E5ASuM3YcNqY5e9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(6666004)(478600001)(7696005)(52116002)(66556008)(66476007)(186003)(54906003)(2616005)(956004)(66946007)(26005)(316002)(16526019)(786003)(6486002)(75432002)(4326008)(8676002)(4744005)(1076003)(36756003)(5660300002)(2906002)(6916009)(86362001)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hlO8BEzmNMNO4P/pnUZjx1PY18bZVxd8bRvZCX6Osvd3ah6HqNtTEipbrh0w0ObMI2S26sG/8CIfXd08BEli3rzGv3U49s2v99vJ5zKwtuqM++kpplHKWwe3/NFV7Fa0MGoITQAdUecjnZxbQRa0iLR8N+mC3cJlfTe1pukqIMlCBVf1J1V7OiXRpKJux9VZofNX6ANMjhEfjZuLtIKucablgKCLzFI7NARCftYbprLn/DODUR/M6XUWl72NIgCdJlRMYj2cvdz9GStRElPWRRFHejgFFNbF6BpcP58lwqngRqhEjAEN6X+g4l8yfHZ0J8osOOxdcGreDkiNt2k4c2XLwHOq7faRAr/lCbPnkTCnx84+UQ7PA0Z6IdX6sf5DPhmiziWqGH1c0vgOaeh6kGQfzPfRbkuI4hOWfsBMd+vM9ojztslXTvV7nowLaVfbxl+cTMV2hKxtPSqa2l5aUeVi2z1Xy+UKjhR7RRpNF08=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1b0f83-8938-400c-2506-08d82379b2fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 20:01:28.2219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3ctYjSlu5cPG4/ZQtbqaUIqF3+8Ey7pk1i9CzkQrKKR3tGXlaL9SXheth471T5g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4272
Received-SPF: pass client-ip=40.107.237.125; envelope-from=alxndr@bu.edu;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 16:01:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 liq3ea@163.com, Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In 45222b9a90, I fixed a broken check for rcu_enable_atfork introduced
in d6919e4cb6. I added a call to rcu_enable_atfork after the
call to qemu_init in fuzz.c, but forgot to include the corresponding
header, breaking --enable-fuzzing --enable-werror builds.

Fixes: 45222b9a90 ("fuzz: fix broken qtest check at rcu_disable_atfork")
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index a36d9038e0..0b66e43409 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -19,6 +19,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "qemu/main-loop.h"
+#include "qemu/rcu.h"
 #include "tests/qtest/libqtest.h"
 #include "tests/qtest/libqos/qgraph.h"
 #include "fuzz.h"
-- 
2.26.2


