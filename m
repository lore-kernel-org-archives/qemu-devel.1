Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3317B206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3317B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoHP-0004Tk-DW
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jgoGZ-0003Yn-PM
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:42:35 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:38198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jgoGY-0004fc-Ag
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:42:35 -0400
Received: from player774.ha.ovh.net (unknown [10.108.57.16])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id AF5B9A490B
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 13:42:24 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id 408631319B8C5;
 Thu,  4 Jun 2020 11:42:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0064213cf25-7820-44ec-a7b8-4b27e9d6576f,
 2E0AA79A099E542C5FE1C9A79F210F9E9C727315) smtp.auth=clg@kaod.org
Subject: Re: [PATCH] ftgmac100: Implement variable descriptor size
To: Erik Smit <erik.lucas.smit@gmail.com>
References: <CA+MHfov0TVbwjy8g_cHVa6Y-bMowCbsGLdt8uUhmcns0v_eVLw@mail.gmail.com>
 <70cece8e-1caf-1387-25e7-971783817cc8@kaod.org>
 <CA+MHfovyMCjqwJ+G3XyRvr5fO60sGff7bwYqSa7a=mFo8CYoSw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7ad445ed-d737-2966-953c-30ab2cca5c51@kaod.org>
Date: Thu, 4 Jun 2020 13:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CA+MHfovyMCjqwJ+G3XyRvr5fO60sGff7bwYqSa7a=mFo8CYoSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16005793079041362723
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeguddggeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeduvdelheeitdduvdektdehfefhvedtvdevvdduffeiffehtdekuddtffffledtjeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhqvghmuhdrohhrghenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.44.197; envelope-from=clg@kaod.org;
 helo=3.mo178.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 07:42:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 12:54 PM, Erik Smit wrote:
> On Wed, 3 Jun 2020 at 10:16, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 6/2/20 6:47 PM, Erik Smit wrote:
>>> The hardware supports variable descriptor sizes, configured with the DBLAC
>>> register.
>>
>> yes.
>>
>> The DBLAC default value is 0x00022F00 on AST2400 and 0x00022500 on AST2500
>> and AST2600. The current reset handler needs a little fix btw.
>>
>> This sets the TX and RX descriptor default size to 4 words (2 * 8bytes).
>>
>>> Most drivers use the default 2*8, which is currently hardcoded in qemu, but
>>> the implementation of the driver in Supermicro BMC SMT_X11_158 uses 4*8.
>>
>> The first 4 words are architected but the specs allows the descriptors
>> to be bigger which is what the Aspeed SDK is doing:
>>
>>         outl( 0x44f97, dev->base_addr + DBLAC_REG );
>>
>> It's using 8 words ( 4 * 8bytes) to store some address in the fifth.
>> This is a waste btw.
>>
>>
>> Thanks for spotting this. I think the patch is correct but we need to
>> clarify a few things.
>>
>>> --
>>> The implementation of the driver in Supermicro BMC SMT_X11_158 adds 4 extra
>>> 4-bytes entries:
>>> https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.h#L387-L391
>>>
>>> And sets DBLAC to 0x44f97:
>>> https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.c#L449
>>>
>>> There's not a lot of public documentation on this hardware, but the
>>> current linux driver shows the meaning of these registers:
>>>
>>> https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/faraday/ftgmac100.c#L280-L281
>>>
>>>         iowrite32(FTGMAC100_DBLAC_RXDES_SIZE(2) |   /* 2*8 bytes RX descs */
>>>                   FTGMAC100_DBLAC_TXDES_SIZE(2) |   /* 2*8 bytes TX descs */
>>>
>>> Without this patch, networking in SMT_X11_158 does not pass data.
>>>
>>> Signed-off-by: Erik Smit <erik.lucas.smit@gmail.com <mailto:erik.lucas.smit@gmail.com>>
>>> ---
>>>  hw/net/ftgmac100.c | 17 +++++++++++++++--
>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
>>> index 25ebee7ec2..1640b24b23 100644
>>> --- a/hw/net/ftgmac100.c
>>> +++ b/hw/net/ftgmac100.c
>>> @@ -79,6 +79,19 @@
>>>  #define FTGMAC100_APTC_TXPOLL_CNT(x)        (((x) >> 8) & 0xf)
>>>  #define FTGMAC100_APTC_TXPOLL_TIME_SEL      (1 << 12)
>>>
>>> +/*
>>> + * DMA burst length and arbitration control register
>>> + */
>>> +#define FTGMAC100_DBLAC_RXFIFO_LTHR(x)      (((x) >> 0) & 0x7)
>>> +#define FTGMAC100_DBLAC_RXFIFO_HTHR(x)      (((x) >> 3) & 0x7)
>>> +#define FTGMAC100_DBLAC_RX_THR_EN           (1 << 6)
>>
>> The above definitions are AST2400 only. We should say so or leave them out
>> because the model does not use them any how.
> 
> Like so?
> 
> #define FTGMAC100_DBLAC_RXFIFO_LTHR(x)      (((x) >> 0) & 0x7)  // AST2400-only
> #define FTGMAC100_DBLAC_RXFIFO_HTHR(x)      (((x) >> 3) & 0x7)  // AST2400-only
> #define FTGMAC100_DBLAC_RX_THR_EN           (1 << 6)            // AST2400-only

yes, but without the C++ comments. Keep the number of chars below 
80 also.

>>
>>> +#define FTGMAC100_DBLAC_RXBURST_SIZE(x)     (((x) >> 8) & 0x3)
>>> +#define FTGMAC100_DBLAC_TXBURST_SIZE(x)     (((x) >> 10) & 0x3)
>>> +#define FTGMAC100_DBLAC_RXDES_SIZE(x)       (((x) >> 12) & 0xf)
>>> +#define FTGMAC100_DBLAC_TXDES_SIZE(x)       (((x) >> 16) & 0xf)
>>
>> I would include '* 8' in the {R,T}XDES_SIZE macros
> 
> Agreed.
> 
>>> +#define FTGMAC100_DBLAC_IFG_CNT(x)          (((x) >> 20) & 0x7)
>>> +#define FTGMAC100_DBLAC_IFG_INC             (1 << 23)
>>> +
>>>  /*
>>>   * PHY control register
>>>   */
>>> @@ -553,7 +566,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
>>>          if (bd.des0 & s->txdes0_edotr) {
>>>              addr = tx_ring;
>>>          } else {
>>> -            addr += sizeof(FTGMAC100Desc);
>>> +            addr += (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac)) * 8;
>>
>> and remove the '* 8' here.
> 
> Agreed.
> 
>>>          }
>>>      }
>>>
>>> @@ -982,7 +995,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>>>          if (bd.des0 & s->rxdes0_edorr) {
>>>              addr = s->rx_ring;
>>>          } else {
>>> -            addr += sizeof(FTGMAC100Desc);
>>> +            addr += (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac)) * 8;
>>>          }
>>>      }
>>>      s->rx_descriptor = addr;
>>
>>
>> and when the DBLAC register is set, we should check the size values to make
>> sure they are not under sizeof(FTGMAC100Desc), in which case we should
>> report an error.
> 
> Like so?

yes.

To be precise, according to the specs :

    Writing 0 to this field is illegal.

which means that the HW can survive with only 2 words in the TX and RX 
descriptors, word0 and word1. word2 is reserved and word3 is architected 
to point to the TX and RX buffers. Without word3, the HW is dropping all
send and received data, which is a bit useless and the receive part in 
the model doesn't support that case. 

I think testing against sizeof(FTGMAC100Desc) is safer for the time being,

> 
>     case FTGMAC100_DBLAC: /* DMA Burst Length and Arbitration Control */
>         s->dblac = value;

I would move the assignment after the tests. 

>         if (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc))
>             qemu_log_mask(LOG_GUEST_ERROR, "%s: transmit descriptor
> too small : %d bytes\n",
>                               __func__, FTGMAC100_DBLAC_TXDES_SIZE(s->dblac));
>         if (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc))
>             qemu_log_mask(LOG_GUEST_ERROR, "%s: receive descriptor too
> small : %d bytes\n",
>                               __func__, FTGMAC100_DBLAC_RXDES_SIZE(s->dblac));
>         break;
you need opening and closing braces and to break out from the switch 
statement in case of error.

> Also, I've not got experience submitting patches to Qemu. My next step
> would be to respin this patch and resend it to everybody as [PATCH
> v2]?

yes. Take a look at : 

	https://wiki.qemu.org/Contribute/SubmitAPatch

The minimum is to run ./scripts/checkpatch.pl before sending any patch. 
The script will tell you what's wrong.

Thanks,

C.

