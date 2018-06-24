Received: from eggs.gnu.org ([2001:4830:134:3::10]:41812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwGL-0002sE-Sy
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwGG-0002wO-Ro
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:04:29 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwGG-0002wF-Mb
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:04:24 -0400
Received: by mail-qt0-x241.google.com with SMTP id l10-v6so9358152qtj.0
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 21:04:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180623215313.1252-1-f4bug@amsat.org>
	<CAMo8BfK3+g-c2C9K9RxiZOAPunGoCHXrdWdz03woAxZ+aM1GUA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f0f6c235-f66c-bd81-0a53-34a9268fdcc0@amsat.org>
Date: Sun, 24 Jun 2018 01:04:19 -0300
MIME-Version: 1.0
In-Reply-To: <CAMo8BfK3+g-c2C9K9RxiZOAPunGoCHXrdWdz03woAxZ+aM1GUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 06/24/2018 12:28 AM, Max Filippov wrote:
> On Sat, Jun 23, 2018 at 2:53 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Xtensa cpu supported:
>> - dc232b
>> - dc233c
>> - csp
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> based on http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06782.html
>>
>> Max: Do we need to use the overlay configuration?
> 
> You'd need to use overlay if you'd build the toolchain.
> Prebuilt toolchains are already configured for specific processors.

I now understand.

These 3 cpu toolchains are now handily accesible:

$ docker run --rm -it qemu:debian-xtensa-cross
root@e0a99f962594:/# xtensa-<tab><tab>
xtensa-csp-elf-addr2line        xtensa-dc232b-elf-gcov-dump
xtensa-csp-elf-ar               xtensa-dc232b-elf-gcov-tool
xtensa-csp-elf-as               xtensa-dc232b-elf-gprof
xtensa-csp-elf-c++filt          xtensa-dc232b-elf-ld
xtensa-csp-elf-cc               xtensa-dc232b-elf-ld.bfd
xtensa-csp-elf-cpp              xtensa-dc232b-elf-nm
xtensa-csp-elf-ct-ng.config     xtensa-dc232b-elf-objcopy
xtensa-csp-elf-elfedit          xtensa-dc232b-elf-objdump
xtensa-csp-elf-gcc              xtensa-dc232b-elf-ranlib
xtensa-csp-elf-gcc-7.3.0        xtensa-dc232b-elf-readelf
xtensa-csp-elf-gcc-ar           xtensa-dc232b-elf-size
xtensa-csp-elf-gcc-nm           xtensa-dc232b-elf-strings
xtensa-csp-elf-gcc-ranlib       xtensa-dc232b-elf-strip
xtensa-csp-elf-gcov             xtensa-dc233c-elf-addr2line
xtensa-csp-elf-gcov-dump        xtensa-dc233c-elf-ar
xtensa-csp-elf-gcov-tool        xtensa-dc233c-elf-as
xtensa-csp-elf-gprof            xtensa-dc233c-elf-c++filt
xtensa-csp-elf-ld               xtensa-dc233c-elf-cc
xtensa-csp-elf-ld.bfd           xtensa-dc233c-elf-cpp
xtensa-csp-elf-nm               xtensa-dc233c-elf-ct-ng.config
xtensa-csp-elf-objcopy          xtensa-dc233c-elf-elfedit
xtensa-csp-elf-objdump          xtensa-dc233c-elf-gcc
xtensa-csp-elf-ranlib           xtensa-dc233c-elf-gcc-7.3.0
xtensa-csp-elf-readelf          xtensa-dc233c-elf-gcc-ar
xtensa-csp-elf-size             xtensa-dc233c-elf-gcc-nm
xtensa-csp-elf-strings          xtensa-dc233c-elf-gcc-ranlib
xtensa-csp-elf-strip            xtensa-dc233c-elf-gcov
xtensa-dc232b-elf-addr2line     xtensa-dc233c-elf-gcov-dump
xtensa-dc232b-elf-ar            xtensa-dc233c-elf-gcov-tool
xtensa-dc232b-elf-as            xtensa-dc233c-elf-gprof
xtensa-dc232b-elf-c++filt       xtensa-dc233c-elf-ld
xtensa-dc232b-elf-cc            xtensa-dc233c-elf-ld.bfd
xtensa-dc232b-elf-cpp           xtensa-dc233c-elf-nm
xtensa-dc232b-elf-ct-ng.config  xtensa-dc233c-elf-objcopy
xtensa-dc232b-elf-elfedit       xtensa-dc233c-elf-objdump
xtensa-dc232b-elf-gcc           xtensa-dc233c-elf-ranlib
xtensa-dc232b-elf-gcc-7.3.0     xtensa-dc233c-elf-readelf
xtensa-dc232b-elf-gcc-ar        xtensa-dc233c-elf-size
xtensa-dc232b-elf-gcc-nm        xtensa-dc233c-elf-strings
xtensa-dc232b-elf-gcc-ranlib    xtensa-dc233c-elf-strip
xtensa-dc232b-elf-gcov
root@e0a99f962594:/# xtensa-

As you said, dc232b is well covered in QEMU and has tests.

I appreciate including the csp cpu because it is big-endian.

dc233c is less useful for testing (closer to the dc232b).

> I didn't try to run it in docker, but it looks like you're doing the
> right thing,
> especially that you see some tests passing.
> 
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

Thanks!

Phil.
