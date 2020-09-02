Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC9C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2390207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="1PR6Y/jV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2390207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWl4-0000z5-W3
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDWhC-0005nn-A1
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:37:18 -0400
Received: from mail-mw2nam10on2114.outbound.protection.outlook.com
 ([40.107.94.114]:28257 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDWhA-0004ye-Mm
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDPWQHNFzT+6Mw1oki9bNNopQqeszqYu43/C1AzS+6tNzMggykSmrfbGRUT3sit0bJbFX1Z5FRwKYbSfNFKKbWvrU2PhjsEZTkjMDSwiDDe90OR9f3Oi5QwAnAXCKK19O8VV7xlwlNTj4R4yeRPVzNfNxBDLb2hl5dFFkjElhKjJ29tFe/BDgPh2xdjkN3w7Mep9O8kbr4Szk0venYJpOB5B/D3XSchhuQVXYb4ZXn8yD+snqfwpa1PE1MINvGlcHwx5qzuwDrJvQ7PSDURLchBqpWXUCvaOP4qc80UBpd+LTE088JuzVx3bIfpn+4wN4ickxt9JPtSAA9JgBZgi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kjjDevcrngpcqFVeuJ2EUYRDchmPlweqwRueRD/XUA=;
 b=QFIqlW4gH9PpfvdPkLhFzWsVcEm1nWO9IrxPZt938E89F9Wo27739HVzps3GRrCk9RKPXbkvhVXp7kftIkSK/bYyeOyQxJ5gpg4mvtUP2Emaks8tO/WbNu3bdnrL9LcbeWe+x1pvGMtA9gGslPvbA3b5KP3X74yUGN7O4dfORQTIqlvjU/FZZD2VDLWtN4lws2y/RmoCa8Voo2urac7WG5nlz6ZaZknqDmxlMTtHAuwVxz0EjTHkgZSl0IN78svNLsRxOp9jkbiIsje6MYfiGDb0OW1BjZABVpy1Qv7ZRTaQ14yavZiYn8cOHiKKGwekd4KoX0FeZiMP+6mXGS01Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kjjDevcrngpcqFVeuJ2EUYRDchmPlweqwRueRD/XUA=;
 b=1PR6Y/jVRXM553Fz1e8vV1eqEJhszZphQ8vBrMRPjdF5Lg4lVSDYUy2t4xlYc9UcgeA2OGmgAX3ZteUXElxZK/CcomNPjawvy0xHyx8LgLa1JF1k2JIYGgW2TPsj3WPbeNbx1lZFHYffmMiLCEb99e1M0xJGgJNHJCnf+M0DuRo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 17:37:09 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 17:37:09 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] scripts/oss-fuzz/build.sh: fix rpath
Date: Wed,  2 Sep 2020 13:36:52 -0400
Message-Id: <20200902173652.307222-4-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902173652.307222-1-alxndr@bu.edu>
References: <20200902173652.307222-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend
 Transport; Wed, 2 Sep 2020 17:37:08 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94ef4cea-3313-4309-6636-08d84f66d18f
X-MS-TrafficTypeDiagnostic: SN6PR03MB3871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3871FF3AECB673317E4A1544BA2F0@SN6PR03MB3871.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBE94o+nMopS109MZ392uXk7di/yZt1DM6hY/Q2Q7AoU0yfyITcP3UJYzfK/MYLAQIsqLf2oZ+JNtcn7AaH276EaF7dQddaAw2LfwQIt64PRkY9uFLQemJNWkuAhVl9iYPN+NgbPnKMfY6nuvyyV1B0VojIUVLJIyPyN7bk8RdKGAG7WDD+YAC73a7gRmbwDOMEvx8S+ZP9TYuSrStUOkge7qtMrmkMqpjUEWuaJIdNirl9cFJh/S0JIQZb4Vw8FbRflTBIO61oGBSingBoBNjLvV8estg+Avv2F3+i5TlooCI5XPWusyHipY+dDUN2dysizK+BWb9WH1x/zz33esQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(6486002)(2616005)(1076003)(4326008)(86362001)(66946007)(956004)(36756003)(66476007)(5660300002)(16576012)(66556008)(83380400001)(316002)(8936002)(478600001)(54906003)(2906002)(52116002)(186003)(6666004)(8676002)(26005)(6916009)(75432002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TOEM36cilUCDRY3uWDgQhJGZXnAfKHPwyKeMnAP3iDbzX3Khp46jU0RHH44T0QOA39M6wWX8E3A0Afs5fxqz94rinNLNWElT2I51vR953w5m3/hs0Ah+dkgZmcZHxGnz019r8dKsioky3drO7O9ScDCN3H3YCQVrBjh+4+/wBiVUYEsq9bWNhc5VrconePWHf3tIZH3BiMzH9SVEDj82vWdMlv89O1Jo40oQwUhJOB+oNhS03l0qLue5SdHYkjXuedheKw2zHZan8vbYUlxCgSKGXQi3U3fzv0aSSnbx4qQrt/W6B7sezSQ+IgvG1JktHPdBfcXqRmov9y1t6zjzZn2a0M2W+vj90wHqQpYrbVCIz1hwZin1URmsvdXrESkwD9FQDwrwRLzRrkNjF/47+TSKrUcrHjLRoIAFCco+akcwVqB7+vfsKv6cJVi0O+L9oYoGXyLlemspEwWxiMoSET1Iw/XKkGlygDuGNqj7NPsWMMutVz8QW7tPbguuBzp58tZ/K//h3E5U5evqICeUTqtpsIMNEG2VBsqPtVBMQf4rR1tvuYcoKMcNOrPpnYcT5pXHyLjoMNLAP4fIAv4qztkdpOoER3Kgm8KSf4DjZWl6jIzzFqgNEzI+Z87ga8rd6nWKX61wP3pDFP8aXs6ssA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef4cea-3313-4309-6636-08d84f66d18f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 17:37:09.6528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eg1hrM67is6O6rS7MTSCNH3sOUXXpTkKpIdeKtbFh848SlLrdVFL5haJ4J9caFED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3871
Received-SPF: pass client-ip=40.107.94.114; envelope-from=alxndr@bu.edu;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 13:37:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, MSGID_FROM_MTA_HEADER=0.001,
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
Cc: pbonzini@redhat.com, Bandan Das <bsd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prior to this change,
readelf -d build/out/qemu/qemu-fuzz-i386-target-virtio-net-slirp
...
0x000000000000000f (RPATH)  Library rpath: ['$$ORIGIN/lib':$ORIGIN/migration:$ORIGIN/]

As of 1a4db552d8 ("ninjatool: quote dollars in variables"), we don't
need to manually double the dollars. Also, remove the single-quotes as
they are copied into the rpath.

After this change:
0x000000000000000f (RPATH)  Library rpath: [$ORIGIN/lib:$ORIGIN/migration:$ORIGIN/]

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index f0b7442c96..d16207eb67 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -81,7 +81,7 @@ rm qemu-fuzz-i386
 # Build a second time to build the final binary with correct rpath
 ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
     --prefix="$DEST_DIR" --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" \
-    --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'" \
+    --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="-Wl,-rpath,\$ORIGIN/lib" \
     --target-list="i386-softmmu"
 make "-j$(nproc)" qemu-fuzz-i386 V=1
 
-- 
2.28.0


