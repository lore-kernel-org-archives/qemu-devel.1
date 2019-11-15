Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FB3C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5A5206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CvRvFsce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5A5206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdu6-00026q-At
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1iVdqv-0007J3-5e
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1iVdqt-0000pv-Nv
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:49:41 -0500
Received: from mail-eopbgr730066.outbound.protection.outlook.com
 ([40.107.73.66]:2417 helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1iVdqt-0000pf-Ci
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:49:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG2Z1+C2i2fD1BGFjFz5EUSS0/aDfXCXSw7ZxTehWodsL46VRUJ84d654wQbz+7oSHnAsxJs3ZzrWTok2Er7znD6p4vtM94V/lhrFh7stOh2cCnNNqX9fUwuWwCQqM+LxGzIj2aYB0f45iGHinKwqf1zumSkYmy1pkAnBzmchI6RFnxvRFRK7Ti+pXfXmJmj2mLei8bxq4EPFEI0nE5jvmlS7ugxvlg4RorO/skzfs7JwNoDGN79KNuIbfp2IbuAGl5WzJQqTYQzXoACZ/6mxjQizM7Ur2TkHGtW4D8BT+R3t4TspZEEmgb4u4sJe09UPm1eu5rqMbhQUrsZZe0m9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7744bsjbYA3zBx2GmU+dtmFvBUsYVkPAZ38OWBoehs=;
 b=DsbEfTPMWrbbE+prQsRDiiHu44TpT7eoKCu+MIA6nGo4/eaumfmayvM58hWHYPZwKVgq3QsyzP0vYGqxNMLHe8bfMnAttQ+4HTziKYZZM3uL4pPQZfRAXTzcTJesBFFQorCnog/mi0Hoc1i/xAlb8g/CFIeGglFJTN2zO2KYQ7U4nZm8U0D68u2/9mbcejSYPkeOqDGAId8NjZJQIuP7rGTOKZNEQSevlhHF0bKuUlKWRHsTeJBEnb9cxNYnPV9I0+IXutN1XlXF6V+NVXcRp9mWMne+GTwmFP+4z+aq6FWLqvq/cxVKdPYnLP6h6EM2sFu5239OxNttX48qcsKemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7744bsjbYA3zBx2GmU+dtmFvBUsYVkPAZ38OWBoehs=;
 b=CvRvFsceNdlyhhb0ZtMGwyfcSHKzdMnP6mhO8eJFMgM71WxI30vjKZm4DKlVfDQwdPfpBc2MJDKQ/BHDW13jHD6EEoe8qk+yRWSNj4xEdXwFVwoLlMF/0G/PNgbLN0OmtCvhXvisGPW53tKL+kCB4W5bBDEHM84tJalOgUlmu0I=
Received: from MWHPR0201CA0099.namprd02.prod.outlook.com
 (2603:10b6:301:75::40) by DM6PR02MB3930.namprd02.prod.outlook.com
 (2603:10b6:5:a4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Fri, 15 Nov
 2019 15:49:37 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MWHPR0201CA0099.outlook.office365.com
 (2603:10b6:301:75::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Fri, 15 Nov 2019 15:49:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Fri, 15 Nov 2019 15:49:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iVdqp-0008BY-Uw; Fri, 15 Nov 2019 07:49:35 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iVdqk-0000xv-QO; Fri, 15 Nov 2019 07:49:30 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAFFnQcL001446; 
 Fri, 15 Nov 2019 07:49:26 -0800
Received: from [10.71.116.146] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iVdqg-0000xB-A9; Fri, 15 Nov 2019 07:49:26 -0800
Date: Fri, 15 Nov 2019 16:49:25 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v6] ssi: xilinx_spips: Skip spi bus update for a few
 register writes
Message-ID: <20191115154925.GD2859@toto>
References: <1573830705-14579-1-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573830705-14579-1-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(7916004)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(54906003)(16586007)(33656002)(305945005)(229853002)(316002)(58126008)(1076003)(14444005)(4326008)(50466002)(70206006)(70586007)(76176011)(6246003)(356004)(6862004)(36386004)(2906002)(106002)(23726003)(8676002)(486006)(57986006)(126002)(476003)(15650500001)(33716001)(186003)(5660300002)(76506006)(336012)(11346002)(426003)(446003)(9786002)(9686003)(81156014)(26005)(81166006)(8936002)(478600001)(47776003)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB3930; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a16b955f-d200-4809-7de0-08d769e36ac2
X-MS-TrafficTypeDiagnostic: DM6PR02MB3930:
X-Microsoft-Antispam-PRVS: <DM6PR02MB3930B03DE319FF739907BCD0C2700@DM6PR02MB3930.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:170;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXMC9Rgs9BjavIoUAPzGD+K9DmM50QRBEOAsqOqNNa+caHpaqiyiR5WqXfGiZv2dR80npFiGdTOepWPbkGhEC7pNk8HQUVMDSenAi1phnMqtkvW1nDLEGh+VayPTyLKpxJgdo/COO9Rszf30o8C1QpDhBxdNtdESExVE2vpMTTYvT8WxOAJvomCT9cy3N4nM9No4KM1OIpfpDb+sVokqo+YjhWI0Cs7rJglCZIDPbFT3J2ShfZg9ZIGQ8riX4ZiLXJqcPMjcei26SSxH3jjJRCmmoOIz068oo+8/8HSz4ygcwbB2Rpq+xlxy5WeNTIeawpO8JMxxtImaUyzOwtwzDBLL4eZBE1We/gsbfaV2mnFzFRZnOtX2DOBDNi5k7IBFRR0tTrlyQFU88Mb5YeR3WcYgxj9Wdb1Pf6BcO1Y2hm87P5kNnMBPIV4uG6w+n2Hr
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 15:49:36.4106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16b955f-d200-4809-7de0-08d769e36ac2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB3930
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.66
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
Cc: Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 15, 2019 at 08:41:45PM +0530, Sai Pavan Boddu wrote:
> A few configuration register writes need not update the spi bus state, so just
> return after the register write.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
> 
> Changes for V2:
> 	Just skip update of spips cs and fifos
> 	Update commit message accordingly
> Changes for V4:
> 	Avoid checking for zynqmp qspi
> 	Skip spi bus update for few of the registers Changes for V4:
> 	Move the register list to existing switch case above.
> Changes for V5:
> 	Fixed Commit message.
> Changes for V6:
> 	Fixed commit message. Added Review tags.
> 
> Note: Resending this as it got filtered for first two attempts.
> 
> 
>  hw/ssi/xilinx_spips.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index a309c71..0d6c2e1 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -109,6 +109,7 @@
>  #define R_GPIO              (0x30 / 4)
>  #define R_LPBK_DLY_ADJ      (0x38 / 4)
>  #define R_LPBK_DLY_ADJ_RESET (0x33)
> +#define R_IOU_TAPDLY_BYPASS (0x3C / 4)
>  #define R_TXD1              (0x80 / 4)
>  #define R_TXD2              (0x84 / 4)
>  #define R_TXD3              (0x88 / 4)
> @@ -139,6 +140,8 @@
>  #define R_LQSPI_STS         (0xA4 / 4)
>  #define LQSPI_STS_WR_RECVD      (1 << 1)
>  
> +#define R_DUMMY_CYCLE_EN    (0xC8 / 4)
> +#define R_ECO               (0xF8 / 4)
>  #define R_MOD_ID            (0xFC / 4)
>  
>  #define R_GQSPI_SELECT          (0x144 / 4)
> @@ -970,6 +973,7 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
>  {
>      int mask = ~0;
>      XilinxSPIPS *s = opaque;
> +    bool try_flush = true;
>  
>      DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr, (unsigned)value);
>      addr >>= 2;
> @@ -1019,13 +1023,23 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
>          tx_data_bytes(&s->tx_fifo, (uint32_t)value, 3,
>                        s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
>          goto no_reg_update;
> +    /* Skip SPI bus update for below registers writes */
> +    case R_GPIO:
> +    case R_LPBK_DLY_ADJ:
> +    case R_IOU_TAPDLY_BYPASS:
> +    case R_DUMMY_CYCLE_EN:
> +    case R_ECO:
> +        try_flush = false;
> +        break;
>      }
>      s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
>  no_reg_update:
> -    xilinx_spips_update_cs_lines(s);
> -    xilinx_spips_check_flush(s);
> -    xilinx_spips_update_cs_lines(s);
> -    xilinx_spips_update_ixr(s);
> +    if (try_flush) {
> +        xilinx_spips_update_cs_lines(s);
> +        xilinx_spips_check_flush(s);
> +        xilinx_spips_update_cs_lines(s);
> +        xilinx_spips_update_ixr(s);
> +    }
>  }
>  
>  static const MemoryRegionOps spips_ops = {
> -- 
> 2.7.4
> 

