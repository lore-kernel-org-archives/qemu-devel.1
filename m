Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BF5C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4CF214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4CF214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdap-0007hH-Ha
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izdZl-0006fE-Md
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izdZk-0007xT-BM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:35:57 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:43553)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izdZe-0006t7-NV; Thu, 06 Feb 2020 04:35:50 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M7bJ5-1itpcH3am5-007zR3; Thu, 06 Feb 2020 10:35:33 +0100
Subject: Re: [PATCH] aspeed/i2c:fix uninitialized variable warning
To: Thomas Huth <thuth@redhat.com>, kuhn.chenqun@huawei.com,
 qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org
References: <20200206040753.42252-1-kuhn.chenqun@huawei.com>
 <3b091938-34a4-0a75-3a86-93195a2382e2@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8cd4dd56-bac9-964b-cab3-1f8918c30328@vivier.eu>
Date: Thu, 6 Feb 2020 10:35:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <3b091938-34a4-0a75-3a86-93195a2382e2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7vRbXmvX6Tyd3fLGHhfU7Y7ofJOyFi6cEHu2uJDDzZq8Ycdiszg
 Uh/QpmAu5wFF6nOOFad4redjvY11dspjZJiqBVpw/fEWZEb1VVmoQ3IX73gnkXsO2yvyF6c
 9vKrecZr5f9oWEJ8DmlMhAgyyplkNc6AvYMaLO6JIUJVLSF/Cp8yk8eD87X6n3Le8kJgHdj
 h1BvV5uRqo+Ya4AMI6UOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Co1mwdfFC4=:zQMsrSG0QB2k0Mj4sVbFs2
 0VTY7hq+P4yPzVLwoMq99WACgwwQ1ba1AqK/2KSPQBk/+xWRjpPU5d4fHto7cNrpypfvz/jKj
 vx/iw4ws3cLllYDdBsQRLqab6dScb1ajeLB+s+5pVlr2PTz4ezzFa60IRaKz2H5r9dnQKOUY1
 VUILKgvB4aJS1cEczP9JmaNG+UaGggNHPX+E3vRDst6d0/x69YfTv4/+MQKZ5Lkq0ZvVEoVh2
 iVL/2FKeYk7HXnl3GpivX0nqO9cr0zfz90tOk/PtZXF1z4WBnLe8LN4cXlL0Kg7G6bTbopuuR
 pl3RCisbCNA9mNxZHMzTg13zR1fiKal4om7TGcf1SYBir4S75mpVzlkG/sj8X0i8RwUNJWqS9
 KFzzXKgllcHi8GOZHA9+V8c3liICdonSP6R9NWbf91cUFc2N0JOBXsm+WqvQz7R6uPMu6fP5x
 8fHpU9UnaGCycZfiOGbt/5uTdhOVCifXflSibWg211TUIXgM1Fs66tmn+1IGT4Cp0CVub9Ekg
 xq7AGXJSjj84hCQZYDfZMbxF8HlGJnKLXPpbsvlQcXNUX42fETzLRlBpKb1PJ7uVP33bW3akh
 j1PVtv7IIyxu8TRjqpLPqk4rzfqvfeACIsYNX/Dj+oyGDO1HE9EX8atSWzgkij/TvNp67Hqwh
 YhHv8sQZsatlYxs+rD3DHiyJjSv5MKHHJIYtRAgXOkoDrekJPSTWa/rnlGk/1Bcbp+NmQB3vw
 u+f5exrlV/iVhzq98Rl9sisr25jLr2BXtcFHFjllughZjG43U/aRUztFakVfR6TzdB8whAD64
 /9en2XYFrhn5ONR+kvcwW3/0m5BS5honFUukoXwRB0njEjr43Hkzu+kVLgO/PGryezEIgLq
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: qemu-trivial@nongnu.org, andrew@aj.id.au,
 Miroslav Rezanina <mrezanin@redhat.com>, zhang.zhanghailiang@huawei.com,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/02/2020 à 09:21, Thomas Huth a écrit :
> On 06/02/2020 05.07, kuhn.chenqun@huawei.com wrote:
>> From: Chen Qun <kuhn.chenqun@huawei.com>
>>
>> Fix warning:
>> hw/i2c/aspeed_i2c.c: In function ‘aspeed_i2c_bus_write’:
>> glib/glib-autocleanups.h:28:3: warning: ‘cmd_flags’ may be
>> used uninitialized in this function [-Wmaybe-uninitialized]
>>    g_free (*pp);
>>    ^~~~~~~~~~~~
>> hw/i2c/aspeed_i2c.c:403:22: note: ‘cmd_flags’ was declared here
>>      g_autofree char *cmd_flags;
>>                       ^~~~~~~~~
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> ---
>>  hw/i2c/aspeed_i2c.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
>> index 9cda968501..fb973a983d 100644
>> --- a/hw/i2c/aspeed_i2c.c
>> +++ b/hw/i2c/aspeed_i2c.c
>> @@ -400,7 +400,7 @@ static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
>>  
>>  static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
>>  {
>> -    g_autofree char *cmd_flags;
>> +    g_autofree char *cmd_flags = NULL;
>>      uint32_t count;
>>  
>>      if (bus->cmd & (I2CD_RX_BUFF_ENABLE | I2CD_RX_BUFF_ENABLE)) {
>>
> 
> Thanks. Looks like the same patch that has been reported already here:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg04492.html
> 
> Could someone please pick this up (e.g. qemu-trivial?)?

I will add the patch from Miroslav in my coming pull request.

Thanks,
Laurent


