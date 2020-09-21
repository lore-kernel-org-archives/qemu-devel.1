Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB163C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D742078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="qmZl5XoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D742078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBcz-0003Sp-7O
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWg-0003Rm-IU
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:58 -0400
Received: from mail-dm6nam12on2117.outbound.protection.outlook.com
 ([40.107.243.117]:28256 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWe-0000b7-Rx
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpdjvad1UUoxuflKjkrnKnq6NsmgPeTTjJjkdU99K6esE1HnFyHcT8kJB6jtHf+gHRaRb2MQnIC666nNLQ1aFBdsiZ68cXC8brI1TGdFdWG9cptKd7uwFQhUUVYBmI+pynz3Johxr2Ueb3UaIJ9vqLzhdW9xpEvnrY52E39JolsPc9843zaF+EdGZW94V8S6d4h14yBu6oWR28Zy7hP8yyAB3zJrapUgw0/5muSvmz+18Ow2cxMVo6jcnPazVk950gq2oolIlmHIRH5Bm1WQsqerXhWnrszIvm7xDts46yuxDQJdFljx0uy8X6F6eqLSoSOxQKb2BfW597DpYULjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTmTlyBJh6n8z64s22Lli8J7bcfVKAeNDxwX97zyLpk=;
 b=RPiHyDNO8eWHe9ke7oG3mmUlcXUi4GN+I06q7supTWRvj+lXMEc1p1L8LlRDH7/7i3nVlf8L++n86m5It5oZwcNI3mAI0CfuQFzVYsYnVxwtDZXRviHbU+c9J8Lym5xXD/jV4V9qs+SyduVg+K93dVcFr48ACsZzvLr6E148/shKGaCHGjpmckvNv2IKhx7X4biZNfXw2SyYLYEQHLoJA56espYouyBt3JVEx+IVMfEY+G6ne5Xye45KZlbUrCmzMRk6drgP1Da7+qugCifHtqYX7LhcBM/Pt3rh4C2JvCcEGPxLMQ8+POrbkpokqsju1KrU/eIjgh/U+vytVzZyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTmTlyBJh6n8z64s22Lli8J7bcfVKAeNDxwX97zyLpk=;
 b=qmZl5XoIp2qrcphGSU/Sn5l0VHdr5DYUsouFgZrHOTsmQDdvBj43rlp2Hm9lnutzkq9bmmGs3aDUB98dvTn3TanqC0EmIhbFW6+2juSpcaMkRmWqy5SboaSQAqM20bBcwn8ffIrDIeCPRPyV1HVNjO7qYj2HVefWcfMuuh1vMwA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:44 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:44 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/16] scripts/oss-fuzz: build the general-fuzzer configs
Date: Sun, 20 Sep 2020 22:25:03 -0400
Message-Id: <20200921022506.873303-14-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921022506.873303-1-alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0034.namprd15.prod.outlook.com (2603:10b6:207:17::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Mon, 21 Sep 2020 02:25:41 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d355978b-56b4-4ec9-ffe0-08d85dd5a35c
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2237547A469139500D792498BA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KySy3n6jYGpTu9UJx71MOjhmrFWO7BQcpd+nUI7nX/jO9vZwdrVL1WlyrSWiPnrt7lZRofq0mfUPKS1dV7ROm261e+IRBHfXowVuERuDVc/tmi1uK6zOyIBBhjs3svvwrjmj6e/eYv/L0O3e40b2JoUnkoMaverB2/W2rjBzpgGMxle7tXjIh29N/9veiMkst7fLN3A87xwCmXLoMwN4Cktb0TzCGDc5fDaZpXz5wVfmDNjy8CRadX22ouvbqIcQYvRR0Jib9mBGHAKEo4uk950f2DBkC2a33flemyZAp8NNON9npfzh0aBgGuOo2n7A6QfmOUzTOe/sDYpNkaQ+0ziCQnHbf0LoQlAYfmDW+hdyL1Wb8hafbpJhaTZLqCDs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UBWjtGmchTgF9HvduivUeIfp411fzRGqyJqmJYI4NsYY5nNwtEwUsekVsfuNRw0fzh80nJk3tcxEcqs7gRiltojIVfZjODhkAzqR7eaYNYt+GdOVoqxzH+zhQeIakZkWu0dU/Ep4LkX9vh48l81BER9WM7nnipVUiBxQ/eryWWe3zBnn3LGg8kPeusLOzmJzSwnZDQKrMAYYBDyOqj+cVkkM2oXPh5WgLLO/RQD16iFtToWYfrauDMaPqZcEAFeev6VSl/Prs0lbTpMawEKIpSaTBl0WtBl8wV4jap+l1zT63//M5ImFJPiH48XUZusNMWsir93xfPfDDisPN0xqnOILISb05ujXV994Jlsfc/zkI+sHNZIjsiMB/3Eq9Pki3JNkTnawAiPCGHR6LUssQBsd550H0WLuvTRwYNL9dmdabQUNEOOzbyIKNczaKXz848GsWXQ9l6XCabRCz5fXYEX16oItXyo3u08Tei1aFsGemIDIF+8bBf3spXE0A+fPPkTrsZGaKyi57xqQSBr6J6sda8sx/kA8KjsUSkGzTG1a9DGnWDFkVVd3dj6+fGwACxvQng+OCJUUhc6Wf87eUlkyp266KUVhuudIoTmN/fvlu/D+JsC9/9c1mviT3Y3vWp+rOCFV40Uo360Hb5A1Uw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d355978b-56b4-4ec9-ffe0-08d85dd5a35c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:43.7745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBWbgpiQMiaOD3lRLTj3Rtz/hvvxtdw5X6bWJX/UhxvmHzC/mQADplAWxoFGLB/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2237
Received-SPF: pass client-ip=40.107.243.117; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:25:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build general-fuzzer wrappers for each configuration defined in
general_fuzzer_configs.yml and move the actual general-fuzzer to a
subdirectory, so oss-fuzz doesn't treat it as a standalone fuzzer.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 scripts/oss-fuzz/build.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index d16207eb67..16b9f39d07 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -87,6 +87,7 @@ make "-j$(nproc)" qemu-fuzz-i386 V=1
 
 # Copy over the datadir
 cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
+cp  -r ../pc-bios/ "$DEST_DIR/deps/pc-bios"
 
 # Run the fuzzer with no arguments, to print the help-string and get the list
 # of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
@@ -97,5 +98,11 @@ do
     cp qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
 done
 
+mkdir -p "$DEST_DIR/deps"
+mv "$DEST_DIR/qemu-fuzz-i386-target-general-fuzz" "$DEST_DIR/deps/"
+
+./scripts/oss-fuzz/build_general_fuzzers.py \
+    "./scripts/oss-fuzz/general_fuzzer_configs.yml" "$DEST_DIR/general-fuzz-"
+
 echo "Done. The fuzzers are located in $DEST_DIR"
 exit 0
-- 
2.28.0


