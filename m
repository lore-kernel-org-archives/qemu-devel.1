Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FF4C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD8B20868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD8B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40653 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTPZb-0003hD-6C
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:38:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTPYH-00036p-H6
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTPYA-0007c2-Q7
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:36:54 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTPY3-0007WX-51
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:36:45 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1M4rD7-1hSaKY3U6p-0020p1; Wed, 22 May 2019 13:36:29 +0200
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
	<20190517023924.1686-3-richard.henderson@linaro.org>
	<20190521150402.GQ25835@redhat.com>
	<a928e588-63dc-ed4c-fcdc-9001941559fd@linaro.org>
	<20190522105614.GD32359@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <be1ac6b8-5256-865b-43f2-1614607b7061@vivier.eu>
Date: Wed, 22 May 2019 13:36:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190522105614.GD32359@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EXXxL8jeuAEiK25nP3Mgjyno9SiSnKlf4hb7UQ42J1kecDz3TLq
	Ul7Nhs/lMOovHRJU+yfizDWRxQMOvWMCqIa54cIWChThoj9QgBga3RePCTGkSI2ZIxexFUt
	4R+BZalHa59m0Ni4pEW5uaPa2Pl4u/2+2TZ++gQZwA0nYAhvCZiI5dkjXW0IvhchtujC/aT
	JAO+IMgtjDHX4oX9IiCCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LR2DtImCN3o=:WUtvJWdt9EuvvqGnObcdJ7
	w3DFfSE+ePdV/c7MDhnrLER4kNPw/flDutLzmi/dh6j4UK8Rzv6YwXKiObKSWcBoPhfduwSf9
	7/SSoJDmj0fPJj5QwqfvB+KWdB8JdnaVIOV1nN4wSm6kuSLbdSku/ivHdewVN7iohQpqndiAC
	penSG9K16RZXtzMyfXiVdCa1zy0soN+HGa7GyxWUN67hk4MQK3CyrbAu/iX9KTK68fk+1NJJG
	YeTFdFEeLBcVssnALyr7jekJqDK4NeIBqbQK/9wFwxHksNyBUbWxtxYl1XA6mL8lkbnvO8ksC
	u7t17iEpEdyTVccIi0Xjs7r0ww6HYiPsvuKZsMnXaKHWy7poMwwPfuOLkPn283yM4zznusras
	QjT2yh/CJcP16ebDS18OlM3hSgtyhwF3zEXOJ/4IqrpWzUEIMiGSudsJYtjEPSiSgpKXYNO/e
	BnHRlgHpLc46VU67upVJtMhcHMQweQYkoxRv/pUrO0NsE72xSZ3IIL2QNT4lEkKFAoLv/Axmb
	Ikifp6Inxq7ArXRnmtYW2Vdqmj2hn4BO1b6K3RarxqWU1IRuAkplrBm5AYX9fOT1EZ1uqJcqM
	QvbP7RAismfNoMJWY2b9lFIwgoQbxw4g+0QQ9qLQUiWxFTtUgvxHbGNlNzsy1NwbWvjKMovna
	zEDyd0t9wh06wuTCIhoUfHJNVSmTfdAFO5/XdPL6z9i3MgWAa4Q/0JbZRSlSWXEQNnMnDoiNI
	fwA+WNnJxCiSd5MhZP8Y0go9YAaleBaixE1kHXti55Qy4xRzPwGXqzu/YOg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH v8 02/25] build: Link user-only with crypto
 random number objects
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/2019 12:56, Daniel P. Berrangé wrote:
> On Wed, May 22, 2019 at 06:52:45AM -0400, Richard Henderson wrote:
>> On 5/21/19 11:04 AM, Daniel P. Berrangé wrote:
>>> On Thu, May 16, 2019 at 07:39:01PM -0700, Richard Henderson wrote:
>>>> For user-only, we require only the random number bits of the
>>>> crypto subsystem.  Rename crypto-aes-obj-y to crypto-user-obj-y,
>>>> and add the random number objects, plus init.o to handle any
>>>> extra stuff the crypto library requires.
>>>
>>> If you pull in my authz patch first:
>>>
>>>    https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04863.html
>>>
>>> then we can just kill crypto-aes-obj-y entirely, and make
>>> linux-user reference crypto-obj-y as normal. My patch avoids
>>> pulling in PAM, and your previous patch takes care of the
>>> static linking problem.
>>
>> You would think so, wouldn't you.  And yet, not.
>>
>>    CC      authz/base.o
>> /home/rth/qemu/qemu/authz/base.c:23:10: fatal error: trace.h: No such file or
>> directory
>>   #include "trace.h"
>>            ^~~~~~~~~
>> compilation terminated.
>>
>> We're missing some dependency somewhere, and I have no idea what's missing.
>>
>> This for
>>
>> ../qemu/configure --static --disable-system --disable-tools
>>
>> I have a working configuration here in v8.  Can we please leave the bikeshed
>> unpainted for the moment and you can adjust the makefiles as you see fit afterward?
> 
> Yep, ok. I'll be away on holiday for a while so don't have time to look
> into it now. So lets get this merged as is & I'll investigate further
> when I come back.

I thin in Makefile.objs:

   trace-events-subdirs += authz

should be moved out of "ifeq ($(CONFIG_BLOCK),y)".

Thanks,
Laurent


