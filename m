Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A529C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F572078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aGOujvZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F572078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDA1M-0003yy-3G
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kD9ze-0001vT-6i
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:22:50 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com
 ([40.107.92.57]:24800 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kD9zb-0007H3-3A
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:22:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEzYHT6a3wVo8ItrSwRlx5SCMkCuOb7wCf8nCB/foesJLzxXedf+SWltadG7Mc5t9cIxUJgA48kwDTjwICiCPlREvHkS/5iIxVjcAMjLSJxSwg4Wrrm3NLiK6rvNCTHjFrBtFcYRPnD45FI0RvfYcN7i6jwXvVgOhj6NQ77Wl1P7uh/uCiMxmHJULlGi+7uavkmuAM3aYUxDlx6/G3t79YagJ4nUHaIeBLDBY9cvvKqFPvDdcXbUr91hFFuOxtFzXjVzy7G01Fp9BO3mqkMDJg5umcMS5z8Ef1TLhNhNtAgWFM81S2R309dR1nnSKp+FaueaAht4v+73wbhiQFyfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALU9XIHy1KbbYt2lWeP4CjhgIGkODGHkzu01fJYKvms=;
 b=Qg9HHOcAFdyhmijB0mR7J1vZLfjgqDJqiUagTktsPEsf6XnkjJv6zT10bRTMB6vR8jY7X0pJ0524PF0TbEC7HEbHIQ5k1MWUbjV09FdopILQrp8aViDIwkXAs7BVLt/TtpfELwwlzBEUBDT9EyzKY1JWxUUXvtk70dzC4RlkhdTj8TlimGSakvnW07+eUHkA2CKSb5lJOKtiMsyzKsy5ChaZtVrmyFfAZpvi6NG7SYtkLIcRw+1dxgpfowguoZaEcIMsSeh5t3YDmuoEUzXeiFpJTL5I49FErcEDR4YSKFM3SLiAaX3oBMAuN342Itm7zhd+bgd93PV1CU09FvALfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALU9XIHy1KbbYt2lWeP4CjhgIGkODGHkzu01fJYKvms=;
 b=aGOujvZ7BNIt2Q+eJz+7odWk49aRaOlm1T4s41HsJHkZscRwwW+AeDwoIVvuxTR4P4IvX5Mi/DqilXGoSJGBXmE6MRJBG0oec5xThryem1uWE/ktMZFj372JQZlZNN3mIHWcTtFPCXoLCOx4ae9G4qqvSklsyTq54U4RC2/UCww=
Received: from BL1PR13CA0037.namprd13.prod.outlook.com (2603:10b6:208:257::12)
 by MWHPR02MB2575.namprd02.prod.outlook.com (2603:10b6:300:46::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 17:07:41 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:257:cafe::ef) by BL1PR13CA0037.outlook.office365.com
 (2603:10b6:208:257::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Tue, 1 Sep 2020 17:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 17:07:41
 +0000
Received: from [149.199.38.66] (port=52951 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kD9kv-0008Bc-Ad; Tue, 01 Sep 2020 10:07:37 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kD9ky-0003Vp-Mq; Tue, 01 Sep 2020 10:07:40 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 081H7daY025863; 
 Tue, 1 Sep 2020 10:07:39 -0700
Received: from [172.19.2.115] (helo=xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kD9kx-0003Vd-H0; Tue, 01 Sep 2020 10:07:39 -0700
Date: Tue, 1 Sep 2020 10:07:39 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: pisa@cmp.felk.cvut.cz
Subject: Re: [PATCH v1 2/6] hw/net/can: sja1000 ignore CAN FD frames
Message-ID: <20200901170733.GA151036@xilinx.com>
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
 <e9a4847e46810282319bdde1a6ddd901eb8783fd.1594725647.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9a4847e46810282319bdde1a6ddd901eb8783fd.1594725647.git.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 448a16fb-1e61-4d8c-9c12-08d84e99892a
X-MS-TrafficTypeDiagnostic: MWHPR02MB2575:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2575BFDF776D4D0055DB2123BC2E0@MWHPR02MB2575.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWQ2vZC0sbHWypOugF4HbXX5Qm1G5iCdAuYM+aF8gzruE1LtRT+cWLO4BlXjHqofp32l8/ZXw6C68I5A8b4UyTidMQGiA+Wrawu23TR+Em3Ro5CUR8HjgEiNSOF16Dxb7guYmmAREAbZOmFsfSOWUWuSPHZrn+k9IaLj24JKuN/X+q4QIh7nN2M5ykhYSEZPsxecRLfTA62R1wKXiWQ8I6AnfqIK4Rs94tEADpe5hW6MYRpGFv8wHwB/uKn8FkXg0RF+Xcfyyqk2x8g9EgszDZf8XcK6aF6jqLldHdQGQxu/3+5dSAQXdy/cdmBtQjI6kmB3KCMvCle1F/YiQXPHLbHjzNG5B7sVJpL87aufxoC/2YlkSz1CXlBdqHYVUoYFN8geQ5pc+Fb0t8xLqR2Lh0+V7dZ5+uVpErxvliUY1XOnN9Qky7ZZGQ1EInna/VM0
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(346002)(376002)(396003)(39860400002)(136003)(46966005)(2616005)(4326008)(2906002)(36756003)(83380400001)(478600001)(82310400003)(82740400003)(8936002)(33656002)(9786002)(186003)(70206006)(8676002)(70586007)(336012)(5660300002)(1076003)(26005)(7416002)(6916009)(426003)(81166007)(7696005)(356005)(316002)(47076004)(54906003)(27376004)(21314003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 17:07:41.0819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 448a16fb-1e61-4d8c-9c12-08d84e99892a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2575
Received-SPF: pass client-ip=40.107.92.57; envelope-from=fnuv@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 13:22:45
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
Cc: Marek Vasut <marex@denx.de>, Jiri Novak <jnovak@fel.cvut.cz>,
 Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ondrej Ille <ondrej.ille@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 02:20:15PM +0200, pisa@cmp.felk.cvut.cz wrote:
> From: Jan Charvat <charvj10@fel.cvut.cz>
>
> Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Reviewed-by: Vikram Garhwal <fnu.vikram@xilinx.com>

> ---
>  hw/net/can/can_sja1000.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index d83c550edc..382911560c 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -323,11 +323,16 @@ static void buff2frame_bas(const uint8_t *buff, qemu_can_frame *frame)
>  static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
>  {
>      int i;
> +    int dlen = frame->can_dlc;
>
>      if (frame->can_id & QEMU_CAN_ERR_FLAG) { /* error frame, NOT support now. */
>          return -1;
>      }
>
> +    if (dlen > 8) {
> +        return -1;
> +    }
> +
>      buff[0] = 0x0f & frame->can_dlc; /* DLC */
>      if (frame->can_id & QEMU_CAN_RTR_FLAG) { /* RTR */
>          buff[0] |= (1 << 6);
> @@ -338,18 +343,18 @@ static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
>          buff[2] = extract32(frame->can_id, 13, 8); /* ID.20~ID.13 */
>          buff[3] = extract32(frame->can_id, 5, 8);  /* ID.12~ID.05 */
>          buff[4] = extract32(frame->can_id, 0, 5) << 3; /* ID.04~ID.00,xxx */
> -        for (i = 0; i < frame->can_dlc; i++) {
> +        for (i = 0; i < dlen; i++) {
>              buff[5 + i] = frame->data[i];
>          }
> -        return frame->can_dlc + 5;
> +        return dlen + 5;
>      } else { /* SFF */
>          buff[1] = extract32(frame->can_id, 3, 8); /* ID.10~ID.03 */
>          buff[2] = extract32(frame->can_id, 0, 3) << 5; /* ID.02~ID.00,xxxxx */
> -        for (i = 0; i < frame->can_dlc; i++) {
> +        for (i = 0; i < dlen; i++) {
>              buff[3 + i] = frame->data[i];
>          }
>
> -        return frame->can_dlc + 3;
> +        return dlen + 3;
>      }
>
>      return -1;
> @@ -358,6 +363,7 @@ static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
>  static int frame2buff_bas(const qemu_can_frame *frame, uint8_t *buff)
>  {
>      int i;
> +    int dlen = frame->can_dlc;
>
>       /*
>        * EFF, no support for BasicMode
> @@ -369,17 +375,21 @@ static int frame2buff_bas(const qemu_can_frame *frame, uint8_t *buff)
>          return -1;
>      }
>
> +    if (dlen > 8) {
> +        return -1;
> +    }
> +
>      buff[0] = extract32(frame->can_id, 3, 8); /* ID.10~ID.03 */
>      buff[1] = extract32(frame->can_id, 0, 3) << 5; /* ID.02~ID.00,xxxxx */
>      if (frame->can_id & QEMU_CAN_RTR_FLAG) { /* RTR */
>          buff[1] |= (1 << 4);
>      }
>      buff[1] |= frame->can_dlc & 0x0f;
> -    for (i = 0; i < frame->can_dlc; i++) {
> +    for (i = 0; i < dlen; i++) {
>          buff[2 + i] = frame->data[i];
>      }
>
> -    return frame->can_dlc + 2;
> +    return dlen + 2;
>  }
>
>  static void can_sja_update_pel_irq(CanSJA1000State *s)
> @@ -764,6 +774,13 @@ ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
>      if (frames_cnt <= 0) {
>          return 0;
>      }
> +    if (frame->flags && QEMU_CAN_FRMF_TYPE_FD) {
> +        if (DEBUG_FILTER) {
> +            can_display_msg("[cansja]: ignor fd frame ", frame);
> +        }
> +        return 1;
> +    }
> +
>      if (DEBUG_FILTER) {
>          can_display_msg("[cansja]: receive ", frame);
>      }

