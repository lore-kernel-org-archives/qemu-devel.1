Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5641C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08B320866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08B320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3vXC-0000YY-UC
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 02:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3vWa-0008LO-I6; Fri, 07 Aug 2020 02:06:40 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:52341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3vWY-0003Gj-Hh; Fri, 07 Aug 2020 02:06:40 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.139])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 0807D549CC35;
 Fri,  7 Aug 2020 08:06:36 +0200 (CEST)
Received: from kaod.org (37.59.142.104) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 7 Aug 2020
 08:06:35 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00561dd772c-9a9b-4e3c-a3e3-212e93e5c360,
 9C6B65F6CFD3D723D723CC07BEDAC6F805E88D1E) smtp.auth=clg@kaod.org
Subject: Re: [PATCH for-5.2 10/19] ftgmac100: Fix interrupt status "Packet
 transmitted on ethernet"
To: Joel Stanley <joel@jms.id.au>
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-11-clg@kaod.org>
 <CACPK8XdWztzwTfqX5Mkk8wbdrL13nfhw_pTw0R6ra06cOXenBA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <99068335-98a0-c9e5-aacc-e322de8b3a6d@kaod.org>
Date: Fri, 7 Aug 2020 08:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XdWztzwTfqX5Mkk8wbdrL13nfhw_pTw0R6ra06cOXenBA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: bec082d7-91da-4bce-a277-6c80a8558996
X-Ovh-Tracer-Id: 17251882800566668070
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:59:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 1:47 AM, Joel Stanley wrote:
> On Thu, 6 Aug 2020 at 13:21, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> The second field of the TX descriptor has a set of flags to choose
>> when the transmit interrupt is raised : after the packet has been sent
>> on the ethernet or after it has been moved into the TX FIFO. But we
>> don't model that today.
> 
> Does any software depend on this behaviour? 

No. I compared with HW with extra logging.

> Perhaps mention it in the
> commit message so we remember why we changed it.

OK.
 
>> Simply raise the "Packet transmitted on ethernet" the interrupt status
>> bit as soon as the packet is sent by QEMU.
> 
> delete the second 'the'?

sure :)

Thanks,

C. 

> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
>>
>> Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  hw/net/ftgmac100.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
>> index 0348fcf45676..aa3c05ef9882 100644
>> --- a/hw/net/ftgmac100.c
>> +++ b/hw/net/ftgmac100.c
>> @@ -547,9 +547,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
>>              qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_size);
>>              ptr = s->frame;
>>              frame_size = 0;
>> -            if (flags & FTGMAC100_TXDES1_TXIC) {
>> -                s->isr |= FTGMAC100_INT_XPKT_ETH;
>> -            }
>> +            s->isr |= FTGMAC100_INT_XPKT_ETH;
>>          }
>>
>>          if (flags & FTGMAC100_TXDES1_TX2FIC) {
>> --
>> 2.25.4
>>


