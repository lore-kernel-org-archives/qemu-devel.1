Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C850CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE8D2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PoY8ShGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE8D2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvDC-0003un-Qo
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jYvCH-0003QZ-70
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:29:33 -0400
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com
 ([40.107.223.55]:6059 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jYvCF-00071W-Iu
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:29:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlongEYfuPS3SLVeC8q9eNiTlMtvil/pvBDaUm0y4uj+m8ieb6qfzAtv/Plzeqr68V+aorbDM6LZhxscrlRwEOSBI29mo0qRuAX4owI0ILCAjnYHkUH+w7wRggpeqpTMQIArXqOb3umSDJ6Br81eovou3qkf3glj1J/iBaPBLPVZ/1qkltL77+jeD0qyDQYoF9snBootCqBPahhit0S6oTIAoRzeixj9XzQqeNqP74WbGhTXnueCeAyn/0iKWn/8SuA1StLrHJn7YhU04IeBpVovb8Dcfj2e+xJNTPxRDlY8soki5PgfnddRRSO8xzbnNZdd3N1fzFegcN/pPkxP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW/QziI/U87W+zUiJcI6fGx7HyOc9ffSJGTiSzzgw+U=;
 b=J/Omym5Z2DHm0N4+uJcN7Trs/GE04vVtz6usX7Hh9Z5M1FepIssv76cc1gFmUCLi9fZFM2AGrTHvGI7lH6EXXy16VpThudyTmsiLNwfVcA3X6twdS22YSj1OVhFO+m0FLHX3RQEhwnWxCHjNsqrMBuJUX315mEf3zs0QcuKLTHXtTQEOdhMw8mtz66L5XR6niQYZ7MHvvboc0Rf/wbEZL4l9t+J1PRTSUGvrrFgC+oVA/OIBHxt6hjvnF0Ldr0tBNiRRvPsS+3vfLn0h/jxyA9btx7AtSaK4pYB3jAtHmv5C+e8zeP0KaCIwD6ZvpwDb/xTMIbclsngqMCgl+qUzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW/QziI/U87W+zUiJcI6fGx7HyOc9ffSJGTiSzzgw+U=;
 b=PoY8ShGlwAk2ktQ1AXCg8EDqerJYirChMoMTUf5dBivUi9R5u/WijFk8pFbLMrX4UdOeholnrWz5CMgLrCgPaC8fjeHShGq8GAWfrZA2A9tJvNsn4qkl46S5HfkpChMk6D+EF5F3KdhvXYYX2i8QAjLU9TBXhYlMoTsOymWK3vQ=
Received: from SN2PR01CA0024.prod.exchangelabs.com (2603:10b6:804:2::34) by
 BL0PR02MB3777.namprd02.prod.outlook.com (2603:10b6:207:4a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28; Wed, 13 May 2020 17:29:27 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:804:2:cafe::91) by SN2PR01CA0024.outlook.office365.com
 (2603:10b6:804:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34 via Frontend
 Transport; Wed, 13 May 2020 17:29:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Wed, 13 May 2020 17:29:27
 +0000
Received: from [149.199.38.66] (port=53491 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>) id 1jYvBs-0007LR-56
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:29:08 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>) id 1jYvC9-0002bD-VF
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:29:26 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04DHTFh0007067; 
 Wed, 13 May 2020 10:29:16 -0700
Received: from [10.71.116.176] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jYvBz-0002ZC-La; Wed, 13 May 2020 10:29:15 -0700
Date: Wed, 13 May 2020 19:28:58 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Joe Komlodi <joe.komlodi@xilinx.com>
Subject: Re: [PATCH v1 0/4] target/microblaze: Add dynamic GDB XML and
 correct SReg reporting
Message-ID: <20200513172858.GN2945@toto>
References: <1589216751-106038-1-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589216751-106038-1-git-send-email-komlodi@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(7916004)(396003)(39860400002)(136003)(346002)(376002)(46966005)(33430700001)(70206006)(8676002)(26005)(9786002)(186003)(316002)(70586007)(47076004)(82740400003)(2906002)(81166007)(9686003)(356005)(426003)(6666004)(82310400002)(5660300002)(33716001)(478600001)(6636002)(33440700001)(4326008)(1076003)(6862004)(8936002)(336012)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b09ecd-0261-410c-3a11-08d7f7632fc2
X-MS-TrafficTypeDiagnostic: BL0PR02MB3777:
X-Microsoft-Antispam-PRVS: <BL0PR02MB37771FF67F9B1E692E444636C2BF0@BL0PR02MB3777.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f79ENzpVyIPvUKKAAE//KNyj+HVH0ZTTss9pAx0Cb9vz4Aufe6uo4nJAhTu6BdkRQ0dynUIuK8rQr6Ymk8UN81/QjOo+qqD3jYwWLoK77UrQuugvu36zFbhyy938iMEPPvtw0/OVhKdvTmREuL/HfOEnhRLAgxaxU+yoRqbJgrFswu6veaqTKU0A2yNjYQcXUqd3qAflZZs5bkWtdpSIBNb2jKbJUYdqCQnEk40psFkHXCCUlyIdYvYVwzkZQTuy7lMCWLTZzOhHCwjB0bozu7h6ZIDkM5hYvJhzkYn169bee1ctlp+/xxe6RWzHB3SyAP4xigqUCCu1dOIxR+Qi1bEgKKii6j8xvcRihlEV/TyWYM6IWJIKa5cvuF6KcVO5WljbMZu7ZFdYJ/31blaFsvFIgzYU7caK8XQtZSorawPePy8YZbwXxvCPIdVbh6dtPTZUFY6UBvBKfeFf3q+xGPHANHzcrm8KiHe9mNafZQA+ABzJvB8dUJ66F9ZIebP8M9HYD1rWEq4kZjWdeg8Od86+VZdkJmIBoQ26qEDv/xChl+GOwonEaAPg5fnwoW8CnwWi2jxEzTkmEQGFmNqIvQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 17:29:27.1275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b09ecd-0261-410c-3a11-08d7f7632fc2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3777
Received-SPF: pass client-ip=40.107.223.55; envelope-from=edgar@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 13:29:28
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

On Mon, May 11, 2020 at 10:05:47AM -0700, Joe Komlodi wrote:
> Hi all,
> 
> This series adds dynamic GDB XML support for Micraoblaze CPUs, and fixes
> an issue when reporting Microblaze SRegs through GDB.
> 
> The SRegs used to be printed out by iterating over the SReg array, but the
> SReg array isn't laid out in memory in the same order that GDB expects them.
> 
> When reporting register to GDB, note that even though 32-bit Microblaze
> supports having certain registers wider than 32-bits, we're repoting all of
> them as being 32-bits wide right now to maintain compatibility with GDB.
> 
> Thanks!
> Joe

Hi Joe,

Looks like you forgot the patch that adds the xml file?

Thanks,
Edgar



> 
> Joe Komlodi (4):
>   target/microblaze: gdb: Add dynamic GDB XML register support
>   target/microblaze: gdb: Extend the number of registers presented to
>     GDB
>   target/microblaze: gdb: Fix incorrect SReg reporting
>   target/microblaze: monitor: Increase the number of registers reported
> 
>  configure                     |   1 +
>  target/microblaze/cpu.c       |   6 +-
>  target/microblaze/cpu.h       |   9 ++
>  target/microblaze/gdbstub.c   | 214 +++++++++++++++++++++++++++++++++++++++++-
>  target/microblaze/translate.c |  16 +++-
>  5 files changed, 240 insertions(+), 6 deletions(-)
> 
> -- 
> 2.7.4
> 

