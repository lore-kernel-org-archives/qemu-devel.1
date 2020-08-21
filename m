Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3982920720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Kk4TjQ/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3982920720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9BcB-0000Us-Ac
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 14:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1k9BbR-0008LN-Ci; Fri, 21 Aug 2020 14:17:25 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com
 ([40.107.237.82]:16353 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1k9BbP-0007sk-4p; Fri, 21 Aug 2020 14:17:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArB5O0O+JldmpaYT60GMgeF3vseXuZvgf4MePpVaPCbPU68Wg0JwfvXriTaMuzoud07iy+RklxRWIYGniuhB88YaiECVwkHZfkBqd6zXuzmUro263Yoh7Q7tKejxKxDYfVnIdLtLzyzZQZuqmHXTUy8ZPLSoQe5Po6lCN7ZopFo7IBBezMH148yFRHHZZqPESw9affanwjn+BT836dNq8d1wBGquzBg2dKLIA+rxy+bFp2s9MJXTpHa1eIM3rT0sHN/DPPpS7oxmESi8coN6z70/4Z3P2mJ2BN7yQloaqXXHicdckl84278sReXKCyVBatr7c7y1MTrcgEoFrsQlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUaYytF5KY7ykTombsrkQRjfQlhppRhxbDohDN2LMYk=;
 b=LMNu3HwnImGCuCayr77R0zs79rd+HwMBP2eQHlCqmG8UYD3vxzYiu2NSc7ybzxm5AoHutWKuXh/2EdIYaojRuq6TFSp/kO1uWUIpk6W7DqZU5dLkov5wkYNZi+h4INGw2FNeD5ArF4RqnphVltwyHWJy1uc1XNcQ7GalVZyRqVHgWyU4cno+j4V76Q39xVyurR1ko7W1woA7uYqDD8fPN51pzc3/e0B4hzcti2AoV9SUdjY8yfMllnbPVA/sMsJ7eng7qlOCrfQnP0N32nPAjcQewJFhl5XKZ6msqzn0bvTeFXMfU0NTcClrXEggGszn6A8/SxCTDUXtWSwrwi+HiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=amsat.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUaYytF5KY7ykTombsrkQRjfQlhppRhxbDohDN2LMYk=;
 b=Kk4TjQ/idjxhQlKmYXKrkTT5wjCAXqQek9//PqgK2TA6jUXuDitTnj4CLGcO+oSvtOu0NihFdZ4EK1xePMNO4SwmsEfNWDcl6gzpZks+3OWnlyyn+UgM8JHsxehigz+i2yKALQAq+Mue/cB7mLFyfUi/XNsnrwIDYVve2ZbyB5U=
Received: from CY4PR06CA0049.namprd06.prod.outlook.com (2603:10b6:903:13d::11)
 by DM6PR02MB6892.namprd02.prod.outlook.com (2603:10b6:5:253::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 18:17:17 +0000
Received: from CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13d:cafe::ba) by CY4PR06CA0049.outlook.office365.com
 (2603:10b6:903:13d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Fri, 21 Aug 2020 18:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 CY1NAM02FT010.mail.protection.outlook.com (10.152.75.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 18:17:17 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 21 Aug 2020 19:17:16 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 21 Aug 2020 19:17:16 +0100
Received: from [10.71.119.128] (port=56158 helo=localhost)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1k9BbD-0002nL-BA; Fri, 21 Aug 2020 19:17:15 +0100
Date: Fri, 21 Aug 2020 20:17:11 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v1 0/2] pc-bios: petalogix: Re-generate DTB and add DTS
 files
Message-ID: <20200821181711.GN31713@toto>
References: <20200820194342.1292611-1-edgar.iglesias@gmail.com>
 <59239d83-7d52-897a-95cd-5916531461b3@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59239d83-7d52-897a-95cd-5916531461b3@amsat.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e25d5327-7c95-4c62-f54a-08d845fe7010
X-MS-TrafficTypeDiagnostic: DM6PR02MB6892:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6892CC3FA1CBBD2632CA9C35C25B0@DM6PR02MB6892.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w70LruLIaMa9qanYhuBDTZWfcKPBrXV6tCTRk7yhYivzEY+E4m0UV1JvYQGwBvXaIjAMkpdh3FbSW6T4gJYbfONXHb+ksusRLxlzt2eADw4Ru/q5saYZriu8/xVG4lvmcm1nsTFHsSa69QFPKDC2zvNbQWebiYgJJT7G7qCD6Tsz2moAmElmCtZJvMlW0KYPOViqq0NExbTRy2BDsDE8n7IAMP8MsHg+6z0wH33wjf/7H/0Wpqw34FokfHnFYmhsJpDTQCsKBhA++/iMouLOTrCls2oyv2RcYMdVLpJHgEyzsM5rJmEITlSryCEr6CFblC9vTEwH91Oh0xSvZH620Pb/cSi6M18TAi73dwm+9pmkgyDrJSCx/Gq8foPRccB0IB9a5qHAAn3q/U6XEfqy2sFsnCWekRb6v/hpmPCcBQ/BbJMlqP61d3iFNykz1q8xaPrjDJKLk3CkemGybA7b2i1K9D/gxTNtj8TvCaOQS0s=
X-Forefront-Antispam-Report: CIP:149.199.80.198; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xir-pvapexch02.xlnx.xilinx.com;
 PTR:unknown-80-198.xilinx.com; CAT:NONE;
 SFS:(7916004)(346002)(396003)(376002)(136003)(39860400002)(46966005)(70206006)(70586007)(966005)(8936002)(6916009)(186003)(26005)(478600001)(33656002)(9686003)(1076003)(54906003)(316002)(426003)(6666004)(36906005)(2906002)(336012)(7636003)(107886003)(7416002)(5660300002)(82310400002)(4326008)(356005)(9786002)(33716001)(82740400003)(47076004)(53546011)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 18:17:17.4215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e25d5327-7c95-4c62-f54a-08d845fe7010
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.80.198];
 Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6892
Received-SPF: pass client-ip=40.107.237.82; envelope-from=edgar@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 14:17:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 01:02:59PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Edgar,
> 
> On 8/20/20 9:43 PM, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > 
> > This adds missing device-tree source files for the petalogix boards
> > with recompiled DTBs.
> > 
> > Cheers,
> > Edgar
> > 
> > Edgar E. Iglesias (2):
> >   microblaze: petalogix-ml605: Add device-tree source
> >   microblaze: petalogix-s3adsp1800: Add device-tree source
> > 
> >  pc-bios/petalogix-ml605.dtb      | Bin 9982 -> 9882 bytes
> >  pc-bios/petalogix-ml605.dts      | 350 +++++++++++++++++++++++++++++++
> >  pc-bios/petalogix-s3adsp1800.dtb | Bin 8259 -> 8161 bytes
> >  pc-bios/petalogix-s3adsp1800.dts | 282 +++++++++++++++++++++++++
> >  4 files changed, 632 insertions(+)
> >  create mode 100644 pc-bios/petalogix-ml605.dts
> >  create mode 100644 pc-bios/petalogix-s3adsp1800.dts
> > 
> 
> I suppose the test_microblaze_s3adsp1800() test in
> tests/acceptance/boot_linux_console.py has the dtb embedded after the
> kernel.

Not sure, but I'll see if I can figure it out.

> 
> Do you mind adding another test explicitly using this dtb?
> That would cover any further changes in these files.

Sounds like a good idea!

Thanks,
Edgar

> 
> Also, can you add a test for the kc705 EVB (and previous)
> boards as you suggested here?
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg605124.html
> 
> I already added a test for the cris/etraxfs board, will send
> it soon. Well you might wait for it and use it as template too.
> 
> Anyway,
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 

