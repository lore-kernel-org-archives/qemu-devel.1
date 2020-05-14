Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31BEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B97205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="s7Ofb/5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B97205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEN2-0002Wc-KG
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jZELq-0000Hy-5c
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:56:42 -0400
Received: from mail-eopbgr750040.outbound.protection.outlook.com
 ([40.107.75.40]:26993 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jZELo-0000Lx-5g
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:56:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkS6BTpQHSXkdmK3W4e4avWzxpB7R8+gNmKEfGVOjtCcp7oqiP33ccNNbMQrn9N3AdWgvdIkXzZdLYdawsz4kNYiD8rI+drqYHj4afTvMyb+dtjFnA81r6ehstcxt7PfMG1CV1cMvTtjQdckkjm6FV9YRSIXe6PBaWJsbG5reJrmuPk7WlfE/VugQm0u2C4l9/HilMzbtiNH3zNuhPtJqFzRrwasBYVaAX7PMgb5FguXqcP4p+V8JdBYm7SHPvUbhFFBuitM5c28lTzqL1DyLW1dhbt/7rpeDivbiG21H81vfySAKmPPkhhMBWZb6nQP0VajRx+K+a/yPjAKVIxJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFQMLsnLPuNTqLPUAZC+aQ4twvPRUESshwZvUpPRgko=;
 b=I449tb8Qeb/SxTLn4xqXRxrrnPdg5Q3399a07mCK8+AR2xPmr7zedIHCkVnS19Asljep0KfOD55RCArvWBeYYD+FvevyVJXsF2EwNegKYwZrFN69lgiascGJkcYymxbnswKYaTzbJouIuniclZ2DBMClSneiyiNbnyUyq8d7Yh4fWBlp8fZTxmMhhf2M/jybu3htEHW8avsZN9b+bHWJ+F1B5h5v6ZGhqpWSV6O7YsC57kz36PZyrdbWAuBCoEr5bdX5bZycIccgIKGR/KyCMMwKwZzo6CUyHBVegnt5xUlIKkVyBPZswbVF6vFc14lyYU408SJ+eZuXMaCroXehjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFQMLsnLPuNTqLPUAZC+aQ4twvPRUESshwZvUpPRgko=;
 b=s7Ofb/5KCVXcAWdKcGpcGvpR6VbwgpRuEfOsobsSDAb/+gwgkD1S9ifWOCOgEUETs7oe1WDPe9ZrJ1NEB4PapXNRIuoMjMONkCW2HsaWPkcx0YB4c3U74jRxnFKTUHiPYFLZf2KwPRicC7/DLXh5PY6tpvx2YK5FTCT7LgXMNs8=
Received: from SN4PR0501CA0048.namprd05.prod.outlook.com
 (2603:10b6:803:41::25) by CY4PR02MB2679.namprd02.prod.outlook.com
 (2603:10b6:903:126::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 13:41:35 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::cf) by SN4PR0501CA0048.outlook.office365.com
 (2603:10b6:803:41::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.10 via Frontend
 Transport; Thu, 14 May 2020 13:41:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Thu, 14 May 2020 13:41:34
 +0000
Received: from [149.199.38.66] (port=35545 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>) id 1jZE6t-0004wA-Ln
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:41:15 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>) id 1jZE7C-00073w-Js
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:41:34 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04EDfSh0017768; 
 Thu, 14 May 2020 06:41:28 -0700
Received: from [10.71.116.176] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jZE75-00072S-ON; Thu, 14 May 2020 06:41:28 -0700
Date: Thu, 14 May 2020 15:41:10 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Joe Komlodi <joe.komlodi@xilinx.com>
Subject: Re: [PATCH V2 1/4] target/microblaze: gdb: Add dynamic GDB XML
 register support
Message-ID: <20200514134110.GQ2945@toto>
References: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(7916004)(39860400002)(396003)(136003)(346002)(376002)(46966005)(478600001)(82310400002)(9686003)(1076003)(9786002)(6862004)(966005)(4326008)(5660300002)(6666004)(30864003)(8676002)(336012)(82740400003)(81166007)(33656002)(356005)(47076004)(6636002)(70586007)(2906002)(70206006)(33716001)(8936002)(316002)(426003)(26005)(21490400003)(186003)(42866002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad6aed00-189b-4954-bd13-08d7f80c84e9
X-MS-TrafficTypeDiagnostic: CY4PR02MB2679:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2679CDA1B0BC60F52594AEF9C2BC0@CY4PR02MB2679.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KhVfzJjHK0CxCjEUtu1hsiGqfLyOKCh5LBYMN/HXQiL6CoEO5NIsNa7ANB87P3ujF0NyklX61OSOZu76AOo82a702GZwhVkkQoc0k57DhJUmRK4I37L1wuhjLSI2GNKhPvSEiwtrJED0pI9An6M7x5r07SXKy6oM5dgA92Qf/kwHEUwfhX2lFJYbiJZafUPH65UxKqoW1jL22wN7uZVQQngMJc+ycKa4ntUbKZUaECJpk2QzwNj48CvhntdS064H0KriUnup8y0wFArVqDEYS5aLSmNa9lrGQNWEKRUJAI2OmMJdKxwwRSKITsiGzZYXsQqLDkzg7hD/a8gA2BIQNiysyG7ny8ara5mpLcofrxFiUYgP+UjTmWV5T5aSPbqf+6Zdjmccwfhsrhi18o9/fPwTKdlK5FShcOVQcAtmhItNKVjkLHfts6Y4sOG7MMGTVRfJsMIlf3m1iCcVqveywA1hszS/LepkAdRk6uyXbYftOw7Tl91b6fbUhHWTmMAziamxl8qeO50u6M6fbHSrAoREveCNixEZRujlIcap5H3+tWIAe6WVBcQp/+E6X7sNGjWeH72TiB1Np/nY47r1p92cQ0STaoOe1u+UFSXgxo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 13:41:34.9091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6aed00-189b-4954-bd13-08d7f80c84e9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2679
Received-SPF: pass client-ip=40.107.75.40; envelope-from=edgar@xilinx.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 09:56:38
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

On Wed, May 13, 2020 at 11:08:45AM -0700, Joe Komlodi wrote:
> Add dynamic GDB register XML for Microblaze, and modify the config file to
> use XML when building for Microblaze.
> For the dynamic XML to be read, there still needs to be a core XML file.

Hi Joe,

I was looking a little closer at this and got a bit confused with
this approach.

So we're adding microblaze-core.xml but we're actually at runtime
dynamically generating and providing the contents for it. So the static
builtin file does not get used.

We should do either (not both):
1. Keep the dynamic generation of the XML file and remove the addintion
   of gdb_xml_files= and microblaze-core.xml.

or

2. Keep the addition of static microblaze-core.xml and remove the dynamic
   generation of it.

Since we're not yet using the dynamic aspects for anything relevant (only
r17 code_ptr) my preference would be to use the static files for now.

Also, it's probably a good idea to move this patch to after the patches
that fix the register ordering.

A few more comments inline.

> 
> Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
> ---
>  configure                   |   1 +
>  gdb-xml/microblaze-core.xml |  64 +++++++++++++++++++++++
>  target/microblaze/cpu.c     |   4 ++
>  target/microblaze/cpu.h     |   9 ++++
>  target/microblaze/gdbstub.c | 123 ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 201 insertions(+)
>  create mode 100644 gdb-xml/microblaze-core.xml
> 
> diff --git a/configure b/configure
> index 0d69c36..5a099b6 100755
> --- a/configure
> +++ b/configure
> @@ -7832,6 +7832,7 @@ case "$target_name" in
>      TARGET_ARCH=microblaze
>      TARGET_SYSTBL_ABI=common
>      bflt="yes"
> +    gdb_xml_files="microblaze-core.xml"
>      echo "TARGET_ABI32=y" >> $config_target_mak
>    ;;
>    mips|mipsel)
> diff --git a/gdb-xml/microblaze-core.xml b/gdb-xml/microblaze-core.xml
> new file mode 100644
> index 0000000..13e2c08
> --- /dev/null
> +++ b/gdb-xml/microblaze-core.xml
> @@ -0,0 +1,64 @@
> +<?xml version="1.0"?>
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.microblaze.core">
> +  <reg name="r0" bitsize="32"/>
> +  <reg name="r1" bitsize="32" type="data_ptr"/>
> +  <reg name="r2" bitsize="32"/>
> +  <reg name="r3" bitsize="32"/>
> +  <reg name="r4" bitsize="32"/>
> +  <reg name="r5" bitsize="32"/>
> +  <reg name="r6" bitsize="32"/>
> +  <reg name="r7" bitsize="32"/>
> +  <reg name="r8" bitsize="32"/>
> +  <reg name="r9" bitsize="32"/>
> +  <reg name="r10" bitsize="32"/>
> +  <reg name="r11" bitsize="32"/>
> +  <reg name="r12" bitsize="32"/>
> +  <reg name="r13" bitsize="32"/>
> +  <reg name="r14" bitsize="32" type="code_ptr"/>
> +  <reg name="r15" bitsize="32" type="code_ptr"/>
> +  <reg name="r16" bitsize="32" type="code_ptr"/>
> +  <reg name="r17" bitsize="32"/>
> +  <reg name="r18" bitsize="32"/>
> +  <reg name="r19" bitsize="32"/>
> +  <reg name="r20" bitsize="32"/>
> +  <reg name="r21" bitsize="32"/>
> +  <reg name="r22" bitsize="32"/>
> +  <reg name="r23" bitsize="32"/>
> +  <reg name="r24" bitsize="32"/>
> +  <reg name="r25" bitsize="32"/>
> +  <reg name="r26" bitsize="32"/>
> +  <reg name="r27" bitsize="32"/>
> +  <reg name="r28" bitsize="32"/>
> +  <reg name="r29" bitsize="32"/>
> +  <reg name="r30" bitsize="32"/>
> +  <reg name="r31" bitsize="32"/>
> +  <reg name="rpc" bitsize="32" type="code_ptr"/>
> +  <reg name="rmsr" bitsize="32"/>
> +  <reg name="rear" bitsize="32"/>
> +  <reg name="resr" bitsize="32"/>
> +  <reg name="rfsr" bitsize="32"/>
> +  <reg name="rbtr" bitsize="32"/>
> +  <reg name="rpvr0" bitsize="32"/>
> +  <reg name="rpvr1" bitsize="32"/>
> +  <reg name="rpvr2" bitsize="32"/>
> +  <reg name="rpvr3" bitsize="32"/>
> +  <reg name="rpvr4" bitsize="32"/>
> +  <reg name="rpvr5" bitsize="32"/>
> +  <reg name="rpvr6" bitsize="32"/>
> +  <reg name="rpvr7" bitsize="32"/>
> +  <reg name="rpvr8" bitsize="32"/>
> +  <reg name="rpvr9" bitsize="32"/>
> +  <reg name="rpvr10" bitsize="32"/>
> +  <reg name="rpvr11" bitsize="32"/>
> +  <reg name="redr" bitsize="32"/>
> +  <reg name="rpid" bitsize="32"/>
> +  <reg name="rzpr" bitsize="32"/>
> +  <reg name="rtlbx" bitsize="32"/>
> +  <reg name="rtlbsx" bitsize="32"/>
> +  <reg name="rtlblo" bitsize="32"/>
> +  <reg name="rtlbhi" bitsize="32"/>
> +  <reg name="rslr" bitsize="32"/>
> +  <reg name="rshr" bitsize="32"/>


This last part doesn't look right.
slr and shr are optional and should only be presented when the core
supports stack protection.

I think it would be easier if we simply copied both these files
from GDB:
https://github.com/bminor/binutils-gdb/blob/master/gdb/features/microblaze-core.xml
https://github.com/bminor/binutils-gdb/blob/master/gdb/features/microblaze-stack-protect.xml

Add both to gdb_xml_files= and register the stack protect XML file with
gdb_register_coprocessor() if stack protection is enabled.


> +</feature>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index aa99830..41cac1b 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -226,6 +226,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>      env->pvr.regs[11] = (cpu->cfg.use_mmu ? PVR11_USE_MMU : 0) |
>                          16 << 17;
>  
> +    mb_gen_dynamic_xml(cpu);
> +
>      mcc->parent_realize(dev, errp);
>  }
>  
> @@ -330,6 +332,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
>      dc->vmsd = &vmstate_mb_cpu;
>      device_class_set_props(dc, mb_properties);
>      cc->gdb_num_core_regs = 32 + 5;
> +    cc->gdb_get_dynamic_xml = mb_gdb_get_dynamic_xml;
> +    cc->gdb_core_xml_file = "microblaze-core.xml";
>  
>      cc->disas_set_info = mb_disas_set_info;
>      cc->tcg_initialize = mb_tcg_init;
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index a31134b..074a18e 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -25,6 +25,8 @@
>  #include "fpu/softfloat-types.h"
>  
>  typedef struct CPUMBState CPUMBState;
> +typedef struct DynamicMBGDBXMLInfo DynamicMBGDBXMLInfo;
> +
>  #if !defined(CONFIG_USER_ONLY)
>  #include "mmu.h"
>  #endif
> @@ -272,6 +274,10 @@ struct CPUMBState {
>      } pvr;
>  };
>  
> +struct DynamicMBGDBXMLInfo {
> +    char *xml;
> +};
> +
>  /**
>   * MicroBlazeCPU:
>   * @env: #CPUMBState
> @@ -286,6 +292,7 @@ struct MicroBlazeCPU {
>  
>      CPUNegativeOffsetState neg;
>      CPUMBState env;
> +    DynamicMBGDBXMLInfo dyn_xml;
>  
>      /* Microblaze Configuration Settings */
>      struct {
> @@ -321,6 +328,8 @@ void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +void mb_gen_dynamic_xml(MicroBlazeCPU *cpu);
> +const char *mb_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname);
>  
>  void mb_tcg_init(void);
>  /* you can call this signal handler from your SIGBUS and SIGSEGV
> diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
> index f41ebf1..cdca434 100644
> --- a/target/microblaze/gdbstub.c
> +++ b/target/microblaze/gdbstub.c
> @@ -54,3 +54,126 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>      }
>      return 4;
>  }
> +
> +static void mb_gen_xml_reg_tag(const MicroBlazeCPU *cpu, GString *s,
> +                               const char *name, uint8_t bitsize,
> +                               const char *type)
> +{
> +    g_string_append_printf(s, "<reg name=\"%s\" bitsize=\"%d\"",
> +                           name, bitsize);
> +    if (type) {
> +        g_string_append_printf(s, " type=\"%s\"", type);
> +    }
> +    g_string_append_printf(s, "/>\n");
> +}
> +
> +static uint8_t mb_cpu_sreg_size(const MicroBlazeCPU *cpu, uint8_t index)
> +{
> +    /*
> +     * NOTE:  mb-gdb will refuse to connect if we say registers are
> +     * larger then 32-bits.
> +     * For now, say none of our registers are dynamically sized, and are
> +     * therefore only 32-bits.
> +     */
> +
> +    return 32;
> +}
> +
> +static void mb_gen_xml_reg_tags(const MicroBlazeCPU *cpu, GString *s)
> +{
> +    uint8_t i;
> +    const char *type;
> +    char reg_name[4];
> +    bool has_hw_exception = cpu->cfg.dopb_bus_exception ||
> +                            cpu->cfg.iopb_bus_exception ||
> +                            cpu->cfg.illegal_opcode_exception ||
> +                            cpu->cfg.opcode_0_illegal ||
> +                            cpu->cfg.div_zero_exception ||
> +                            cpu->cfg.unaligned_exceptions;
> +
> +    static const char *reg_types[32] = {
> +        [1] = "data_ptr",
> +        [14] = "code_ptr",
> +        [15] = "code_ptr",
> +        [16] = "code_ptr",
> +        [17] = "code_ptr"
> +    };
> +
> +    for (i = 0; i < 32; ++i) {
> +        type = reg_types[i];
> +        /* r17 only has a code_ptr tag if we have HW exceptions */
> +        if (i == 17 && !has_hw_exception) {
> +            type = NULL;
> +        }
> +
> +        sprintf(reg_name, "r%d", i);
> +        mb_gen_xml_reg_tag(cpu, s, reg_name, 32, type);
> +    }
> +}
> +
> +static void mb_gen_xml_sreg_tags(const MicroBlazeCPU *cpu, GString *s)
> +{
> +    uint8_t i;
> +
> +    static const char *sreg_names[] = {
> +        "rpc",
> +        "rmsr",
> +        "rear",
> +        "resr",
> +        "rfsr",
> +        "rbtr",
> +        "rpvr0",
> +        "rpvr1",
> +        "rpvr2",
> +        "rpvr3",
> +        "rpvr4",
> +        "rpvr5",
> +        "rpvr6",
> +        "rpvr7",
> +        "rpvr8",
> +        "rpvr9",
> +        "rpvr10",
> +        "rpvr11",
> +        "redr",
> +        "rpid",
> +        "rzpr",
> +        "rtlblo",
> +        "rtlbhi",
> +        "rtlbx",
> +        "rtlbsx",

In case we decide to keep this dynamic approach, tlbx and tlbsx should be
before tlblo and tlbhi.


> +        "rslr",
> +        "rshr"

These need to be optional and in a separate XML description with
org.gnu.gdb.microblaze.stack-protect.


> +    };
> +
> +    static const char *sreg_types[ARRAY_SIZE(sreg_names)] = {
> +        [SR_PC] = "code_ptr"
> +    };
> +
> +    for (i = 0; i < ARRAY_SIZE(sreg_names); ++i) {
> +        mb_gen_xml_reg_tag(cpu, s, sreg_names[i], mb_cpu_sreg_size(cpu, i),
> +                           sreg_types[i]);
> +    }
> +}
> +
> +void mb_gen_dynamic_xml(MicroBlazeCPU *cpu)
> +{
> +    GString *s = g_string_new(NULL);
> +
> +    g_string_printf(s, "<?xml version=\"1.0\"?>\n"
> +                       "<!DOCTYPE feature SYSTEM \"gdb-target.dtd\">\n"
> +                       "<feature name=\"org.gnu.gdb.microblaze.core\">\n");
> +
> +    mb_gen_xml_reg_tags(cpu, s);
> +    mb_gen_xml_sreg_tags(cpu, s);
> +
> +    g_string_append_printf(s, "</feature>");
> +
> +    cpu->dyn_xml.xml = g_string_free(s, false);
> +}
> +
> +const char *mb_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
> +{
> +    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> +
> +    return cpu->dyn_xml.xml;
> +}
> -- 
> 2.7.4
> 

