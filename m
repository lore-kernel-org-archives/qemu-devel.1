Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9795C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 07:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C596F20693
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 07:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C596F20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i68f9-00073s-Sf
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 03:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i68e5-0006X7-KM
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i68e2-0001xJ-Hm
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:27:01 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:51474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i68e1-0001e5-VD
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:26:58 -0400
Received: from player695.ha.ovh.net (unknown [10.108.57.95])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 6A7B1109E19
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 09:26:49 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id 8C72B966DABC;
 Fri,  6 Sep 2019 07:26:44 +0000 (UTC)
To: Joel Stanley <joel@jms.id.au>, Amithash Prasad <amithash@fb.com>
References: <20190906011010.1135084-1-amithash@fb.com>
 <CACPK8Xds26gq=e=7D9qtPJ4FOvhHb0Q-_Chj_MFHcWO99EBcwg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <773184fa-ade7-f1f8-491f-b2c0b16b5a9a@kaod.org>
Date: Fri, 6 Sep 2019 09:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xds26gq=e=7D9qtPJ4FOvhHb0Q-_Chj_MFHcWO99EBcwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 736338542352173888
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejkedgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.238
Subject: Re: [Qemu-devel] [PATCH] Check correct register for clock source
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/09/2019 03:16, Joel Stanley wrote:
> On Fri, 6 Sep 2019 at 01:10, Amithash Prasad <amithash@fb.com> wrote:
>>
>> When WDT_RESTART is written, the data is not the contents
>> of the WDT_CTRL register. Hence ensure we are looking at
>> WDT_CTRL to check if bit WDT_CTRL_1MHZ_CLK is set or not.
>>
>> Signed-off-by: Amithash Prasad <amithash@fb.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Thanks for the patch!

yes. I have pushed it on the aspeed-4.2 branch but it can go independently
as there are no conflicts. I changed the title slightly to reflect the
area being changed.

On the clock topic, we should consider looking at the "Clock framework API" 
from  Damien Hedde :

	http://patchwork.ozlabs.org/cover/1157671/

Thanks,

C. 

> 
>> ---
>>  hw/watchdog/wdt_aspeed.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
>> index 9b93213417..f710036535 100644
>> --- a/hw/watchdog/wdt_aspeed.c
>> +++ b/hw/watchdog/wdt_aspeed.c
>> @@ -140,7 +140,7 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
>>      case WDT_RESTART:
>>          if ((data & 0xFFFF) == WDT_RESTART_MAGIC) {
>>              s->regs[WDT_STATUS] = s->regs[WDT_RELOAD_VALUE];
>> -            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
>> +            aspeed_wdt_reload(s, !(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK));
>>          }
>>          break;
>>      case WDT_CTRL:
>> --
>> 2.21.0
>>


