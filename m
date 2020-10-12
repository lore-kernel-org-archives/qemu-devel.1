Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BCAC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC4520757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="W1irhzvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC4520757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0r5-0002lL-Jj
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kS0q7-0002Cx-9H
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:38:23 -0400
Received: from mail-co1nam11on2086.outbound.protection.outlook.com
 ([40.107.220.86]:14624 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kS0q5-0007EC-2y
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:38:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMS8rk9pT0vZ0tJWuZ2NGwVUqbUPorZH7QzIKNNcFQ1YIO0nfwxXL3JRTDEfx0cNIgJlcalKYdYCmi/c6D/d/NJnyFEkfO6131dvZq5c/EmhF4/uplWK1DMTVDIfmytfZzTw50hkWSSIwwM1Z1tfBGOMAOclm9q8HFoGdfbNrQx+D3Y8tksTikONIQ1GSWAa4L66qYCGOMgPfwF7TdmZBpOXh9QBx5VjFuOwlgwjEE5rzEGlhKLJ9qb+2gflEjkwxg1ccdXI4+k48YmyyRIAqdTo1tLBN+xwWUbJTdYqXlVzlCr47jbG6T3IMVPwgVa+o4+aOhSnit8o5Vb+XiB+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH9Y6qCX0WAny7OBppxFa+LFbLfFLUv7ViAuZgfrVco=;
 b=gtAj3tLXcCdpM/hZz3CO7Op9+x6107cFmZIWM1NeBL6GHsrm70s6jnJrWz3050YMFpSz4VinUaTSugiirU3mngwts1bjaJoQhQT7GGbkyqyCQfB47cVj7TyyaGkXbMDinIsUZl0/Z/14dfuEN45pLn4BIYMSWQX/cJ/RJpN90o4SiXjc85LYxmOj2IWwF5ofb8uFgb4OCGE6cPz204rtaCEecg1042aLXKh8lkdo0lQtTRxyNHMoVw2le8RgujivFhRPk6/5Qjw5RXrnBVYrNYGJna2JuaAhWSvRPW8CAnbko34x62vUljXlzhhFmeWz8P6Amb9EV9Qjk5ct+HlfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH9Y6qCX0WAny7OBppxFa+LFbLfFLUv7ViAuZgfrVco=;
 b=W1irhzvbThQDieFMKnvD/zR8koIeA8So4X/2Q67z0j2TIcwWaMN4vLHMaZMARTV70U/cn1RHLo9fTIcsGgTHeAaTWlLA45axjitm7db0iwrBAp38TVD8euSefIScz9XJk89QTj2YBp68IVxN0KyuugbDxMTPZYOWw2R/PwvJa7M=
Received: from MN2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:208:23b::24)
 by BN6PR02MB3267.namprd02.prod.outlook.com (2603:10b6:405:63::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 16:23:14 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23b:cafe::12) by MN2PR11CA0019.outlook.office365.com
 (2603:10b6:208:23b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend
 Transport; Mon, 12 Oct 2020 16:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server id 15.20.3455.25 via Frontend Transport; Mon, 12 Oct 2020 16:23:13
 +0000
Received: from [149.199.38.66] (port=47686 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kS0aj-0008AR-Rj; Mon, 12 Oct 2020 09:22:29 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kS0bR-0002Oo-H2; Mon, 12 Oct 2020 09:23:13 -0700
Received: from [172.19.2.115] (helo=xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kS0bR-0002Ol-8s; Mon, 12 Oct 2020 09:23:13 -0700
Date: Mon, 12 Oct 2020 09:23:13 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 2/3] can-host-socketcan: Fix crash when 'if' option is
 not set
Message-ID: <20201012162312.GA159389@xilinx.com>
References: <20201008202713.1416823-1-ehabkost@redhat.com>
 <20201008202713.1416823-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008202713.1416823-3-ehabkost@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e7186b8-7c4f-4008-2a7a-08d86ecb1e51
X-MS-TrafficTypeDiagnostic: BN6PR02MB3267:
X-Microsoft-Antispam-PRVS: <BN6PR02MB3267573CAF475E0EBD1A9360BC070@BN6PR02MB3267.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHEv9RZpo0dB94S0Zbkjf49cSPU32cRrcpQ3ZHwSNy2QDWwjgcoivw5S620cjwBeYU6n4EdgqY09Ox4iKNjErPeU6YGQS4XYsfbu1qdBiUYMOwIZHjG2LBAQT61om6pkie3Aot1tABVY1u9L75cvlVSU3nhoClvfTG2lglH1ZiCR/w+lGxpP8rUzw56b1dRH7feIKlJpvFtzjzsgYwsslQapCcf9nlH/cbWoD+RJUv0OB79aJXb6ItuMHOPZa1v5pQAvmoMGQ7jsBj9e5OcpIBDZCFpBjtw62arFSosnzSpFBYi61yB8dAUxV0FZxuZ3WHjxSrDOuoTcOre+aDaS0G4dhIJRnX5zL7Qdb4tM9BDLzO4MrVqeBNhVgg6pxdude/wWmv87XEOpWfFaRlu7FgcBrcS5nbDxxPhlgvagx6Q=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(39860400002)(136003)(396003)(346002)(376002)(46966005)(4326008)(6916009)(8676002)(82310400003)(336012)(478600001)(82740400003)(426003)(1076003)(47076004)(2616005)(81166007)(5660300002)(70586007)(186003)(2906002)(356005)(70206006)(8936002)(26005)(316002)(7696005)(36756003)(33656002)(83380400001)(9786002)(54906003)(27376004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:23:13.8867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7186b8-7c4f-4008-2a7a-08d86ecb1e51
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3267
Received-SPF: pass client-ip=40.107.220.86; envelope-from=fnuv@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 12:38:18
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 08, 2020 at 04:27:12PM -0400, Eduardo Habkost wrote:
> Fix the following crash:
>
>   $ qemu-system-x86_64 -object can-host-socketcan,id=obj0
>   Segmentation fault (core dumped)
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> ---
> Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Cc: Vikram Garhwal <fnu.vikram@xilinx.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  net/can/can_socketcan.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
> index 92b1f79385..4b68f60c6b 100644
> --- a/net/can/can_socketcan.c
> +++ b/net/can/can_socketcan.c
> @@ -194,6 +194,11 @@ static void can_host_socketcan_connect(CanHostState *ch, Error **errp)
>      struct sockaddr_can addr;
>      struct ifreq ifr;
>
> +    if (!c->ifname) {
> +        error_setg(errp, "'if' property not set");
> +        return;
> +    }
> +
>      /* open socket */
>      s = qemu_socket(PF_CAN, SOCK_RAW, CAN_RAW);
>      if (s < 0) {
> --
> 2.26.2
>

