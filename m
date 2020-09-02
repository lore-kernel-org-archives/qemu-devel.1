Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680D3C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E8A207D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="he0Paosy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E8A207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTxF-0005Ct-Ea
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTu2-0001fI-VH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:38:22 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com
 ([40.107.237.125]:4768 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTu1-0002nB-CR
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:38:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5DEGwNpTmS+4DekblYVQVSDJqcIna7DldmxtWNvppyBbZdaj8YAMLXc3T5gecFSsH2aSe7C/qvIRIL9T/8IhElpBG/MQF59YYm6z1LUHzcXN2IlF4OKc/Xpv/Jb9YFRP4RChAKHgiAThBLIIBmzd9e95OQpnm16NvmCXt4aXp4fcQLldgmApbaWEkZnMPPtYUNiLC5fylGbrZQdKLDd91XWtwe5pVT9twHnSftqN+vOX3ipP8Gud6UTP2FAbbHD7vI/JmJ0eJiDM5YPpG6HgCJz2/OA9O2RWjlBO9yra23Hh1ofSA1L7fhieumpjjF19gIj/Hgxk7iEQwluW2z5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kjjDevcrngpcqFVeuJ2EUYRDchmPlweqwRueRD/XUA=;
 b=dWcCXiakYiYXaJU2HaAkNfRZM0kcecFRJyj8A7wtsLDcaWDqQX0kkzUOl+xm68Ei/BOB1FcsTW/swHXEx0MRL9sulrSJ5BKK1z04ZH8bO66g5cmOe1if9sOyOgVYxXuyqjpnsc0J2UFyk3ApABwrE6MiYeNQkux7DPIfQUjzFZWUMEgdPCs3a0MUgFcOjLhQXYYJXYsSEkJ0ZiisIJLJs2DheTKxJ7PpaO6zLOaH0FLOPzfPJxo0PIks/dL799DFpoc4f2xIyoPQp5zj/Q6W7azL/VAP8bl+qoHcPgxD9n4RsubN1w2b+TlRuYsz+xfxMRCzPbflqLbcOWU4tFnwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kjjDevcrngpcqFVeuJ2EUYRDchmPlweqwRueRD/XUA=;
 b=he0PaosyV2+H5Fh2F5v3wSzFh7zY5nvg9aA25h+Q+xpi7HKi13Mt5kmBOcPoiR/ASGRfqlykoLwnVFNWvzqmgs0pHeS33Ubt6PVjxdmwmEjb3AWUaKLFtbR/PYz+OKwh5If8fzj7CnLg9xNKTBxb1rntdk9Q+7UMGsZ1qDOlzKc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5561.namprd03.prod.outlook.com (2603:10b6:806:bc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 14:38:17 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:38:17 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] scripts/oss-fuzz/build.sh: fix rpath
Date: Wed,  2 Sep 2020 10:38:00 -0400
Message-Id: <20200902143800.124073-4-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902143800.124073-1-alxndr@bu.edu>
References: <20200902143800.124073-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0065.namprd20.prod.outlook.com
 (2603:10b6:208:235::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR20CA0065.namprd20.prod.outlook.com (2603:10b6:208:235::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 14:38:15 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55eae1d5-1a13-47aa-c7a4-08d84f4dd402
X-MS-TrafficTypeDiagnostic: SA0PR03MB5561:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5561172BB727E305E762D9CFBA2F0@SA0PR03MB5561.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+HeLxlD4AuyApRhA+bnhy6eGEgfouFEKVxI13LfrvcAzguK1/JfcMqS8LS4qB1nkt1lWjR8R9/kqOe9QuLMurdsiPoVHpn3XnkQkl3bDbi3EsdYUdwrZHLFyNquZccLN2IZtHvaH2/MluGrW4Fin0UnT30cvKeBEvtX1h4x2gp5dguItjfrU52VCyIr+dYaJqCUOmsiI0Y7kpyIpLyO1UiwEVUKUvWHNzaiK0WySvVif0sIJ3qQgzTo6OBkzJ5QsxA0eGX37TZN4RA5Ds4LHpnvq/duitVV3GibELVVBYGD/tfINzrSPpAFbQos97rAKFeogyDVeudFfNLkpq2+/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(75432002)(83380400001)(8936002)(4326008)(86362001)(478600001)(16576012)(26005)(2616005)(956004)(8676002)(2906002)(36756003)(54906003)(6486002)(6916009)(66556008)(786003)(186003)(66476007)(5660300002)(66946007)(6666004)(1076003)(52116002)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IMwGXa7bk9d90TlrV3r9g255GOE/ZpDvoa+uLG3cO33XYHn94V3v/wqbT21lk9YN76Kn9flG1JJhOJcU7x0M/nRz7azUVbk/sK01M3e6vaKM6yh5pmGbXvmZsiUsbBHBe5Oc1GcGXJUiqE04I5gJvvR72jyjHUQcAe/XUzgG/+xXD4oA5AXJ18GXheaW73prRElMQk60NhlUsMUteqqWl0EJdGOr4VKLu8tqeAL2M18+/FtdipXQwyklx1ggYhCsX52JwbtDho2vhFdVa42h4SXowdGOPi9gOgd/F3wMPYxnlgDNrmrD9pQKqHyzM4OPCvc8L1+v3UJAUYOAupSuDGhdeOhSVPK72OhrbT1CSC1qP7rmSHyInVeGv1eT9J8diN9A+GDPfk5AIkVmhZ8XhYOoIKZUwAku4UoAUoufH5/q1um3dGWRDEkI1mAR+KjTYqkGvjtUA6Mgbdaf/QSdAfDzi6xSGuvZrmKmhd+tUPGKQVr0Tau7mzxaUzOmGceZZ1DNugiD/VVx9qzMNCjt9xKEqfXep/ZoLZxVkgRkxtY5ovZEW+PcUDp4AjOHXTDT440M18z98uHq2fh2UWqdLi82AtBVf8F43YY9gVbLaQ6CHDF6Bbyyu44CCrD3+kQpGHeDhCwG1MnX9uHgr+bNcw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eae1d5-1a13-47aa-c7a4-08d84f4dd402
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 14:38:17.2266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3UNyCWvhHKUUFlnqhebpKde846WnhiqcbHcDSnC/fyqWvzRhVxkTi+D6WC/fv8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5561
Received-SPF: pass client-ip=40.107.237.125; envelope-from=alxndr@bu.edu;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 10:38:13
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
Cc: Thomas Huth <thuth@redhat.com>, darren.kenny@oracle.com,
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com
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


