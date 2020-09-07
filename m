Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA721C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DE92075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ex8eGB2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DE92075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDZk-0004ap-BX
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kFDZ6-0003z2-Uv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:35:56 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com
 ([40.107.236.47]:1313 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kFDZ4-0004rS-G9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:35:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0yhmDk4jmuvAz0bDREW8a3wYaSp2C5XdgT4Y2f6az13rZ3McvaFQFwUcSXmfcQuO3IZmBcuvbFmWjUL3e30TJfktsBBY47Q3+Nmzemc99As6+ETZePXGTJ9/+NoEyq9AB+/cZLrjou37qJ+rUv0s0Qwp7x9xlnJYFC2BqLQwgN9qc6tnwevmyQIN0WgSCDvIfUBgpt2ed/5Fb4Hi8+OXxm/N1skXYmtvbdx2OQBeFncBA8M5lfICsSiMlHIxPQdpFq8xXZ2X02kQ3iF9qmqKALt8aj+f0V92e0OEgR1fuMexQer5NzO3bJK0tBDzRqjYj/GMc28hdH8Nltd6V103g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjuQo7r3v2OHRf9PFp4cGVYSh4Soaq2GRlVnJMPYdoU=;
 b=D1jIIyVblKVbwc3fRxCL6NYJWhnByujsHVBM7xpB6YF+zS/J/9ls4Zx495cKknwn0kjLda7BEbYXq2eAb473QIGkjLVguy6qIF56KZtum3W6aNoiT1gj03iip09OCkR+NN11FGv8k+EMwcuZaUqSpewPb7+UjLMsCylylfzfZxmfmM0CFkH3PS5ei+UEYl1lmyXzFg/YtdSPEMVHhFddcTS2pseb0JTS8HZ89JLaR4ETfKnMmseu+AQBqvzcIvsTa/Zng3+63q8rFtYo67XGAWfqMiQOmXeUPQKiSrH7WWDw1Cfhnpsfh+HbvW4WbxtzbZ5LH8/gvPvjR7kRlF31Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjuQo7r3v2OHRf9PFp4cGVYSh4Soaq2GRlVnJMPYdoU=;
 b=Ex8eGB2/8UrRNcsP/hv0GFbT9Yy+Eb/6+8OaVnOieaUefj0K8WCKVcm9aMMW76CaFPMjBwCgc+crIx5GKGBwvehrwUPO7s2nXjjzDp2dT9yz4HiShCVDgVQPe+PgAwVCmrEomOB6hAhQVRhgyA53/I6vPgfuAWyB2oSADP8Ha5o=
Received: from SA9PR03CA0012.namprd03.prod.outlook.com (2603:10b6:806:20::17)
 by BN6PR02MB2465.namprd02.prod.outlook.com (2603:10b6:404:57::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 09:20:49 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:20:cafe::59) by SA9PR03CA0012.outlook.office365.com
 (2603:10b6:806:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Mon, 7 Sep 2020 09:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Mon, 7 Sep 2020 09:20:49
 +0000
Received: from [149.199.38.66] (port=38846 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kFDKH-00042H-Bd; Mon, 07 Sep 2020 02:20:37 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kFDKT-0005kD-Go; Mon, 07 Sep 2020 02:20:49 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kFDKT-0005jq-0g; Mon, 07 Sep 2020 02:20:49 -0700
Date: Mon, 7 Sep 2020 11:20:43 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 00/19] target/microblaze improvements
Message-ID: <20200907092043.GV14249@toto>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3f4a311-f14e-428e-9fb8-08d8530f4f95
X-MS-TrafficTypeDiagnostic: BN6PR02MB2465:
X-Microsoft-Antispam-PRVS: <BN6PR02MB246560E54A3690CC270AAFCCC2280@BN6PR02MB2465.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zHxc7LMM0LP7swCrPoqbdZcjYiLvnONig75J48J12jbJs4J29k8cE6KjX85uGJzYFaMUzY0k11OV9dACwfwj1adXe3k19q5+x0uvY6V71rbYIK4VyCTODdy0ao9JpJj6hFoieEBj6moqsYoUNJXb0eeie11/KfPUZGJsjdPlJinTCUWgY/vH8UISVxtqLL4VSvARFZ4AGPcY3RXHTzb4f5NXwVBeytAeA76j7WZrr/rpTGxzz0cmaiJHTV0I9gv7fYvz0Oyk22XEpMrHFioplGDKYcNqwcd6STMx/rye/AOIfYkT7FHoFD7CVnWlaJQU1YDe00cIggcxxCNRJ6xhJ6vi+uuwf9Y2o5wppX0NH7sWJsy7HRwowUovic0/6Bv+xXFbpwbd9fDuqktsmb45g==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(39850400004)(346002)(396003)(136003)(376002)(46966005)(33656002)(81166007)(82740400003)(426003)(70586007)(356005)(336012)(186003)(70206006)(8936002)(1076003)(26005)(6666004)(316002)(9786002)(478600001)(33716001)(82310400003)(83380400001)(4326008)(9686003)(2906002)(5660300002)(47076004)(8676002)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 09:20:49.7705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f4a311-f14e-428e-9fb8-08d8530f4f95
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2465
Received-SPF: pass client-ip=40.107.236.47; envelope-from=edgar@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:35:53
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
Cc: qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 04, 2020 at 12:08:23PM -0700, Richard Henderson wrote:
> Version 3:
> 
>  * Splits out MicroBlazeCPUConfig, and moves some values
>    out of CPUMBState (env) that are constant configuration
>    parameters, or derived from configuration parameters.
> 
>  * Do not save configuration parameters with vmstate.
>  * Pass around MicroBlazeCPUConfig in the translator.
>  * Do not set TARGET_ABI32 in configure.
> 
> Version 2:
> 
>  * Includes fixes for iflags that could cause lockups.
> 
>    It seems it was easier to do so with icount=7, which is what we
>    do during the replay acceptance tests.  This causes TBs to contain
>    no more than 7 insns, and often less to make up for an incomplete
>    count elsewhere.  Which stressed the iflags bits around delay slots
>    and imm in ways that pure single-step doesn't.
> 
>   * cpu vmstate is filled in
>   * interrupt logging is tidied.
> 
> 
> r~

Looks good, none of the test issues were relatd. Thanks Richard!

On all the patches I had not previously reviewed:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Can you take the pull-req via your trees?

Cheers,
Edgar

