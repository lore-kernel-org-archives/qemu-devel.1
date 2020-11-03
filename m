Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0340CC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F394206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="08ayXLZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F394206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmLP-000259-6F
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJd-0000jP-LH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:44:58 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72]:13281 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJV-0007gm-Sd
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:44:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCRTvgBhovi4M4WSI2CNL+g0mRZOArur8nHbkZ0bLv8Uf7G7lgsXmg/cYxIcwheq1L9SxKsIugUobkFjrWdYoEoDOCdqW87hfD+NVIOLN6B2C07HKaUuqh6Nkj8apAsUr9gX8RPqnX3f5FZjYR+FxDoNtkQ8KhBEPbUjh7459Ae12QevgQc0l5UpzGf/dTShYimeBbkjFf/fG/9kq/CrBPgLgSYVx9eLvTJ3Jgt9KmHv+N1GiCw43iaUjigG1xEH5Ui8c7ikQU7L2L4B6Kv4jNmEKz9pi9gu9HojhKWeCi3jgaiUtEfaKHwj/czfK6hdkqGtsh/CoGZ0Hq4ExE5zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLYNCImMe2utqvDZqwMheGO5CLksdSPZ6Oc6wmQm9/Q=;
 b=PZTwy5Y3Y3Wjpj5MOmJRmNIraReC/tSHxe1uETM8TtR8N/i77BI3xXwC5YL6Nj/Rm715rqeRupgDyEqBFIi4CnCSqj/KuwfPIGHs9nx3IObYkTZ3Iph0CtDcDcwuadpO6QN72sJ/PSIkgOT04nUPBVua9BCGChGrWPKYQ/mxSEDCZBD0HhkSdQ/bTGEqu5Njgx/zFQImtJ6uQcR12VIxM+OQH7BQW+QxoQJOdBrn8+p22iLpz++PCZdnMoz3AFs/fi7K78zyjUVFKC5nYMus+nmv/nFL/LwJqNrS5rfwUv7DG48mRXLuaxWBxiWZUYh9HOQIurx5ba0IZ4p7PdWs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLYNCImMe2utqvDZqwMheGO5CLksdSPZ6Oc6wmQm9/Q=;
 b=08ayXLZZSHHu3Wbyxs/IZIGtEkCLIk1vfzsFqO8lojsez+VpfNxGbPOkl5jxXrMXQ6oeBi19aXN0t6lTdnZTy3KAAAavci669jrpsulMJgvd5AbOUYfZv4Id5UpVnXvPL/jTjLWaUQXtiuL0YXdmSgUObHO+m1NTDTuOAjv0f7s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:44:39 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:44:39 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 11/12] meson: minor simplification
Date: Mon,  2 Nov 2020 20:43:43 -0600
Message-Id: <20201103024343.894221-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM6PR02CA0109.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::11) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 DM6PR02CA0109.namprd02.prod.outlook.com (2603:10b6:5:1b4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 02:44:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25e537ed-21fd-43fe-4a69-08d87fa268be
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4311D20A42162594507FBFB295110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZ43V1T97YLO/WwWROrfxuP7U3nj9haQrRGVaIBJ87yCBLQBuqVbAkttUShY5EE+0Ij6DXvAQ9E3QKVTnCTEKKQy0XTD3zRp9AmpJpKsQtaSkvYcWofFIyWQuCCag9j76mvMSoeINB6kTyhx/X/U+YIkyatJVgx89QsDm0T3US+eKH1/YUJisiUCY8L+tNhhugZgcLCVMRE0axX4VY1YMyjSoh1p+CfRvhgkybthEe1q1h+YBVpbGgGSFmylwKa4vjmHGOcezIs7YWxd6D6LgQSf7zmafg5S7i90Mr9cSX2S+PjlpfgzD8J5J+r4gWjRrLCuObWZPRJunWUKXdx3dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(4744005)(86362001)(26005)(66556008)(956004)(66946007)(6666004)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6rQUW6PaxoJ+o0SP+0rzHUmuBa45H6h4jN2CN+SrpReRHXT9iH+etRPAYdVCw3hhS4e/oaJD+vce9Sy8A+5nF6w3AUNY8UAUWVx6WTQp55ME3s6Rph7bDO4we87OD+xp22UZokDCQtPHTTdiNkA6nMmybl00RF0J/VA0k42Z2/uhjtoMbB6VHe3pqRkSCr1Lmp/iO6ocFC9BK4DZEGa0P6Sgyy7kXxaY3Aky4G3kXg4mjS7rR0FzBZQg6eD4W8VMgjaWmIh01Ct03UO+2HstDx6/YMhlXq/P4CHOKIKECpZSDmLRznRw0Zyu2WdIIzMPi7U8uOlF/dUq/7IPTaZFEExo10Q4N8DwAy+62MUGiKzJZ0HHChDaHIQBCCyguVmdnbl6pZPMbojR1AOwruz6A/eeo0z1C9izeJ4S47fsjQf4GhLg+t7jnCZnTj7hy5jkXD+GdEKBlRAmy3ifEOmGOdTuO1o3sQZzMWOz2Rvn/OlSuun8UX49Fesy7kYSFRWMddhG+0TurhRbiJR8XBYgEBA5VpguqXueWF6SfRhm2EKFNIQyBjPITZajK9wmYZLAcwdGOEDz0IOk7ybpUR6mFT9qkj/dGZeGbWI+THxFReYXN/qOBT0ubnlxtEkPXXYBlyOZpZVGVtBEZrnLas4n4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e537ed-21fd-43fe-4a69-08d87fa268be
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:44:39.2611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oULIy9iOvhk67GK9pgkrfcVE8QJXBoNVL9vZ0dS4LB3Q2IfDstpjvGK4pDIjSVrBpuO0/T5Uinm7Zn2OThPe7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
Received-SPF: none client-ip=40.107.244.72; envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 21:44:34
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


