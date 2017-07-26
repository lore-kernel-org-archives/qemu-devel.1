Received: from eggs.gnu.org ([2001:4830:134:3::10]:52448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daTSA-0007R0-5H
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daTS6-0005un-8s
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:02:46 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daTS6-0005sS-2H
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:02:42 -0400
Received: by mail-qt0-x244.google.com with SMTP id c15so2893042qta.3
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:02:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <65ED9743-B53C-4E6A-866F-C883650914CE@gmail.com>
	<91ba54de-b2eb-f3a9-eb0f-a697b7698149@amsat.org>
	<D06632B7-4405-47C8-BCF6-3C90274923E4@gmail.com>
	<CAFEAcA_BRPRAmA5cJEtsY8zn0K358peX5PzvD05vZys1swo0EQ@mail.gmail.com>
	<AF369030-9AE0-4C46-A416-7B92359C1851@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <76a9f07d-fd95-9b6e-4d2d-4884541239dd@amsat.org>
Date: Wed, 26 Jul 2017 18:02:36 -0300
MIME-Version: 1.0
In-Reply-To: <AF369030-9AE0-4C46-A416-7B92359C1851@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] hw/core/loader-fit.c:105:41: error: expected
 expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 07/26/2017 01:46 PM, Programmingkid wrote:
>> On Jul 26, 2017, at 6:24 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 26 July 2017 at 06:15, Programmingkid <programmingkidx@gmail.com> wrote:
>>>> On Jul 26, 2017, at 12:13 AM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> Hi John,
>>>>
>>>> On 07/25/2017 07:55 PM, Programmingkid wrote:
>>>>> While compiling the mips64el-softmmu target I encountered these errors:
>>>>>   CC      hw/display/g364fb.o
>>>>> hw/core/loader-fit.c:105:41: error: expected expression
>>>>>         *addr = fdt32_to_cpu(*(fdt32_t *)prop);
>>>>>                                         ^
>>>>> hw/core/loader-fit.c:105:32: error: use of undeclared identifier 'fdt32_t'
>>>>
>>>> It seems you are missing the libfdt headers, so indeed you found bug.
>>
>> Configure requires libfdt to exist to enable mips64el-softmmu,
>> so something is going wrong with our configure test compared
>> to how QEMU itself is being built.
>>
>>> That appears to help make things move past the loader-fit.c file. Here are the new errors:
>>>
>>>   CC      hw/core/loader-fit.o
>>>   CC      hw/dma/rc4030.o
>>>   CC      hw/ide/via.o

It looks you ran "make -j3" firing 3 CC tasks.

>>> hw/core/loader-fit.c:105:41: error: expected expression
>>>         *addr = fdt32_to_cpu(*(fdt32_t *)prop);
>>>                                         ^
>>
>> ...this is still failing on loader-fit.c in the same way.
>>
>>>> And also the ./configure output, I'm interested by:
>>>>
>>>> "fdt support       no”
>>>
>>> Actually it was "fdt support       yes”.
>>
>> Configure thinks the fdt headers are available…
> 
> They appear to be available. The dtc/libfdt folder does have the files QEMU uses.
> 
>>
>>> ./configure --target-list=mips64el-softmmu
>>> Install prefix    /usr/local
>>> BIOS directory    /usr/local/share/qemu
>>> binary directory  /usr/local/bin
>>> library directory /usr/local/lib
>>> module directory  /usr/local/lib/qemu
>>> libexec directory /usr/local/libexec
>>> include directory /usr/local/include
>>> config directory  /usr/local/etc
>>> local state directory   /usr/local/var
>>> Manual directory  /usr/local/share/man
>>> ELF interp prefix /usr/gnemul/qemu-%M
>>> Source path       /Users/john/Documents/Development/Projects/Qemu/qemu-git
>>> C compiler        cc
>>> Host C compiler   cc
>>> C++ compiler      c++
>>> Objective-C compiler clang
>>> ARFLAGS           rv
>>> CFLAGS            -O2 -g
>>> QEMU_CFLAGS       -I/usr/local/Cellar/pixman/0.34.0/include/pixman-1 -I$(SRC_PATH)/dtc/libfdt -D_REENTRANT -I/usr/local/Cellar/glib/2.46.2/include
>>
>> ...and it's put our local copy of libfdt on the include path.
>>
>> The fdt32_t type that the compiler is complaining
>> about ought to be defined in the header in
>> dtc/libfdt/libfdt_env.h.
> 
> The fdt32_t type is not there. Here is the full libfdt_env.h file:
> 
> #ifndef _LIBFDT_ENV_H
> #define _LIBFDT_ENV_H
> 
> #include <stddef.h>
> #include <stdint.h>
> #include <string.h>
> 
> #define _B(n)	((unsigned long long)((uint8_t *)&x)[n])
> static inline uint32_t fdt32_to_cpu(uint32_t x)
> {
> 	return (_B(0) << 24) | (_B(1) << 16) | (_B(2) << 8) | _B(3);
> }
> #define cpu_to_fdt32(x) fdt32_to_cpu(x)
> 
> static inline uint64_t fdt64_to_cpu(uint64_t x)
> {
> 	return (_B(0) << 56) | (_B(1) << 48) | (_B(2) << 40) | (_B(3) << 32)
> 		| (_B(4) << 24) | (_B(5) << 16) | (_B(6) << 8) | _B(7);
> }
> #define cpu_to_fdt64(x) fdt64_to_cpu(x)
> #undef _B
> 
> #endif /* _LIBFDT_ENV_H */
> 
> 
>> I wonder if you have an old copy of that submodule;
>> if so then "git submodule update" ought to fix it.
> 
> I’m not sure how to obtain the version of libfdt. I did see a file called version.lds.
> At the top of this file is this text: "LIBFDT_1.2 {"
> So maybe I am using version 1.2. Perhaps the configure test should declare a variable
> of the fdt32_t type in the test code.
> 
> After doing a git submodule update qemu-system-mips64el compiled successfully. Thank you.

Oops I wanted to ask your "git submodule status" output before that, to 
reproduce your bug. Anyway checking out a pre-v1.4.2 is enough.

Peter I guess I found the culprit, compile_prog is not called for dtc 
submodule. I'll send a patch.

Regards,

Phil.
