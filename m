Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9A3C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16392063A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A7PrcLOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16392063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZl0z-0003Fx-V4
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksR-0006RH-0c
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:47 -0500
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com
 ([40.107.94.58]:64832 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksM-0005WU-0p
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS1JQeFb+O/cloX/uk0gzpugVpMpFzQAyqzAKru5efAu8B1HJAlUmjY1fbNQLFmocwbtUH6dX+GzpNWt5iKLM7zksua8UXLInfZCnjOIymdVCl/ARpu7ozf6YWkRWfUmMDBa6TREF8Mumwm0N5wEKJk78up9Tu9qOgOKFp6+ugwAsLZqS5Kiupk7CQYRzIQpZXAe/X8xOB1jAUQnvDcguhtVNyTr3XWP26E9Az4HL2LtqS3HvPLQxMktPa7857I4wh1M+CkAB+rvMaQGPus9hoUGhsrM7fXBEVwEdHTMNtsS2yW/bZqKrS4CqSDpq1D5HAbi0AxCqIoxF5Qp4I1+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLYNCImMe2utqvDZqwMheGO5CLksdSPZ6Oc6wmQm9/Q=;
 b=oeKrGuP7YkrJtRWMswmASlfJFqKXN/VQEcCOcDbcjk/gEkz4+0mA/pkRlQArYAmaDlytGJNubxq8FmYmV3y+2R3Fdr8oQcr79OTCJuwRsexyoqGCSge+bV2CLpTd38Fs+VbhbcddjWaADLktoqB3PTpk5nVVZFfL69dO6L9eE+GUYEHqrH9OImf/cCDbdETiYZSfBjWMkSuPQlETXLJCcb7ieuE4oFSvR6fLMXem1q1S90UMmyLYRVnJGCQobv2mxRcClC0sQTNCkEVo1ws/qQygEP2Ln0NQyqXPiwJxW9VBnV++WuktgV2HszZGpw2TciaW4y60R7Gk22ANPzc4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLYNCImMe2utqvDZqwMheGO5CLksdSPZ6Oc6wmQm9/Q=;
 b=A7PrcLOPGSWAlX6eQW0uw5bky9cBmkqoRe36D2OFZELh7/I2GLzT4mT/oWWsPlV50AffabwpI6xzMSl82r4hgJ3icsUPYqkbXEBFJlFc7Dyo1YvORl/UKr0JT80+J8seM/DPFXQjnz04GzPlyqtLpU6twSTRspZVly2ptbcoZbQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:14 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:14 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/12] meson: minor simplification
Date: Mon,  2 Nov 2020 19:11:33 -0600
Message-Id: <20201103011134.887744-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN4PR0801CA0023.namprd08.prod.outlook.com
 (2603:10b6:803:29::33) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN4PR0801CA0023.namprd08.prod.outlook.com (2603:10b6:803:29::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Tue, 3 Nov 2020 01:12:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c046609-13a2-4b8c-337c-08d87f957fc4
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50013EAF4D68568D2E40117395110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRwHHExzjpdH1hv8MWsnW7/gdVufUpSJ5dhuz03N213i11p50V0XdYn8k6IrABExHfSl9PeAYra6s8VdDjR81JtRAwXx7toq4ljiuH4ZoOrTKMqBIJEif/l7wQJ4jxpYJyyqMXja6VUP4kQd65clheWHqDBMw28TOFJhgGYVJLhR/rhtTU6X59wdIADN169mejHwUdESI1WDKbwd7J30+91Ed0o2rBfXIGEC1WeDXb0BNTxULUR48JJ9DxoTtxtwyhNi73GPgW+CeyjOqPyKiMtwcX9dTntEvgNGFc47KHhIImgHMzRwsdXfrCkZazFe1G/RmddmoVkruzL1bcNXQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(6666004)(83380400001)(4326008)(4744005)(36756003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hy0ByobZ1uxaV0jjWAr//PY2FQs3UWxOGB87I0fagPLVciNyd100VzXxeQNPkU6CpAAAdw2niQEabl/43R0/hO55bE5AyptBnqlyhpkPFFT/XzJ0QGVO3Jl2tD29yfJHQbePQcd6IyoPGf81EwxMa3DNHwsQUzYYx57etow2iUCmEulfJxTggF22J14Rb9sSbyIYo0FhoejiUfTO0MraHn7b2nIQK7LxNheGqFHiJyYMSLr0wp62z4lQ+7J6sAMiEs8EKmpqndmvkjTax0PU9laMyXDhvT7AwtLDoZ4c4ZJO13jAUCdeHVoVgI2739nrAelXVOnXVF5AT8MBSzt90ZfmSMq02Eqwk1AaY4BZD5dQP2z9xDqx84+HSjs25d0kDZh3xg32M6e8erPUuEH79ul1T95vqXJpINzLYMNUBjU8u1dYkbfwJ+Pu7KhLCjYGtzWFK1KKdG30fm8+BWWVRXWIqDUKvmqqBfrYTDkQ7J/pK4STcppLuSJZykJipR5B4KB87fw/sIEV1EQBS1GnOjlTsIogkLPy9Xl/NZkHIJDvUtpuCxZSFJ0VQfJBIogNzDYMea8LVfuP2bK2OtOWiq4Am/NaDB4THi6R1KCJYTS6IWxP6/8iumTzLkGS42u4FM4E8itIyWBiUMZnD63CjA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c046609-13a2-4b8c-337c-08d87f957fc4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:14.5017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HOkaqBrSS4sBhgIo+SC2JQ3+NBUxTNFOSNQVX7QghEt+5sxC07Px2S3hKhulKkH4euYPhCMDR8sK4+jDSxCiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
Received-SPF: none client-ip=40.107.94.58; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:12:23
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/meson.build | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/qga/meson.build b/qga/meson.build
index 635de9af41..4cb3b3f259 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -22,12 +22,7 @@ qga_qapi_files = custom_target('QGA QAPI files',
                                depend_files: qapi_gen_depends)
 
 qga_ss = ss.source_set()
-i = 0
-foreach output: qga_qapi_outputs
-  qga_ss.add(qga_qapi_files[i])
-  i = i + 1
-endforeach
-
+qga_ss.add(qga_qapi_files.to_list())
 qga_ss.add(files(
   'commands.c',
   'guest-agent-command-state.c',
-- 
2.25.1


