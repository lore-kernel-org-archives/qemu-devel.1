Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED765C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8641205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S5w/ER0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8641205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZELV-0007Eo-Sz
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jZEII-0002yz-0H
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:53:02 -0400
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com
 ([40.107.243.69]:22048 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jZEIG-0007K5-GX
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:53:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blJXRWD/TRIFbuvpnicJTtocKajH833GYqU4aUiQEjinwmzRgftf1lZPNH3Wm/SGxwwMq3NgkM3bkNSxh8fsKPLb8LqJWS/SOuHekhAjaIqY6uG/jFr4BWyRRJf7LBmpQ9jOLg1PW+As0xQpHEO0Kk5LcCBOHUCwwfEblFsiy1SiqO7l2+IFP7t5yLYu8Kj5zChlgM5c1aZnQi3fdHOxP/N7ulHxnx8E1O5GHJNOZCyJ7+ntwA1ghRIL6OpleJ8THCaoDcr2hqFOU9BfCdU5Cc/kScn15MLwJR1NMosu6UuIkCc6SYR3Sm0VUCXZlA+k6aLQfhMM75R5cyR09zYBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcDDz8DW/+5HCxbmbDIEJTusAIzKk5oc3Eqwd9aGQNs=;
 b=ZPDI4yWaH5ZogQlf2HM62girdZ0CQSiJ86prrcjdbjcUiKEedednTq0sipEOivB7V7i33asIJDwdJ1/ecTzavyZY313kWj0gWQ/2VW2+HtjGFeoZ9VUfUpvKksYEDMEBYC1Iu+nUcLxokZma0ErZQQ+SAjX/uL6FPsalOizXGMm3PpaYs1HfxqNrbEmu8b+S6L7u2ewYJXv+8o3Z8UVPIVgMj8vp3zlMf3aslRhI7u3ya876u1RdTey4OC7ve1pYHeoKGqWPte1FQGHsGm8qEoL0g5MsfvAxECnyUoVNHS59OiLvhpCa6BVafemBRC+WRElltuY59727venCik8fTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcDDz8DW/+5HCxbmbDIEJTusAIzKk5oc3Eqwd9aGQNs=;
 b=S5w/ER0MV8fzBC1txD1a6O/njNpmrmEJYCJNUk07DY8G8V2m4d+/efc0phuzc7bBNzVbb1jxWGqA3lU22qGEU8XkiX30Rfd6Cjh3R0vK+ZoZm0qbnbWqLiKUjsW3KUq3uARTsAK8h5VZ/BDma74HGpopfoPrBCcggL1OWTPAKFo=
Received: from CY4PR1101CA0022.namprd11.prod.outlook.com
 (2603:10b6:910:15::32) by DM6PR02MB5228.namprd02.prod.outlook.com
 (2603:10b6:5:46::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 13:52:58 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:15:cafe::85) by CY4PR1101CA0022.outlook.office365.com
 (2603:10b6:910:15::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Thu, 14 May 2020 13:52:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Thu, 14 May 2020 13:52:57
 +0000
Received: from [149.199.38.66] (port=59807 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>) id 1jZEHu-0005FD-H3
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:52:38 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>) id 1jZEID-0003BZ-FI
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:52:57 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04EDqpF0023972; 
 Thu, 14 May 2020 06:52:51 -0700
Received: from [10.71.116.176] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jZEI7-00039X-2O; Thu, 14 May 2020 06:52:51 -0700
Date: Thu, 14 May 2020 15:52:34 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Joe Komlodi <joe.komlodi@xilinx.com>
Subject: Re: [PATCH V2 0/4] target/microblaze: Add GDB XML and correct SReg
 reporting
Message-ID: <20200514135234.GU2945@toto>
References: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
 <1589393329-223076-5-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589393329-223076-5-git-send-email-komlodi@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(7916004)(39860400002)(346002)(396003)(136003)(376002)(46966005)(478600001)(5660300002)(6862004)(4326008)(9786002)(2906002)(9686003)(8676002)(6636002)(70586007)(82310400002)(1076003)(8936002)(82740400003)(70206006)(186003)(33656002)(33716001)(336012)(426003)(356005)(47076004)(81166007)(26005)(6666004)(316002)(42866002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9931f5f8-4281-48cd-516e-08d7f80e1be3
X-MS-TrafficTypeDiagnostic: DM6PR02MB5228:
X-Microsoft-Antispam-PRVS: <DM6PR02MB522814BC930A2FA3BA185E6EC2BC0@DM6PR02MB5228.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qM9k1BfezlwTmtWeVmdParkbUZq9a+2iO73ANHrpuLFHxTuGMQ5BC7bIw9gmnS0wLWrOq1yCi0ZdDIV+y+kWadjgTABk29Nj326RbjMKpXEBlCBAI3/ArFA1gH866hVkqIFuKqNG00rOx3EWJacayL4jzW4dtjtVUDa/AWFprLzvSwkCHh19Jt4uk4McYq5vigSbF8i98k/b1r7HH6uAswQQVaWtAuuDyknNcMBZjXgb5HSEfzy80qiZsqDC7kYYo6MpA0bR8UXeuj+Oom3xqO11Yz/a2eP02b+gEcYjVzB4XdMxHXuayzshMWsOK3nuA9a8SF3cQBiBdJTypck4sE3q1n7wngEtW/PmN9M5X2PLN/BuNRZ7Ff9mtCx98zbo/HdScmZ7HrJAa4uhMimR6ZkEwzXEl8M/BQZ/WGbZt8CzBHQNQhJ9UKLSqNe6hUtz+Da+W/XKw68f+fSkbkbxc6E40O5KaVm2dsJoVCpRv4KSQUwuj0Mguh57a3v9Znyx4NKh77BxOGNnUmVpiwfmdSt1kOtKoMaSxaWx3yd7Z8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 13:52:57.7297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9931f5f8-4281-48cd-516e-08d7f80e1be3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5228
Received-SPF: pass client-ip=40.107.243.69; envelope-from=edgar@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 09:52:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 13, 2020 at 11:08:49AM -0700, Joe Komlodi wrote:
> Hi all,
> 
> This series adds dynamic GDB XML support for Micraoblaze CPUs, and 
> fixes an issue when reporting Microblaze SRegs through GDB.
> 
> The SRegs used to be printed out by iterating over the SReg array, but 
> the SReg array isn't laid out in memory in the same order that GDB expects them.
> 
> When reporting register to GDB, note that even though 32-bit 
> Microblaze supports having certain registers wider than 32-bits, we're 
> repoting all of them as being 32-bits wide right now to maintain compatibility with GDB.

Hi Joe,

I've taken patches #2 - 4 into my queue.
Patch #1 needs some more work.

Thanks,
Edgar



> 
> Thanks!
> Joe
> 
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> 
> Changelog:
> v1 -> v2
>  - 1/4: Added missing core XML file
> 
> 
> Joe Komlodi (4):
>   target/microblaze: gdb: Add dynamic GDB XML register support
>   target/microblaze: gdb: Extend the number of registers presented to
>     GDB
>   target/microblaze: gdb: Fix incorrect SReg reporting
>   target/microblaze: monitor: Increase the number of registers reported
> 
>  configure                     |   1 +
>  gdb-xml/microblaze-core.xml   |  64 +++++++++++++
>  target/microblaze/cpu.c       |   6 +-
>  target/microblaze/cpu.h       |   9 ++
>  target/microblaze/gdbstub.c   | 214 +++++++++++++++++++++++++++++++++++++++++-
>  target/microblaze/translate.c |  16 +++-
>  6 files changed, 304 insertions(+), 6 deletions(-)
>  create mode 100644 gdb-xml/microblaze-core.xml
> 
> -- 
> 2.7.4
> 

