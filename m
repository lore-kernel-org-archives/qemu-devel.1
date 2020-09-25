Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08337C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E793221E5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rheVKHLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E793221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLt60-0007DX-Jq
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kLt1z-0001lr-GJ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:05:19 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com
 ([40.107.236.89]:10240 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kLt1x-0002ju-J9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:05:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWA5nW2B+lBNzd1EdEKFJ8GvwuOj20bp8MctUVZ/MAygeaTJbRkTi85mBAzT5l4sJ2yfKUdIMBpVtzl9apZIO108faV3Xwlk7X4OQvdK9z8aHqXEb8kaRXrqIMH6Aq3BvVsPabtkZ3C8aokurDU3N14wtRHdOPPii0xxTAqSQTkS4irwcq3TwcGh29a4HVSdwMMFi06X2nI1X/RnHtow5ccefv0KN2LtICgbTh1B/gsOVQWz1vKVtfoH6ZsezluImLUpasdunsCtOz4n230I9QdXa11FHV9AB1YdY1P4Vk4M/u5UsWqrJnzGA75D2wssY4NxrT9Ozl4h6IakYw/u0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUExxZlpjBC1vkPTH+mWTdoLVsXwFGz0EGGEDNi95DA=;
 b=LqnjDAVEm50ZVpo1HfkWTurDlPyUYtRVETReKb3QxPi0JDMixNcomXrcEywMR/T/jw7P2xpZCF61ZbJanYAcbBRlxwG6wXiQNzYESUtrNUvrBablwv42yeoomyLLaL7c1q3sGcLWgdQl9QwvZPrEL3lush3ZV6YlidTTKebH0sDfnsgXjiMXFIq5NsZBduces8imlc3A1icvXbm24r6bW0JXf3OunfQMAZzsnDl+Fr/2Q1ALoO/MnPeYmLDGshRYQAMUiSt1J9JXa5jCZ2M7EgUzJmTbhXT+0kRvpGqG1bqTOGlfJ2+bZThuiz9QTRiYrWmBddmlHFyM8n1AuJN5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUExxZlpjBC1vkPTH+mWTdoLVsXwFGz0EGGEDNi95DA=;
 b=rheVKHLvM/wDHF7+sAm7WYjhm0/1Ho4Tw9VjMeoVO/tVP1K/gTrVuNJ2K0BU3f8Cf8R7+hYSbb+oP+YKISjfeSsoJ7g9/qSu3a1JSJEI36sQXdT+xk4JLIQkJO+O2yoAEWtTgb3hQQrFga0cRYI7A2mYbVrr4YYywGCRKLeTjYw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22; Fri, 25 Sep 2020 19:05:03 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3391.024; Fri, 25 Sep 2020
 19:05:03 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 6/6] sev/i386: Enable an SEV-ES guest based on SEV policy
Date: Fri, 25 Sep 2020 14:03:40 -0500
Message-Id: <1cfb0be5fdad55948f42f9056dfc16dc435099cf.1601060620.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601060620.git.thomas.lendacky@amd.com>
References: <cover.1601060620.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:4:ae::16) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by
 DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 19:05:02 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07469ac6-3651-49ee-369c-08d86185e8a0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42972EF7E11DFC22A562E8D2EC360@DM6PR12MB4297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyPiIOJx1/w6zTB7dMTjZZOg03ZGTjoHynhBYwGQLF1uesY781JxNriaCEwBAoQ65mlLCpsLdCXNxySp+ivNnWs6OkFGqScqG/akOsMuBbW9GsgYESTq7er/lnww2cLGAXIlVAqXYytE0L8s99XRokRcw7fKOhCvRHMRSvYrkYZHTI60uEHPXlSMBwWMHP2g3iXrUpIxrTAEh9UmWVOe7XJFcBPLNM5vhk0MXIFHqaxkEf6mPobjXg24tRPqThqobGO9Qgu9dnl8MJ5FtQe7KS+ejehS6vqHlNjwqaVNt6XsUjtYmD+p/FcpaTybDvUWCLpMLGuCEywWGz3Nr59TnxIJ8cYm0uE0cTg/4Wf4u95QaRw3QvXlmu98dbxjFj/S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(26005)(4744005)(7416002)(956004)(186003)(6666004)(16526019)(54906003)(2616005)(6486002)(66556008)(66946007)(36756003)(8936002)(66476007)(86362001)(316002)(478600001)(7696005)(52116002)(2906002)(5660300002)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jHY1I4sgNygabV2amgs2B5gqe58IbD6LtLjhZaqOc+xYyhJM3leTFBy7r0V1O3LlLrRIsLWCf7ym0oJCZnqv5I7dtRnSv4QxhKPoXCihEpomlAECLMpMlqWB+Sap0e+YKsk6ZZamlTMBNNhfNY59a7X4UmPnr9fSkYHDRG6wjP0310mMLbJozIeLIfitYZX7brhtN73FFD2XVpJeZe5r0ZqRLFte7SQ3TonQwecoq2mjM44SMV1n9IIyXJHD0PgKIX73X7Xi0CjFtFAa7ZqfAV1yB9NZ706m+THwTa7cdO47iAJnP+N5oMI2UghCkj+rMCWTXI8qtMLqqHgDZ8KfHIiRJldVgDGztJaU11ma21kSlM/3tsyEFiaKziE+Abv0+ga/WNdc03AuQswi8BmhmN69pWLpvjB3g6vuf/aiio17la7LG6r1P5jO5bkExQaMxcP6spKMQy4lz0sLSUU2ytI41i4OimqK48pCVu0BbYGbiWLnY5T8gj+g1uill44ZC7mfrfG1Tw5lCHEYxah48IY7ljOW4+0kmWIp28dltiDQGZZNPfiPVFhJIz1J0katZWtkRStiXlLDS1JAVohd+ZYHPD/2UiGsRl9ssYzm8FhD1esOtabWMiddXur81jS/dhVo7lA8Jz5agfayZBJpKA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07469ac6-3651-49ee-369c-08d86185e8a0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 19:05:03.7222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aBhQteN0R/xRClzASdw0EXJK7xfIpGpVzdSq/k4YS5LDY7e7lV0mFYbXtTLxnzkER0ob/fwAR8FEKZUrTUqqg==
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

Update the sev_es_enabled() function return value to be based on the SEV
policy that has been specified. SEV-ES is enabled if SEV is enabled and
the SEV-ES policy bit is set in the policy object.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 target/i386/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9c081173db..d3342f5cb2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -377,7 +377,7 @@ sev_enabled(void)
 bool
 sev_es_enabled(void)
 {
-    return false;
+    return sev_enabled() && (sev_guest->policy & SEV_POLICY_ES);
 }
 
 uint64_t
-- 
2.28.0


