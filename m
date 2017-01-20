Received: from eggs.gnu.org ([2001:4830:134:3::10]:32980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUbSn-0001dk-8x
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUbSj-0006C0-C8
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:50:53 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUbSj-0006Br-5v
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:50:49 -0500
Received: by mail-wm0-x22a.google.com with SMTP id r144so49968911wme.1
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 07:50:48 -0800 (PST)
References: <20170120152141.14276.42073.malonedeb@soybean.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170120152141.14276.42073.malonedeb@soybean.canonical.com>
Date: Fri, 20 Jan 2017 15:50:46 +0000
Message-ID: <87o9z1enmx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1658120] [NEW] building with
 gcc-aarch64-linux-gnu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1658120 <1658120@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


Bilal Amarni <1658120@bugs.launchpad.net> writes:

> Public bug reported:
>
> Hi, while trying to build qemu v2.8.0 with gcc-aarch64-linux-gnu cross-
> compiler I'm getting the following :
>
>
> In file included from /usr/include/x86_64-linux-gnu/sys/syscall.h:31:0,
>                  from /root/qemu/util/compatfd.c:21:
> /root/qemu/util/compatfd.c: In function 'qemu_signalfd':
> /root/qemu/util/compatfd.c:103:19: error: '__NR_signalfd' undeclared (first use in this function)
>      ret = syscall(SYS_signalfd, -1, mask, _NSIG / 8);
>                    ^
> /root/qemu/util/compatfd.c:103:19: note: each undeclared identifier is reported only once for each function it appears in
> /root/qemu/rules.mak:59: recipe for target 'util/compatfd.o' failed
> make: *** [util/compatfd.o] Error 1
>
>
> I had configured it with :
>
> ../configure --target-list=x86_64-linux-user --static --cpu=aarch64
>
> And I'm on :
>
> Linux ubuntu-512mb-fra1-01 4.4.0-59-generic #80-Ubuntu SMP Fri Jan 6
> 17:47:47 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

Do you have:

/usr/include/aarch64-linux-gnu/bits/syscall.h

In your system?

When cross compiling it is these sort of problems come from not having
the architecture specific development files. On Ubuntu you want
something like:

  apt-get build-dep -a arm64 qemu

--
Alex Bennée
