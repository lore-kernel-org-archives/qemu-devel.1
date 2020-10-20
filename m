Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85465C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 22:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F322225C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 22:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UMB7p7d0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F322225C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV00Y-0002E1-E7
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 18:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kUzzZ-0001gB-Qh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 18:20:29 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com
 ([40.107.244.89]:64097 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kUzzS-0003c4-2r
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 18:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAzrzme5ReAxDoW8ljG6Vd9cCnLCWOo2kFg9UVxH1B2y7zbC9Neh1dzH/PGlPVj3VbGzuzx5wtsqtJlhi+GvPS3S3igpsuZPuHpX3+xoMhE9XvXhCh+olSHPHiO+Yd7bjNy62MvsYDx/hIBfRn5L+k1SAsYwPwTJ2tNKJWlLM952MoS2HWVArAxevYwlzsVOBCRhwq5p8e0HaOPCmDBepzHOEU+WT5kqmkm7RXlIIynUmzeuqFFPmrzdOKKR7zFmxlWFNlH9Wtbi1t9Baz8YTp0qCIacxdqBXVdE2x/2R5mn492u+xzuTPGCl3vauRB/e3mF2MoaajTQeivAxNm0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnIyEvpphMkLub3G3Lylr2/rQCCw/rSLqcOoji8Yle0=;
 b=MXe3PfNdvk2eAe13nrxBAQDdJTrFTyAEavYlscXxT93WlnhAPDV1FxYG8t70C4kv/bacCm+ZjSssKTDCrgSBB7RLLZY9dbAR2+y7/TxHslYpZ9SZ2AD5KPJYuYMzUt4qsb2kzehcCaZAzcu1PGKUfxRGBEcHvUIHf2OcTLBhsPd9aVZoT0A20J6sSy8bP73/fYMrtY1zPEYfSo2XVqPpJXlVnxcYrhcmuv1SOIAzsbjO9p6T/dADRutHSF3bA7yt6BbaWUh7NxgUz8GbqeMVtJRS+sHkdxTmNE5aM3Y5RhAt5vtC1N/kkhK+9uaTLIpU2CUps6/a9QTi+eEWj83sNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnIyEvpphMkLub3G3Lylr2/rQCCw/rSLqcOoji8Yle0=;
 b=UMB7p7d0/qVXgs6Nj5YeUcZ0wP62jd75t7oyspoEIRxFex7V1qrgOHq+HY6NqCFPjoOlG+rdTIy0xop5qVopt5QuAI/9kZLIvDcSExVWV76zSZhzvm/rxPXzs3r/Vn1Cr1hTikAeYbf0xReiGNUj+tUv2df/bBRBmogmpyVEIiI=
Received: from SN4PR0501CA0066.namprd05.prod.outlook.com
 (2603:10b6:803:41::43) by MW2PR02MB3834.namprd02.prod.outlook.com
 (2603:10b6:907:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 20 Oct
 2020 22:05:12 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::ca) by SN4PR0501CA0066.outlook.office365.com
 (2603:10b6:803:41::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Tue, 20 Oct 2020 22:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 22:05:12
 +0000
Received: from [149.199.38.66] (port=55861 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kUzjr-00021t-GE; Tue, 20 Oct 2020 15:04:15 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kUzkl-0002uv-9h; Tue, 20 Oct 2020 15:05:11 -0700
Received: from [172.19.2.115] (helo=xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kUzkk-0002uc-HF; Tue, 20 Oct 2020 15:05:10 -0700
Date: Tue, 20 Oct 2020 15:05:10 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v11 1/4] hw/net/can: Introduce Xilinx ZynqMP CAN controller
Message-ID: <20201020220509.GA14267@xilinx.com>
References: <1602654397-35162-1-git-send-email-fnu.vikram@xilinx.com>
 <1602654397-35162-2-git-send-email-fnu.vikram@xilinx.com>
 <CAFEAcA_=eERP_Q49k9oNa6Jun8oWGeE0D+uZaN6QxEZAfZO+mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_=eERP_Q49k9oNa6Jun8oWGeE0D+uZaN6QxEZAfZO+mw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cab18a8d-bc47-4796-221a-08d8754437aa
X-MS-TrafficTypeDiagnostic: MW2PR02MB3834:
X-Microsoft-Antispam-PRVS: <MW2PR02MB38348E6D193B88703AE36CD8BC1F0@MW2PR02MB3834.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyM66ZkTfpP97R/wOskl79EXX9XNotQhWs38C6xw+ICnRjqzhDF7c89cCt+iy3MNNX2m87K3y5zrXwGm4F/ES9u/627uM2wFjXWVsaJpll6GN+XtRsYKD/9pDDG3CvfQc6z+v0DrnFbVXWotsQLpbp0Mg5c4Qj5bNFdugIO+mfHSSnF1/1HADOnz3RD4ZiinQ6SqtlwLvqBP8J5ejgren6HZW0sVAYm7CmgXZXAwfhVcc6PzR7xi7i8PNwSwPoPa+JsSpeAotDpSK0szgo94nGO7W4jDDV2HN1swQU/qhZA0zpIWXdnmJEWNSdzWXgbrcgor4P9F0WMTxI/YWQ1isgy/KVFNfiVqMfvIY5Qf5X65WgVDUpH6vOKV2UCh3Bgh2SBknxOiFzYZkrRJ6SZq38BBhJMUQQwbYCrYYpLqNrcF0wdlgSL7KdJ2ESP06K4ZLFy7w+JJByheW9TcRvMk+MAyjc0iowy7VCqG63dIoq4=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(376002)(346002)(396003)(136003)(39850400004)(46966005)(70586007)(82740400003)(107886003)(26005)(70206006)(1076003)(9786002)(83380400001)(82310400003)(8676002)(6916009)(5660300002)(47076004)(336012)(33656002)(966005)(186003)(2906002)(8936002)(426003)(7696005)(36756003)(478600001)(2616005)(4326008)(356005)(316002)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 22:05:12.5017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab18a8d-bc47-4796-221a-08d8754437aa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3834
Received-SPF: pass client-ip=40.107.244.89; envelope-from=fnuv@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 18:20:16
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
Cc: figlesia@xilinx.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 11:53:25AM +0100, Peter Maydell wrote:
> On Wed, 14 Oct 2020 at 07:04, Vikram Garhwal <fnu.vikram@xilinx.com> wrote:
> >
> > The Xilinx ZynqMP CAN controller is developed based on SocketCAN, QEMU CAN bus
> > implementation. Bus connection and socketCAN connection for each CAN module
> > can be set through command lines.
> >
> > Example for using single CAN:
> >     -object can-bus,id=canbus0 \
> >     -machine xlnx-zcu102.canbus0=canbus0 \
> >     -object can-host-socketcan,id=socketcan0,if=vcan0,canbus=canbus0
> >
> > Example for connecting both CAN to same virtual CAN on host machine:
> >     -object can-bus,id=canbus0 -object can-bus,id=canbus1 \
> >     -machine xlnx-zcu102.canbus0=canbus0 \
> >     -machine xlnx-zcu102.canbus1=canbus1 \
> >     -object can-host-socketcan,id=socketcan0,if=vcan0,canbus=canbus0 \
> >     -object can-host-socketcan,id=socketcan1,if=vcan0,canbus=canbus1
> >
> > To create virtual CAN on the host machine, please check the QEMU CAN docs:
> > https://github.com/qemu/qemu/blob/master/docs/can.txt
> >
> > Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
>
>
> > +#define MAX_CAN_CTRLS      2
> > +#define XLNX_ZYNQMP_CAN_R_MAX     (0x84 / 4)
> > +#define MAILBOX_CAPACITY   64
> > +#define CAN_TIMER_MAX  0XFFFFUL
>
> "0x" is more usual.
I will correct this.
>
>
> > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, SRST)) {
> > +        trace_xlnx_can_can_receive("Controller is in reset.\n");
> > +        return false;
> > +    }
>
> > --- /dev/null
> > +++ b/hw/net/can/trace-events
> > @@ -0,0 +1,9 @@
> > +# xlnx-zynqmp-can.c
> > +xlnx_can_transfer_fifo(const char *message) "%s"
> > +xlnx_can_srr_pre_write(const char *message) "%s"
> > +xlnx_can_update_rx_fifo(const char *message) "%s"
> > +xlnx_can_rxfifo_pre_read(const char *message) "%s"
> > +xlnx_can_tx_post_write(const char *message) "%s"
> > +xlnx_can_can_receive(const char *message) "%s"
> > +xlnx_can_receive(const char *message) "%s"
> > +xlnx_can_realize(const char *message) "%s"
>
> This is not the usual way to do tracepoints. Generally rather
> than having one trace point which gets passed an opaque string,
> you should have trace points for each interesting event,
> which have an event-specific format string that prints out
> the useful information. Here's an example from a UART model:
>  pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x
> read_count %d returning %d"
> Notice that it's specific to one event (there's only one
> place in the code that calls that tracepoint), it mostly
> relies on the name of the trace event itself to give the
> user context, and it uses the format string to provide some
> information about the internal state of the device (not always
> relevant for all trace events -- sometimes you do just have an
> event).
>
> That way users of tracepoints can enable, for instance,
> all the 'xnlx_can_rxfifo*' tracepoints if they want all
> the logging, or only 'xlnx_can_rxfifo_full' if they only
> care to log the "fifo filled up" event but not others.
>
Hi Peter,
Thank you so much for explaining this in detail. I will create distinct
tracepoints for each event in next version. I will prepare v12 and send it soon.
> thanks
> -- PMM

