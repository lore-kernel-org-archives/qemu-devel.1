Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024ECC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347D920848
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="MUJNS5H4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347D920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLbS-0000Br-0Z
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN3-0003uR-14
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:09 -0400
Received: from mail-eopbgr690121.outbound.protection.outlook.com
 ([40.107.69.121]:59894 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN0-000854-SI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klefLHG85UNRXjqCR7okK9rh1e5me6TLo4ej+ztfDotnuy7lz4ibOHFVOFCURrJKZBCJmJETlxaxExLu4284qhFQ2kKk37PTiSLEeI8xcJ44EonGTOxJYT/b0AhNmFpQlV0XWOdp+V2MMwHwTdLyO2ChwHP2MoUCL2Jkc+wFsEqsaZGBAsFSQgiW0v+NJ5dLkG8id8E9Wh/6AymM1D4SAQU5FZZZx/la9zpqqxAIP5HVnns9O1R9phpU6omOA498zWvBeNifmHv9vlqdSySaWm88oFjVhQlQX+BrUZksF0R0pMS4PTb+xbOffkmrg37PsEWhes11jv7iLyuKDotgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofhel/Y+zk6nPpUJhwyqcyc0WQlzkNTfewTkfViO8DY=;
 b=KzYUGUP4Z7wkXguIJPdVZlGQe66He7jp/uhM8Kbquc26j6vrzQEpmuJSPGlIdualVz8defdl3rZaXdiHz7EBN48lxee8QTiuuYSM/lfhVN6jG4KY6IF30r4yGHmstX9hUZDxvGnMBP5fU13ki3fPAwADH5BxI+di7DMiUAuiEIbWDV2yx7uH5fmyvKMgPm6vUjgrx1/5TJ4iaaQdVzrSHnmA4yIpyHfMGcbHD8aIWv8jGmWgetP0xoTcrbOOV5CRcllc/KE9jzi5BQQq07ZtsbCt52omm+1IR2qVoNAqOl1u8zrOvJwG6RpLXtJd+/YukLPdKSHzTPVd9q8MoRHNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofhel/Y+zk6nPpUJhwyqcyc0WQlzkNTfewTkfViO8DY=;
 b=MUJNS5H4me0iT5+WOt0zX7v+pu6xsCFSiu7TV6aO2JWgKQ6JZQbCJ+R8dkHG7SByAwX30Qx4PNMJqpp/0SbDv6hpCwkFusvGWbcobkt5aFs3mSjPn4BGYaA3l09c5ePgFNlz2aNbpWMOVtwWTNsMonW+iG0O/tV5xUfQK/4lVyk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:55 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:55 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 13/16] fuzz: add an "opaque" to the FuzzTarget struct
Date: Wed, 21 Oct 2020 17:09:19 -0400
Message-Id: <20201021210922.572955-14-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021210922.572955-1-alxndr@bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR0102CA0064.prod.exchangelabs.com
 (2603:10b6:208:25::41) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR0102CA0064.prod.exchangelabs.com (2603:10b6:208:25::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4fcd7d1-4ec8-4971-5865-08d87605a84c
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB40458B23ECC42BE9E5A109FEBA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72/82u0h+ZwTku0lrdqMSFZ2aw/ddXw9bTawG0H8YkeBCicSJRn+qdVXD1DyeDhJv1TAoQ9JVMSJXp/lO4kx5xGrWq9K8s/NXL5OLU8Hvfjdxqfr3Ij8vnLyJmdnwVtNIu306rvYkC83fYEXH4pZRcUBSgx3evOwaFp6mZtA3mB2LnP4lF9Dt3EcbgwL0pU+OHAwG+F74c5QBywog8oft0+igkrH/ZcjLZfEAYO4OMiaryc8Dc+hTms3SWJfXEM7pJpqo3wyC4Ht5Yete4fxyEg7vwnVp52pwmSmLcJPeM0xAcXunl4cCcPJ4phro/0g+mpOCnjvWryXE70C98aXTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(54906003)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(4744005)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Wokg1UlwOr0n0+lQjRL02LK3YsjZdUIIQf4YA/Q6oMxLpIv63ztKTwM01yxx01ltOyCnG3vwuTpLBSaEDIsAAZC7hW+17/cCoxwHkaWCqeCfVk41nD2LDHiXtr50bdML2fDkMCeU517yS7FOz/TeHqyGI0BUhSQRZ9UEkwyDef+cVx3GR+aag2lXRpc6G0jKPPYkx69kZCXYzlVoUASLNSib27IpG90n3F1WZ30Q8D7re71myxfHL56xyPH7Ef2ajkGP42jKU4Jv7WfGqyyyaje3tOsF4XmOm1XkLqH5rBXdomEPLK78IwbOyLukxDC4H8k4U60iDhrriy4CA7Y0lJh21ykeAv/FrPK9OPz6RCnVkrnzuUF58XqGnuiIOFpl5V2HGB12d8DCee/SldafpaHBMWsyc0Cni9XWkd4tQqGnbEQynWWxkf1VkrS/kHX1CWq2HMRJKJfVBRw1+ZTtjw9Y697XWTL8/gZsP+F0bx6VLj5AxfA9GLKaZvvw4znzSicXWUUpkXz+Rt0rs0sglC/T8CUCoGPAGr3wPPKmEI095/baTVn3gnlvvvJiwDkkPKodaJnzX8ebal/i5YBG/g2jf+lRfhY7JYLoC92i3v8nKzm05L/mxofrt4HOEQKaJBqI17rFT27m7LE0Of4ulQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fcd7d1-4ec8-4971-5865-08d87605a84c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:55.0420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtl38Vza5wo2vYsRxwpvxlEWZWQd52F5arH+VvXVgZRwGN6+lcSzx48TGnQ0iYLS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4045
Received-SPF: pass client-ip=40.107.69.121; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:09:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.454,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
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


