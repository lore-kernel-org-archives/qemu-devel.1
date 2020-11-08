Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F19CC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 16:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FEA206DC
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nPHMflLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FEA206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbnXE-0000JA-8y
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 11:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kbnWN-0008J5-2u
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 11:26:27 -0500
Received: from mail-eopbgr760070.outbound.protection.outlook.com
 ([40.107.76.70]:56558 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kbnWK-0005Hs-Qd
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 11:26:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7+ZCOxCxZPt8HPlFzsBr+wjXcYy9XEBYRBhO/ZwIujJ5SRfAi6AbioN+QLBgKGz4bUcqTv2TbM+ZFw+awSjI87muPlRh4I1ugO82lYL1lkAzmsRL1xQvpsmFqAWVKkkbREg8FMwwGdAnMEjp2+cp4xysltGuqb+5WsD1nB+3gtjAdtgyt3Kf5mQNLX+81GcGy76BShnO3Glo0LEXhtrOiLc8CcGBkF+IzfN18nbkp53nM8Rfbd7YVicfy0pAH132LyI1xIjWo7+cGZVzuFOq65T+ylKYpz4YbA1A62BoCBJhcyGZPerOUMaD7zi2ljOt/b3Ce0JhY5lyPUskjZ8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWhLKPXNrhqpwG0Eb0x65K2aph9kPdq1JZoz/Ti8z3w=;
 b=duYo1zThhyA1HVKoT4SX5bZFcLkZf334TEPf1b0W43AlarnqRcRHrd81xm0pIvPrz6k6kKRjCe/H5YyURJZEXaye215y5HY48zGzpu3qWxxIxAC+6keiLtAU4bTRFNIg1WiDhiWZc3Lt9TZNm1dQ2PpCRtF5bi//dM2oNgRImti+mcnoblKq4ljo0sjsCESHqmzMwqnfFW7DSTuHmAeU9I2OxT7YJ31fSkNKHLQAYi93c6mP/F/V/sry3sbWPQrN4TQde543FBuYxO6CdD+eDKnqpUwn25VE9c9nH+k5h+vnz/cn+V6N7dHYIj88voKsYsCkQCP3rTMwL6QQgffI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWhLKPXNrhqpwG0Eb0x65K2aph9kPdq1JZoz/Ti8z3w=;
 b=nPHMflLh2MulmEn11MD1pumYA6vdEFcDMRxccDZDzyvRb6g588uFzZbWSOJ4KZ0FwsSOUnFLmKWEtnriEw6y0fGD4xmuHQWCZ+OOHdL0kOPRlDCeKm6BwaE0tbbF/Zx3uFd5Uew6Y6AivK5+IIdQLDcfcnO224CUuGuoU6H4K/E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Sun, 8 Nov
 2020 16:11:20 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3541.025; Sun, 8 Nov 2020
 16:11:20 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2] qga: fix missing closedir() in qmp_guest_get_disks()
Date: Sun,  8 Nov 2020 10:11:12 -0600
Message-Id: <20201108161112.187945-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: DM5PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:3:13d::18) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 DM5PR20CA0032.namprd20.prod.outlook.com (2603:10b6:3:13d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Sun, 8 Nov 2020 16:11:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92264859-cd7c-4820-50e4-08d88400ee06
X-MS-TrafficTypeDiagnostic: CH2PR12MB4197:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4197BC757E81E61A65705AB195EB0@CH2PR12MB4197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdvgKQjmLb2YMVnxlS8XCHel/hItT6+JYiuBfuIeyH2SvjWjxtGL9p2RNxfAVuvO6KfUjzKLVHoHfJI0YquYDfqihJz5FMGUf+ziXwmOpuEV2pkSAoQMrPuLblEyDaZHJBNYTPiy4IUH53uFYsFItr0NnEyH/iyUtDefTpwIfom3PpDj7+esRqZRpSoOUDlk7FdX/0k7X6cXP7Mr211fHSlM4O7wej8DjomusLtcb2Jdr/w1hM0LAYWmg2CiNz5bJ4ai0aEdVJyyUPVeKtGIiG+g3YoCg7Ntt+lNkWsbrnWehs/euiBYQqp4+6pk3uNRq4hXDxvlnzX8If2DcWpZMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(6486002)(66946007)(316002)(54906003)(83380400001)(66476007)(66556008)(956004)(36756003)(478600001)(6496006)(2616005)(44832011)(4744005)(26005)(16526019)(186003)(52116002)(86362001)(5660300002)(8676002)(8936002)(6916009)(2906002)(6666004)(4326008)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gyRhoK7ljcUgTFfFJGsNJGFrLhd2WDXX7qluekspQUFD7PA2X8AG6VX1W/OTGguAZXOhBuiFLTt/ZPx9JmwexmqDtkkN6ZeMxNHWKjhbprdBWt98CUkIcuu12meKQcPB8I1ZGW84C/Ks0DwQaQ90q/UhxIKRigPIQ2Q7PdlYDRyayVuPiVrBc13Gh6o4PjaoOOmHftcivn/o9vhRJLp7eFeg4uS8UQnkX5OPZDizTMxNFBKAebmacWDUQ5ir/L9tYlSqft0UqqJ1qytEqUDunfXDPb0f4qUz+fAJAkLxGE1mwIgx9XwgChvRXa1YkOCK/9dcaiyvFvXbwsvoDeJkbQRMIhff7kE/mxwH9K47NnGxd6Mj7EOD11T9dqWg+7qFUE0OkFsI6gIcEyFn7HGBegFJXiar8gCIeUerwAPX2eT2Pd/KJcA43+8RzfxY1iZeIqduvDlY/kSlQfBQ0gSUk647G9hUDkFWp8N0vkqes91FVQUVLvkytmHwPtrNsONLwhHAeLBFny1/J3EWkg9xWl1Re9k9kl8gaoBF4Pfb7UPgjqT4LiGmhOqrRKlPhE9RBFkdjuSh5LdozFbC+FkVpUINj2slDZvZVTZtodd3a0cAwqxn8iYIXzpE/AizNXf9r/bwTcrFkf5Y81lf1JR+cksB6+VdjYUsluQjr+VX16B+BH9OvgO2ow2wLPc9z2c0JCYn92Iv7ckkkXNfmfgMSuuLZ6VoeJFD9OBTEQNGiaDxDyXtIsYHkvzNxgJxVY80ZPrmBYlPfrAu7fI4yxC3HCaUYy4ZLLxvYcvldOL68VafT5Bd8A3123+HWqBgp8bHFStIRiajbMwNimJIlfX7PE2hAylNJJdT1bPUeF+3QW6cW6zfziPfidG9LFppd8a9C/GDGNtYUiTRp3fYxfufZA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92264859-cd7c-4820-50e4-08d88400ee06
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 16:11:20.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KciHvDWX+d/Zshlaw3DR7++L4XfOBVXVNWQl0vNxA5BpZMI6Pn8slyMF9OublgTon4wkEHzO+CxgtrEmJW5GZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
Received-SPF: none client-ip=40.107.76.70; envelope-from=Michael.Roth@amd.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 11:26:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1.299, MSGID_FROM_MTA_HEADER=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We opendir("/sys/block") at the beginning of the function, but we never
close it prior to returning.

Fixes: Coverity CID 1436130
Fixes: fed3956429d5 ("qga: add implementation of guest-get-disks for Linux")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Tomáš Golembiovský <tgolembi@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 3711080d07..12c1ba5ef7 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1443,6 +1443,9 @@ GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
         get_disk_deps(disk_dir, disk);
         ret = get_disk_partitions(ret, de->d_name, disk_dir, dev_name);
     }
+
+    closedir(dp);
+
     return ret;
 }
 
-- 
2.25.1


