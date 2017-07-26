Received: from eggs.gnu.org ([2001:4830:134:3::10]:57149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daBXc-0006qz-LJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daBXZ-0002Wy-Jv
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:55:12 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daBXZ-0002WY-G4
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:55:09 -0400
Received: by mail-qk0-x242.google.com with SMTP id d136so14288438qkg.3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:55:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
	<20170705075411.6556-2-sameeh@daynix.com>
	<CAFEAcA_tLBx---taBCugWXeRuiJAyUxHdo0d5w9v782zmwOtGQ@mail.gmail.com>
	<150102421956.26979.11807844910746708101@loki>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <915a2000-5535-049e-7e31-d4cb1e5e0314@amsat.org>
Date: Tue, 25 Jul 2017 22:54:59 -0300
MIME-Version: 1.0
In-Reply-To: <150102421956.26979.11807844910746708101@loki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] Makefile: clean: Clean exe files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Sameeh Jubran <sameeh@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>, QEMU Developers <qemu-devel@nongnu.org>

I purposed another fix for Sameeh's issue, see:
http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07597.html

On 07/25/2017 08:10 PM, Michael Roth wrote:
> Quoting Peter Maydell (2017-07-23 15:03:56)
>> On 5 July 2017 at 08:54, Sameeh Jubran <sameeh@daynix.com> wrote:
>>> From: Sameeh Jubran <sjubran@redhat.com>
>>>
>>> Clean exe files such as qemu-ga.exe
>>>
>>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>>> ---
>>>   Makefile | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 16a0430..22d29d6 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -487,6 +487,7 @@ clean:
>>>          rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
>>>          rm -f qemu-options.def
>>>          rm -f *.msi
>>> +       rm -f *${EXESUF}
>>
>> On every host OS except Windows, ${EXESUF} is defined
>> to be the empty string, which means that this will be
>> "rm -f *", which is probably not what we want...
> 
> Perhaps something like:
> 
>    clean:
>      ...
>    ifneq ($(EXESUF),)
>      rm -f *${EXESUF}
>    endif
> 
> ?
> 
>>
>> thanks
>> -- PMM
>>
> 
> 
