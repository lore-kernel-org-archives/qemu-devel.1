Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B304C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B521B21D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZfmhL0e8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B521B21D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLt3J-0003Pt-Pp
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kLt1w-0001hb-Jd
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:05:17 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com
 ([40.107.236.89]:10240 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kLt1t-0002ju-PQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:05:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyKTLNzLJS1AU94jxBVtW9QSit/uZGvyM2ZT1fJ0QjZLqLoNzGeWnGKf9FXSwjKvo5zXxuIA7Xx36IjCPWwsYfL5n/ZYKa+pdf9q1SZSq8I6VDxNwW1c8vB8aSTlPYM+3GICQCiHRp7WUo/fHVtGGxE7X4YfQRJHpV0G+WfIPkyRHcqUkZIb2IONBcrSlhH0c+O0ehlWmaPixGjNRGamjl8HcrLgsVKugn4savco2dl160QwSdo+PdqivGNGfONLXFNQph7ghSW6v/yOwIWPlNnwAHzckf1julVJFKkeYDQXt7w5GNGqHQXwHISNqNzIbWwF+TN+MLTQGZaCyoC5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcEIoxSbsvJlPyskQ0rbz1fEN1HfciJgHrROeNeiM0s=;
 b=W8apDHtgCyK2l9cqSzwe/Q0QEW84yzd70HSG5mhO+PHj/RJj6RxF912xZb7kg0GsD8DA0BNFLPWVq5rRFEdNbma5i1iNThxA+xvhmI6vvBBNV+qfFq0W4BFVLKVz+ylSBBVS1Gnu5pBMbL7OQ9CybpP/ejtuxPyYfFbQVyr5LVLxjQl6z7n3P4ZnZtDwaO/+NjrOU6Uv0I9SVrFkzl8IxxPsXhgYgQF/qei/9H+h8eSz6WkeMXLBIp9q8xf81BB62f+P/U8Nf3oQlXzOwa82XovXmh6ZADYZh8YCWmd3qZyBzo6x+C4gI/981c0naC+shNGzjjVCFXxMD9SWhrmjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcEIoxSbsvJlPyskQ0rbz1fEN1HfciJgHrROeNeiM0s=;
 b=ZfmhL0e86DoJ8aRPVqzBjs2yeXvu0c7a5375753oROB1WxMK/+eIlbdvPGkqGMsDyh2b4QkhnQZjnGguEQcwisZK2wl19xWtIwD+lgy/H1DBih8lJuGVaqzu4OAf7MvVVxEdTyedtZfFS/I5CtDnhgvQaSKig21MCw9KpQMsTyk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22; Fri, 25 Sep 2020 19:04:56 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3391.024; Fri, 25 Sep 2020
 19:04:56 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 5/6] kvm/i386: Use a per-VM check for SMM capability
Date: Fri, 25 Sep 2020 14:03:39 -0500
Message-Id: <eaec49f1ce4c8fd69277b1a7c374dcd87b9bb95d.1601060620.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601060620.git.thomas.lendacky@amd.com>
References: <cover.1601060620.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:3:ac::12) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by
 DM5PR21CA0002.namprd21.prod.outlook.com (2603:10b6:3:ac::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.8 via Frontend Transport; Fri, 25 Sep 2020 19:04:55 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e59e862-45aa-431b-273e-08d86185e433
X-MS-TrafficTypeDiagnostic: DM6PR12MB4297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4297117BF6ECEA5EF655BC3FEC360@DM6PR12MB4297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0MkHATowLlULWWtDVxg67vliy3nktJCLuicNPHHA881ko8u/1OCA2pPYKCs3QML/8fu29ZCJ5T9QCLFYhjeJefGeau9mudSSi5kTAG1uuZDA0zxWLWfotgL2tSxCvN4GtWDGhWs5O8NNokQJaQeP1s9xj0spOtzMx/5F4u9pLsrak0GE25BUp05QRDPBkV2pgAf9qwV2dBiebttqeqeSdRJdVfuXr426R0kOV4SOZdjjd4ZtoOvtkWk8RxiqeRKcalKX1FHxTkhNL9nPaC0I4699mND2AVw5z7r2q9tu5NXjCBz+D09fKW2gVd29+HW8x9djqFxJTlQge9IhqucvsFuCU0xYM29MBB6RPin97o8iUfFDbzb8iLktO7QDpCm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(26005)(4744005)(7416002)(956004)(186003)(6666004)(16526019)(54906003)(2616005)(6486002)(66556008)(66946007)(36756003)(8936002)(66476007)(86362001)(316002)(478600001)(7696005)(52116002)(2906002)(5660300002)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BFJg1kd0vupApHrwJS8y97Vah83n67YUO6q3kuGNWV9iAjV6E8H+ZVWAqiDM0N0E5gB/Rrr6mcXv2Q5JtWKehaiJ4Z+SebOGFxYOnFb89chLRih/TClj74Ot1JWVECIpe7uwr2B682RhIVKfNv0MzMM57nAt50v0IckN56aPWxivCXSlODttYF+8bi46tZgiCY2XZkVK1lsEE7k4eepIIjdX+AhqOI+/G0j9aER4oCfbw+eF7DurRxNS7QfmbSybGhmDe0uvw5whpyvxlw8eI+AJXPxtWucMocOXRKaaHLnxWMZmdWxgLz5TeyQk2KrYUPC8m/TCRonhPj8Fh//8b+vLapIteDhocftOsDXvZYKROFh9LkY4nsmB0issWjQDNIulh69md/Ysg81oe/78TyQUIPqX3LpMLy6KPnonG3L9wum+WT7zsZaA6P+XuKRX1TeU+iyenLxYw5xqje4s65aAWB9LHAI42M6Upn/KmSBRyGXaJ0kesiuEY3LEck9Ndsh7mghg80IOSRqEqIyk3M4g4vkmwi1JFISW6PqtGCBLW9LXFHfcHe+dGVYhmVsP+7Ixd2ekjdQBtn9dVHTnb1hj1EFKNpBaSJ+l/uNmacDMy+IoulN9Af9KqR9f4Ouklp/dOrKk9K7e6O2RunHTJw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e59e862-45aa-431b-273e-08d86185e433
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 19:04:56.2346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtt85i2uKmjWi7BI5trD03OZcOffnwgdsC6leKwjBewCDkI/UJ010pAr8Xk7/LMxC+g7LGfgz+Wtf+tx88rkqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
Received-SPF: none client-ip=40.107.236.89;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 15:05:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Connor Kuehl <ckuehl@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tom Lendacky <thomas.lendacky@amd.com>

SMM is not currently supported for an SEV-ES guest by KVM. Change the SMM
capability check from a KVM-wide check to a per-VM check in order to have
a finer-grained SMM capability check.

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 target/i386/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index eefd1a11b6..917cdf8055 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -134,7 +134,7 @@ int kvm_has_pit_state2(void)
 
 bool kvm_has_smm(void)
 {
-    return kvm_check_extension(kvm_state, KVM_CAP_X86_SMM);
+    return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);
 }
 
 bool kvm_has_adjust_clock_stable(void)
-- 
2.28.0


