Received: from eggs.gnu.org ([2001:4830:134:3::10]:42135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddKM2-0007Cj-KC
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddKLy-0001BR-Fs
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:56:14 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddKLy-000184-AJ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:56:10 -0400
Received: by mail-pf0-x242.google.com with SMTP id j68so2148638pfc.2
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 10:56:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-7-f4bug@amsat.org>
	<9a40c690-0b80-cd34-6129-849703b452e2@amsat.org>
	<87a83reidf.fsf@linaro.org>
	<748298c3-8616-05b7-d4f0-1287c625739a@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cf883887-08ce-a8e1-bd98-cc1746e88790@twiddle.net>
Date: Thu, 3 Aug 2017 10:56:03 -0700
MIME-Version: 1.0
In-Reply-To: <748298c3-8616-05b7-d4f0-1287c625739a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/8] tcg/tci: disable MTTCG if TCI is
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, Jaroslaw Pelczar <j.pelczar@samsung.com>

On 08/03/2017 10:40 AM, Philippe Mathieu-Daudé wrote:
> On 07/26/2017 05:02 AM, Alex Bennée wrote:
>>
>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>
>>> Hi Peter,
>>>
>>> I think this patch belongs to 2.10, as there is no time to fix TCI +
>>> MTTCG. Should I RESEND it alone with "for 2.10" subject?
>>>
>>> One other option might be disable TCI if MTTCG enabled, but there is
>>> no ./configure option for MTTCG while there is for TCI.
>>>
>>> Regards,
>>>
>>> Phil.
>>>
>>> On 06/28/2017 10:02 PM, Philippe Mathieu-Daudé wrote:
>>>> TCI + MTTCG cause strange errors...
>>>>
>>>>     $ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4
>>>> -accel tcg,thread=multi -kernel kernel7.img
>>>>     qemu-system-arm: Guest expects a stronger memory ordering than the host
>>>> provides
>>>>     This may cause strange/hard to debug errors
>>>>     Segmentation fault (core dumped)
>>
>> So this isn't TCI enabling MTTCG by accident - this is the user forcing
>> it when it wouldn't otherwise be enabled. Hence the scary warning...
> 
> Hmmm this is the user enabling TCI, I'm not sure about "forcing it".
> Now MTTCG is enforced by the ./configure and there is no option to disable it.

Er, no.

If you write "-accel tcg" you are not forcing mttcg on.
If you write "-accel tcg,thread=multi" you are forcing it on.
If you write "-accel tcg,thread=single" you are forcing it off.

MTTCG is only enabled by default if TCG_TARGET_DEFAULT_MO is defined, and in
the case of TCI, it is not.


r~
