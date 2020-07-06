Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E7EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DDD2084C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="pdkdlH9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DDD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXF3-00052O-Gy
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 15:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jsXE4-0003Kt-T0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:56:28 -0400
Received: from mail-mw2nam12on2126.outbound.protection.outlook.com
 ([40.107.244.126]:37345 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jsXE3-00032S-Cs
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:56:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+qjZ1xT+U2N8EGfIS3Eya9K4Lq6y+lxZbA501aHbqAhQ8kBp7AgAd54u2/+aDWWP2UmBiqlx7FKVv0bDP5PszGCC29fLUXkSBV2J+2MMu8XhR44AFOhSaI1sgiwoeUWjYFJiSTlBT5MKnrKqwiVOlsn3dm4X2Ui+d/rBurRbwYO2mZkSuCJC4O0qck2dhLntoyUctDeYcudOfchspf/3W2F9ET0aULIMtcIcSqbb1AdwxXhdELZ6FgjBIJgKdOyGtk491PlcUVUwlCtJW2p3BwHZF0YwzUkfhhsn4Vfs0dvFOVHZdkneJtx4qb/2/iH+5vruWFPqhcpLjZ6d18wPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH7NF+7Y9CD4fAPbIhuC/DSOh6r1uy1UgxJtzSdvP2w=;
 b=c5P/VI9qxLYgDo2HuoVDWZR9ZkDyaRR2cMAtR8NALXNQ1V0mjLbw3q5dDSwcS6B2LuxNg98rliNfB7j462/wXtsARmV/26SqivDS3c2OySASnnGoCcqRWBO9BUgdIOAvHmla0b+v1gXasMxPuD+0ZC/BeHjOVdRCwa5vhHR4qFjIgygYxY4kjiElSEtsQeUoZlYz4G7+NLo43iGWIH5R0gNyTXBEuoF8hEPeHpOmHg78gT5nYrH7WteDlUIYesk8vxOis00qguDmVHG/OLAZyjhESaWNIrDBVHTBbhFc+nHUDfGusMjjtrQnD00hMq3ZedxzKBcdoM4H3nPMgRuXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH7NF+7Y9CD4fAPbIhuC/DSOh6r1uy1UgxJtzSdvP2w=;
 b=pdkdlH9LRAhtQkUtoVPWtNeA4RKw1eCQqssOg/P2KM0n/+f78++TpziSzM1OyK1ajZJ64ZZluoAqacGr6h5kmDgUqzxWjSv7NGxKSNphEbjtazPCmzZWxf9dMwAvgtFUghrJwdYzM6cbUTPg8vVIs5OzxVZ6iWBNdMqGjW5ybh4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3520.namprd03.prod.outlook.com (2603:10b6:805:4d::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 19:55:48 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 19:55:48 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] docs/fuzz: add information about useful libFuzzer flags
Date: Mon,  6 Jul 2020 15:55:33 -0400
Message-Id: <20200706195534.14962-4-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706195534.14962-1-alxndr@bu.edu>
References: <20200706195534.14962-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0142.namprd02.prod.outlook.com
 (2603:10b6:208:35::47) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0142.namprd02.prod.outlook.com (2603:10b6:208:35::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 19:55:47 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 852db675-c762-4fa0-2a18-08d821e693d2
X-MS-TrafficTypeDiagnostic: SN6PR03MB3520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB35207D66782AAA232966CFAFBA690@SN6PR03MB3520.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rP619gyNKtGnJCHZe/uKjxRmbmDsEcjTi1MnCJJaWJiQCr2vtnyD6Ouzn+BDeEuFkZL/842lF6Pa4V4WsnRyjHFjVja0rHS8/jmjCG6Nk/Y8q5DkdKI3U9IPXR18eNLQyr3hOkPu3brXh0Cv1T1FSluA0shWZ8zejv+itbAuqFAPtqCSQv82VHTUO+UcgJr+1At2I2IY7vAxRvRN7f4hw0GTMxgcBFGDlXrhe34CldtAIthorCjhQxTHHZXk7Lsysk9jmZTZh6Ga+dlj5Mi2Ma7hg22GVZWEoMBKMjloh15ZkmhCQLgd3YSrsWihyshZWvEmjxAeGxRpMWwwzYQFBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(83380400001)(16526019)(26005)(8676002)(66476007)(66556008)(7696005)(4326008)(786003)(75432002)(478600001)(8936002)(66946007)(1076003)(36756003)(86362001)(52116002)(316002)(6666004)(2906002)(186003)(5660300002)(6916009)(6486002)(956004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zpJG7mECfkMztiNyME/PhRQVXVFJsEzhWy/4g7wuv2BjQ94Cosm+zhftLJJoMaFGTBI6NIvnR0fgk8dpjCheOxF4LKtbPb9MZUApE/pjnptcfozdNXuVH3BK6MMry3QXwVcsFvIdTDFACb24+HCxY+tDiOTG7IZUG9zthVEFV67MFLPYD9EvVv/HgWfvaDYTKLmTvCwDAzfv50KsSXzgoNMgqekNimClnlLkHB0nq8VO3zkUaS662DXfFlfEcY8mPbabsO9F6MfYgaz/99TOLUelbwLBFzjdb1AO55fwOnK455NlGArOXGZCOppofNAL0PCHQVyNfu+Wy197M1vA3kxG8fnWqsaXwD8bB2QS7DqyQyKPBwpftJunNxKO76f9cmunQG2p/1sYgyilHESHYUZm7K+Mg8Qj1niQeiTCfEbptudzXStuTljbc6OdYhlOS5rcLQ6OqCCNyM4xNlYwGPh9ptvldG9N7efy4lyM0T4=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 852db675-c762-4fa0-2a18-08d821e693d2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 19:55:48.1612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLtav38GgP2RWGqCsd8klOOGEiTw32ewDld2CxjAGTVmUzaVN4s57WczYf49U1ZT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3520
Received-SPF: pass client-ip=40.107.244.126; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 15:56:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, philmd@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 docs/devel/fuzzing.txt | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 382ade974e..284d57f8fd 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -48,6 +48,43 @@ Information about these is available by passing -help=1
 Now the only thing left to do is wait for the fuzzer to trigger potential
 crashes.
 
+== Useful libFuzzer flags ==
+
+As mentioned above, libFuzzer accepts some arguments. Passing -help=1 will list
+the available arguments. In particular, these arguments might be helpful:
+
+$CORPUS_DIR/ : Specify a directory as the last argument to libFuzzer. libFuzzer
+stores each "interesting" input in this corpus directory. The next time you run
+libFuzzer, it will read all of the inputs from the corpus, and continue fuzzing
+from there. You can also specify multiple directories. libFuzzer loads existing
+inputs from all specified directories, but will only write new ones to the
+first one specified.
+
+-max_len=4096 : specify the maximum byte-length of the inputs libFuzzer will
+generate.
+
+-close_fd_mask={1,2,3} : close, stderr, or both. Useful for targets that
+trigger many debug/error messages, or create output on the serial console.
+
+-jobs=4 -workers=4 : These arguments configure libFuzzer to run 4 fuzzers in
+parallel (4 fuzzing jobs in 4 worker processes). Alternatively, with only
+-jobs=N, libFuzzer automatically spawns a number of workers less than or equal
+to half the available CPU cores. Replace 4 with a number appropriate for your
+machine. Make sure to specify a $CORPUS_DIR, which will allow the parallel
+fuzzers to share information about the interesting inputs they find.
+
+-use_value_profile=1 : For each comparison operation, libFuzzer computes 
+(caller_pc&4095) | (popcnt(Arg1 ^ Arg2) << 12) and places this in the coverage
+table. Useful for targets with "magic" constants. If Arg1 came from the fuzzer's
+input and Arg2 is a magic constant, then each time the Hamming distance
+between Arg1 and Arg2 decreases, libFuzzer adds the input to the corpus.
+
+-shrink=1 : Tries to make elements of the corpus "smaller". Might lead to
+better coverage performance, depending on the target.
+
+Note that libFuzzer's exact behavior will depend on the version of
+clang and libFuzzer used to build the device fuzzers.
+
 == Adding a new fuzzer ==
 Coverage over virtual devices can be improved by adding additional fuzzers.
 Fuzzers are kept in tests/qtest/fuzz/ and should be added to
-- 
2.26.2


