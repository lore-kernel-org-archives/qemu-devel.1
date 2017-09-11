Received: from eggs.gnu.org ([2001:4830:134:3::10]:46757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drPKk-0003EE-Pm
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drPKf-0001gN-76
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:05:06 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drPKf-0001fd-1t
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:05:01 -0400
Received: by mail-qk0-x242.google.com with SMTP id r66so5308260qke.4
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 07:05:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499765477-10541-1-git-send-email-thuth@redhat.com>
	<20170711185511.3033-1-f4bug@amsat.org>
	<db1350c0-192f-ab32-250a-2fd234ebe68e@redhat.com>
	<4a1e2715-7811-c4ed-d76b-d49471eabafd@redhat.com>
	<2d25cf14-be6c-4cdd-b324-4d203858e499@redhat.com>
	<ee46c331-56ff-0762-d4e5-02bb04eba6b5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <559262bf-5223-d1e9-6a99-867057b8a2c7@amsat.org>
Date: Mon, 11 Sep 2017 11:04:55 -0300
MIME-Version: 1.0
In-Reply-To: <ee46c331-56ff-0762-d4e5-02bb04eba6b5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: move atomic_template.h to accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

>>>> On 11.07.2017 20:55, Philippe Mathieu-Daudé wrote:
>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>> ---
>>>>> same as Thomas previous patch. this file had no entry in MAINTAINERS.
>>>>>
>>>>>   atomic_template.h => accel/tcg/atomic_template.h | 0
>>>>>   1 file changed, 0 insertions(+), 0 deletions(-)
>>>>>   rename atomic_template.h => accel/tcg/atomic_template.h (100%)
>>>>>
>>>>> diff --git a/atomic_template.h b/accel/tcg/atomic_template.h
>>>>> similarity index 100%
>>>>> rename from atomic_template.h
>>>>> rename to accel/tcg/atomic_template.h
>>>>
>>>> It's also used by a file in tcg/, but I've checked, and yes, the code
>>>> still compiles fine if the header gets moved to accel/tcg/.
>>>>
>>>> Tested-by: Thomas Huth <thuth@redhat.com>
>>>>
>>>
>>> That part of tcg/tcg-runtime.c probably should be moved to user-exec.c,
>>> and user-exec.c should in turn be in accel/tcg.
>>>
>>> Since this is just code movement we can do it after soft freeze.
>>> Philippe, can you send v2?
>>
>> Ping?
>>
>> Looks like the atomic_template.h is still in the main directory ...
> 
> Still waiting for v2...

I chat with Thomas last night about it, with 2.10 freeze I totally 
forgot about this, sorry! I'll respin v2 during the day.
