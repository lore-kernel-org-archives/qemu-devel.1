Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31374C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2E02074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CbBt/T9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2E02074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeK2-0004S7-D4
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kAeHR-0008RR-4B
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:06:49 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com
 ([40.107.92.76]:42272 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kAeHP-0003xT-Jt
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:06:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2jzrRPJ8/FLEwWrIkIiz57hacjxNNnGAK0Ty6EAsuWPibtYVKYLHu8PzgEPGXLXRFRikVah8r5AhW/IYGKrWh25666OEAT+w7X5763FuAg0lXkgss8OZJ2cvgL819LVebM5TJBI/L27djmruwRwQDWXhAwKA4llMk+kakuX7D2Zzbh7z4mWlAArhEU/qcQouSQNIrb81iUWO66vQsTA0r+0RejjbP4hOqzNCoql8PC3ZXysSlB3T1J+1DCZFAgvy1b8otUYIc1lzlD0Wo/TL7eedeG4QRdmeTLjO5yN3j9rmWg6TGeTaHsPdgf2/BOkK7MtSvDG7EbUc2gDvjXFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow1m4GXEZvMOOFuF2jbpJkKWGA1rQF6Uh32xVVBeyYY=;
 b=f949HC/wABCK7vrQwMZueC7ubGmqEYHaLYw/awLdp86wCxtZBuxkMcp6PlGiIdy4NBsmtVczqcvK/gIed3UjnIQwEGmmgZwMb8nZkE4/uvz8CuNrZx6Y9gTy+IGOlcLigt3a3LppIaYe/qLrC1OEIyyp+SSvkUoadKigVKtUiwFeSwPomURR5BjXUG80Y4uPIOj4EYllIIZv2n4W3gIJ1QpTwqmQbz/60NIUWYPPn6fh4m9Zi2I882s5S3U7X60+cTc1Zs572qZeui2aa306x737mAulx17UZIvXpVe4UZvpki4oDkKUgWzgEJ2SMnt32KsXgAICFibBWCRj37JEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow1m4GXEZvMOOFuF2jbpJkKWGA1rQF6Uh32xVVBeyYY=;
 b=CbBt/T9U0oR+io47rhdNhG/t1vt+AuTV0Vwt/uQDuJaOXcB5ToErF1FYbB02vsIhiIrHXVFuU388TdBFfDpRjZ4TvlziKP+IV+zAvyTnBNAIZygQf+wfCKqLGJY9x/umHHXACkDyegOhC/DbRN/QHB2cUPeNJVM6FmAyzAR3wbg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Tue, 25 Aug 2020 19:06:29 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 19:06:29 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH 4/4] sev/i386: Enable an SEV-ES guest based on SEV policy
Date: Tue, 25 Aug 2020 14:05:43 -0500
Message-Id: <8390c20d2f7e638d166f7b771c3e11363a7852f6.1598382343.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598382343.git.thomas.lendacky@amd.com>
References: <cover.1598382343.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:3:117::27) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM5PR13CA0065.namprd13.prod.outlook.com (2603:10b6:3:117::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Tue, 25 Aug 2020 19:06:29 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf206588-4478-40b8-1fdd-08d84929f930
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0219A795677B14EA9DC4EF3CEC570@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TxRoL0qImlDHXNa/LRrjIuYg43uUWsRKVsTlQQiTlKpIlE1w89ZdtP9YI+FNoUMb7LftmuFk/kCHV5qGJcYDavOKCxIOEuuy3u6MA1K0cNKJpquDgdZM/L+Jz8pQKzZ+4G2lUmryO8n8KpKIL8rIv3o7wc5CCAd5jiD0SPUm2/2ywZxwKZ0M8McMGnY5yiAH3MTgHgYKcroLXI0U1V4izxdD7SRxDkwKkNknLP4SFfeskRIgbi5ds46P2xLQn0zhzUXLFPk/Nm+HXKNyfxWRYtRMG5a8j6hHVWiK3cKhPICqZvTkh8PC0Ri9Lnf/4RnZr9+op+SGnunadfOqv0h1VRlHf0Q2/FAW9jKUti+0jNA4i566+3b6Z2LsrydT49g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(4326008)(186003)(86362001)(8676002)(83380400001)(54906003)(16576012)(8936002)(6486002)(316002)(478600001)(36756003)(52116002)(26005)(6666004)(66556008)(2616005)(66476007)(66946007)(956004)(2906002)(5660300002)(136400200001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: v9USAGvmyJacV4ftxTaw7YDNOgeBBeb2KTecAr3sguftgZROGaFvn4xacEiMq0aenoiYrtjKviuKh/vx/rwSxToO4CUVTG+qLbvHmVuiTs1y9o+9sNm3esze/6c1B0YSW2lxtvmBYXC1XYYLdPstrkrzUe1j6Inud4iJiBq/76dD6EYjw8IK3iHSvBeY6hYSVFE3eaN6kLd4QLzyLmM+Bq4EIbwNzQLwPwVDoM96WmFtBmWyYJq0rZaRjwWJHg63AmIHVAW0ngE+Cl9XAvOazaTgWtkrgDfumBbU4sbeBFXCRbnTP7Iz38cf1vybK2fsVpvF57bkodaMuxmFzlnqyP1wcB+6UKrKYciWMqsawUJ98HxGxVmdpcgLrhx6Hr3txU+B0IaazeV0u4Kkwz4BPY83ztOUd0LxOJA0HwG3ZLW5+HD9JLUtsNlO32s54TdTlz7Ox3VgMBa165Imo2CtqiAcBDXx+SAI044DJucF0hxAnQXhUWF+rbSpPNL4rIlVd64XvlfW7fy829FljVr4qj9y8PgMFURJcnZ5WNMgFA+WWYpAA+T+ZAIVIrphvpT+h+s/wZF5TK2b4WhoAvq2A94rJYixlQs3JRMREcZ+x0DQ4kcXNrWYFZEqKybfpi6ZTK2oxqkhaNbnM15RBwgFGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf206588-4478-40b8-1fdd-08d84929f930
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 19:06:29.8871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY+WXkQ5tcVGnyGltdJIeO2p44VTO2hBlsBhIhUDkMIN0kpgO5szAy4zkjEsFdy3mRs5KxscjThILRcqbp3+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
Received-SPF: none client-ip=40.107.92.76;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 15:06:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tom Lendacky <thomas.lendacky@amd.com>

Update the sev_es_enabled() function return value to be based on the SEV
policy that has been specified. SEV-ES is enabled if SEV is enabled and
the SEV-ES policy bit is set in the policy object.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 target/i386/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 5146b788fb..153c2cba2c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -70,6 +70,8 @@ struct SevGuestState {
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
+#define GUEST_POLICY_SEV_ES_BIT (1 << 2)
+
 /* SEV Information Block GUID = 00f771de-1a7e-4fcb-890e-68c77e2fb44e */
 #define SEV_INFO_BLOCK_GUID "\xde\x71\xf7\x00\x7e\x1a\xcb\x4f\x89\x0e\x68\xc7\x7e\x2f\xb4\x4e"
 
@@ -374,7 +376,7 @@ sev_enabled(void)
 bool
 sev_es_enabled(void)
 {
-    return false;
+    return (sev_enabled() && (sev_guest->policy & GUEST_POLICY_SEV_ES_BIT));
 }
 
 uint64_t
-- 
2.28.0


