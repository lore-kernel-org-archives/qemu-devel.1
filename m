Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EF9CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 12:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB16B206CC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 12:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ufrsk2wU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB16B206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYq65-0005lY-U3
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 08:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jYq57-0004ty-6M
 for qemu-devel@nongnu.org; Wed, 13 May 2020 08:01:49 -0400
Received: from mail-eopbgr770053.outbound.protection.outlook.com
 ([40.107.77.53]:37895 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jYq53-0007Ei-FV
 for qemu-devel@nongnu.org; Wed, 13 May 2020 08:01:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZbYCmiTT41/ZeKq4EhEp7FHTPY0r5liNJUKsuHD5/Z5DzMb5+P713LBlLZS5flGDQ2k4TcruX0BohTrmoCpUzF6fBpafG08vs8ncbktOYQ6tQTCm99H3vuzI/TNh9iSCOzVGBb2yTgjPu5BXdY9QNY/WL6hyQgf8cTIF7sy/tpVlp+ChgnjwY+qDz+MGrrQL0iCIa2EBAlqVNeABnR4sTrITKuVGHzmFHntEhAOyENM1ipqVp0Wod0/Cv9VKpwftPvGi4i3b7tiowFIz2wOkIExOrKr30u+Nizyps0ZTVrvdN1/jG/8UFMwcy0FBXlwIGJwMGMHSKl3FZBfA3zN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V04aedMwDn11qqi6Wyw42Wye32/KKVWHnBu1xxhJbAw=;
 b=jaICNYVKsCra/EkYgDl8glU2LJllsbERyyf6FV7KYU5UtOX7BnFFqKCvj7cgf2KayLbyMN15ZQvnPCSZpyQ9zfu1pC/Zwp7APPEP5O5cas2Yv4QKK/p+O5Bj+EYXXELJJnTLiQn+11omp08rWRfQBATgDL4oZ4e/X8gOGLojqEyvluW+OKWkUT2kssWcPtrbnROluxcPR9oPbHHfUFCVQIdj2YQ2k2m7rfYK0eu32qI9Zqc8k/jT+7yOG4ghvD7Wa0DTSvGA8ZV6JXowiPOmweDC1eDjB29nEE0hcbZyXPkDRwYjXxxedchiog1W5BOWdu/8ph5RjQMG+9sddVIR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V04aedMwDn11qqi6Wyw42Wye32/KKVWHnBu1xxhJbAw=;
 b=Ufrsk2wUzG3PQF1h1ncIIl67SZ6a6Vc/rwtgkU9nZtthBC/j68IEkueIXANVaSg/FjKYt2q1ykLZ6idUdfnEzDoQVHXa+qZzceBiz5koLXnZO4fcJCquTNhjk/e5Bi9UR7Gy5ektMWQMM7qcqTQpk6t7dXaRT6eyHlMAZu6A5k4=
Received: from MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) by
 CY4PR02MB2629.namprd02.prod.outlook.com (2603:10b6:903:73::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26; Wed, 13 May 2020 11:46:38 +0000
Received: from BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23f:cafe::46) by MN2PR01CA0039.outlook.office365.com
 (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Wed, 13 May 2020 11:46:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT034.mail.protection.outlook.com (10.152.77.161) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Wed, 13 May 2020 11:46:38
 +0000
Received: from [149.199.38.66] (port=53014 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>) id 1jYpq8-00021n-BH
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:46:20 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>) id 1jYpqP-0002XG-RW
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:46:37 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04DBkS1u030723; 
 Wed, 13 May 2020 04:46:28 -0700
Received: from [10.71.116.176] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jYpqG-0002Si-3g; Wed, 13 May 2020 04:46:28 -0700
Date: Wed, 13 May 2020 13:46:11 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Joe Komlodi <joe.komlodi@xilinx.com>
Subject: Re: [PATCH v1 0/4] target/microblaze: Add dynamic GDB XML and
 correct SReg reporting
Message-ID: <20200513114611.GJ2945@toto>
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
 SFS:(7916004)(396003)(346002)(39850400004)(136003)(376002)(46966005)(33430700001)(6636002)(26005)(186003)(5660300002)(8936002)(9686003)(316002)(9786002)(4326008)(1076003)(426003)(336012)(6862004)(33656002)(33440700001)(2906002)(81166007)(82740400003)(6666004)(356005)(70206006)(478600001)(47076004)(82310400002)(33716001)(70586007)(8676002)(42866002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c902567-694c-4eed-98f9-08d7f7334bb8
X-MS-TrafficTypeDiagnostic: CY4PR02MB2629:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2629AD370C45BDDAD6D03E34C2BF0@CY4PR02MB2629.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRryB+wbU7dD7sK2YzSud45A/zSJKuylL9qmfTW0kPC01q4/zXnvfRZ0UiW9Y+j+S7KwF3rMuqndP5Nnr+Kl6B4RqleJ5jNbfw7y2Vqr+Qd1cE33JaSjhCcix9ILEhaieb8+tJXGSepaMU6BmE/15mzHDffg94SiOuICHIPdB9r/o2BOXJ5bl1epy619346UcR3MXZ3hFZqKLsjvJJMMOyMm9LMmBJNLwDZbbijWYbtK+1JimY7kHLsjSw4GjKMjgFCOEvqwE9bGrcgXA7DZhbbupJq/wGv4S0i9VNDRqWdbEZ2SoEYSCrQTM/3E3XnDx14saZqy6jleWUahLNMO8LSoDrx7u0rE+VLGIpw3t2ZV0k5e8Fa8NpAzXIuA21N77X7XLWtHcgRmihqx5qIseo+z49rIyJHFJ4LWnTU7ZG24PXZ3Uo09mFm7WhnSkCUblhRdL1syAko6vJazUd9MV9e2U8Bx4qzlwMIQFZ/px+IILCy5QtL2cXUQtlgamXMWdk6v8VfHTKOITOPGW6lSQmu5z1zXUoSSGmlTvceY2HQuHRab9G6/de/0csnHZjbcf7MvEBnMpLLb9XvYQoPGYPBJzeQCRB2BiC2HdEw9U40=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 11:46:38.1966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c902567-694c-4eed-98f9-08d7f7334bb8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2629
Received-SPF: pass client-ip=40.107.77.53; envelope-from=edgar@xilinx.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 08:01:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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


Thanks Joe!
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



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

