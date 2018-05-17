Received: from eggs.gnu.org ([2001:4830:134:3::10]:46491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKlv-0006l5-1s
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKlq-0000I9-18
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:24:51 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:43320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKlp-0000Hv-Sj
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:24:45 -0400
Received: by mail-qk0-x22c.google.com with SMTP id h19-v6so3914036qkj.10
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 08:24:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180516205543.29305-1-laurent@vivier.eu>
	<20180516205543.29305-6-laurent@vivier.eu>
	<4e676844-2918-77b0-521a-16ded3228de9@amsat.org>
	<62244f16-30e5-3383-249a-a0a932d684d0@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a924ff70-8da7-b754-3c90-269fac47b98d@amsat.org>
Date: Thu, 17 May 2018 12:24:40 -0300
MIME-Version: 1.0
In-Reply-To: <62244f16-30e5-3383-249a-a0a932d684d0@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/8] linux-user: move ppc socket.h
 definitions to ppc/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 05/17/2018 04:17 AM, Laurent Vivier wrote:
> Le 17/05/2018 à 01:17, Philippe Mathieu-Daudé a écrit :
>> On 05/16/2018 05:55 PM, Laurent Vivier wrote:
>>> No code change.
>>>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>  linux-user/generic/sockbits.h |  9 +--------
>>>  linux-user/ppc/sockbits.h     | 19 +++++++++++++++++++
>>>  2 files changed, 20 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
>>> index 093faf0a48..5ad43eb0c8 100644
>>> --- a/linux-user/generic/sockbits.h
>>> +++ b/linux-user/generic/sockbits.h
>>> @@ -30,14 +30,7 @@
>>>  #define TARGET_SO_LINGER       13
>>>  #define TARGET_SO_BSDCOMPAT    14
>>>  /* To add :#define TARGET_SO_REUSEPORT 15 */
>>> -#if defined(TARGET_PPC)
>>> -#define TARGET_SO_RCVLOWAT     16
>>> -#define TARGET_SO_SNDLOWAT     17
>>> -#define TARGET_SO_RCVTIMEO     18
>>> -#define TARGET_SO_SNDTIMEO     19
>>> -#define TARGET_SO_PASSCRED     20
>>> -#define TARGET_SO_PEERCRED     21
>>> -#else
>>> +#ifndef TARGET_SO_PASSCRED /* powerpc only differs in these */
>>
>> #ifndef TARGET_PPC ?
> 
> In fact, I have copied the line from linux, I think it's better to not
> depend on the target but on the value we want to define.

I see, but it isn't safer to define each separately?

/* powerpc only differs in these */
#ifndef TARGET_SO_PASSCRED
# define TARGET_SO_PASSCRED     16
#endif

#ifndef TARGET_SO_PEERCRED
# define TARGET_SO_PEERCRED     17
#endif

#ifndef TARGET_SO_RCVLOWAT
# define TARGET_SO_RCVLOWAT     18
#endif

...

> 
> Thanks,
> Laurent
> 
