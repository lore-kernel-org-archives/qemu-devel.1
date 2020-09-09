Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E22C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF740206D4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FKPXLaeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF740206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG3nv-00073E-UO
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1kG3nF-00060a-Pi; Wed, 09 Sep 2020 13:22:01 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com
 ([40.107.243.60]:62977 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1kG3nD-0007u6-M4; Wed, 09 Sep 2020 13:22:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzrz1x2rjyUQSBW/zebVCAIXtGIExtD86b23/takTdTrWdKbAOKuOaNkHAyBDXohw5nHkMZ27gscLbiRe/R0qa66BI6vGrgqclPaV1iG+fhI7VnkzLeg5HCfY5nUVpJEeftmahxQ8uQwGLercN7zWTwpfVbMtW8FoicAnOo9aR1+st/76gNiRJsHG8VWPplujYzwZqURO+72aAtShO4CGkCBax7nWaBsGIQT3Kk0nH5rKlj2npCW63hjhgCCsPkeRQkStpDzef6WCG6NEj9jl0jRHFABhBmr9pmWn+zWPD0WK3aM6fKSTYLWi5+h6BXBWfovGekoogYEcbSca5Q3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJzX9TT1Nyn3jONRB715iQIXOymvGJ4WH8zDas8d42k=;
 b=MTGlCJ5aNcNUYutk52nWo0AXk+A2hKiU5QFdIWcX8VmkQ2ek2mkOIP40+pkGZaSyq1KPpDevBUslpks+hDT25EkhMSLrbhBqERpcuFZ3AKc/cZUk8/uuJo08pZD9LyzHT09jiwXd5qbb+DBHectrOpPy7QSav4UTATbbA8TAtocw9tcxaa5ByGu1214wmcBdMzbEuaCstk2T8EVCL0ERXEL9sO6acanMiDGVkgQz9qbi3hd7C3R/t4r4X9uKOtr1rno50emicfqcbea/OyXFO2Lcat08hQyjgs2VLK1n6WnLJZ/U2B5Wpai5ohvzUy6ORX5b093nJxWD0auGu4AJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJzX9TT1Nyn3jONRB715iQIXOymvGJ4WH8zDas8d42k=;
 b=FKPXLaeEc+BygMW7ZxE2/LNw6jpFjACOMjmw4gQMpUq3s+nFdn3oRuQaVSzCVY7fe9eAVuFYfyqJQATenR3ju3+x5s4FZ3E17lMJEvjNpmvb04uMgB/fCxXHFICzSKjdhCeBLt8vHDqFYby5Yon46x8aNNygCpPfWQwBWC9KExs=
Received: from BL0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:207:3c::47)
 by DM6PR02MB6494.namprd02.prod.outlook.com (2603:10b6:5:208::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 17:21:54 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::2d) by BL0PR02CA0034.outlook.office365.com
 (2603:10b6:207:3c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 9 Sep 2020 17:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 17:21:54
 +0000
Received: from [149.199.38.66] (port=59756 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kG3mr-000725-A4; Wed, 09 Sep 2020 10:21:37 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kG3n7-0001BU-AM; Wed, 09 Sep 2020 10:21:53 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kG3mz-00019t-PF; Wed, 09 Sep 2020 10:21:45 -0700
Date: Wed, 9 Sep 2020 19:21:40 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 1/1] hw/arm: versal-virt: Correct the tx/rx GEM clocks
Message-ID: <20200909172140.GH14249@toto>
References: <20200909161514.622998-1-edgar.iglesias@gmail.com>
 <20200909161514.622998-2-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909161514.622998-2-edgar.iglesias@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b037fdb0-2cfa-4369-3a5b-08d854e4d94e
X-MS-TrafficTypeDiagnostic: DM6PR02MB6494:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6494FDC3A2C526A2453127EDC2260@DM6PR02MB6494.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1AIdVe6xbmSg820wHchMGj3sCkZhNRU/AvZAWfFaur9F/tHaHGtJJPlleVGKhUW0t68uNXYwZtEyDULlVIS5H8DbtlwM0LNMoEEc7vbljYX2TVqFRoIoxuUcwvqR0NWlID/H08cr3geABlNe7wjy+86bEXspmEp7Awj7PIO9I0vn1/gtdalNRnghoLWSVJniH2jhfy1B5U2H1R3nYF1vODavMS23Y7h1Ny6ohpchkSxkrycoHjwXZeZNgg2bR4c41Z7bYlMwAUkxTh5LBEoa1oIG7lmluTPspj9ZfIzRd8GyQer5/oZoMwsGAFEzqTc2fiCwtiKbWWW4o39cyL+CDefuUC80apROB3Vtf/wtGSjnP7bBiKE6PTBeItRuTF5Wr1kv1/IHDK3Xie+sIG9zGg==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(396003)(376002)(346002)(136003)(39860400002)(46966005)(107886003)(33656002)(26005)(186003)(8676002)(81166007)(82740400003)(47076004)(8936002)(33716001)(478600001)(1076003)(7416002)(5660300002)(4744005)(2906002)(70586007)(83380400001)(6916009)(70206006)(6666004)(426003)(336012)(82310400003)(316002)(4326008)(9686003)(356005)(9786002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 17:21:54.7834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b037fdb0-2cfa-4369-3a5b-08d854e4d94e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6494
Received-SPF: pass client-ip=40.107.243.60; envelope-from=edgar@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 13:21:56
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
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 06:15:14PM +0200, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Correct the GEMs tx/rx clocks to use the 125Mhz fixed-clock.
> This matches the setup with the fixed-link 100Mbit PHY.
> I also avoids the following warnings from the Linux kernel
 ^^^
Argh, this should say It, not I.

I'll send a v2 keeping the RB tags.

Cheers,
Edgar

