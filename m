Received: from eggs.gnu.org ([2001:4830:134:3::10]:36611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fS5d5-0005k2-2G
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 15:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fS5d1-0007ww-U6
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 15:03:55 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fS5d1-0007wT-N9
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 15:03:51 -0400
Received: by mail-pf0-x242.google.com with SMTP id z24-v6so9086796pfe.7
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 12:03:51 -0700 (PDT)
References: <20180610030220.3777-1-richard.henderson@linaro.org>
	<20180610030220.3777-10-richard.henderson@linaro.org>
	<CAFEAcA8+NuuT_TDkQuh=C9Mo3xod=745fSTjSP7umSUrt8PFBg@mail.gmail.com>
	<CAFEAcA-ugGMyvJDizrDC51co_L5aF=BS0zZ98kvo_VE9JOLGOQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4009f62a-a5b0-d2aa-7d81-dfc73b301e6c@linaro.org>
Date: Sun, 10 Jun 2018 09:03:45 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ugGMyvJDizrDC51co_L5aF=BS0zZ98kvo_VE9JOLGOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 009/108] linux-user: Set up
 infrastructure for table-izing syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 06/10/2018 02:39 AM, Peter Maydell wrote:
> It would be cleaner to have a single
> #if something
> static foo_impl(..) { ... }
> static syscall_impl foo = {
>     .name = "foo",
>     .impl = foo_impl,
>     .strace_stuff = ...,
> };
> register_syscall(foo);
> #endif
> 
> Hash table?

It would be cleaner to have everything in one place, yes.  I just replied along
those lines elsewhere in the thread.

Indeed, now that I'm thinking along the lines of strace, I'm thinking that
there should be a separate argument extraction step that would be shared by
both strace and syscall implementation.

I'm not a fan of register_syscall(foo) and the startup costs that implies.

The set of syscalls that we support is fixed at compile time.  We should have a
compile-time generation step that builds everything that is required.  Whether
this is C emitting C, or python emitting C, I do not yet have an opinion.


r~
