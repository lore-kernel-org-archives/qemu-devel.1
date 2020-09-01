Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8DEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 20:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF1D207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 20:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="geg3SmCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF1D207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDCU6-00049N-PF
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 16:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kDCTG-0003Xh-A9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 16:01:34 -0400
Received: from mail-eopbgr690040.outbound.protection.outlook.com
 ([40.107.69.40]:50966 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kDCTD-0001dq-Hp
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 16:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co9g2+mkrZaEw3mHNPwKMDju//TZTtEG2Ay19Mun+dHI6M0IozNFB0IxSxroASVU8IrWVAYcStXDl/V1lQQUI1tZ9jpAfUYmwvvUq5chC7qz4z6TOhZvcMvggo8dXacfADAkoCGGXXzCL1S48isspdQ3WgZ8OtwDKgKb86mqecF6C0DompEATdHsjvQWnaln4aKN+s/V7mvGe9oPt7bjd/61OLGXw10Fudih/BCX9PgOJ3BAjSYqByer+5/jSXPTGpiExZfFMdIgbHXLMmeJxAaU0rNYoANEcLoC2IGCmCJ0Zbq8VcL5LH4fFI3oQOCHxfa3MDix/6OxztZWvtuz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG8wW4nSySzIeYEDxzGK7fTw01r2VVj8QgMVRWefKDY=;
 b=kANo9ElklIjVeFa4nAlfyhNhYsZdkur0qJWK2YX3+F6UFoUxuX6RuqZMNpSwqcgVE7uucY7f1q5t1v+exb8UDTrzEAq3VFxMheZkdEz7f2XWQx7SllVZ2EkBFCYfSes8nM/UNwDlZmvHEsazfA2Q37DyupXbN/wMgCQgsqijHeRp1HlKdMYFiqZO9rcTyf/C3ApSlyaU8k/o0A1wEpVIaRPC6PhS1JJi+FrLu8u7Y/uHIvePwbN/pw51ckuy34SnYaT/ARFFFXEC8CIs0LXbUTayRc52UBQvfO5OjpoOxzJqIYugCJj9he3CA+3mq3nAqGSXClWPwR+FEAdxGGzWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=cmp.felk.cvut.cz smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG8wW4nSySzIeYEDxzGK7fTw01r2VVj8QgMVRWefKDY=;
 b=geg3SmChUB893cIqyQYlCBPqpKrWfqdFn0F6CkdhSxIZJWTJm7WCyptlLIRGz9GjoQbotNc1jmLnHJ0Imp9s3q1zx8HRH0dHcW9rCeQ9XwG67i2HcXC1+tAQUb3egLMq8qcOqxJdsKaylckUTw+l6Afpp2EG5A2TZ/WALmyHARs=
Received: from SN4PR0801CA0017.namprd08.prod.outlook.com
 (2603:10b6:803:29::27) by DM6PR02MB5820.namprd02.prod.outlook.com
 (2603:10b6:5:17b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 20:01:27 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::ab) by SN4PR0801CA0017.outlook.office365.com
 (2603:10b6:803:29::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Tue, 1 Sep 2020 20:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; cmp.felk.cvut.cz; dkim=none (message not signed)
 header.d=none;cmp.felk.cvut.cz; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 20:01:26
 +0000
Received: from [149.199.38.66] (port=47313 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDCT5-0002hv-3E; Tue, 01 Sep 2020 13:01:23 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDCT8-0005eq-Kc; Tue, 01 Sep 2020 13:01:26 -0700
Received: from [172.19.2.115] (helo=xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDCT8-0005en-8a; Tue, 01 Sep 2020 13:01:26 -0700
Date: Tue, 1 Sep 2020 13:01:26 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: pisa@cmp.felk.cvut.cz
Subject: Re: [PATCH v1 1/6] net/can: Initial host SocketCan support for CAN FD.
Message-ID: <20200901200119.GA152258@xilinx.com>
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
 <b401e976ac9c73cf1582bca95442a255676ce940.1594725647.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b401e976ac9c73cf1582bca95442a255676ce940.1594725647.git.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f34cfce-5483-4ee2-0c1e-08d84eb1cf71
X-MS-TrafficTypeDiagnostic: DM6PR02MB5820:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5820C36A336DFDE5A5376711BC2E0@DM6PR02MB5820.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0oepOxOCpTOc16P1PRRFosqUPdgm1b2v01pkMMrFixUInDnxo50Z1UOtVQ5JNKh88Br39ijbjQG5UKy8V2ALljHPcyG6pwLARrMySA9MGJPfXAhbBmkAi3JT7+mxoLs1kB7y1XZABa+2yqLSkTbyReM2V0w021pkIpVK4Dn8/uxOGugRkCeAs+8HOiwIii+mgyx8SuNv8aayS8ZuxCsyxE4Lxh5oB1istkTpVPMBwiT1srdO90iUw49IPKNpR8BBj7VlEwkC9vzrxd8ANr3iojsoi0tz/efZApDQ5FQNjMm6r7H1aNfIQxzyXvgrcSDcHFyakH+oSWwBlI1zt9eFa/RFZak2R3NQmY/uX43rcFWLLZECzIOtEfzuyC5ViXdnhTqZNMGJgM2zwxSU3tlTWXGmKURfSpQpEBMXFxD0nY=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(136003)(396003)(376002)(39860400002)(346002)(46966005)(186003)(70586007)(7696005)(2616005)(9786002)(4326008)(426003)(33656002)(70206006)(8676002)(7416002)(5660300002)(8936002)(36756003)(26005)(1076003)(336012)(82740400003)(6916009)(316002)(81166007)(356005)(54906003)(47076004)(2906002)(82310400003)(83380400001)(478600001)(27376004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 20:01:26.9215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f34cfce-5483-4ee2-0c1e-08d84eb1cf71
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5820
Received-SPF: pass client-ip=40.107.69.40; envelope-from=fnuv@xilinx.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 16:01:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
 Oliver Hartkopp <socketcan@hartkopp.net>, Deniz Eren <deniz.eren@icloud.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ondrej Ille <ondrej.ille@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jan,
A couple of comments on this patch.
On Tue, Jul 14, 2020 at 02:20:14PM +0200, pisa@cmp.felk.cvut.cz wrote:
> From: Jan Charvat <charvj10@fel.cvut.cz>
>
> Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  hw/net/can/can_sja1000.c |  2 ++
>  include/net/can_emu.h    |  8 ++++++-
>  net/can/can_socketcan.c  | 47 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index ea915a023a..d83c550edc 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -268,6 +268,7 @@ static void buff2frame_pel(const uint8_t *buff, qemu_can_frame *frame)
>  {
>      uint8_t i;
>
> +    frame->flags = 0;
>      frame->can_id = 0;
>      if (buff[0] & 0x40) { /* RTR */
>          frame->can_id = QEMU_CAN_RTR_FLAG;
> @@ -303,6 +304,7 @@ static void buff2frame_bas(const uint8_t *buff, qemu_can_frame *frame)
>  {
>      uint8_t i;
>
> +    frame->flags = 0;
>      frame->can_id = ((buff[0] << 3) & (0xff << 3)) + ((buff[1] >> 5) & 0x07);
>      if (buff[1] & 0x10) { /* RTR */
>          frame->can_id = QEMU_CAN_RTR_FLAG;
> diff --git a/include/net/can_emu.h b/include/net/can_emu.h
> index fce9770928..c6164dcfb4 100644
> --- a/include/net/can_emu.h
> +++ b/include/net/can_emu.h
> @@ -46,7 +46,8 @@ typedef uint32_t qemu_canid_t;
>  typedef struct qemu_can_frame {
>      qemu_canid_t    can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>      uint8_t         can_dlc; /* data length code: 0 .. 8 */
> -    uint8_t         data[8] QEMU_ALIGNED(8);
> +    uint8_t         flags;
> +    uint8_t         data[64] QEMU_ALIGNED(8);
>  } qemu_can_frame;
>
>  /* Keep defines for QEMU separate from Linux ones for now */
> @@ -58,6 +59,10 @@ typedef struct qemu_can_frame {
>  #define QEMU_CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
>  #define QEMU_CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
>
> +#define QEMU_CAN_FRMF_BRS     0x01 /* bit rate switch (2nd bitrate for data) */
> +#define QEMU_CAN_FRMF_ESI     0x02 /* error state ind. of transmitting node */
> +#define QEMU_CAN_FRMF_TYPE_FD 0x10 /* internal bit ind. of CAN FD frame */
> +
>  /**
>   * struct qemu_can_filter - CAN ID based filter in can_register().
>   * @can_id:   relevant bits of CAN ID which are not masked out.
> @@ -97,6 +102,7 @@ struct CanBusClientState {
>      char *model;
>      char *name;
>      void (*destructor)(CanBusClientState *);
> +    bool fd_mode;
>  };
>
>  #define TYPE_CAN_BUS "can-bus"
> diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
> index b7ef63ec0e..fbc0b62ea4 100644
> --- a/net/can/can_socketcan.c
> +++ b/net/can/can_socketcan.c
> @@ -103,6 +103,14 @@ static void can_host_socketcan_read(void *opaque)
>          return;
>      }
>
> +    if (!ch->bus_client.fd_mode) {
> +        c->buf[0].flags = 0;
> +    } else {
> +        if (c->bufcnt > CAN_MTU) {
> +            c->buf[0].flags |= QEMU_CAN_FRMF_TYPE_FD;
> +        }
> +    }
> +
>      can_bus_client_send(&ch->bus_client, c->buf, 1);
>
>      if (DEBUG_CAN) {
> @@ -121,12 +129,21 @@ static ssize_t can_host_socketcan_receive(CanBusClientState *client,
>      CanHostState *ch = container_of(client, CanHostState, bus_client);
>      CanHostSocketCAN *c = CAN_HOST_SOCKETCAN(ch);
>
> -    size_t len = sizeof(qemu_can_frame);
> +    size_t len;
>      int res;
>
>      if (c->fd < 0) {
>          return -1;
>      }
> +    if (frames->flags & QEMU_CAN_FRMF_TYPE_FD) {
> +        if (!ch->bus_client.fd_mode) {
> +            return 0;
> +        }
> +        len = CANFD_MTU;
> +    } else {
> +        len = CAN_MTU;
> +
> +    }
>
>      res = write(c->fd, frames, len);
>
> @@ -172,6 +189,8 @@ static void can_host_socketcan_connect(CanHostState *ch, Error **errp)
>  {
>      CanHostSocketCAN *c = CAN_HOST_SOCKETCAN(ch);
>      int s; /* can raw socket */
> +    int mtu;
> +    int enable_canfd = 1;
>      struct sockaddr_can addr;
>      struct ifreq ifr;
>
> @@ -185,13 +204,34 @@ static void can_host_socketcan_connect(CanHostState *ch, Error **errp)
>      addr.can_family = AF_CAN;
>      memset(&ifr.ifr_name, 0, sizeof(ifr.ifr_name));
>      strcpy(ifr.ifr_name, c->ifname);
> +    /* check if the frame fits into the CAN netdevice */
>      if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
>          error_setg_errno(errp, errno,
> -                         "SocketCAN host interface %s not available", c->ifname);
> +                         "SocketCAN host interface %s not available",
> +                         c->ifname);
May be this formatting change in a different patch? As this is not related to
CANFD.
>          goto fail;
>      }
>      addr.can_ifindex = ifr.ifr_ifindex;
>
> +    if (ioctl(s, SIOCGIFMTU, &ifr) < 0) {
> +        error_setg_errno(errp, errno,
> +                         "SocketCAN host interface %s SIOCGIFMTU failed",
> +                         c->ifname);
> +        goto fail;
> +    }
> +    mtu = ifr.ifr_mtu;
> +
> +    if (mtu >= CANFD_MTU) {
> +        /* interface is ok - try to switch the socket into CAN FD mode */
> +        if (setsockopt(s, SOL_CAN_RAW, CAN_RAW_FD_FRAMES,
> +                        &enable_canfd, sizeof(enable_canfd))) {
> +            warn_report("SocketCAN host interface %s enabling CAN FD failed",
> +                        c->ifname);
> +        } else {
> +            c->parent.bus_client.fd_mode = true;
> +        }
> +    }
> +
>      c->err_mask = 0xffffffff; /* Receive error frame. */
>      setsockopt(s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
>                     &c->err_mask, sizeof(c->err_mask));
> @@ -232,7 +272,8 @@ static char *can_host_socketcan_get_if(Object *obj, Error **errp)
>      return g_strdup(c->ifname);
>  }
>
> -static void can_host_socketcan_set_if(Object *obj, const char *value, Error **errp)
> +static void can_host_socketcan_set_if(Object *obj, const char *value,
> +                                      Error **errp)
This one also not relevant change for CANFD. Rest of the patch looks good.
>  {
>      CanHostSocketCAN *c = CAN_HOST_SOCKETCAN(obj);
>      struct ifreq ifr;
> --
> 2.20.1
>
>

