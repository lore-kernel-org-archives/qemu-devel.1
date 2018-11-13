Received: from eggs.gnu.org ([2001:4830:134:3::10]:40526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gMVZ2-0006vs-51
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gMVYy-0006Bh-PF
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:04:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gMVYy-0006Az-EP
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:04:52 -0500
References: <20180629145347.652-1-peter.maydell@linaro.org>
	<20180629145347.652-41-peter.maydell@linaro.org>
	<e8d62bcd-f8a9-2a6a-7765-0cf69cc8c1b5@redhat.com>
	<d979b505-7f01-360d-60e1-aee0e497859c@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c453cf1b-888a-66e1-afd8-15460929dd2c@redhat.com>
Date: Tue, 13 Nov 2018 11:04:48 +0100
MIME-Version: 1.0
In-Reply-To: <d979b505-7f01-360d-60e1-aee0e497859c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 40/55] target/arm: Enable SVE for
 aarch64-linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 13/11/2018 10:51, Richard Henderson wrote:
> On 11/12/18 10:10 PM, Laurent Vivier wrote:
>> Running some tests for my pull request, I've found this commit breaks
>> ltp-full-20180515 sigaltstack01 tests with ubuntu arm64/trusty.
> 
> Hmm.  Just noticed this part -- my pass came from ubuntu arm64/bionic.
> Do you believe that the glibc version plays enough of a part in this?

Probably, or the compiler?

$ cat /etc/apt/sources.list
deb http://ports.ubuntu.com/ubuntu-ports/ trusty main

$ dpkg --status gcc  
Package: gcc
Status: install ok installed
Priority: optional
Section: devel
Installed-Size: 41
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: arm64
Source: gcc-defaults (1.124ubuntu6)
Version: 4:4.8.2-1ubuntu6
Provides: c-compiler
Depends: cpp (>= 4:4.8.2-1ubuntu6), gcc-4.8 (>= 4.8.2-5~)
Recommends: libc6-dev | libc-dev
Suggests: gcc-multilib, make, manpages-dev, autoconf, automake1.9, libtool, flex, bison, gdb, gcc-doc
Conflicts: gcc-doc (<< 1:2.95.3)
Description: GNU C compiler
 This is the GNU C compiler, a fairly portable optimizing compiler for C.
 .
 This is a dependency package providing the default GNU C compiler.
Original-Maintainer: Debian GCC Maintainers <debian-gcc@lists.debian.org>

$ dpkg --status libc6
Package: libc6
Status: install ok installed
Priority: required
Section: libs
Installed-Size: 9225
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: arm64
Multi-Arch: same
Source: eglibc
Version: 2.19-0ubuntu6
Provides: glibc-2.19-1
Depends: libgcc1
Suggests: glibc-doc, debconf | debconf-2.0, locales
Breaks: hurd (<< 1:0.5.git20140203-1), nscd (<< 2.19)
Conflicts: prelink (<= 0.0.20090311-1), tzdata (<< 2007k-1), tzdata-etch
Conffiles:
 /etc/ld.so.conf.d/aarch64-linux-gnu.conf d69324714eb19058cc7bb5e854a427ca
Description: Embedded GNU C Library: Shared libraries
 Contains the standard libraries that are used by nearly all programs on
 the system. This package includes shared versions of the standard C library
 and the standard math library, as well as many others.
Homepage: http://www.eglibc.org
Original-Maintainer: GNU Libc Maintainers <debian-glibc@lists.debian.org>

thanks,
Laurent
