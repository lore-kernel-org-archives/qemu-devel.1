Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9CD2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9CD2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOaV-0003w2-27
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jgOZq-0002y9-PT
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:16:46 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:54166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jgOZo-0001Up-PX
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:16:46 -0400
Received: from player759.ha.ovh.net (unknown [10.108.54.13])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7D2E113958A
 for <qemu-devel@nongnu.org>; Wed,  3 Jun 2020 10:16:41 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 7676412FF2C50;
 Wed,  3 Jun 2020 08:16:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005e5d11780-1c5a-446e-b0e7-8d6c600b1ffc,C5A150AF1F13250A6CA48450E7A9998CD11FBF1B)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH] ftgmac100: Implement variable descriptor size
To: Erik Smit <erik.lucas.smit@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <CA+MHfov0TVbwjy8g_cHVa6Y-bMowCbsGLdt8uUhmcns0v_eVLw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <70cece8e-1caf-1387-25e7-971783817cc8@kaod.org>
Date: Wed, 3 Jun 2020 10:16:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CA+MHfov0TVbwjy8g_cHVa6Y-bMowCbsGLdt8uUhmcns0v_eVLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6658853527203121955
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepkefhtedufeffvedvleejgeeghedvgeeuieeufeejueeltddugeduhedvveelgfehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.46.122; envelope-from=clg@kaod.org;
 helo=8.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 04:16:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 6:47 PM, Erik Smit wrote:
> The hardware supports variable descriptor sizes, configured with the DBLAC
> register.

yes.

The DBLAC default value is 0x00022F00 on AST2400 and 0x00022500 on AST2500 
and AST2600. The current reset handler needs a little fix btw.

This sets the TX and RX descriptor default size to 4 words (2 * 8bytes). 

> Most drivers use the default 2*8, which is currently hardcoded in qemu, but
> the implementation of the driver in Supermicro BMC SMT_X11_158 uses 4*8.

The first 4 words are architected but the specs allows the descriptors 
to be bigger which is what the Aspeed SDK is doing:

	outl( 0x44f97, dev->base_addr + DBLAC_REG );

It's using 8 words ( 4 * 8bytes) to store some address in the fifth. 
This is a waste btw.


Thanks for spotting this. I think the patch is correct but we need to 
clarify a few things. 

> --
> The implementation of the driver in Supermicro BMC SMT_X11_158 adds 4 extra
> 4-bytes entries:
> https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.h#L387-L391
> 
> And sets DBLAC to 0x44f97:
> https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.c#L449
> 
> There's not a lot of public documentation on this hardware, but the
> current linux driver shows the meaning of these registers:
> 
> https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/faraday/ftgmac100.c#L280-L281
> 
>         iowrite32(FTGMAC100_DBLAC_RXDES_SIZE(2) |   /* 2*8 bytes RX descs */
>                   FTGMAC100_DBLAC_TXDES_SIZE(2) |   /* 2*8 bytes TX descs */
> 
> Without this patch, networking in SMT_X11_158 does not pass data.
> 
> Signed-off-by: Erik Smit <erik.lucas.smit@gmail.com <mailto:erik.lucas.smit@gmail.com>>
> ---
>  hw/net/ftgmac100.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 25ebee7ec2..1640b24b23 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -79,6 +79,19 @@
>  #define FTGMAC100_APTC_TXPOLL_CNT(x)        (((x) >> 8) & 0xf)
>  #define FTGMAC100_APTC_TXPOLL_TIME_SEL      (1 << 12)
> 
> +/*
> + * DMA burst length and arbitration control register
> + */
> +#define FTGMAC100_DBLAC_RXFIFO_LTHR(x)      (((x) >> 0) & 0x7)
> +#define FTGMAC100_DBLAC_RXFIFO_HTHR(x)      (((x) >> 3) & 0x7)
> +#define FTGMAC100_DBLAC_RX_THR_EN           (1 << 6)

The above definitions are AST2400 only. We should say so or leave them out 
because the model does not use them any how.

> +#define FTGMAC100_DBLAC_RXBURST_SIZE(x)     (((x) >> 8) & 0x3)
> +#define FTGMAC100_DBLAC_TXBURST_SIZE(x)     (((x) >> 10) & 0x3)
> +#define FTGMAC100_DBLAC_RXDES_SIZE(x)       (((x) >> 12) & 0xf)
> +#define FTGMAC100_DBLAC_TXDES_SIZE(x)       (((x) >> 16) & 0xf)

I would include '* 8' in the {R,T}XDES_SIZE macros

> +#define FTGMAC100_DBLAC_IFG_CNT(x)          (((x) >> 20) & 0x7)
> +#define FTGMAC100_DBLAC_IFG_INC             (1 << 23)
> +
>  /*
>   * PHY control register
>   */
> @@ -553,7 +566,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
>          if (bd.des0 & s->txdes0_edotr) {
>              addr = tx_ring;
>          } else {
> -            addr += sizeof(FTGMAC100Desc);
> +            addr += (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac)) * 8;

and remove the '* 8' here.

>          }
>      }
> 
> @@ -982,7 +995,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>          if (bd.des0 & s->rxdes0_edorr) {
>              addr = s->rx_ring;
>          } else {
> -            addr += sizeof(FTGMAC100Desc);
> +            addr += (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac)) * 8;
>          }
>      }
>      s->rx_descriptor = addr;


and when the DBLAC register is set, we should check the size values to make 
sure they are not under sizeof(FTGMAC100Desc), in which case we should 
report an error.

Thanks,

C.


