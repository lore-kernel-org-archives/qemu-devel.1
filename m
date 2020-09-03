Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AF9C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1531A2071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NZldyKBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1531A2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDi2v-00084D-5k
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 01:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kDi2B-0007f9-C9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:43:43 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com
 ([40.107.92.46]:58762 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kDi28-0006Vh-Tn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:43:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mppyGMdNJjI91yDCjW3jQCZ6YoH4eJDA116N1W1xkfTdsBOUFPhz9+7C2wtudqCjkFezmaX2MVYIgOiBXasD36L5+A9u5/B6ndDK21GHfj+ChW/Z4VCw0VVA5Oz4gMzqsWqgLXSznJTqMSiEaJwH4+j1+0gQASgfWptYlfYgBs0Rcu8R7mD4R7L1pAi3wPIHKNCJwHinMBlQfSHY2UBmxhOYVUf3zJ/MXf2xU8KBZMQiwWkTqRRjJBQY2j3NCTEIAMGjKRRdTN/K6yIu5DTRjlR6kyXYljHvV45tGozTN02K/8jSDC9X3b4O2jpKnusHmCltPbMVKGQKDYXWAAMLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i72qooGvkipQGPsH3HQpUWttODDX0Y62v2t0Xf768zg=;
 b=QPJc4Ydkkk0D8GBiSc9WnK3kDeZk+EEcLd1gVHaons6r26zapsiZ+1KdzHG3k2fXDPm9mdLd8b0js5Icscl6QiYr1THxJGoB55hPDynd0mmtEKiHviyxhsHPW3NVmegy8YDS9aAgtb2qDKHj8TU095iyJRMPX09zIBE185WbKi30VBj1NRPhBZbnfJ9v67oDDL9h17+7nAVROnuMWzpWHFlSef4UuvX6OIY/nZSkzZN2/hOfajUj1kUhC7P7JxoLKkA03bUZ6E6BAGBLEIrVHZfwVS7EGxjc9uSEWjsD8FxIgMUwB6qeJNf1ykFsLGAB3Oeyt8fNI3AirdQ/TR7t7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=fel.cvut.cz smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i72qooGvkipQGPsH3HQpUWttODDX0Y62v2t0Xf768zg=;
 b=NZldyKBrgyeqcdyrQb8J4c6e1N/KiW9YSiqAto0vEKtS3nDDQkoD2VSiysBLGNKzZA10FHOKppOzpEuP3ENtio6+XS4AGscyHMjiX4BeUCwUpCBAmI5wIS/Sb/ZLvVCf4x+bjUYFExYdrMFbWquzccopv0wy+KAcuGRbcQkZWCE=
Received: from SN2PR01CA0053.prod.exchangelabs.com (2603:10b6:800::21) by
 CY4PR02MB3159.namprd02.prod.outlook.com (2603:10b6:910:79::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Thu, 3 Sep 2020 05:43:38 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::e5) by SN2PR01CA0053.outlook.office365.com
 (2603:10b6:800::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Thu, 3 Sep 2020 05:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; fel.cvut.cz; dkim=none (message not signed)
 header.d=none;fel.cvut.cz; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server id 15.20.3326.21 via Frontend Transport; Thu, 3 Sep 2020 05:43:37
 +0000
Received: from [149.199.38.66] (port=51769 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDi1y-00062G-MX; Wed, 02 Sep 2020 22:43:30 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDi24-0000WR-0u; Wed, 02 Sep 2020 22:43:36 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0835hYMZ032134; 
 Wed, 2 Sep 2020 22:43:35 -0700
Received: from [172.19.2.115] (helo=xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kDi22-0000WO-Qr; Wed, 02 Sep 2020 22:43:34 -0700
Date: Wed, 2 Sep 2020 22:43:34 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: pisa@cmp.felk.cvut.cz
Subject: Re: [PATCH v1 3/6] net/can: Add can_dlc2len and can_len2dlc for CAN
 FD.
Message-ID: <20200903054329.GA405867@xilinx.com>
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
 <30758547c49f254b3965fc12500735bea8265c97.1594725647.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30758547c49f254b3965fc12500735bea8265c97.1594725647.git.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2db091a-e714-4aee-4121-08d84fcc4df1
X-MS-TrafficTypeDiagnostic: CY4PR02MB3159:
X-Microsoft-Antispam-PRVS: <CY4PR02MB315919764EEF1F82E81C2C1FBC2C0@CY4PR02MB3159.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0pBYmlPzKdmYFoED3TRLL9hTP4+bnRjUGRY1iw372+ZApm1pmLia/P/4eKOAKEzTMJsOs/AYEiH+rv3oA6II6JqITxK7VLDRyj9oTugvJW2h1IYwA+8S//dr2UEZjQ3FfJie6t/oN97QHv6cSBX3Hh5oMEsO3MwTmQDfKIP2nOpkmkBKtr37UBIYt49lXmjxGr4RazNM+D3luH1oayFgAAhjdibH4gDP040G5Tuu3pvJa7TPyYKNCq2dDOrpNerAOTePcFtjspousqFlrklnmoJk66SD5apo4tKgJiT+O/cZWmHMj2OAIANA0b3zbtuRwhyow5pYvWsRr2P8shTQov+qNj31MUf931omPBfpMv4CjepIRNXKV7Jlq4Ox8k3VjYFEDl9FW5q+bKJS61JrZMfn0OEHVX1ZB/MP1Z85SM=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(376002)(346002)(39860400002)(136003)(46966005)(82310400003)(7416002)(8936002)(8676002)(9786002)(478600001)(356005)(81166007)(6916009)(2906002)(70206006)(70586007)(5660300002)(82740400003)(316002)(36756003)(2616005)(7696005)(26005)(54906003)(426003)(4326008)(336012)(1076003)(186003)(47076004)(33656002)(27376004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 05:43:37.2314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2db091a-e714-4aee-4121-08d84fcc4df1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3159
Received-SPF: pass client-ip=40.107.92.46; envelope-from=fnuv@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:43:39
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

On Tue, Jul 14, 2020 at 02:20:16PM +0200, pisa@cmp.felk.cvut.cz wrote:
Hi Pavel,
> From: Jan Charvat <charvj10@fel.cvut.cz>
>
> Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  include/net/can_emu.h |  4 ++++
>  net/can/can_core.c    | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/include/net/can_emu.h b/include/net/can_emu.h
> index c6164dcfb4..7d395fbb9b 100644
> --- a/include/net/can_emu.h
> +++ b/include/net/can_emu.h
> @@ -127,4 +127,8 @@ int can_bus_client_set_filters(CanBusClientState *,
>                                 const struct qemu_can_filter *filters,
>                                 size_t filters_cnt);
>
> +uint8_t can_dlc2len(uint8_t can_dlc);
> +
> +uint8_t can_len2dlc(uint8_t len);
> +
These function are aimed for canfd. Perhaps rename these to canfd_dlc2len and
canfd_len2dlc for better distinction?
Rest of the patch looks good to me.
>  #endif
> diff --git a/net/can/can_core.c b/net/can/can_core.c
> index 90f4d8576a..0115d78794 100644
> --- a/net/can/can_core.c
> +++ b/net/can/can_core.c
> @@ -33,6 +33,42 @@
>  #include "net/can_emu.h"
>  #include "qom/object_interfaces.h"
>
> +/* CAN DLC to real data length conversion helpers */
> +
> +static const uint8_t dlc2len[] = {
> +    0, 1, 2, 3, 4, 5, 6, 7,
> +    8, 12, 16, 20, 24, 32, 48, 64
> +};
> +
> +/* get data length from can_dlc with sanitized can_dlc */
> +uint8_t can_dlc2len(uint8_t can_dlc)
> +{
> +    return dlc2len[can_dlc & 0x0F];
> +}
> +
> +static const uint8_t len2dlc[] = {
> +    0, 1, 2, 3, 4, 5, 6, 7, 8,                              /* 0 - 8 */
> +    9, 9, 9, 9,                                             /* 9 - 12 */
> +    10, 10, 10, 10,                                         /* 13 - 16 */
> +    11, 11, 11, 11,                                         /* 17 - 20 */
> +    12, 12, 12, 12,                                         /* 21 - 24 */
> +    13, 13, 13, 13, 13, 13, 13, 13,                         /* 25 - 32 */
> +    14, 14, 14, 14, 14, 14, 14, 14,                         /* 33 - 40 */
> +    14, 14, 14, 14, 14, 14, 14, 14,                         /* 41 - 48 */
> +    15, 15, 15, 15, 15, 15, 15, 15,                         /* 49 - 56 */
> +    15, 15, 15, 15, 15, 15, 15, 15                          /* 57 - 64 */
> +};
> +
> +/* map the sanitized data length to an appropriate data length code */
> +uint8_t can_len2dlc(uint8_t len)
> +{
> +    if (unlikely(len > 64)) {
> +        return 0xF;
> +    }
> +
> +    return len2dlc[len];
> +}
> +
>  struct CanBusState {
>      Object object;
>
> --
> 2.20.1
>
>

