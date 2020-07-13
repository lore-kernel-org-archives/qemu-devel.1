Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1808FC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AD92065D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AD92065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutyi-0007g2-6u
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1juty9-0007B4-Ra
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:37:49 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:36301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1juty7-0008Lx-DV
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:37:49 -0400
Received: from player738.ha.ovh.net (unknown [10.108.35.12])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id DE956146F54
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:37:43 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 411C41468140A;
 Mon, 13 Jul 2020 08:37:41 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001c1bef1ea-6339-4ac1-a142-6c8ffd8a858d,29C60B8BFD44B6CD822E82BF6A6060F4508BB267)
 smtp.auth=clg@kaod.org
Subject: Re: hw/misc/aspeed_scu: 5d971f9e breaks Supermicro AST2400
To: Erik Smit <erik.lucas.smit@gmail.com>
References: <CA+MHfoubt1g2FzcjTw3a0vNr7X2T8Jb+nYoc4_x=Z2TP51afKg@mail.gmail.com>
 <a7acba46-5a9a-5dd2-71c6-7e4586485823@amsat.org>
 <CA+MHfot6FdS2yT0mEsCW36bCfwy-WY-1KPQ-KDfYBKzTy=Gd7w@mail.gmail.com>
 <CACPK8Xdqr+EufMgooCY=D+Vt98qu11YTHE5Fzi5+xqX=wKReeQ@mail.gmail.com>
 <CA+MHfouin6Zmz+GrjWRCc_WzPF=ff-z_5V7BLv0HkL+SW9bRoQ@mail.gmail.com>
 <8879bfee-752b-c4e2-7646-c42dec84a440@kaod.org>
 <CA+MHfou6ijtwjzWye6CKaqTa4sKxF1WmgH9juaSdO344uP2UZA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2c326d1c-3b91-96f4-20c0-2e2e1be9b2ad@kaod.org>
Date: Mon, 13 Jul 2020 10:37:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CA+MHfou6ijtwjzWye6CKaqTa4sKxF1WmgH9juaSdO344uP2UZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2114158550930459456
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrvdekgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.40.148; envelope-from=clg@kaod.org;
 helo=5.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 04:37:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 7/13/20 10:06 AM, Erik Smit wrote:
> Hi Cédric,
> 
> On Mon, 13 Jul 2020 at 09:52, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> With this patch, the supermicro firmware boots further but there is still
>> an issue. It might be the flash definition I used. The machine is detected
>> as an AST2300 SoC which is weird.
> 
>> BMC flash ID:0x19ba20
>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> The firmware is expecting the flash ID to repeat. The following makes it boot.

That doesn't work for me.

C.

> Not sure if this is the right way to go.
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 8227088441..5000930800 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -1041,7 +1041,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>              s->data[i] = s->pi->id[i];
>          }
>          for (; i < SPI_NOR_MAX_ID_LEN; i++) {
> -            s->data[i] = 0;
> +            s->data[i] = s->pi->id[i % s->pi->id_len];
>          }
> 
>          s->len = SPI_NOR_MAX_ID_LEN;
> 


