Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE96C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73912098B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="dXp2hMEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73912098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2qs-0006AJ-Ui
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cn-00027B-QS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:09:09 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cm-0004s9-BY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:09:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGjmwzHr59oNcpLTf4EMRWuHRNVwTSM9D4AN6hK9JNqNyY1D7Oe9IJTsB3ndXoCOG0lxlKpw/PuWyjYjHNBm1rNKP/ZG6dQSYBX4j5oSOazOQ8WRjV+RoR9ByA0mttYLiCAzH7LrWeuOl90G/4yScfGNXojiRoJH825DVHkdAC7YjhA+hMycHO/Uo8ONaYk0nO4L4sS24Iefo1u54flHu4FjZ/FLADE8DyUVU+OufdEiQeBBoOCQuZFIUv0htR22AblXJM5UtgOlRetNNgAaLScd0IaQpG1vUorx198loaSz8z3UBiq3OPInJCBO60fOcP+4VEbZA6tIgjiOi/wVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzftJy83Kkyh0SvycGdUAqsn3APx2vCrNfLWB5KU5aw=;
 b=autACgSdJNxoCVKWHn+WTAjpuFRCacZB0kH6NDn2l8MFjOXLM1r3iXsvjL3O8Hygf7a3xZmwzg8mJvVP/UlSM4N7UpapGFM5ykEeStgKvmjUQ2E0baF5BEzXTZlYDm+u9d+4j6K4J72kod/TxReDC7AS/lhrqEUYR4hQjTGe07L+n9qQSCfbMvfd3HzmvSPL7ouoz2HkG/SOJmGW8qCpY+xqBxpaW3qEEumzqKulQl3wmesSgTnvVnygZ7z4PEC1npopfjrq02knPD1dB2QLJdNK3xuJuf8gWLRcpAf8mp+hcZlOaY7uKbJMhVaEkuqk80/HTryna+rs0y1dfvWDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzftJy83Kkyh0SvycGdUAqsn3APx2vCrNfLWB5KU5aw=;
 b=dXp2hMEiv6RuXTl+RNyjZy6/yPXL7IgiTUc2hj0oPwmAz1RnLjQ9B2LZX96A1IbIcgSZSVgfS7gZWxVaVmEUkrveKeKda/e4PEEbhxHdEmapiLYQDW2yIe2U/M2jgSNcDkQVwgre1NCJRzAkVk8i3Wnc4kldorncb63uRVCZwok=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:28 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:28 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/16] scripts/oss-fuzz: remove the general-fuzz target
Date: Tue, 20 Oct 2020 21:07:52 -0400
Message-Id: <20201021010752.973230-17-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021010752.973230-1-alxndr@bu.edu>
References: <20201021010752.973230-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Wed, 21 Oct 2020 01:08:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bf79c84-b71a-402f-3f9f-08d8755dd17d
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB23339190C6CE6BDC2F13F288BA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjmGIoCqezQgTAkVPJ38JhK3mM89RX17k6XAdN+oT7TNdlBeKiTd7T82lWOxwBhntVe121vSAQp5ur7N03qWG1NkX2KhnmlTKAYzqG5ogyWIqW9bIePffd0HXMajwSaGKsXYlrIpYFz6KW3hYUOBvSklNn2ajv9pnjkdHLkVhh/B1bYtjW8/1D+QRTJQckXKjoHq6VfP+SbsendPAvlpS69eeurmFBaCW0DTqo21lDN6l2HZ9PrLhnMY2lshWZ9nOJ09EmpgC1hRvzqZXmIV4Y25JZWpmdWVyqWzmolZ00R230QkbzxPFAwTcwmIbKqxH4PJu5I1IcyNPixlr2DXxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(54906003)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6WcWdqJIhFidizEQJNc2vs0AwTu9/PnAWWsR7G9l4UffgS2kuQvPCcLmGS5UmLyaYd/l9yY7TYOF/5qXnqasTbVpJP3EuUVbXX3aeA/MflZPJMSKZQq3ZGUyVQCfGBnUAjiwHBLaATTW1yHceVdiDrzic/5N8snLeXhrPhhSA/IGRTUzPQFD4nQyGnICC5emyD+kB2YJuz9hs0+M4L0hxWTRr9JZrKsNOw8AmbmNIAl+6dznth+CSYFoq/THQOrpLROAvd1JAyX8RrIx6iTeFlHqlziSoNV4IFrf7k30WrnYZaQdUoHsY5qGrwhP/oWWwweDEKQg/iD757EyqQyTSY+ydKeQBqJn5UxcAXvV5PbV/7hFEpBBZ8QX3fvHC8HoRWsWyQdDKvAmF60rG0nOXdjxa+uuL9+wJz+CIw4Vzu6NFlvmez7yLWF7pMyB2YFxeqxYV/EYtEdj3GtIUwSgEBQoKmoTsBtvqkJb9p7+P4tmle2PLzAXYYbiznX32lnT4KydzZGlzdPSu9tXccK/EBlyaMu5opdOY5/D7HrwsXDDyiDo4RAM5n4gfgKrbFu8c9hLhMebHgAZz4Dvi2mUEPUU1i8Se9URfNUi0bVofb9SqdJaJ3RvNWc97/1WLKwl2dk/L3Shreo180tEGcrQyg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf79c84-b71a-402f-3f9f-08d8755dd17d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:28.2268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxABPzdIz4kpP2kbjsXr5qqmoeuuhDbDGmKmxk56x5IVm59mjjkHBfRotsyQtA5n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2333
Received-SPF: pass client-ip=40.107.220.130; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 21:08:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.441,
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
Cc: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

general-fuzz is not a standalone fuzzer - it requires some env variables
to be set. On oss-fuzz, we set these with some predefined
general-fuzz-{...} targets, that are thin wrappers around general-fuzz.
Remove general-fuzz from the oss-fuzz build, so oss-fuzz does not treat
it as a standalone fuzzer.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/build.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index 0c3ca9e06f..eed73ea410 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -97,5 +97,11 @@ do
     cp qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
 done
 
+# Remove the general-fuzz target, as it requires some environment variables to
+# be configured. We have some general-fuzz-{pc-q35, floppy, ...} targets that
+# are thin wrappers around this target that set the required environment
+# variables according to predefined configs.
+rm "$DEST_DIR/qemu-fuzz-i386-target-general-fuzz"
+
 echo "Done. The fuzzers are located in $DEST_DIR"
 exit 0
-- 
2.28.0


