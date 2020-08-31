Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C60C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 12:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 777BF20782
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 12:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="q7i5578I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777BF20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCj8u-0006V7-Kt
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 08:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1kCj8A-0005kw-7o; Mon, 31 Aug 2020 08:41:50 -0400
Received: from mail-eopbgr760048.outbound.protection.outlook.com
 ([40.107.76.48]:20357 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1kCj86-00043t-FG; Mon, 31 Aug 2020 08:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrP3C2Xfy0s4OVo9L5/88PBHx1J3J5VLBtB87nb+FN8amr5tZyqWSegfIs1KA7eSaikiG+CZRoGfuKhd/pdwktj0JFXEWH3p/VE72QPbFUKlvB7Gms0s1usMxFpueVDkRZo2SBSTiAhpLohwCuM0FA+pYf0O4Scc7FATA6ZZMUGNyF9ilrXqO1h+N0OmnXxVyHYSPbLlde2mwqCxq7+Yuv/cT8MkH4e58nPA46DrJyaz6O1JzVgEzjzhPy/UXSd90ZBJaCiv/aAiBnJXTK8ORGXq+wJfAR/wZ0JIefzM8PzAyRD6cXu3TCXsEoF5a4Lk9z0mgV/R2SGpYiu592/eJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EclMdyf35hmWjRvXk1G/IkZSsdsd/lNkS4tCE9bucMo=;
 b=SDaXCTzVNJnjeF+a0zshovNImyAo5bp17xyTGzf8CyE6u6dvAB/BTAbaniEObskMilyufcV4WFgSTVfkE1Ony3/f2Qo42Z3AZTP31OlIYnzB3p/lTSVMPS4ng+O5wl6mcv1Rk9BUcqv54MopOBiKnj+Xq+XSONaEqYPVHPDK7LMCR+9T42PZZuWgtN87F9ePmpjKXrrIzW02sCobSXPzGHzZIuNC5CGHC9HexI1KxUXDBIfwX2uUGaSAqM/PVk1O3u5LbN/gApXsrl/jHmFhQ9ZQPdH6ZlTG6wBIDlcXtzcFNTfrm1ggrgcobNR39QK72mTQp/vD4j6xhOeWwXKVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EclMdyf35hmWjRvXk1G/IkZSsdsd/lNkS4tCE9bucMo=;
 b=q7i5578I/3R0J3Qt5yKnZob7JcUR77qjasp7Kwg6Q3EyZ9DFbD5C/6kT9/rZARN2w7thnIAtHi9xM6hVI9kZKpOr3q7M/uO+YKUCLETHsauLqmkUcVdeIu69AhLZ25iMpuiuMGzyjzKSWrnechFxWh66oD6C2plqZGiub1qi6UE=
Received: from CY4PR14CA0025.namprd14.prod.outlook.com (2603:10b6:903:101::11)
 by BL0PR02MB4738.namprd02.prod.outlook.com (2603:10b6:208:5b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 12:41:41 +0000
Received: from CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:101:cafe::ad) by CY4PR14CA0025.outlook.office365.com
 (2603:10b6:903:101::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21 via Frontend
 Transport; Mon, 31 Aug 2020 12:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT034.mail.protection.outlook.com (10.152.75.190) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 12:41:41
 +0000
Received: from [149.199.38.66] (port=50851 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kCj7z-0006Gw-BS; Mon, 31 Aug 2020 05:41:39 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kCj81-0004Z9-4C; Mon, 31 Aug 2020 05:41:41 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07VCfWeC017370; 
 Mon, 31 Aug 2020 05:41:32 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kCj7s-0004YR-I4; Mon, 31 Aug 2020 05:41:32 -0700
Date: Mon, 31 Aug 2020 14:41:28 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 2/2] target/microblaze: Improve transaction failure
 handling
Message-ID: <20200831124128.GB14249@toto>
References: <20200828113931.3252489-1-edgar.iglesias@gmail.com>
 <20200828113931.3252489-3-edgar.iglesias@gmail.com>
 <3556c713-8635-2868-cd4c-387fcef6c50c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3556c713-8635-2868-cd4c-387fcef6c50c@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cee689d6-94f4-40d9-3792-08d84dab3606
X-MS-TrafficTypeDiagnostic: BL0PR02MB4738:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4738AC5155B800F086C9769FC2510@BL0PR02MB4738.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7HPvJiZUyr7/zHR7lUoO7K9FymIAchhe/l3qHWqEenNhVpuuKuQmBbi+ov5tj1naE/2UT39NUoIjtXIa3RB8A08LfjnYWxxgimuQg0yEwHIzvI2jOrdJV9bH27FZtMDPZeivJlpt+x9xvJBfSIyjnBmdYVmksyLyLO1RKqofzRMK6/DUUiACH3p+phQ0etXtyxNLVeHnIaERJCL5WOUKeLTnLgxbnDUBkDHKw+N46hcxvM+Q66ii8o+NF31uBqYDhCXWsBp3K0M3OExxYzMw0xzSuN0ml2WX+xycd1/PHjCCOBUPlbLiz/S0DcpG2tHgG7IyQSCXvVXRjIzgpE7L49gcx7S4t0X6vEZJ6j24YFRStQ+WldVzkPvha1LQ8NxFeCIaaLV7t1jfQXi1G3xRdhYpCGgJ2vepbGuTSz7eAknwIh+F/SwhW7A4JRGgWOFf2PoOmn4hJvUWJODTZHBBjW8+LbPF9l9HaZusqbJVX8=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(136003)(396003)(376002)(346002)(39860400002)(46966005)(4744005)(82740400003)(5660300002)(9686003)(7416002)(8676002)(8936002)(336012)(1076003)(33716001)(966005)(9786002)(26005)(478600001)(70586007)(47076004)(316002)(4326008)(186003)(107886003)(426003)(53546011)(81166007)(83380400001)(82310400002)(6916009)(2906002)(6666004)(70206006)(356005)(33656002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 12:41:41.3908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee689d6-94f4-40d9-3792-08d84dab3606
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4738
Received-SPF: pass client-ip=40.107.76.48; envelope-from=edgar@xilinx.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 08:41:43
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me,
 qemu-devel@nongnu.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 28, 2020 at 01:34:08PM -0700, Richard Henderson wrote:
> On 8/28/20 4:39 AM, Edgar E. Iglesias wrote:
> > +    if ((access_type == MMU_INST_FETCH && cpu->cfg.iopb_bus_exception) ||
> > +        (access_type != MMU_INST_FETCH && cpu->cfg.dopb_bus_exception)) {
> > +        cpu_restore_state(cs, retaddr, true);
> > +        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ?
> > +                             ESR_EC_INSN_BUS : ESR_EC_DATA_BUS;
> > +        env->sregs[SR_EAR] = addr;
> > +        helper_raise_exception(env, EXCP_HW_EXCP);
> 
> I think it's better to use cpu_loop_exit_restore, adding the one line for
> cs->exception_index from helper_raise_exception.
> 

OK, let's use the patch you posted:

https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07630.html

Thanks,
Edgar

