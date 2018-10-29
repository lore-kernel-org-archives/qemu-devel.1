Received: from eggs.gnu.org ([2001:4830:134:3::10]:39926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH6dB-0004xt-Az
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH6d7-0000lq-UC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:26:53 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gH6d7-0000jk-7K
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:26:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id l2-v6so2239495wmh.3
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 05:26:49 -0700 (PDT)
References: <1dc0f7d0.1ce87.166bf995fb1.Coremail.wj193102@163.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1dc0f7d0.1ce87.166bf995fb1.Coremail.wj193102@163.com>
Date: Mon, 29 Oct 2018 12:26:46 +0000
Message-ID: <87bm7d9bw9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu3.0.0: Linux on non x86 CPUs run x86 executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wj193102 <wj193102@163.com>
Cc: qemu-devel@nongnu.org


wj193102 <wj193102@163.com> writes:

> Hi, everyone.
>        When I have installed the QEMU3.0.0 in the Linux on non X86 CPUS, =
I want to use user space emulator to run X86 executable. So I get the docum=
ent from the QEMU web page (QEMU document) .
> I find the section 5.3 and read the content. But I have some questions in=
 the following:
> (1)I can't understand the content: "On non x86 CPUs, you need first to do=
wnload at least an x86 glibc (qemu-runtime-i386-XXX-.tar.gz on the QEMU web=
 page). Ensure that LD_LIBRARY_PATH is not set:
> unset LD_LIBRARY_PATH". How I get the X86 glibc? And How to use it?
>        Compiling and installing it in the Linux on non X86 CPUS or
>        not?

The usual way is to create a chroot and install some x86 distro in
there so that it can provide the requisite bits and pieces. The details
vary depending on what chroot you want to setup.

I personally tend to use Debian as it has excellent architecture
support. If you have a working docker setup you can even host your x86
userspace in a docker container which simplifies some aspects.


> (2) I also haven't understood the content:"Then you can launch the
> precompiled ls x86 executable: qemu-i386 tests/i386/ls". The file of
> "ls x86 executable" is in the any Linux from the path "/bin/ls"  on
> the X86 CPUS. Is that right?

Yes. The very simplest case is a statically compiled binaries as you
then don't need to worry about jumping hoops to get the dynamic linker
working.

> Please help me to resolve these questions. Thanks very much.

If you just want to prove you have a working x86 emulation you can just
build the tcg test cases:

cd i386-linux-user
make guest-tests
./qemu-i386 ./tests/linux-test

--
Alex Benn=C3=A9e
