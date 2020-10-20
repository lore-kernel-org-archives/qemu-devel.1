Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856EEC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807B82223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ac2o0rSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807B82223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUs3L-0006GJ-Vl
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <figlesia@xilinx.com>)
 id 1kUs2A-0005II-T2; Tue, 20 Oct 2020 09:50:39 -0400
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com
 ([40.107.223.67]:63968 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <figlesia@xilinx.com>)
 id 1kUs25-0003fb-SH; Tue, 20 Oct 2020 09:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TipVh3UmQWG8zMEve5Xi+9bpmm/Fn6ZgUqbQEUwwPv7ZvYGtKhJFE0y4SuaYdRnvbh2aE1Xj/Ppf3Gz8LZgXa+1GUe4Kq6AKsr2w/phWc6j9FN+axWod1q9f/PKe/iRiPhhUl/EKZEDLdtdQKDdqxt4r0M/aOPnnqXmhp+vrfnvcq5scmFHn/SP4PeuKbdkMGoV7fUq6sUpGPOWEvol2Y/aM8UF91l+Uh8xl2t44Wcgsy98uMuK1crchixQqWpXSJbcfpaxIxmpBhNO44Pw6XVadCmnekEGSf3hfYLKsDNAXHSEEy7heSN8gd03xPXOqEqAcisZeyqhtPXhGBdFUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5ruWueXi7bAbcns6fS1u2NNhowvYXs3g7urn88h1y0=;
 b=BRA35raQf5KTdgCI9uSoVqphWR+NGRcL4Qa3WBnyGNk4EKW1lsuSHcWVYYG3YHXcwKiFhjku6qkCSjSAB2ZoHFsw7/TFdYJAgpOjkswijuDXLTIA1HbDczJQ78eB1h6KOpfhAcBcLds1ix9Orn7+kQVXZF8jZR0mCzQ/zjHiIudIE8PJFwptv42t6omRN7IlbHHQdmsZ4tJ2aYOv2WyEkaXfp/rXjGAqRnqdJoUPwF0aeMtwiQOCmS2QvTrqbe4aL0LQQiVQPLoCYawZbhprlJYDFzy5x1o+GZz30RODPHXlBD3bzVOs1sU96DNQmOfzTfrJvX+KEXygMZeKlCBH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5ruWueXi7bAbcns6fS1u2NNhowvYXs3g7urn88h1y0=;
 b=ac2o0rSOCuHaGKVkxfMvKtvmhXsP2XSXeoohthfR7ERVL3N5uF0C3Vl8OKvLUgCBDwPJmxvNKgKyRx1ekuDvkyam7M5sfcoQilQGoFBfJbaJ3CIur33NygWErZLhO/TwDnUs9pRjs8qWvmq6KinEN7C2VQ10jxSAESteY+jTF0w=
Received: from MN2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:208:15e::24)
 by DM6PR02MB4569.namprd02.prod.outlook.com (2603:10b6:5:28::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 20 Oct
 2020 13:50:26 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:15e:cafe::51) by MN2PR17CA0011.outlook.office365.com
 (2603:10b6:208:15e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Tue, 20 Oct 2020 13:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 13:50:26
 +0000
Received: from [149.199.38.66] (port=51918 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1kUs14-0002sZ-Kt; Tue, 20 Oct 2020 06:49:30 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1kUs1x-0007zr-US; Tue, 20 Oct 2020 06:50:25 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 09KDoEri026230; 
 Tue, 20 Oct 2020 06:50:14 -0700
Received: from [10.23.120.221] (helo=debian)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <francisco.iglesias@xilinx.com>)
 id 1kUs1l-0007lD-Nr; Tue, 20 Oct 2020 06:50:13 -0700
Date: Tue, 20 Oct 2020 14:50:11 +0100
From: Francisco Iglesias <francisco.iglesias@xilinx.com>
To: Joe Komlodi <joe.komlodi@xilinx.com>
Subject: Re: [PATCH 1/2] hw/block/m25p80: Fix Numonyx dummy cycle register
 behavior
Message-ID: <20201020135010.jwkkr4or6zs5fcm7@debian>
References: <1601425716-204629-1-git-send-email-komlodi@xilinx.com>
 <1601425716-204629-2-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1601425716-204629-2-git-send-email-komlodi@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 962b0f26-506b-4d69-2999-08d874ff194a
X-MS-TrafficTypeDiagnostic: DM6PR02MB4569:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4569188161ABEFF645405A55AD1F0@DM6PR02MB4569.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGDX1pZyQi3235t2PX700vMRE6IiOloXlS/fQxDrT3gpqbJCvGvFiIwTsIqTpsVIBgRm7/5FZgTIcX4a8FRmGs+Zh5uLut5DQsEoclm622E16TYI/TwackIm3T0T1y4whbfTA3VWUEi0uZhX8CZ3Se2lKFIboFKi58jHvm/AymAcfyqduYV4A4ae25pzi9CkUI41XjywaOJcGqYmHx/Bj83Hf5JyxEufPCPuEpzcj5k+Rx+Nkr3XH5+QsGhfd7zwzdZ4d0GJtetCtegbIo8okN6wh3O3iTY2JjF8/1nAbAviaoZJ3M1fDUqIpkBJI1jOGfGZC1XolkvcBVOMB8nmTl8HUkP8ZskqpHhRsMuMrGSN1oB5tkGc+dh7CDFbmy0am3T1c+L3puNjFEDeHsT1eAqAOvbpHNn4+cjndie1cOBDGh2caaaJSn1sUqkkaG+ahT8A2I1wu92kgbW2p5xIM137/3ddkY8ngmUYB2WOZbE=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(376002)(346002)(39860400002)(136003)(46966005)(8676002)(26005)(186003)(426003)(336012)(966005)(478600001)(44832011)(33716001)(316002)(9576002)(6862004)(4326008)(8936002)(2906002)(9686003)(6636002)(9786002)(70586007)(5660300002)(47076004)(1076003)(70206006)(82310400003)(81166007)(356005)(83380400001)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:50:26.2628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 962b0f26-506b-4d69-2999-08d874ff194a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4569
Received-SPF: pass client-ip=40.107.223.67; envelope-from=figlesia@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:50:27
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
Cc: kwolf@redhat.com, alistair@alistair23.me, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Joe,

On Tue, Sep 29, 2020 at 05:28:35PM -0700, Joe Komlodi wrote:
> Numonyx chips determine the number of cycles to wait based on bits 7:4 in the
> volatile configuration register.
> 
> However, if these bits are 0x0 or 0xF, the number of dummy cycles to wait is
> 10 on a QIOR or QIOR4 command, or 8 on any other currently supported
> fast read command. [1]
> 
> [1] http://www.micron.com/-/media/client/global/documents/products/
> data-sheet/nor-flash/serial-nor/n25q/n25q_512mb_1_8v_65nm.pdf
> 
> Page 22 note 2, and page 30 notes 5 and 10.
> 
> Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
> ---
>  hw/block/m25p80.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 483925f..43830c9 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -820,6 +820,26 @@ static void reset_memory(Flash *s)
>      trace_m25p80_reset_done(s);
>  }
>  
> +static uint8_t numonyx_fast_read_num_dummies(Flash *s)

Should we rename the function to something like
'numonyx_extract_cfg_num_dummies' (since it is not only used inside
'decode_fast_read_cmd')?

> +{
> +    uint8_t cycle_count;
> +    uint8_t num_dummies;
> +    assert(get_man(s) == MAN_NUMONYX);
> +
> +    cycle_count = extract32(s->volatile_cfg, 4, 4);
> +    if (cycle_count == 0x0 || cycle_count == 0x0F) {
> +        if (s->cmd_in_progress == QIOR || s->cmd_in_progress == QIOR4) {

QOR and QOR4 also has 10 dummy cycles on default so we will have to check for
those aswell, perhaps something similar like below migth work:  

uint8_t n_dummies = extract32(s->volatile_cfg, 4, 4);

if (!n_dummies || n_dummies == 0xF) {
    switch(s->cmd_in_progress){
    case QOR:
    case QOR4
    case QIOR:
    case QIOR4:
        n_dummies = 10;
        break;
    default:
        n_dummies = 8;
        break;
    }
}

return n_dummies;

Best regards,
Francisco Iglesias

> +            num_dummies = 10;
> +        } else {
> +            num_dummies = 8;
> +        }
> +    } else {
> +        num_dummies = cycle_count;
> +    }
> +
> +    return num_dummies;
> +}
> +
>  static void decode_fast_read_cmd(Flash *s)
>  {
>      s->needed_bytes = get_addr_length(s);
> @@ -829,7 +849,7 @@ static void decode_fast_read_cmd(Flash *s)
>          s->needed_bytes += 8;
>          break;
>      case MAN_NUMONYX:
> -        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
> +        s->needed_bytes += numonyx_fast_read_num_dummies(s);
>          break;
>      case MAN_MACRONIX:
>          if (extract32(s->volatile_cfg, 6, 2) == 1) {
> @@ -868,7 +888,7 @@ static void decode_dio_read_cmd(Flash *s)
>                                      );
>          break;
>      case MAN_NUMONYX:
> -        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
> +        s->needed_bytes += numonyx_fast_read_num_dummies(s);
>          break;
>      case MAN_MACRONIX:
>          switch (extract32(s->volatile_cfg, 6, 2)) {
> @@ -908,7 +928,7 @@ static void decode_qio_read_cmd(Flash *s)
>                                      );
>          break;
>      case MAN_NUMONYX:
> -        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
> +        s->needed_bytes += numonyx_fast_read_num_dummies(s);
>          break;
>      case MAN_MACRONIX:
>          switch (extract32(s->volatile_cfg, 6, 2)) {
> -- 
> 2.7.4
> 

