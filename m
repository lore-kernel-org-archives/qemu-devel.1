Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFABC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7B72192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RsavJHp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7B72192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVtYs-0006Fn-Vl
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kVtY5-0005bu-DI
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:39:49 -0400
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com
 ([40.107.93.70]:40833 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kVtY2-0005bX-Tu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:39:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMoPuPwy4ouiG2W2sE1GgySlnOePQYwss8TF3Zi3jYyGADygHDvywXOFeKm4uqaJ+mdXXTAzHfq6RhxvJoctDD63s0klIK9zjsLo5JIx5qMqNsaGeI9p9EBCh63NuSZOeIDJ+3+LqBYF7bp2igLJ3MoDjzJb8RKt9a8FTGn72hcFxijH/djzipE4EAtfk0hZLpmmKslpQ6EHS782wuVfefFz8cTyuGPLjpYVxJiRUmzvIiIQ2DZ75iwHdz59SE3eARILw2IfY4fhLHnFRmnWtJxuaHCK8b2nxCH+L/ktGgN3qxFLwsZubzo0Un+KZ163nnA8j/LY6knx2qm9UNYJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Odi3NI1+kMTTUsjVQha67cCDo2sOQK4+WmLSIqPVPKE=;
 b=JuvUydt7NFDq+gu/TLP/IqOekSdRS5ElbgW2I4hKabgkF9tmjmn+MCLDUrbZlGqvYCnPYD78tPjjnzIHc+WlqOBbYOd38kqJCOdJFe3Bw+I1EB2fzabISSYxdliqhXJMNhSuJLWYwdNzy5YikZfRSOY9oTsNS+9AIOw83m7J5C9CpkESTanFzWIxrazR/asERWfJmeGSNv+hUOmX+LGnXROS8b3yjADJYMLTuy5fklozq1pbM8crxJTWUqXilzqdBgHFJQHqP+wRuAlhO6xfeZsBlMiz2vTP9CAGXJXbQ/xgk0lymSFT1+GM+M1Vu4fMQkQaajfXTZpHvQqij9qaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Odi3NI1+kMTTUsjVQha67cCDo2sOQK4+WmLSIqPVPKE=;
 b=RsavJHp08ACv4eTh4oOxaylNNOEkZy1H8Kdj/vZWh85fDzWf0dScdQ5JV++GN5e4slB9maXzEPFcUp7rtWzqxBWYeojE6ef3S7niXHDavWscBsWSQ8cV081iPxneT2bn21pnzJV6cNG6R/2KwanJZ2xI85QOfNLf1OGd31niBxM=
Received: from CY4PR19CA0046.namprd19.prod.outlook.com (2603:10b6:903:103::32)
 by DM5PR02MB2236.namprd02.prod.outlook.com (2603:10b6:3:51::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.27; Fri, 23 Oct 2020 09:24:41 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:103:cafe::57) by CY4PR19CA0046.outlook.office365.com
 (2603:10b6:903:103::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Fri, 23 Oct 2020 09:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server id 15.20.3499.20 via Frontend Transport; Fri, 23 Oct 2020 09:24:41
 +0000
Received: from [149.199.38.66] (port=49763 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kVtIT-0005dG-So; Fri, 23 Oct 2020 02:23:41 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kVtJR-0005v3-9A; Fri, 23 Oct 2020 02:24:41 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 09N9OVY6010284; 
 Fri, 23 Oct 2020 02:24:31 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kVtJH-0005to-AF; Fri, 23 Oct 2020 02:24:31 -0700
Date: Fri, 23 Oct 2020 11:27:18 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v12 0/3] Add Versal usb model
Message-ID: <20201023092718.GN18995@toto>
References: <1603369056-4168-1-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603369056-4168-1-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d02030c-830b-4913-d034-08d8773578ba
X-MS-TrafficTypeDiagnostic: DM5PR02MB2236:
X-Microsoft-Antispam-PRVS: <DM5PR02MB223693F6C59E8E2FBCD676C7C21A0@DM5PR02MB2236.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/7+HBlJ/Aeamak4EoMUJgIwNyTt/iebhG0NN64HpYNhSlt7dunwXQqXBKLNnC/x7aY1gyLcSZXyHbJC7/pbSmB2NlweDxTIrV8JM4yKcCFzPrcddFMMB0GK+ZTUlGekxrgf/Q9zigyampJ078M1NIabNUT4M8T9QzzftbZgtd6XHQVOloIUEGJ4PAHUdDqwp4VSC3+s0Vik7KknnI7pQ61OVeqzbDXYqX5WzlXTm/3F4id5nHXK4soQyeHc3FKw4ThAofVjzx7FcLo7q+QcJ3uHUFfdR2hmctYrU4bO0EtPjiM1/S9uJCQnKHewcD4Sacnv5Hb90gi4fTcHjxOYkqceNyM7ORWFFjAUSybxso9KyBuyjHAI+ILfQevB9sch9iFazRHhISoi3eCmLhvZlA==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(4636009)(7916004)(39860400002)(136003)(396003)(346002)(376002)(46966005)(426003)(107886003)(336012)(6666004)(9686003)(26005)(7416002)(316002)(54906003)(186003)(81166007)(2906002)(33656002)(1076003)(70586007)(8936002)(70206006)(9786002)(82310400003)(83380400001)(5660300002)(33716001)(356005)(4326008)(82740400003)(6862004)(47076004)(8676002)(478600001)(6636002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 09:24:41.5246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d02030c-830b-4913-d034-08d8773578ba
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2236
Received-SPF: pass client-ip=40.107.93.70; envelope-from=edgar@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 05:39:44
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?'Marc-Andr=E9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?iso-8859-1?Q?Mathieu-Daud=E9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 05:47:33PM +0530, Sai Pavan Boddu wrote:
> This patch series attempts to make 'hcd-xhci' an independent model so it can be used by both pci and system-bus interface.


On the series:

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Changes for V2:
>     Make XHCIState non-qom
>     Use container_of functions for retriving pci device instance
>     Initialize the AddressSpace pointer in PATCH 1/3 itself Changes for V3:
>     Convert XHCIState to TYPE_DEVICE and register as a child of XHCIPciState.
> Changes for V4:
>     Add DWC3 usb controller
>     Add versal, usb2-reg module
>     Connect sysbus xhci to versal virt board Changes for V5:
>     Add extra info about dwc3 and usb2_regs devices in commit messages
>     Use only one irq for versal usb controller
>     Mark the unimplemented registers in dwc3 controller
>     Rebase the patches over master.
>     Move few mispalced contents from patch 2/7 to 3/7.
>     Fix the author names in the header.
>     Move the inclusion of "sysemu/dma.h" from patch 1/7 to 3/7 Changes for V6:
>     Fixed style issue in patch 7/7
>     Renamed usb2_reg model to VersalUsb2CtrlReg
>     Fixed author in headers
> Changes for V7:
>     Create a usb structure to keep things clean
>     Remove the repeated patch in the series i.e 5/7 Changes for V8:
>     Fix vmstate sturcts to support cross version migration.
> Changes for V9:
>     Added recommended changes to fix vmstate migration.
>     Fixed commit message on 3/7.
> Changes for V10:
>     use vmstate_post_load avaialble in VMStateDescription
>     tested vmstate cross migration.
> Changes for V11:
>     Removed the patches which got accepted
>     Changed object name "USB2Reg" -> "ctrl"
>     Updated Subject line on cover letter.
> Changes for V12:
>     Use reset class for usb2-ctrl-regs module
>     Move the few register update to realize
>     Marked registers which are unimplemented in regapi model
> 
> 
> Sai Pavan Boddu (1):
>   misc: Add versal-usb2-ctrl-regs module
> 
> Vikram Garhwal (2):
>   usb: Add DWC3 model
>   Versal: Connect DWC3 controller with virt-versal
> 
>  hw/arm/xlnx-versal-virt.c                    |  58 +++
>  hw/arm/xlnx-versal.c                         |  34 ++
>  hw/misc/meson.build                          |   1 +
>  hw/misc/xlnx-versal-usb2-ctrl-regs.c         | 229 +++++++++
>  hw/usb/Kconfig                               |   6 +
>  hw/usb/hcd-dwc3.c                            | 666 +++++++++++++++++++++++++++
>  hw/usb/meson.build                           |   1 +
>  include/hw/arm/xlnx-versal.h                 |  14 +
>  include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  45 ++
>  include/hw/usb/hcd-dwc3.h                    |  55 +++
>  10 files changed, 1109 insertions(+)
>  create mode 100644 hw/misc/xlnx-versal-usb2-ctrl-regs.c
>  create mode 100644 hw/usb/hcd-dwc3.c
>  create mode 100644 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h
>  create mode 100644 include/hw/usb/hcd-dwc3.h
> 
> -- 
> 2.7.4
> 

