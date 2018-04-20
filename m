Received: from eggs.gnu.org ([2001:4830:134:3::10]:33465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Jfl-00058M-Ma
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 20:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Jfi-0001vk-GG
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 20:13:05 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9Jfi-0001v0-90
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 20:13:02 -0400
Received: by mail-pf0-x243.google.com with SMTP id g14so3416837pfh.3
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 17:13:02 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0b1a0dd5-4b79-5e60-5b45-8ee8f2de07c8@linaro.org>
Date: Thu, 19 Apr 2018 14:12:56 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/43] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/19/2018 03:58 AM, Alex Bennée wrote:
> I did start playing with crosstool-ng and Linaro's own ABE scripts but
> realised this could end up a massive time sync. What would be really
> helpful is if the respective maintainers could encode their EXACT
> STEPS for building their cross compilers into some docker recipes.

Building a cross-compiler with an existing libc binary is easy.
Building a cross-compiler without a libc is harder, and involves
a bit of two-stepping to get things right.

For someone who has never used docker, what's a recipe look like?
Just a shell script that gets run within a container?
Is there an opportunity to wget or local copy an existing libc
tarball/package to put us into the easy case?

> Finally the end of the series has me adding Emilio's fp-test to the
> per-target builds. Unfortunately although some osdep.h and softfloat.c
> fiddling allows us to build in most cases I still can't build for
> example an i386 fp-test on an x86_64 host using the cross compiler as
> it triggers incompatibilities with config-host.h - in this case Int128
> support. Currently I just hackily disable fp-test for non-64 bit
> platforms.

It seems I can't even build fp-test for x86_64.

  CROSS-BUILD x86_64 guest-tests with cc
In file included from /home/rth/work/qemu/qemu/tests/fp/fp-test.c:14:0:
/home/rth/work/qemu/qemu/include/qemu/osdep.h:30:10: fatal error:
config-host.h: No such file or directory
 #include "config-host.h"
          ^~~~~~~~~~~~~~~
compilation terminated.


r~
