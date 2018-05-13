Received: from eggs.gnu.org ([2001:4830:134:3::10]:55701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fHsEu-0006rG-8m
	for qemu-devel@nongnu.org; Sun, 13 May 2018 10:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fHsEt-0000Xz-DT
	for qemu-devel@nongnu.org; Sun, 13 May 2018 10:44:44 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fHsEt-0000Xa-97
	for qemu-devel@nongnu.org; Sun, 13 May 2018 10:44:43 -0400
Received: by mail-oi0-x244.google.com with SMTP id c203-v6so8551615oib.7
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 07:44:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
References: <20180513090613.27960-1-sw@weilnetz.de>
	<cc3f26a7-a8b7-35a8-9ffa-c5940c9c1927@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 13 May 2018 15:44:21 +0100
Message-ID: <CAFEAcA9amm4vv5aGR-Aj8=iGKACS78Sb-J9kU2YH-UTbeT6sdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] disas/libvixl: Fix VIXL_FALLTHROUGH macro
 for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 13 May 2018 at 10:57, Stefan Weil <sw@weilnetz.de> wrote:
> Am 13.05.2018 um 11:06 schrieb Stefan Weil:
>> It now prevents compiler warnings (enabled with -Wimplicit-fallthrough=
>> or -Wextra) as intended.
>>
>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>> ---
>>
>> I suggest to add and use a similar macro QEMU_FALLTHROUGH()
>> for the rest of the code and can provide a patch if that's
>> fine for everyone.
>>
>> Regards
>> Stefan
>>
>>  disas/libvixl/vixl/globals.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/disas/libvixl/vixl/globals.h b/disas/libvixl/vixl/globals.h
>> index 61dc9f7f7e..33c4231d91 100644
>> --- a/disas/libvixl/vixl/globals.h
>> +++ b/disas/libvixl/vixl/globals.h
>> @@ -112,6 +112,8 @@ inline void USE(T1, T2, T3, T4) {}
>>  // C++11(201103L).
>>  #if __has_warning("-Wimplicit-fallthrough") && __cplusplus >= 201103L
>>    #define VIXL_FALLTHROUGH() [[clang::fallthrough]] //NOLINT
>> +#elif defined(__GNUC__)
>> +  #define VIXL_FALLTHROUGH() __attribute__((fallthrough))
>>  #else
>>    #define VIXL_FALLTHROUGH() do {} while (0)
>>  #endif
>
>
> Even with the above patch, disas/libvixl raises a compiler warning for a
> fall through case. The patch below fixes that warning, but I am not sure
> whether a fall through is correct there.

This sort of question is probably best asked of upstream
VIXL, rather than here...

thanks
-- PMM
