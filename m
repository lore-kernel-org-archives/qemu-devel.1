Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2309F2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2309F2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaekj-0003BW-8m
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 08:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jaekB-0002gj-TS
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:19:43 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:40821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jaekA-0006hE-H4
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:19:43 -0400
Received: from player687.ha.ovh.net (unknown [10.110.208.44])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 8151316738C
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 14:19:31 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id A546F126EBDD1;
 Mon, 18 May 2020 12:19:14 +0000 (UTC)
Subject: Re: [PATCH 04/24] aspeed: Don't create unwanted "ftgmac100",
 "aspeed-mmi" devices
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-5-armbru@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9fc4a6e2-fa90-ba62-91cf-e22eb3ef4cdc@kaod.org>
Date: Mon, 18 May 2020 14:19:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518050408.4579-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9030561680808250288
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddthedghedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.76.148; envelope-from=clg@kaod.org;
 helo=9.mo179.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 08:19:31
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 7:03 AM, Markus Armbruster wrote:
> These devices are optional, and controlled by @nb_nics.
> aspeed_soc_ast2600_init() and aspeed_soc_init() create the maximum
> supported number.  aspeed_soc_ast2600_realize() and
> aspeed_soc_realize() realize only the wanted number.  Works, although
> it can leave unrealized devices hanging around in the QOM composition
> tree.  Affects machines ast2500-evb, ast2600-evb, palmetto-bmc,
> romulus-bmc, swift-bmc, tacoma-bmc, and witherspoon-bmc.
> 
> Make the init functions create only the wanted ones.  Visible in "info
> qom-tree"; here's the change for ast2600-evb:
> 
>      /machine (ast2600-evb-machine)
>        [...]
>        /soc (ast2600-a1)
>          [...]
>          /ftgmac100[0] (ftgmac100)
>            /ftgmac100[0] (qemu:memory-region)
>     -    /ftgmac100[1] (ftgmac100)
>     -    /ftgmac100[2] (ftgmac100)
>     -    /ftgmac100[3] (ftgmac100)
>          /gpio (aspeed.gpio-ast2600)
>          [...]
>          /mii[0] (aspeed-mmi)
>            /aspeed-mmi[0] (qemu:memory-region)
>     -    /mii[1] (aspeed-mmi)
>     -    /mii[2] (aspeed-mmi)
>     -    /mii[3] (aspeed-mmi)
>          /rtc (aspeed.rtc)
> 
> I'm not sure creating @nb_nics devices makes sense.  How many does the
> physical chip provide?

The AST2400, AST2500 SoC have 2 macs and the AST2600 has 4. Each machine
define the one it uses, generally MAC0 but the tacoma board uses MAC3.

Shouldn't the model reflect the real address space independently from
the NIC backends defined on the command line ?  

How should we proceed in such cases ? 

Thanks,

C. 

> 
> Cc: "Cédric Le Goater" <clg@kaod.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/aspeed_ast2600.c | 2 +-
>  hw/arm/aspeed_soc.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 71a0acfe26..0a6a77dd54 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -188,7 +188,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
>                                sizeof(s->wdt[i]), typename);
>      }
>  
> -    for (i = 0; i < sc->macs_num; i++) {
> +    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
>          sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[i]),
>                                sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
>  
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index cf6b6dd116..7ca860392a 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -203,7 +203,7 @@ static void aspeed_soc_init(Object *obj)
>                                sizeof(s->wdt[i]), typename);
>      }
>  
> -    for (i = 0; i < sc->macs_num; i++) {
> +    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
>          sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[i]),
>                                sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
>      }
> 


