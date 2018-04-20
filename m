Received: from eggs.gnu.org ([2001:4830:134:3::10]:34518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9dOC-0001uf-Ha
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 17:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9dO9-00089v-7X
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 17:16:16 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:45277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9dO9-00087F-1X
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 17:16:13 -0400
Received: by mail-pl0-x230.google.com with SMTP id w22-v6so1325100pll.12
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 14:16:12 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-27-alex.bennee@linaro.org>
	<3765e085-c4e5-44a4-5986-41b233be4d22@linaro.org>
	<87r2na9tq6.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <120fbfa4-a1f7-54c8-9172-bb6f2a7b524a@linaro.org>
Date: Fri, 20 Apr 2018 11:16:06 -1000
MIME-Version: 1.0
In-Reply-To: <87r2na9tq6.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 26/43] tests/tcg/arm: fix up
 test-arm-iwmmxt test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On 04/19/2018 10:18 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 04/19/2018 03:58 AM, Alex Bennée wrote:
>>> +test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs
>>> +test-arm-iwmmxt: test-arm-iwmmxt.S
>>
>> This appears to be insufficient.
>> If I begin with armv7l-linux-gnueabihf-gcc, then I get
>>
>>   CROSS-BUILD arm guest-tests with armv7l-linux-gnueabihf-gcc
>> cc1: error: iWMMXt and NEON are incompatible
> 
> Was this with the docker fall-back?

No, apparently my docker install is "sudo", and so is unused.

> It worked with my local:
> 
> 07:37:25 [alex@zen:~/l/q/qemu.git] softmmu/demacro-cputlb-rfc + arm-linux-gnueabihf-gcc --version
> arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
> Copyright (C) 2015 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

My arm cross is self-built, with configure options mirroring a native fedora
arm gcc:

Target: armv7l-linux-gnueabihf
Configured with: ../comb/configure --with-sysroot
--prefix=/home/rth/work/gcc/run-cross --enable-languages=c,c++,lto
--target=armv7l-linux-gnueabihf --with-system-zlib --enable-__cxa_atexit
--enable-gnu-unique-object --enable-linker-build-id
--with-linker-hash-style=gnu --enable-initfini-array --with-cpu=cortex-a15
--with-float=hard --with-fpu=neon-vfpv4 --with-abi=aapcs-linux
Thread model: posix
gcc version 7.0.0 20161220 (experimental) [master revision
f7619de:63fb493:269ead384b0fdd3dd4f7030be44e54e5a19c4e8c] (GCC)


r~
