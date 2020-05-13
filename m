Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47D1CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8A520740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RmkTgezt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8A520740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYprW-0005oW-LF
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jYpqg-0005K6-90
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:46:54 -0400
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com
 ([40.107.93.42]:7937 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jYpqe-0003ff-LH
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:46:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ts98DA5pc91TKI1fmcVexLyw0zFu07V2F99YG3Z+MHUdxCiOYub1V2BUfRQaT7YgJ/xIj1WnrBT7dy+xOxwiCXyhVNYFPTM5P0TdGMoY9jwCXSqWwx4z3FVf/dfMnrEn4I1uM/4soBSjg30Up4lLulNLf1gJSvyU0rQ0bpGj6OEBDiOcZas3fQYS0ameGlh0o8ZDQsLB6Fc/WbKC2auKZr9lLfGm5T9wTzntlei7QxCu17hW8nTb03/PousT0hLGMFyeTGV/AT+GdZMmlT0J1Y/neXopwOjkqt3Wk+GQmu//iqdPnUAOfscYpymSobFM8MloGpy+qiKB/L0foK/ZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5MaT8CNZd2SbYHu+r0DsQ9J6XXJEvvw5IcToWyLocU=;
 b=FDJbadLWp6rwb4o1RRsXyqH0FWqReUkI9Vl3dVeQ1ordqxrNfAqTqWsSE9GFQPiYO0Aj3UQ7jLuMydyVtw/qjg6EjMcZGomGd+S7N5D4vJ/4tNpTe9apt1wroGE7YQ15ZsH3oE+KXnlYXpUnYwuvzU36RGWWOOFZSYEWufZsdG+96FAFunapC0kX9mEY1EgXOCRRdzUHuzl+9s8ePdmOgINNjV2F21l4vP9pUwIz/jccklGgoHFYBfmIRyNAVfD6/MQ3yshfpHQym1/HBkrofkwiP4ZuolumynP5oT4HQzAGAYIdHx9sk8Cu9x5mSkvzg4TxF3+7KRiij8r+AQPx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5MaT8CNZd2SbYHu+r0DsQ9J6XXJEvvw5IcToWyLocU=;
 b=RmkTgeztfZjgpdMjGVZa/9QSCw+DoQjvu8IT0jslIGFAZj/XYo3o82VB9yH1tl9lvxyQMyNOCF6LuUyPm1rFrtozYA/ZI8Vlc+fvdcRKxwVmiU8t/lxmCT4T04Fkz6qH5pIZJn0ZGzxeoZxFRVriz830rgzY2LFb/25XBGHwQDQ=
Received: from SN4PR0201CA0070.namprd02.prod.outlook.com
 (2603:10b6:803:20::32) by MW2PR02MB3660.namprd02.prod.outlook.com
 (2603:10b6:907:10::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 13 May
 2020 11:46:48 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::a0) by SN4PR0201CA0070.outlook.office365.com
 (2603:10b6:803:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29 via Frontend
 Transport; Wed, 13 May 2020 11:46:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Wed, 13 May 2020 11:46:48
 +0000
Received: from [149.199.38.66] (port=53095 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>) id 1jYpqI-00021y-Em
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:46:30 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>) id 1jYpqZ-0002YJ-Ul
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:46:47 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04DBkivY030822; 
 Wed, 13 May 2020 04:46:44 -0700
Received: from [10.71.116.176] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jYpqW-0002Y2-7W; Wed, 13 May 2020 04:46:44 -0700
Date: Wed, 13 May 2020 13:46:27 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Joe Komlodi <joe.komlodi@xilinx.com>
Subject: Re: [PATCH v1 0/1] target/microblaze: Fix FPU2 instruction check
Message-ID: <20200513114627.GK2945@toto>
References: <1589219346-106769-1-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589219346-106769-1-git-send-email-komlodi@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(7916004)(346002)(39860400002)(136003)(376002)(396003)(46966005)(33430700001)(33716001)(478600001)(426003)(82310400002)(82740400003)(47076004)(9686003)(9786002)(316002)(336012)(70206006)(6862004)(70586007)(81166007)(4326008)(33656002)(8936002)(186003)(356005)(8676002)(5660300002)(6666004)(6636002)(2906002)(26005)(33440700001)(4744005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 827e309d-677e-437e-2686-08d7f73351b6
X-MS-TrafficTypeDiagnostic: MW2PR02MB3660:
X-Microsoft-Antispam-PRVS: <MW2PR02MB366054241A23FD0698AD4CD2C2BF0@MW2PR02MB3660.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QbIVFi6eq5DgJYtwhV9EGNMAEkW+bkgwWJ+3UKW8ZyutnvNNlrr0QCLN+dWZ2YOzq99KJKfI91h1E76gEjBvNP9pn10j3mx6Yvb0op+b88yYGqs+CQsgpSBpbtvOgh/TwxmMJ/XOlzf8t+xdV1NZ+qiguEBeu5s//3sBrzirhszbRfsRw1rYAwtVrvfXBbywYlO0d9N0KIFeE4KUbtCh4gk4t9DzjTL1Am/hEJMdv1VtAf64BzOzSGXAvZYfKSr4WZnCCzFGUjNmXjizUyR2yQNamEx9LhQxkcd0jDjBuzZWBlzwpvPRLgKZRTVcMmueO3BLvzyQ+e1RMNLcPQjCZLLwhyxlfSFI7ZWZA66qrRNOMko2KxnxbUKXTUUbdmGulzbVwkaS7tgPvo0PpT9KyEggkrgoOIvk+REhlwDCZK1CY8VCPZt9zM3NOiRPrjmYLDczVQu2+orgYdyuiRobGBkXD5rcLboEDmtq87uuEDSk+oQg1S+RZWkEaabUHh0nd8nxcpcdK21yTqedmM+Sh8OSrOfuu1RtBCD/a16jB80JZwd/QW7ArU5quybn+DG+qTNApMRW0lLTxqpRTYpsA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 11:46:48.2469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827e309d-677e-437e-2686-08d7f73351b6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3660
Received-SPF: pass client-ip=40.107.93.42; envelope-from=edgar@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 07:46:51
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

On Mon, May 11, 2020 at 10:49:05AM -0700, Joe Komlodi wrote:
> Hi all,
> 
> This fixes a backwards if statement that caused Microblaze FPU2 instructions
> to not be executed, even if use-fpu=2 in the DTS.
> 
> Thanks!
> Joe


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>




> 
> Joe Komlodi (1):
>   target/microblaze: Fix FPU2 instruction check
> 
>  target/microblaze/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> -- 
> 2.7.4
> 

