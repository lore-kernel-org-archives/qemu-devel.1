Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 21:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A852078E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 21:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A9sNDD63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A852078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIIdM-0006nH-6F
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 17:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kIIXO-0001ov-Rg
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 17:30:55 -0400
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com
 ([40.107.93.54]:28256 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kIIXN-0002jx-7R
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 17:30:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvMRp8ykQ7ljWVSPTLhFhECDgwjC6IdNio7GrMQEiv/ATSP7flgZlUTBGP+wv7VmRmNzaoRyhlzIuJmu52g399n6QThCGYYwToXbmORBCoRKV6e1o6NoTimtKIIzHhjUTUP8xMI3tcW1nllgabZTjCA+FL7dFTzVMMLMZiJUzzsUw6iOf1PKkBaPz7NtglWrCu0fVlIBgDDf32EB8Erui8Bp6Qef8QpczHKDwS43xa8vTvvhRnV92CV9P31JmDLUW0tXFO7Xsus7lQIFqUbSf63AMADnXuZTv5XCbaTN6gt3CgtAAy89TA/rinEbaoDPJB0LFE14NUcIK7Fh1gDG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ycV0xdRknSZ3vAEGYSJeRPZJ+9Q3xBqw3WL1RRP48E=;
 b=E/pFPejiuKS8zgFGSjI00roR8l9MUUwO6UiWjC2q/+6HU/cGKjXH80lh/PxTBV8z8Q6PffcLihFsVbT4B3b0jnPfNrBJkDpn+t0C+cUCNqHsjLvImo6Qjl5CGahs/CmoDTxShoVFq7lmQ2AFa5dF/Ye2I71ivaH/iUSjHHdasfCurkBkWqlTd0KlDaopp+7RDgGo/RbItboq2QUvrqtm5kEaT0nlN3LKfoI1t2Gag52OIKuevcKylrbV32jKh20OZjQrnCwjofuMwyIddC1yTH/stmLTdtQJL2uph4SOdL/PCoMRJYrWK+S68BFYQYhc03Fr7zZMiyn4Jo9KNefF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ycV0xdRknSZ3vAEGYSJeRPZJ+9Q3xBqw3WL1RRP48E=;
 b=A9sNDD63jtY2QQbZ5pSrjENuxq9GnIdyPe3WQ30nwc1AQr6LHjEk4Lk5YB7l/75YzhAg7jP8/XscJGHgqSjYV8+/LQ5PPrqtAhU7E3ANZq0R8z5gTxCtur5jhjHdF2D+n/SS/dMAcVhQaa/6Kpsu72E6j75FMQuVThoCvCDQCio=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1352.namprd12.prod.outlook.com (2603:10b6:903:3a::13)
 by CY4PR12MB1607.namprd12.prod.outlook.com (2603:10b6:910:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 21:30:42 +0000
Received: from CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::989b:b1b2:464c:443]) by CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::989b:b1b2:464c:443%10]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 21:30:42 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v3 5/5] sev/i386: Enable an SEV-ES guest based on SEV policy
Date: Tue, 15 Sep 2020 16:29:44 -0500
Message-Id: <8e560a8577066c07b5bf1e5993fbd6d697702384.1600205384.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600205384.git.thomas.lendacky@amd.com>
References: <cover.1600205384.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0120.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::22) To CY4PR12MB1352.namprd12.prod.outlook.com
 (2603:10b6:903:3a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by
 DM6PR02CA0120.namprd02.prod.outlook.com (2603:10b6:5:1b4::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.19 via Frontend Transport; Tue, 15 Sep 2020 21:30:41 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0bdae57-f3b5-47ce-5db6-08d859be9951
X-MS-TrafficTypeDiagnostic: CY4PR12MB1607:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB160713CA51DE6DE40B3F6A26EC200@CY4PR12MB1607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QphyhJbXiqa7nYb4sFtH+ax/7xNmay9vwA2q9Cu+P6Ox7FGuS7VMjOqRlg2MFDN17ZzeyQrhLomEV810IbTuCmsXuE66r2lYAqQX8dU5SF0uBMiNMocEy9IbFDZvbhN2GzeLt7a60PH7dc9BPwRgLArQyCdWVgj++KUqF5sfs8Ny6lMw+EJ4NGM7jADXnWhRL/r/ITrZ6xAgVV+V+4vLbeXue220t4Ami081Vxd9wH8JlZ4JF4yygbgsfpfknB0SrOIKQ7ACWu9u8pXhc332rqHrQJBKT2bIb+bxtKZAPv1PyYzav7pi8YvPPLkfedkpUU8x9+oQ+OYLEtp/GunnRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1352.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(5660300002)(956004)(478600001)(86362001)(52116002)(2616005)(2906002)(7696005)(36756003)(66476007)(8936002)(66556008)(66946007)(316002)(54906003)(7416002)(26005)(6486002)(4326008)(8676002)(16526019)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 47GMNjAWOuJCdlJy2GSLH/1ruByqDPly69GECDd9SQUAnLyIPLv/tTCK7RHsJc8tx/vG+Z4mEDX5NujLTEMQPwSInB8CbOn3A2Aq1IyE62mMuOyHSwo8/GTAqKLzn7jkCf5wNionEB0AIKhqTvEIV2n9CpJ2pOUucRSz2X9Xazm/DJdhuag4r1vT2OPMAJxSRBErMhWdtyFharkr3sJtckYR72Mvghm2AehNrKAn/omKjYsJnjI1CYCRYGR6LqSlARBcfHk4RJkaQc0ahnclbEdAprhofWBqMlQUXPb6IAoP4BnoaMTHtKfpWn0KsNhqqi5pR5Zv8vbRyJip1psr+P0SW+AXq8Zxgv0Y/suUxiXBXwLDRK/GtiyIh3250IlJdzq+2T+Co2Swt0wFzMtK+t/Ez3Q5AKHHiQ3xKdE08+DzI9snfHf5+krIw1ihcfy8ne5m5boujGNlFCMVvisg6xSHa71tsuKp/bmVQqZXW6kGexT0XDixyTrULVls9M2JXSsEuQISofNuvgxQ5ml+UNSqyHhp22Udouf9+6jaynbWNo/sq59ugxozsisMjJMn3SgU3G7GHHG8yeTckWl1FGjmwG0Xer/ij57N4c8miYRaVSZEfyxOiYH5mx5OFJn3yGTWbtDTnd0NZwuXQu0LRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bdae57-f3b5-47ce-5db6-08d859be9951
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1352.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 21:30:42.6028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JkiRUzGHCOrSK5dh8YCB6V0rjvT/6VOCHfdhWz2VWvv6zS55QbDBor+oa1s0JyR0dChXKzMIxbQTA62+ReL1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1607
Received-SPF: none client-ip=40.107.93.54;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 17:30:43
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
index 6ddefc65fa..bcaadaa2f9 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -70,6 +70,8 @@ struct SevGuestState {
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
+#define GUEST_POLICY_SEV_ES_BIT (1 << 2)
+
 /* SEV Information Block GUID = 00f771de-1a7e-4fcb-890e-68c77e2fb44e */
 #define SEV_INFO_BLOCK_GUID \
     "\xde\x71\xf7\x00\x7e\x1a\xcb\x4f\x89\x0e\x68\xc7\x7e\x2f\xb4\x4e"
@@ -375,7 +377,7 @@ sev_enabled(void)
 bool
 sev_es_enabled(void)
 {
-    return false;
+    return sev_enabled() && (sev_guest->policy & GUEST_POLICY_SEV_ES_BIT);
 }
 
 uint64_t
-- 
2.28.0


