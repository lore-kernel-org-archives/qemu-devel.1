Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F83C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72416208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="jY22bhUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72416208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyoG-0006NM-B6
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg2-0003wt-09
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:22 -0400
Received: from mail-bn7nam10on2139.outbound.protection.outlook.com
 ([40.107.92.139]:64992 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg0-0007AB-Fp
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/3VesC3AQ6ZvCraTeMIDoMQSOKbm6lvrCnZuJil/2DtbLnVUPP7tVnSO5HQvb3Wkpar+XVkTSKk3jSMehjs+epzcg1PRjvoA/+bqVmupxJJ988JnMdkonnmjVs9QxVcl6sL77Dj6E9rYjzOLuhHl3+fMcU+yUxv3nmLAlBVjOYQSJ7uwzod755KGluRwfjZ/wllkqZMHnd9dVsP6KoL2WsgDSsjrIVtXqegVjbTS5bn/uHcDbUsHGTE9mOnV+GgddTmvqD+CXPIvMnIb0hygR8baZulHTFzVG+zFKPbKhASDHpduY7N7zSNOL0s/Bb7G5jNB6sWEK53qyw+JBRPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhub4K0MscenTNQAKzz7uu6HWMoeyiVockrHhmm3j1Q=;
 b=HsB70NBdumDMzomNhq4iCcAI/v9lnfXangED5JR/NiLCDJHSMDGN5hubFNYkLlI1QRTZCTVjKmzghKueBi5bH91lGiAEtQoFgkJAU/8k3Sz94QApvM9SQ+D8U3N9wceP36tZEK0vrTafe9XleZvnbh0djjZPCLjIeDN1HawCoifNSKRRBKXrhSLgAi7g97oUYTF/5j0M8i27nTMCimUusM5tayca6vggbqhutZyytjSuDesMbBeqC/CWc9c2mQ3IlAv+d+R/BdlZ5Hnu73kLONUQ1Cf3HxcB3LBHuxEIPbmm/13UddMJu6yUwALWXMTftJr/0D88HwAekm2LoSCZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhub4K0MscenTNQAKzz7uu6HWMoeyiVockrHhmm3j1Q=;
 b=jY22bhUuBpd+EJE/4NWMSUw1GDVeBlSi0woz7vPothN2XZxhYaCgwCPgrqgu0EuPiRyylVuaMxb1e/OxypXK2wR3SmexSx5XfcowKPR4KC2DS3C3K8BOBWorAQ8ZjoROndVXFx+JwWgTyw44oRCfEW79E3E9cZzxYryVjOZaVBU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:15 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:15 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 13/17] fuzz: add an "opaque" to the FuzzTarget struct
Date: Fri, 23 Oct 2020 11:07:42 -0400
Message-Id: <20201023150746.107063-14-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023150746.107063-1-alxndr@bu.edu>
References: <20201023150746.107063-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dd3b082-a572-4b71-a7c4-08d877657734
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB551688F314CC1E4231A5B3EDBA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1OiE2ueIIOHQurZwJT9iubX0BDWjhE0FIiZ4KRzFEFhI25u+JmnrMwbd9ozCgSk/AwnPsg4eyI0p8sVq4GNju8bZOLSOW/h0mhuSXmtOS57K9zei8XppVHsIY50VEhmBwxioC78tk1M0zRkSGEwIbYylXFqWigbJUZq58lk2ym8AQdQnwtHJKsdwTWYj5UqtY+/m7L6zD3naUtZf5H48HHyNDcjMYEH9X7T6V2QVjmvNbs4olFe9u5fahjDV1vNFXaVWStuCqfIbOeyTmsIAk+biafI2reCNZ7lfSmOKg4ENzGQrXsE7iuMvG5146j06IlkJwFcbYVZISE97j+LPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(4744005)(5660300002)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(54906003)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qxldeaxiztSo1tSHgQoNosccUil3N+trqL/OPHQFPCKSXNkotTR+0MBOCD+Vqi74s1Op4I9Z9+IYSf0bZh6LIxigJVTO/Jrid0y5/byJQEgIpnzUgHJkAJzkx2hFp6mg5iUg5vLxP+nUUgRLwD7nsZmyGeXiEIu2INLD4HRf/ts074yyKFgJQdfGjP4ZJx84uBaJqY/U3XVZSWz/e7bqe5z1Hxt7paiUrYbnEfcMO6PDT576VESba2FDRmSg6HxbueKKNMoJzIxpWnkd3e753vRoj0whOQp++wEpQ9jiRwc4R3zpBgVtwp3qdARGJk9UgDk5RYRR3ioISeL0v2oCD1QkeKJP7Jxri9qQm+B8hUPMAIMb0scEWSo3PJDvbfIeMmylF3tz15Gyr6ApzY3cW3iQWosqwrOrePuBj04jvCfOnl/7waIFB/NI8nESqxh2IpOm+jMXZOd1N0iJonZ4hgLypy2yRSHV+WkiJgda4RyOCgUM8fPYhsFLcL+G8M9PJ2MBxUiOzxrG9e37RoCJnWgbtnsMFlXKKENJMkhfbKPuXbZuh6TyHEUbliqVnrwxQSZXnpn1lGOdEM5ZijI0bqXyyzR708Sx0OIyxP9nAbkZELGizfBgmS5vnkydIplSNkBz2LXSk8GiQgRX906glA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd3b082-a572-4b71-a7c4-08d877657734
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:15.0545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzKf6pd7m+ayosRZOguCxhg1YZ9FUWwQ3iFozjyXJneS4aUdm8a2UVj74NF2T+NP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5516
Received-SPF: pass client-ip=40.107.92.139; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.63,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It can be useful to register FuzzTargets that have nearly-identical
initialization handlers (e.g. for using the same fuzzing code, with
different configuration options). Add an opaque pointer to the
FuzzTarget struct, so that FuzzTargets can hold some data, useful for
storing target-specific configuration options, that can be read by the
get_init_cmdline function.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index ed9ce17154..08e9560a79 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -100,6 +100,7 @@ typedef struct FuzzTarget {
                        uint8_t *out, size_t max_out_size,
                        unsigned int seed);
 
+    void *opaque;
 } FuzzTarget;
 
 void flush_events(QTestState *);
-- 
2.28.0


