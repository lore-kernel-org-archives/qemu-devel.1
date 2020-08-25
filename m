Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA7FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3305120786
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="c8hhhE6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3305120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaIu-0001nn-Co
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1kAaGa-0005gg-Em
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:49:40 -0400
Received: from mail-mw2nam10on2112.outbound.protection.outlook.com
 ([40.107.94.112]:55521 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1kAaGY-0008RH-JB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6Rl4J5UUqQsUVQInraTUlVanFo72/mmp+Yx5DSOcPuZPQioUGmHuXehHHGwLNLuNhfipOshgcGX6Fto87bQlETwRglqu5SMbx5HiCuJlc0zvMjr2TilIoHHpPj8KIV59gNj8Bdjkj9Kfx8uEdcO4/1oGyYryJ9aa9Va5FwzzVt74GbTEmompmJ9nibo0Qq7c8wUNOmv8J1bzQUUt0yFo/kLSZzteDGtNwoqahba3yBGuJvp0BFQ5ZrnH3dfwl2g6b3YNisE2RrL3w03GHDAceLT1W7PVekt+aTDKVnKrBsD7qOWVRTQVUIdRc+ZftztFf6flBCpAeoiobsYAN13Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8An37WyOUMpteaKTZQmOKwiRU3d5MsT/RLHaGZFWzSg=;
 b=Mzi1JEU7DmcDiaOl5XlgNOKs9J2FB2McLRWO9nnwUBIhE9cR40r8iaGKvs0QDxbwMXOLoFaulJZrbMSYdXEu2clNgiPu6FhOgfZ/Es6EameqgJeFb87jZdhk/1llf9OjC+fp4eRDfnRcjO1sJmHHePzCqdbo9VKIza30auCL/xnpg8k16RgVZEbaxJG/WGTw8WMkzXlbueFH5puA/o3zeH12+UpXycdcrOYxyj16MPkcBBT6bMGsH5DuIO4/123UjXBtWQK8XpQeIGy1lie7zz1qfjEXjQ79Ho/w29ErbidlCpHBMG3IY4qPVcEGnzk1IH9rgKTK6u3BlZQx6zVzeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8An37WyOUMpteaKTZQmOKwiRU3d5MsT/RLHaGZFWzSg=;
 b=c8hhhE6EsY4NC/X+5nijUao+i1/AoXGibDivXxTq4NzYktvsu4xdf9XdInax7ZEGGtXNy7E2RHkV9cbrl54S1RNFAPM7KzA5osA1H9XzaOJUIIzD1X5kkCpt78NUetws6f34FYSAL6sAAUNJFkwSNcgzPlyS2Rn37QGEgyUyr40=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from SN6PR01MB4304.prod.exchangelabs.com (2603:10b6:805:a6::23) by
 SN6PR01MB4990.prod.exchangelabs.com (2603:10b6:805:c8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Tue, 25 Aug 2020 14:49:35 +0000
Received: from SN6PR01MB4304.prod.exchangelabs.com
 ([fe80::447c:afdb:2702:e275]) by SN6PR01MB4304.prod.exchangelabs.com
 ([fe80::447c:afdb:2702:e275%5]) with mapi id 15.20.3305.032; Tue, 25 Aug 2020
 14:49:34 +0000
From: Aaron Lindsay <aaron@os.amperecomputing.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>
Subject: [PATCH] target/arm: Count PMU events when MDCR.SPME is set
Date: Tue, 25 Aug 2020 10:48:10 -0400
Message-Id: <20200825144810.1755379-1-aaron@os.amperecomputing.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAFEAcA9jUpJF4FQirb3avWJAMjh+AdkimW3DgMyMjbDjBCQSvQ@mail.gmail.com>
References: <CAFEAcA9jUpJF4FQirb3avWJAMjh+AdkimW3DgMyMjbDjBCQSvQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:208:15e::41) To SN6PR01MB4304.prod.exchangelabs.com
 (2603:10b6:805:a6::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR17CA0028.namprd17.prod.outlook.com (2603:10b6:208:15e::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 25 Aug 2020 14:49:34 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.73.113.219]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b72b8d38-48c2-45d5-125a-08d84906152a
X-MS-TrafficTypeDiagnostic: SN6PR01MB4990:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR01MB4990E8615A844BE3B719BA858A570@SN6PR01MB4990.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXSeWXNg06NNIX8xudNKx7WQbaErK3NopsqJHqZuJQ7CJX/MHcpZExFK20W5UBSIWOnhqcb3iomRVcmcDmMzMW3dmujLiBysVI8m4MykdETYnY4XdZAaMOmHb8iB49AZAE1GYcT0SCmRAkHuYUbock5tLVeyqHTSB5zYaG1JqTy84vxV8aZqJojbugRiDJ+Lr9HRqaNw700AGqsm1337kVjWcEia3+CbpvZ2VlW24DyuqPctP9hLOyR4tVtu3vyNVfxcEoKxVJ5VT1b6xsp2BfW60qM1EGGU3An/RFf1yagfimeD3PJ3q6fne3I6OFGU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR01MB4304.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39840400004)(136003)(366004)(1076003)(83380400001)(66556008)(66946007)(186003)(6666004)(26005)(4326008)(66476007)(4744005)(52116002)(5660300002)(6486002)(6916009)(16576012)(8936002)(107886003)(86362001)(316002)(956004)(2906002)(8676002)(478600001)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4ITKFQqr0X+LMdvVHONkVLEZI4ebHKkEgF2vuFR5gdBs/pHvBL1xQeVG2b+dLuUYhJor4gxH3BmNWVikrHfIejn7YIlLITR6jV/Us/oRUMdFiSniafNPz4nTucBjIb5sF5ODlsD2++xfFWcYLV1ZAGzh7UFp7t0oMdrfK+3ZzenMUMW6EghtNC3QhZXUoee009gFkKbG/2t9vPGAKQH2eL5P3xaBByPo7diXd6nsxhFX+xv03DCV6c2V9E1e0emknMXcJRS+Oy0e2U7YJrHNL0gZfeN2Ay0f4YjT3bp8rxiuSHKEOnj4C9JUrDB1cZ5rE4o186SKTJWsb9TmQJuKwbKgv8W/Mqj6AR6m/ncwUAvBc5bsrOQ05ccNxrLbg6dinhJ+yEQ+lzykrQ+uFBZhyxyBZeQdkcTPqVbw54EOMs/lzF2UdELQFe/vLfqNN3bmnl+1TVc4WDRugIxe1JMYjX3E6OjwDakH9O8wfJMq24zfn7Uwhoz/c4L9Rh6uUuz7C8AABAGFQbHssRSOs3qSfMY6p6oXNKSOz8HTpgs9mwGhQ99Fub773mUmXVcsqBEHl6/IwBqDXSZ3vl5gdFm7yG46vbm+E9QmIfYdGmgvTEapqR55UvqeX1NrCCIk3j10NC0a6gbttvLQXmGqr8AKDA==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72b8d38-48c2-45d5-125a-08d84906152a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4304.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 14:49:34.9753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTpekrf+ke6+2kWo5PjdAgB9XwH1ijtd52bGZnG+tNkgDG22km5KIAUK2jypNxSyfjHeYXzAazUHyOaZu2VDgovZVqY1yL8RnUO9Jq1hLtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4990
Received-SPF: pass client-ip=40.107.94.112;
 envelope-from=aaron@os.amperecomputing.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 10:49:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This check was backwards when introduced in commit
033614c47de78409ad3fb39bb7bd1483b71c6789:

    target/arm: Filter cycle counter based on PMCCFILTR_EL0

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6b4f0eb533..8e7730c7e3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1452,7 +1452,7 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
         }
     } else {
         prohibited = arm_feature(env, ARM_FEATURE_EL3) &&
-           (env->cp15.mdcr_el3 & MDCR_SPME);
+           !(env->cp15.mdcr_el3 & MDCR_SPME);
     }
 
     if (prohibited && counter == 31) {
-- 
2.17.1


