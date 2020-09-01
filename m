Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EABC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C96206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KvrH91J2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C96206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3Ei-00006E-T6
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kD35J-0006po-Lh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:00:13 -0400
Received: from mail-bn8nam08on2071.outbound.protection.outlook.com
 ([40.107.100.71]:33505 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kD35G-0004Y6-Gb
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:00:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRaqQqd2YEL3aM34cBa81oYYya6Iw6hDwV2HDufqamreyp247yhjTqy+ls0nDbXWTlhIcsNAneIuSLA+LIJEBsi7x0t3WCmZoi/phVB4hoLUfpOxUgbqgrQJByGZ3PmrUjOkwIAnY7ohwf5k1NxosmEeun2qVF+ndh1QjaENrpC8CSQ1x3IC0EdEZGFRxOgZcBUZKtiU5BdJuf/cy9W8FxJdzQSCTGK4/ir+HVDl4UJA/8kNtDjCh/Ytw33CWqtjznKqkcoZKG5KLerVx23d/2K7RocL+r5SgrNPQPygJm79QtElYI0tFwO71yYpM1JWopLLQs6RzciE3XtURkrr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu78bp0pe84jWbQu4JDyVFYvHyEllRwSGyMlV12Hkh0=;
 b=ig99esayn/lYlmmpg48qSrKl9HZvAjqG5bfXrGDHTDuufYTTeH+kB+hLPQhdAsu/fhLqRqs/wp5GD3d76vYG9Jq1ZSNnU+/TJY6bbh3sWua0N8VN6LDGygvD8fVrDS4i/4fW7qvtXZYAZiv2EnaHZA8qiOEQr31ZQ5jmXGB5XsO0xfMrcwsrEu9YMZL8r8/rK8guPBjNcLiLBVg8Tqfociz+MQYw2hJ5MUd/A+HBK+vtJLNYHvK9iAkXkOfpw8TAr7xqrX9fJCWQ3NJi7c4A7Fr/N6f1qnpsVNRZKMCcO7guKkA0YARwubPZYCSuM/JKW46kRdIXmqEl+iKN3E7WUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu78bp0pe84jWbQu4JDyVFYvHyEllRwSGyMlV12Hkh0=;
 b=KvrH91J2/j1XqtBlbXp0Ou//7XXRtj4R11zOrC4vGZVtP02XjnRtcHtRxrti+jpgwCXwxf4pzbjwlFLcSMPsuPLfUJiAWL5bLKgolQiKAfaNx8PuLhvrm+39wgcGyrXARq/LCXcYagnPHOQOlrUGlpug+CYrr2kecR4m+3JEomI=
Received: from CY4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:903:18::11)
 by BY5PR02MB6098.namprd02.prod.outlook.com (2603:10b6:a03:1b4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 10:00:07 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:18:cafe::fa) by CY4PR02CA0001.outlook.office365.com
 (2603:10b6:903:18::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 1 Sep 2020 10:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 10:00:07
 +0000
Received: from [149.199.38.66] (port=54073 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kD35A-0008EF-BV; Tue, 01 Sep 2020 03:00:04 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kD35C-0004HR-Tr; Tue, 01 Sep 2020 03:00:07 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kD35B-0004BF-VI; Tue, 01 Sep 2020 03:00:06 -0700
Date: Tue, 1 Sep 2020 12:00:01 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/6] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
Message-ID: <20200901100001.GM14249@toto>
References: <20200831184018.839906-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831184018.839906-1-richard.henderson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a816a5c-4773-42fd-76df-08d84e5dce71
X-MS-TrafficTypeDiagnostic: BY5PR02MB6098:
X-Microsoft-Antispam-PRVS: <BY5PR02MB609815A052AE16D615841025C22E0@BY5PR02MB6098.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtaAQqi0p5t5Wl3+XzkPk1bkISmprulnzk2v6n/l2vbl9EbECiWx0gt/+jYzlUQ0mvGeVmQjPXLffYf+V4Cc+7n3rwDec16uoLEhot+O3VlhmohEKu//1QzvzMw3OpSjskcNC/gJMq6iktjMd6G2Jm/fNV1th2BFVb4IG0m51p1p32k09r5rsiU7dZ22aZXLqtPYMSUDpbu2chVNZKJlcKUjXP+pZgds7mFdQVuPqOZc8WlJ8c/fAegqm8G3Jlk5gU31M1TkoIU1MlMjJQpRJAB2PpBhUwrWVOh/8+5bJy8Dadnu0NbbKJS8l8xmu/ZdnBuRVt/7rV7oUyz+nn8ahpDm86hqDX2cu0cQvdQfA37bPOv1M+mRo/v68YbUx5oB56fX2xZLLk2HCIpudLM4PQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(136003)(346002)(376002)(39860400002)(396003)(46966005)(9686003)(1076003)(4326008)(26005)(2906002)(316002)(82310400003)(6666004)(186003)(426003)(5660300002)(336012)(33656002)(70586007)(33716001)(8676002)(9786002)(82740400003)(6916009)(83380400001)(81166007)(356005)(8936002)(70206006)(47076004)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 10:00:07.5352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a816a5c-4773-42fd-76df-08d84e5dce71
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6098
Received-SPF: pass client-ip=40.107.100.71; envelope-from=edgar@xilinx.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 06:00:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 31, 2020 at 11:40:12AM -0700, Richard Henderson wrote:
> Based-on: <20200831160601.833692-1-richard.henderson@linaro.org>
> ("[PULL 00/76] target/microblaze improvements")
> 
> Hello again, Edgar.
> 
> I had dropped the tcg_gen_lookup_and_goto_ptr patch from the
> previous omnibus patch set, as you had reported lockups.
> 
> I have identified, by inspection, two cases in which we failed
> to return to the main loop even though we should have:
> 
> (1) Return-from-exception type instructions.
> 
> I had missed these before because they hadn't set cpustate_changed.
> This still worked fine because they are all indirect branches, and
> had exited immediately.
> 
> Fixed by distinguishing these cases from normal indirect branches
> before we start using lookup_and_goto_ptr.
> 
> (2) MTS in a branch delay slot.
> 
> We did not check dc->cpustate_changed before setting
> dc->base.is_jmp to DISAS_JUMP, which lost the fact that we
> need to return to the main loop.
> 
> This mostly works fine without lookup_and_goto_ptr, because
> we either (a) finished an indirect branch and returned to the
> main loop anyway or (b) we'd return to the main loop via some
> subsequent indirect branch, which would happen "soon enough".
> 
> We should have been able to see soft-lockup with the existing
> code in the case of a cpustate_changed in the delay slot of
> a loop of direct branches that all use goto_tb.  E.g.
> 
> 	brid	0
> 	 msrset MSR_IE
> 
> I.e. an immediate branch back to the same branch insn,
> re-enabling interrupts in the delay slot.  Probably not
> something that shows up in the wild.
> 
> ----
> 
> Follow-up question: The manual says that several classes of
> instructions are invalid in a branch delay slot, but does
> not say what action is taken, if any.
> 
> Some of these invalid cases could leave qemu in an inconsistent
> state.  Would it be legal for us to diagnose these cases with
> trap_illegal?  If not, what *should* we be doing?  We could also
> LOG_GUEST_ERROR for these either way.

What I found out is that these result in undefined and undocumented
behaviour but that the behaviour is deterministic, i.e the cores
won't lock-up or exposed security issues or anything like that.
RTL will not raise exceptions on these either.

So I think LOG_GUEST_ERROR and treating as NOP is probably a good
approach. We can fix that in follow-up patches.

Cheers,
Edgar

