Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE225C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269C9221E5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XxASVByB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269C9221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLt5S-0006Hy-77
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kLt1l-0001fA-Lv
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:05:07 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com
 ([40.107.236.89]:10240 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kLt1j-0002ju-RO
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:05:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoScSua5iacBY6pKaqsOrN6Cf6o4zmC4d58S504aYvf5QtOZSv0lLssXq0EAJRqDeiymo2GpsaEWUueEoJb1VMU0PiSwiWxb/h9T9IbA9p2moKizqrS77QiD4kwhL2t7kKZFE9lrlLysLIHAULg+UgbCGnzgCcpla8RFWrHmJOOwdJbD668Xr211495KZ96UG9mGTZwfRPI33F+9r0v+veZEQFUWBpzTPjvP7wkjGCeGWmKP1At7aOWL6pYgBY4nvSlKlxKcAqUVZhHBeQum0vqnYpZInPWQ4fApET8WwO0Q+qjmF0EgrP633BSemJWVTx43HduSubCmNcQhxRItCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0KhVtK8IDDsAo2UQC80AAu5NeKvoOdS/VQ6KL5+SDc=;
 b=K2XOV9hOQAf/9P3FGHGA6Dg9FgiZGSv6O9pRPShrahh5N9koszFVf6V/Zd1vtd41livnTl7al5N540o/hG1nEVYLaI6tmZvxHzCpOBth5+ednmKWuTMQiujiCilbs+/wDxQJ7x7hLS5wXZSOy8wg/9docqfv88Zwao9ytBZsW3arDNms0tZuJPwMDsQI22tcYEm/STudRWzHGXNINL7GqKIsNfA3bqgRFF/WcB6n0zpXTJjJ/u7aDoMzC7jkBN7gFXeDJNptocFFP25urfPkOyxPucjLRMKctqpB15rjSQNnSXYN4O972q8kAZ4q/YjwNHTy6irYreWoqzFF1fBuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0KhVtK8IDDsAo2UQC80AAu5NeKvoOdS/VQ6KL5+SDc=;
 b=XxASVByBKxXzCQDGX5NXSiiVg0gwbLPiI7GPAb2dX82JqZi4SzD3tCI3QCg9Hw/5stl3/PD5YLBbvbP5c31w0zksne0bfL1676csA8XXOtA/z4MOobfB6iJeCSm/1GyQrlkFhYukLfMXiM3wGamWmG4P4+MP6QYqZYguZKepzyE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22; Fri, 25 Sep 2020 19:04:33 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3391.024; Fri, 25 Sep 2020
 19:04:32 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 2/6] sev/i386: Require in-kernel irqchip support for SEV-ES
 guests
Date: Fri, 25 Sep 2020 14:03:36 -0500
Message-Id: <dcbeb6aba051f10b8e6e8a0b90e26101eb3ee526.1601060620.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601060620.git.thomas.lendacky@amd.com>
References: <cover.1601060620.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:3:ac::28) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by
 DM5PR21CA0018.namprd21.prod.outlook.com (2603:10b6:3:ac::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.2 via Frontend Transport; Fri, 25 Sep 2020 19:04:32 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c872ae2c-f363-4e9f-de0a-08d86185d647
X-MS-TrafficTypeDiagnostic: DM6PR12MB4297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB429724491F1DE4ADBEB35450EC360@DM6PR12MB4297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiu41ZjytNDZSLY0d3AdTPQIJqY2YEmAGOx3Zbvg4Emj2vtSu2Dcb2HiF9etsLMjCTKzQENJBymoms4Cl44ncGdJCLEHZqB3KkKeLEgO+BwqZMJ6XAZw1kvFk96cdlTsw3ilNa3qpoKm0UHMYUFfcZLbX8drVVy/jgdKl6IZAPfO6hWnON+hIsNOpSn9RUxpCKNPeVe94uZjvdVHWufVbEtPOnB34ZYISgZrutws3hf6YTz4fVI2DA8bubuX+lJ4avie5AitMaiuAuFJtdmtA3EJJayefLsT6c6cV80dm/obErLF8vO+4u3GvyhQMKRQYCsHT0i01IIiFfuowWgnctEcvp/ak/RmQDfVQCG6ZR3wjwXvLopnit2+Ojn6hL1f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(26005)(4744005)(7416002)(956004)(186003)(16526019)(54906003)(2616005)(6486002)(66556008)(66946007)(36756003)(8936002)(66476007)(86362001)(316002)(478600001)(7696005)(52116002)(2906002)(5660300002)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0ZlkXVeG4jtCvXqTYAfInl7rtEoJASUBDS24U44OiEZD3c0GrPbYO7hDH1ncq4CEhrEMlvfy68nauPvkNdDZlUahNA1+iyy5qv1Ykc/fW4YQr+krNkMs+mmNlGocNan/hZb70kdnXK4oL76JJFa6pNfiYQj86vMDt0vb8tztOp2OgBroJwFZeph0KJVKfgwBc07f2OcKTvjOPUoURB8ib1T5Now/c7GO2y52xplwRwUZWcr77lXm54xv7j2aMA6EiOmAIxRW/9RDqbo2/jbgLaVfoUGndiAhRyXW2OH4JwrdALvrjtJEX3EcPWtLku1UlmeHKLu2XFUT45Ew+Hiuy8BuQjlPeoI6oTFz9EsMgffdi2OoON3E8yPU5iCXX+gWlOB8BQURNlJqKz6osJiKvdp4C8UI5ctB2tYp+m6U1Icsb7ERwH70V7qbqKPtE5LxMXA3gPCiz1yFOYmQhm6HQu4a0EcCxcxiLj/PPPkEjajR4k+0nXM1R+6HLBo6TZ3qTfNfEZMhgHLzVHt7Dnm6E46bpNtuZ4QnkBD9KSzVRfYJXAyOWb6LO4v2zxGse/6/+prayHUSpuxnkJzp/Vt3TDq9gayERquDESctqQRQicyedFyOadRZRZ2xNaiGpkt/9aFwK3c0Rq2ofi2tzneRpw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c872ae2c-f363-4e9f-de0a-08d86185d647
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 19:04:32.8722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLPObFx/O6q9y+htSPc2ukSXxCkSMdSZRNsA2Cf4kTS+rlDSZ8VO+ApsfEDbwKse6XYsRhyZKB4DdkTEFCjOFg==
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
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tom Lendacky <thomas.lendacky@amd.com>

In prep for AP booting, require the use of in-kernel irqchip support. This
lessens the Qemu support burden required to boot APs.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 target/i386/sev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index af6b88691f..0d4bd3cd75 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -774,6 +774,12 @@ sev_guest_init(const char *id)
     sev->api_minor = status.api_minor;
 
     if (sev_es_enabled()) {
+        if (!kvm_kernel_irqchip_allowed()) {
+            error_report("%s: SEV-ES guests require in-kernel irqchip support",
+                         __func__);
+            goto err;
+        }
+
         if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
             error_report("%s: guest policy requires SEV-ES, but "
                          "host SEV-ES support unavailable",
-- 
2.28.0


