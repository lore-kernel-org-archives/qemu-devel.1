Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F94DC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B01D207DD
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tNtgSPcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B01D207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVywi-0007RX-Fm
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1jVyvp-00070S-P3; Tue, 05 May 2020 10:52:25 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com
 ([40.107.92.85]:6194 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1jVyvo-00038g-4v; Tue, 05 May 2020 10:52:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIIqPcW8ldIrmDVFb6+KHn7yRfQI8FbMYCnRhoze9QQIbxg75Mfib2rcJRvs3ZqVJ56LqMJxeR7y6148DK9CRdGteJJhwyA2Z/gGxMrpZhilV+TdMB6mg6Z4BMXYYEy7EL3I1VuzsDNiITRC+lREniltUp/9pX9dp1yf/h0zV3BAf0BUB0xFAyQHBAXubyUqIEOW27hiw7eU/ervoJfB5e0lMwYoJVMwGoV0IEoverAaf2a/OzGBggPsS5QFknhSxQBkmcSP6qb9P7vMeve7krKzI2poUJFda3divfj3lIiuEGK05uuIw1JGKdi/QYNtGSMbJbmTpSUcacOG955Ehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu1J7mmjH5xr9mlOQhTqyM/P+1F86EcUFbYGFXBUgV0=;
 b=hAo6FaujGnwx1t70s9gdsP8HwwC+vs9V0nnRitelPZONTnHRX2g4g3k3n+AZAeflgKeqofk4qGGAp2MvdbV8ot005fxSyB5Huap0WroyiLadUMrKqq3xJ+4WocJH4N9oYUtoPeJo+TUgRmfMJfbORQCNRSVy4uaVrhMcbi2RHjy49fCLduzE5BAeeKbHt7nCin2fxaRkEHVWlFDa71n8mru8IoNAFW6kTlmUtnG/ISXHgebOa01LITbPErh39TNeyZYwdO0xuG66dq0WOH6ox/hi+A6ADkbKi/N6irPCQXxQtPCf3GANJVgCD8XwAByxhujb9kbd4IlcK9/nCBc9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu1J7mmjH5xr9mlOQhTqyM/P+1F86EcUFbYGFXBUgV0=;
 b=tNtgSPcGEoxmsXfCuZCsdSDleIad6dTbHzUXic5wunueevvuRWLfZHd1L1pCOvYo+mO/tM4NC+mIiamfoCDOhdGOOJ2/PdR7mcXPKj8DBVFeWy3rKYg0SC4RH0DP26Gw1CqKzi9UNBI1Jf5F8/mGmf3qD8JQexSr7xoTCgAhGPs=
Received: from CY4PR22CA0045.namprd22.prod.outlook.com (2603:10b6:903:ed::31)
 by DM6PR02MB4121.namprd02.prod.outlook.com (2603:10b6:5:a6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Tue, 5 May
 2020 14:52:19 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ed:cafe::5f) by CY4PR22CA0045.outlook.office365.com
 (2603:10b6:903:ed::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Tue, 5 May 2020 14:52:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.27 via Frontend Transport; Tue, 5 May 2020 14:52:18 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 5 May 2020 15:52:17 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 5 May 2020 15:52:17 +0100
Received: from [10.71.116.176] (port=51511 helo=localhost)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1jVyvg-0005pF-SL; Tue, 05 May 2020 15:52:17 +0100
Date: Tue, 5 May 2020 16:52:18 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 6/9] hw/net/xilinx_axienet: Handle fragmented packets
 from DMA
Message-ID: <20200505145218.GE2945@toto>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-7-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200430162439.2659-7-edgar.iglesias@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xir-pvapexch01.xlnx.xilinx.com;
 PTR:unknown-80-198.xilinx.com; CAT:NONE; SFTY:;
 SFS:(7916004)(39860400002)(396003)(376002)(136003)(346002)(46966005)(33430700001)(478600001)(1076003)(9786002)(8936002)(186003)(8676002)(47076004)(26005)(82740400003)(70586007)(36906005)(33656002)(82310400002)(9686003)(70206006)(7636003)(316002)(356005)(6916009)(2906002)(107886003)(4326008)(54906003)(33440700001)(7416002)(5660300002)(426003)(336012)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd6f1319-b99a-4669-a729-08d7f103e8c8
X-MS-TrafficTypeDiagnostic: DM6PR02MB4121:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4121AFFD7516839222EBA00CC2A70@DM6PR02MB4121.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:212;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +urTF7orGLH0Jr6i8mFT1gs2A6rntE4Y4P82KwBhfVp7TCrYCKj9YoqIOa5AUWq2wWG/Ojw0OtwT1bgGIewOjFXm9fS1xxei31PaeiRBXIzk0rWxByA1q/Cu2cpNORYC5FswDPX3RP/dyBPyXMoQF6UeFP4Z3cF087FzFaZnKyBMvaH/V49pp/90pUF74cLkXwz5eDgO/LU0QVIWx99cd3TRooqDuIGJCYBoS24K0jSmT3CgONz5n2Z0R9rTHxvEZULicJN0fQNP07b4HtW9tHhMIvPDpcqNq+SWtonmu7B1bp5TRX8W+eRO94zN16N1NOO63Eq5HgFnBOHpm7i/0nA2k3U2m0hmlDdchAarl0BkS6CUyU9scw+QlTLviPLrxWvwPaYdxJQ2vRfXPQ4CRRjvLjiFetzsb9HmPnhn3sy9+pA0uzPlJk/0FCuOVPdZau8U7O4Mssu5+JVcdl9DMHD8IlfsejIAgUqovEC/wKLpeR3KKk7K9Gd3G/oPFBfR++CLVrRsouEFLi8XtTYqp2QwsXY/rM0hw43SdKTcrkKuoq2Yk/1z+AzN17L8jpU1liunVJP7ZW+pT1yF8HgDpA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 14:52:18.5985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6f1319-b99a-4669-a729-08d7f103e8c8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.80.198];
 Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4121
Received-SPF: pass client-ip=40.107.92.85; envelope-from=edgar@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 10:52:21
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com,
 jasowang@redhat.com, alistair@alistair23.me, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 06:24:36PM +0200, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add support for fragmented packets from the DMA.


In v2 I'll add a check in the tx-path for packets larger than c_txmem...

Cheers,
Edgar


> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/net/xilinx_axienet.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index bd48305577..e3826cf3fc 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -402,6 +402,9 @@ struct XilinxAXIEnet {
>  
>      uint32_t hdr[CONTROL_PAYLOAD_WORDS];
>  
> +    uint8_t *txmem;
> +    uint32_t txpos;
> +
>      uint8_t *rxmem;
>      uint32_t rxsize;
>      uint32_t rxpos;
> @@ -421,6 +424,7 @@ static void axienet_rx_reset(XilinxAXIEnet *s)
>  static void axienet_tx_reset(XilinxAXIEnet *s)
>  {
>      s->tc = TC_JUM | TC_TX | TC_VLAN;
> +    s->txpos = 0;
>  }
>  
>  static inline int axienet_rx_resetting(XilinxAXIEnet *s)
> @@ -902,17 +906,28 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
>      XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
>      XilinxAXIEnet *s = ds->enet;
>  
> -    /* We don't support fragmented packets yet.  */
> -    assert(eop);
> -
>      /* TX enable ?  */
>      if (!(s->tc & TC_TX)) {
>          return size;
>      }
>  
> +    if (s->txpos == 0 && eop) {
> +        /* Fast path single fragment.  */
> +        s->txpos = size;
> +    } else {
> +        memcpy(s->txmem + s->txpos, buf, size);
> +        buf = s->txmem;
> +        s->txpos += size;
> +
> +        if (!eop) {
> +            return size;
> +        }
> +    }
> +
>      /* Jumbo or vlan sizes ?  */
>      if (!(s->tc & TC_JUM)) {
> -        if (size > 1518 && size <= 1522 && !(s->tc & TC_VLAN)) {
> +        if (s->txpos > 1518 && s->txpos <= 1522 && !(s->tc & TC_VLAN)) {
> +            s->txpos = 0;
>              return size;
>          }
>      }
> @@ -923,7 +938,7 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
>          uint32_t tmp_csum;
>          uint16_t csum;
>  
> -        tmp_csum = net_checksum_add(size - start_off,
> +        tmp_csum = net_checksum_add(s->txpos - start_off,
>                                      buf + start_off);
>          /* Accumulate the seed.  */
>          tmp_csum += s->hdr[2] & 0xffff;
> @@ -936,12 +951,13 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
>          buf[write_off + 1] = csum & 0xff;
>      }
>  
> -    qemu_send_packet(qemu_get_queue(s->nic), buf, size);
> +    qemu_send_packet(qemu_get_queue(s->nic), buf, s->txpos);
>  
> -    s->stats.tx_bytes += size;
> +    s->stats.tx_bytes += s->txpos;
>      s->regs[R_IS] |= IS_TX_COMPLETE;
>      enet_update_irq(s);
>  
> +    s->txpos = 0;
>      return size;
>  }
>  
> @@ -989,6 +1005,7 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
>      s->TEMAC.parent = s;
>  
>      s->rxmem = g_malloc(s->c_rxmem);
> +    s->txmem = g_malloc(s->c_txmem);
>      return;
>  
>  xilinx_enet_realize_fail:
> -- 
> 2.20.1
> 

