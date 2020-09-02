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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8B3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8500420773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="AylvLP1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8500420773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTl6-00039g-Md
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTjy-0001CO-Ni
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:27:58 -0400
Received: from mail-dm6nam12on2106.outbound.protection.outlook.com
 ([40.107.243.106]:47968 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTjx-0001T7-8R
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:27:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxsdYTR9aLVZcTAIXFmgfwp+YS9t3pZU2aZ2b+X7BgraLeInyg7dCOWNpBP+1V0a2KtHsfpZ/nFpdDfzz4Gmcxja7d2ZlF2nyahDsKjCHsBK15Zoxi6/Io5tc0QEQBBqHkVaeQz3sH3oEC9mTldmy9pHAI48uZ5AaHgWnw24jb3t4QtQCrtkGodEQhAbXnq5x/hobp6h96vyXP4/vjQQ6eNKNYyt22Ga8FLP9B1BbeicTmIxWqJ+dQ47ZG8CxMdKIOH5rnH39xO5G0viiXHbF6n0TY/CWP9y3qNh5p97KRNR+mUCsnDHqNG92iUqslYUg5nMTZXyD1bHTl1uTKOIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kjjDevcrngpcqFVeuJ2EUYRDchmPlweqwRueRD/XUA=;
 b=ZHkRAnZxS/ZLZFnkOqnmaufdDGRkOP3DFE40mz19R2NlVKQN3QxAPaDbum5+fCUhN0EZIjglU8xtTHljqWIxiIrxzcMNUgOibmRUvlWXokHCEX6mWt8I0cYvzlwrUR1CBP+6hWWRROeWdTSZ+roxmiS9M9GI5HMijVgRU2eF07se/VLU5M4AM3l+gnCbMWTztzazyUSoykaLpNewv5XQZUvSj55ZO0G7+eZzKh+AQvc+GFSSdigMdg3GN5B/LJqGHXRN2tqgoBd9PSIaC0fBHbWlC54CztFhXIUIDU/8vvujXrmXLAldAtacimTpPkKYvz2IZcS3k2rYTEiJsz5E6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kjjDevcrngpcqFVeuJ2EUYRDchmPlweqwRueRD/XUA=;
 b=AylvLP1v2v11axsfT2jHaqCx/uyEaPu3rPLuNa33YRA7RfXGeI0U9KF9cfdrUNboBePuKUI+167NjcfsHHlK99e5x+e//2ydX1D82uJORw+yjiKXcUKQY2F1NPGI8LXRB8al6dM/ttIrJlfE+uqVFYau2hBWSVc6iIhrwZebVTg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 14:27:20 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:27:20 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] scripts/oss-fuzz/build.sh: fix rpath
Date: Wed,  2 Sep 2020 10:26:57 -0400
Message-Id: <20200902142657.112879-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902142657.112879-1-alxndr@bu.edu>
References: <20200902142657.112879-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:208:e8::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:208:e8::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 14:27:19 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66c3659a-2ab5-406e-9baf-08d84f4c4d19
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB546599B3B0F0870BD6F76A86BA2F0@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvKIvuZRy2otfOcY3gz5xUOxWIPgGxnE7b0HEU44yOIjwpjqdG8DdTDjU+ZgyOnDh8Y0ocFv3EWKlWv6ue3M4MoIODnPlOzXJF8fe8d9x0Twmfr2/HNEBEGOypUh7RBupsNdsuXNMrZ7zHswt/lYHQIJqM4zyJOfakjYEdCziRiUFMGgSkDe3QPyS4gIpie72pbiPjCVY98rzijEOfJ6LPRlp3Y8/GQNU4HPK/2cmKb22CJKKXou1OQmVu9z5BjC4Topwq+GH91KCC/O/e1rrBFyD4JrnGLCQvEMRBQFNH6IXkSVJD7k3j3mrusg2lQTuyBgHoEjvPGF4jq7xursrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(1076003)(8676002)(66946007)(6916009)(66476007)(66556008)(54906003)(52116002)(6666004)(86362001)(4326008)(75432002)(5660300002)(6486002)(478600001)(83380400001)(8936002)(316002)(956004)(2616005)(786003)(36756003)(186003)(2906002)(16576012)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ITn23cR176dg60NwoFWPqet7EAwsW3ZfemqMa0VfSLXw6sUJcNCagGkoPTHHGbZ0lxoySsPbfGlgfoh9TnXv6LC24sB2lbOPKsX+RiDapAiaGlAKnWX0hirNYm9yuGOfV4GlrdMzFhhyYSBdVsLOmp+BPPHPsWmRZDF0Ro4HG+DLQ/CUH/0rL/ZJuagwQWW6CjoWgzr0lfPz46gmlCtW1+c7PrIVtfJZHXJ9AOHYf6kTcCJuWgoxBdcx3MRNYptU7BduvBYJ8h+TeToB6XhGG5SQ+IEucQuKbIsoVxQzKP0jd3awQSizIeUZYHWj6GlEvIUSWyGJx/WIMO2Oo1hdO6CgzaqTYcby7Mv7w8j1nTF+XXnuF3bHT9v0SANofnADkEHO+K3Mo4xIti4MWlC4ZlwCnK7IqM4Cxj+SATeKfsSrrVtQoH0odRHp85WCPb0hpYX5nM5JZ4s4qqP3yYfBdrMsr8EUK5TovjeOsAUmatLYYgshE1FD6wqR0CRex34x6a971DqOtgmUBFPn2wivrvMvXAoJDgloySEhJeElnObsw/JEQ8iJ5OuSa75Wgmc/vIO0ks26xYRrQPe72+HR0U415H008pTZ7+KraXWyh8wj6nxVXNR9d6fvWTSqtB0sb7gXJFFlCh/i1Q3VhFvjWQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c3659a-2ab5-406e-9baf-08d84f4c4d19
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 14:27:20.6385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2e64LYgXwTkFyq9Kw95xFRmLHZwqVkXDXrRm0WjSHV3ra8HgGErGaKIvPtta7Cp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.243.106; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 10:27:16
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
Cc: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 bonzini@redhat.com, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
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


