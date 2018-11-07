Received: from eggs.gnu.org ([2001:4830:134:3::10]:46497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKM1O-0002yE-IV
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 06:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKM1L-0005ov-UD
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 06:29:18 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKM1L-0005j2-EP
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 06:29:15 -0500
Received: by mail-ot1-x341.google.com with SMTP id g10so14414882otl.12
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 03:29:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1e2ba070.db56.166ed56f891.Coremail.wj193102@163.com>
References: <1e2ba070.db56.166ed56f891.Coremail.wj193102@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Nov 2018 11:28:53 +0000
Message-ID: <CAFEAcA8cahw3r8LVEk=o9DWpBLyoy7VSBvEKC0Rq-+oR94VpHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] The error from compiling QEMU statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wj193102 <wj193102@163.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 November 2018 at 08:43, wj193102 <wj193102@163.com> wrote:
> Hi, everybody.
> I want to compile QEMU statically. But when I make the soure files, I get the error messages. Please help me to resolve them.
> Now I will tell you the steps what I do.
> (1)$ cd qemu-3.0.0
> (2)$ ./configure --prefix=/usr --static

Note that static compilation is only really supported for
building the linux-user emulators, not for the system
emulators. So it's best to pass configure options to tell
it to only build the linux-user emulators, like
--disable-system --disable-tools

(1)/block/file-posix.c:1945: Error: There is an unknown field
'prealloc' in the initializer;
(2)/block/file-posix.c:1946: Error: There is an unknown field 'errp'
in the initializer.

Which compiler is this? Google provides no hits for
this error message, which suggests you're using something
weird, rather than gcc or clang.

thanks
-- PMM
