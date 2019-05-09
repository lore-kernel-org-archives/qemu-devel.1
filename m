Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B5C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4622216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4622216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51058 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeyR-0006F8-Tk
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 05:04:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOexT-0005vV-Pp
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOexQ-0005XZ-9E
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:03:19 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOexQ-0005WS-0I
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:03:16 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1Mg6Na-1gngFI14lq-00haqH; Thu, 09 May 2019 11:03:06 +0200
To: Peter Maydell <peter.maydell@linaro.org>, Erik Kline <ek@loon.com>
References: <20190423222005.246981-1-ek@google.com>
	<CAFEAcA_C4BQgYmZrzFZ_bwWVWcfcV1NF_PWp1wHsvqB9iPu0kQ@mail.gmail.com>
	<CAAedzxpgv9A9cFbsDynCcZKxyDkQ0dL+m60ckwWcfD=j8TmSHw@mail.gmail.com>
	<CAFEAcA9BTg7E=Yq3TxO2G88Qgi=K5Q3tPvw0sVPW4q=tFc5EtQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e487f045-4238-3226-8ec8-2d6f332be1e9@vivier.eu>
Date: Thu, 9 May 2019 11:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9BTg7E=Yq3TxO2G88Qgi=K5Q3tPvw0sVPW4q=tFc5EtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uCRtLhwHHU9aFSTMCwC2iot3SkF1OQjT0QoRlI/EuYpSDJh7suM
	4B+pJTTvR7tCDABUIC3QbElawSRfYgiMTP8weRWRYuCxgyY6RZr6b7J+qDqWFvELcFYXwqu
	Cw/Dvmez7wUjnvfP6816UQsC6Z5y650rf1bp8EldjmuymPHl6njY/djtfX4m5i5QKhLEv/5
	sb0WOMEFKJyCKT1g1tdRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IW2GmO3a8rw=:4CM/kQ82tSL4EXQb5aCQkX
	gOHmhFu5rrAzvCRI29IlhIhf5YNmt7b1Zmqwot1ahLlGUzexwedGEfnjcr6gggrKUEkS49bb+
	8SajkZfuOjOyBPIppivR5w+/A8nll+5HvjAAqRzXFXGzc/FCEKfghzFhR7mBR6TBfMn2xCCF+
	dtLM264W8FRAm6BN2Q+WDyj6CSIJyyJIBj0ye8Wm8f5+QXxAuJo7YUxQhM42fp/QlVkiaHEHh
	UrnYOPuJS9BKih02FXyshb2KdxxwRILzgKNzdHrifbVWkuZSVb7CIhVLeYjFtWKM7cHWgthaG
	SjFsb6TUP9TGQznJRPC43ImD7LazXdfw1XXMNAo7IsNccEVKal9EWuOytfjgOhr/VMf1EVo5h
	WfQnMvYzx50ZtAEu3sq0yvRy1teukMc7lZVNLWMpHQJphtm7RS1eEnuTUubNHYx1f4D9DnlfE
	mcbRbchuO3LzYD83LX5yVkHrgks2ZgEdalg0gVJqUN/DXYBAgQ29EZmuds7EfzbKPBuojn0lE
	T+LgEiKwoJjzsAnpjY7Ct7ss7LZmpTI4j6UwNNPKig5d5CO+wDr4JiuYlhV08Pn8+A0RHam0x
	3u+jXKY/D7qVDdh646Lf7UYxLxLHCQpXieS2QHOjguP5kX9GiA7WCyp+6Cz1b2V1yniz3CxAV
	+GCaHNY1jp5ZYZj9GGqudPpA5Wcgj/RztK7I5JblVmMjh4uSKRkW50/belcnl16mwVgPydh47
	ozKL9DMovcXuScskgkesKgKjbaDYgW+8xRnE8YXJzj+FlWocgsiE30qv7/Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH] The ioctl(SIOCGIFNAME) call requires a
 struct ifreq.
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/05/2019 10:55, Peter Maydell wrote:
> Ah, just noticed the linux-user maintainers weren't
> cc'd on this patch. Laurent, could you pick this patch up,
> please?

Applied to my linux-user branch.

Thanks,
Laurent

> 
> thanks
> -- PMM
> 
> On Wed, 8 May 2019 at 23:54, Erik Kline <ek@loon.com> wrote:
>>
>> Anything else I need to do?
>>
>> On Wed, 24 Apr 2019 at 02:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>> On Tue, 23 Apr 2019 at 23:28, Erik Kline via Qemu-devel
>>> <qemu-devel@nongnu.org> wrote:
>>>>
>>>> Signed-off-by: Erik Kline <ek@google.com>
>>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1814352
>>>> ---
>>>>   linux-user/ioctls.h | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
>>>> index ae8951625f..37501f575c 100644
>>>> --- a/linux-user/ioctls.h
>>>> +++ b/linux-user/ioctls.h
>>>> @@ -178,7 +178,7 @@
>>>>   #endif /* CONFIG_USBFS */
>>>>
>>>>     IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
>>>> -  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
>>>> +  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
>>>>     IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
>>>>     IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
>>>>     IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
>>>> --
>>>> 2.21.0.593.g511ec345e18-goog
>>>>
>>>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>
>>> thanks
>>> -- PMM


