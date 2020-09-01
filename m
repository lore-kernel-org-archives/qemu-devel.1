Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15C6C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7996204EC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="opWHoeuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7996204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD0QZ-0006AN-Sk
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 03:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kD0Pl-0005TV-Bv
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 03:09:09 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com
 ([40.107.243.61]:21057 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kD0Pj-0006UX-Jg
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 03:09:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR3P0/wYbrL7wq1CbG57PXfi6w1ATEG6jVtWVBSqw+7ZR6FG1DXpVuwAPQYuEsGmJ13ehYp6i2kOCYgAonKRcTINfQgeYBEmDFS5rN2vZGDpQhW2gt4933KIgyU31te1mLSNXD4/t6yNFOS2nxZeYur1isAKxKYZzJ4AtdP4ey3YwtW3lMDkl9ZToTT1SqpsQM6sJ167GR3FKeRP23F1tNpYTN0dY61mmzp2Hwk5f7NBzJ+1YFST1zxbVCAqqdg13cj4CV8jt066G3WP2WDfHaRWz0iSRekpHOZvLUJk9bL8h5cS4Kd79HAaMFPq5phxj/XAf9GcNgGX5D+AFY8kPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVdbuMzFF7zycJNYp4bqGcTbeiBL6gzVKaMoWOemZeM=;
 b=dGCeezCGOlPxyDxplRED3yBGYqfXb0KRa2sUKvshIVezVI/pI/UpcykUssyeRadR1xBFUYHPoIPlF4lZTJB/LLB2OCONHhsEZmrcYj4EvNrgBuxIhAZkd6pD2jV3JSB+KpuKEj+Hx/U0OXNYh77QRibsBPz4QEHBRcjnuP8OCDwZqmBZHufPgVr19Y36rN+oyLbqzFAnM8J7bzITwN+ota5vKexActooDMVkGlpLxeLN3fEXlHs89XOSyZ9s0aZBhz3mJ+7N2UlYWAQMHEkOG8pUxJ02/7LUNZA3SLkgKu26kAIsiu2eNiOG0iNQpe0xXN8tHJJen5H6r2nRRVD5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVdbuMzFF7zycJNYp4bqGcTbeiBL6gzVKaMoWOemZeM=;
 b=opWHoeuNTeW+nY8BzFnCBY7Hu3z28WDYZ0qk1FJXIMTYfvdJdOpBs6H4Pzd8J3qM9SF3/FM1h1TBo3BZkWbi2q1RAXOvQ52QoB6lDXsQ/nGwpzw66HVlIme82h5KdAu2kwfYiTAjzauQjAXVnba3roIGtQlAVJD1ywRo5Jz36cs=
Received: from MN2PR18CA0007.namprd18.prod.outlook.com (2603:10b6:208:23c::12)
 by CY4PR02MB2790.namprd02.prod.outlook.com (2603:10b6:903:11c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 07:09:04 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23c:cafe::ed) by MN2PR18CA0007.outlook.office365.com
 (2603:10b6:208:23c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 1 Sep 2020 07:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 07:09:03
 +0000
Received: from [149.199.38.66] (port=51197 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kD0Pb-0004oF-VA; Tue, 01 Sep 2020 00:08:59 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kD0Pe-00029G-P6; Tue, 01 Sep 2020 00:09:02 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 081792s4015825; 
 Tue, 1 Sep 2020 00:09:02 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kD0Pd-00028M-Sq; Tue, 01 Sep 2020 00:09:02 -0700
Date: Tue, 1 Sep 2020 09:08:57 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/6] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
Message-ID: <20200901070857.GK14249@toto>
References: <20200831184018.839906-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831184018.839906-1-richard.henderson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6070de0e-58ba-441e-142e-08d84e45e85c
X-MS-TrafficTypeDiagnostic: CY4PR02MB2790:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2790B335F25EF6CC62864072C22E0@CY4PR02MB2790.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djL9Oo8IxGuObVT9kmRzp4lRckpdEcVfdLDeCMye0bTaL8OO8zcpBmzhCnDJNwNzrpwdTF52CL2s+liRaYA3RRDY8wZxUHbtojw4t1GJZYAaSW+fPD2mAWYlxo2YukcogipB1Z2lf1GEEuXKzt+iq9Iy203lZ3SKA1AMb8oNDI2b9/tZExyZMCjSesPRDaZrODGIUPN3JBqDvCWOuT+1eq37XZZ7YZpQJJJwlh1pc04VxZL3jSgZc+Dvn9kodEIitXaeZ5+HFwJvZSelHk8QrPe695qXk2tyD9Mzddw0qum4N/4HzyRHk6OShM0HUjShZ64+kdz4fBI2CUoZUdMhoxhrLxSVlof2GCedQ2vvNP3tyrnSn1cnbpL9K4+QiCaUirLBL+WcqcRLXRBFBvqW1w==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(136003)(346002)(39860400002)(376002)(396003)(46966005)(9786002)(9686003)(4326008)(186003)(426003)(82740400003)(26005)(82310400003)(6666004)(1076003)(47076004)(336012)(356005)(478600001)(83380400001)(81166007)(33716001)(316002)(6916009)(2906002)(8936002)(5660300002)(33656002)(70206006)(70586007)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 07:09:03.0953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6070de0e-58ba-441e-142e-08d84e45e85c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2790
Received-SPF: pass client-ip=40.107.243.61; envelope-from=edgar@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 03:09:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Nice! Yes, this seems to fix the problem we ran into before.
Series looks good both in review and testing except for minor typo in a comment.

With the typo in patch #4 fixed:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



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
> 
> I've added some TODO comments in these patches that are relevant.

Thanks, I'll try to dig out some details. A guest-error will likely
be needed anyway since some cores don't have exceptions enabled.
But we may want both.

Cheers,
Edgar

