Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB687C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F992222B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="B+z/X6b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F992222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3kt-0007yB-P1
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WW-0007gN-Dn
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:28 -0400
Received: from mail-co1nam11on2103.outbound.protection.outlook.com
 ([40.107.220.103]:1568 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WT-0000mo-Ac
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avOGbXz5j+f15ouHVUD5auOhhsb0uR3cF+Nc+8qUxmT2giz3tINYp2IoTEBIk4SHqzqcfAMaeeetwmjewtFHXJJRHrPYclWWDSDJLAavoR+QBqcC/d5hdtxfsiLO3/ih+417vbaOzAs1CsAb8OPOBfFQELNEOM8pPj+L0v84/etygln8KeHIFliKCamhAtqTgv9SOdCJu5eKadKF6sqBKCpVu7+olNyVG4hPNc3xubhXE3kQy3kLeDg64+Gbl6TtW+YQE5luqaM9UUfH5FDovsyg3zFjIeXyzyZGF3qhRGzOK+yVVYsGZYfHN2lbwrVHUoJn3MUuG0U7uU/0HAbo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzftJy83Kkyh0SvycGdUAqsn3APx2vCrNfLWB5KU5aw=;
 b=O35Rq7tZx6/5AeljSjN9J7UZjoXmI34MwmK2AJG/Al5DKJnUBVr+hsLUaFYlFfi4YqwlfwkEe07Q+S0IIQKAJ1nLV32KRbPAU3Wic67t59kkxQnz5Bewdl7Uoqc2hZfXT8VsZlyVgSc26KlRQ8FOo2u56dN6ltnLYWGVj2gYpJnCqrz0BONfrFgJE9Coksq0u+awwlgWsGkupsdjwqutOihx3f8E4Y6e30b8GFk0TN/3d60AYgZFZ1OgfFoIGuthdSQFWTtAH5QZHzoV121B5IpHgk8/LzugJIhbs+g/V9BKeYgYS+2qvq+zBULkUjpFK9sAPu8C3i9TQ2FBxoRRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzftJy83Kkyh0SvycGdUAqsn3APx2vCrNfLWB5KU5aw=;
 b=B+z/X6b4D+qYobZR+Ea9KvZMCS6H78tF6uwqXFtZX2sWoZLjS9pdqyNIZUSzPFJLuHyk2g6Ln/U6hExoqQ8RfE3XPML5rqVilRcgX6Byg3/19K0NTjjRpgs6PfSDOFlOBfxpQzuPTO/1O9/1fEop7ghhbFUZLfruS+sQQn1ptus=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA2PR03MB5721.namprd03.prod.outlook.com (2603:10b6:806:117::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.30; Thu, 15 Oct
 2020 13:42:19 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:42:19 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/16] scripts/oss-fuzz: remove the general-fuzz target
Date: Thu, 15 Oct 2020 09:41:36 -0400
Message-Id: <20201015134137.205958-17-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015134137.205958-1-alxndr@bu.edu>
References: <20201015134137.205958-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:208:257::30) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0055.namprd13.prod.outlook.com (2603:10b6:208:257::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Thu, 15 Oct 2020 13:42:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1dc5b05-330e-463a-756e-08d8711022e3
X-MS-TrafficTypeDiagnostic: SA2PR03MB5721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR03MB5721AD7C600D6C3569294745BA020@SA2PR03MB5721.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ft4jGL2MZZrTRAdLz6b+zoRWPaIXK9TAvsO6u2cs3wwX7BikJvCV7ezlSeepmCrWrA+ZLk9movEw439Zr9EreJIjXH2FJIrJb+2/wyHE8b2Px8KB1h9NmURmgnrAcZwTftNqzhd+1sRwL8CYO8E+SldOpkKSR/maYe6BoLIKM/pmC969EnZm5hg77PUXpPyzHPuY3HySuflaGuAag3wyhEIAWDw79RDM/7sqFnwodCtqJRN2KxPc7uswGc+dBnBtxdx9BH4gQM0Abc9t70OCHMTtnNc6NBXK/Z7lcSnkxfPgSStO4WIzJKAJCLLXViNzZMAUNzhy5UUUQeGRlq/V61TdmGmar7029COEsSns8509c1XXxhjHBdfwpwa8O9Ov
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(5660300002)(1076003)(34490700002)(26005)(6486002)(66556008)(6512007)(8676002)(86362001)(52116002)(6506007)(8936002)(66946007)(75432002)(4326008)(186003)(956004)(54906003)(16526019)(786003)(2906002)(478600001)(6666004)(36756003)(2616005)(66476007)(6916009)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zG0dBZgIuVVR3L6GTlfID8yX/m45XrJx37pkZsTBRIdrzfdo6d8uSgoRs+mH0MmtyUbHLP62dWD/iDiFGnKm0zsLmYp5hijdStay0uVpiyGU708i/uaVmwcOA9nP4VhhFwX6C9LV6rT6pYKcYCjdl1eUV+t24tff3TXHX/N4on08P6mDUjRBs3syfNu2twr7Vv8EqEI5Ls/5m+8kcVXacT2P8FFCUasqrT+/wWbJtICT0NSKdGFIaUUtvGjF6Am9i0HoLh9SWSW4WK4H9DY/HObjdH9roesU+liADs7YgGUQrIssSi+hACkWcXbbkj4x/yvyWPdeglIvTnTt+VOkFwKZs/k8Q64WzAT3qs/F21nv1xQgN92vS7xXh8GKsI7leMESoFPyPoSnqavYNx95rKCR5gzY2aqH4w+7T1Tph0SGpeqevEYzJEYHs4qbJlbtrpXxtWzPMIk23QtIsl9cbC80kFdJ5dILWxiQhec6zIDFeNSWswTkju/h9pl4h+bi6BXKZMro/Yv6/hvrev93X4j4zKJRIAl+1PVDCeX/gXBiVQwV0g3P8yX3/puUZmiurJiVgfKB0Nlq5sbzWHHzcsY+4ZUVJqoxMqkxOxfLwGgd6Ac9AQOe6wQFGczcH4GugtRvyg6Jy2jWVHd2yYmedg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dc5b05-330e-463a-756e-08d8711022e3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:42:19.4141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWiGISpLiIOw8WJKInOj2L8+qY08SdoQu68kLdyU8ZpRqmbkHKubvyc4gIlCC7Kp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5721
Received-SPF: pass client-ip=40.107.220.103; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
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


