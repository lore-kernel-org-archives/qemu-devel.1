Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8962C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F0C206CC
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GTO+HVzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F0C206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKhvE-00016k-QI
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 08:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1jKhuB-0008Dc-Re
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1jKhuA-0008H1-Rl
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:28:07 -0400
Received: from mail-co1nam11on2062.outbound.protection.outlook.com
 ([40.107.220.62]:6109 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>)
 id 1jKhu7-0008DV-BO; Sat, 04 Apr 2020 08:28:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/VGSeO494gCEiFHaDPORgBA6qW16BkZtlFthHJXsjy4+dkqOWwvPyUNsouNDCB3RMsDpbPIo8dGTaR21mgvNY/EalaLv0Xmxlz01mo39T0c4FNW3Qd+9V3e8uG2OVsuQHvs/a6z41EE7JoIhPxRghSq96m5E00AjPN2pJNtOn/inG+sCv+jHwyZ3WHRhDu0WorRN+aurSQUtF2De7ES8x7r6opJv+05Wlc2lncIl+sWG1Kq013icO0+qT6HmJpWJbGlLofbvJYvRlokpJGQ18oKEsOPTAOx/6EcN2P89LG7i2tjg8Eu1XoY90AUGh99alxtiyr16+WD+2lfxgOgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maZKNtn7wlA4YHBBM6nYzFvGPYNDg1duoI8yzA2N6js=;
 b=kxs5PEzTtNXmWafZXLgbmCBhnZhi6ct1bG0N7KlPxoH5qoEjvs0v7hS+p9v9IW1po+1uLG5MKf7XMRkpid+3OnZQlP4xY38FJ6jqX5IIVZQanrm0dhTEpyRQVd3gAxfoxMJ1DWVoRBRhSYbUrtU31IqDZbcI8tAZAKgNkC8Tt3gCDB7m9BR4+Cel6c2ZFXZQW3tHTZDDyy+V92cJBKCGJEgbcxel5Fd/fTNWUIDdCoBhz99R+0JkMS5EyHBVTRYbIcleUuLyOSm9HoIMeGLmfFTOupze496GEsPv2lkK2cLcpWMuiBFfFlCeUeubpl9vFrkvTswdb4BMhJNvkM+Yow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maZKNtn7wlA4YHBBM6nYzFvGPYNDg1duoI8yzA2N6js=;
 b=GTO+HVzss2R2elX7IkqLyskfmrwHFaHessaN3MXMXixZykAtARv9hitRn/Wv69Z++c8cStTarySE8K3K3u0qbwUXLrC7tLuxFujGXLk4/7RM3ZfXpNvOPN8sO/2jO4fIrcEWVZfjCuBEr8K3APZI0v0SIK8YjbWG/z9MvobUmQQ=
Received: from MN2PR22CA0012.namprd22.prod.outlook.com (2603:10b6:208:238::17)
 by DM5PR02MB2874.namprd02.prod.outlook.com (2603:10b6:3:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sat, 4 Apr
 2020 12:28:00 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:238:cafe::e0) by MN2PR22CA0012.outlook.office365.com
 (2603:10b6:208:238::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Sat, 4 Apr 2020 12:28:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server id 15.20.2878.15 via Frontend Transport; Sat, 4 Apr 2020 12:28:00
 +0000
Received: from [149.199.38.66] (port=51043 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1jKhts-00047B-Ih; Sat, 04 Apr 2020 05:27:48 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jKhu3-0002ct-Nu; Sat, 04 Apr 2020 05:27:59 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 034CRwOM028373; 
 Sat, 4 Apr 2020 05:27:58 -0700
Received: from [10.71.117.116] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jKhu2-0002cm-D8; Sat, 04 Apr 2020 05:27:58 -0700
Date: Sat, 4 Apr 2020 14:29:08 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 0/5] dma/xlnx-zdma: Bug fixes
Message-ID: <20200404122908.GP4289@toto>
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
 <CAFEAcA_E9VQSZRoV5rk-QOgj-F_-w-jhBBVb4p8vUx-VY9_-CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_E9VQSZRoV5rk-QOgj-F_-w-jhBBVb4p8vUx-VY9_-CQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(7916004)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966005)(47076004)(107886003)(33716001)(316002)(4744005)(7416002)(54906003)(9686003)(336012)(5660300002)(356004)(6666004)(426003)(1076003)(82740400003)(8676002)(26005)(4326008)(186003)(2906002)(81156014)(70206006)(478600001)(70586007)(33656002)(81166006)(8936002)(9786002)(6916009)(42866002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e09b072-b887-4dfa-6fde-08d7d8939d02
X-MS-TrafficTypeDiagnostic: DM5PR02MB2874:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2874394702EE6AB2CC6694D0C2C40@DM5PR02MB2874.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03630A6A4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJ72N/ID7NF9OZSOC3wuOnR+xdE9QoOpiTEswOjU/Xw0w5vwxgtCTrHxqJkA6zwXbdMXGWaWh3rmg757Csz3SN9e2HbEJuoJqiXe4aAOEHen7lOUsyADO1TYDo57ij2nxKBSXaVwEQ3bH++U6K2KD1tmHiU9IUyYBK7F44e0n98ziglj9bfaZoO0LgLNPlL4TMiYadcMjT+4q+vO26CAm26zGkap2+IQTmonNkIb3c7bYVfYwCd+Efz2N7kfmJBNPuCksouETAEnJu5T7PdjIba5q+RyLW4mK4mIkvwewgMATD9ggy09wBmjOhCG623cmfII9mQWZxrjSkWqzAGhWsuQ3GUXrBCLQYYani631JVXedGcMI9RNkgA9NIQMFWohJh7kioJNEkV6u0/1nCy29GUdPDWE3P2dFvzhW8A6I7kmh7dO7IPelyl63Sbl7N4Yaqyhr9SkQgCnylbBugKX+RIfE2jh6ejAflZ1QXplijqOFlAinO/qFlUeM3efYAXl/U0G5MA2xtnK+2DBCvUCKfhMbStEBNv7KUvSzfXoeI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2020 12:28:00.2029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e09b072-b887-4dfa-6fde-08d7d8939d02
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2874
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.62
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
Cc: figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 03, 2020 at 07:53:24PM +0100, Peter Maydell wrote:
> On Thu, 2 Apr 2020 at 14:46, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> >
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Hi,
> >
> > This series fixes a couple of bugs we've ran into with some
> > proprietary test code and drivers using the Xilinx zDMA.
> 
> Thanks; as these are bugfixes I've applied them to target-arm.next
> for 5.0. I'd appreciate it if you could take a look at the
> endianness bugs I mention in a reply to patch 5 (probably
> that is 5.1 work).


Thanks for pointing those out!

I've just posted fixes for the endianness related descriptor loading
bugs but left some of the C struct issues for 5.1.

Cheers,
Edgar


