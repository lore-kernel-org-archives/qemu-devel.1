Received: from eggs.gnu.org ([2001:4830:134:3::10]:36721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLbMq-0004bt-0A
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 14:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLbMo-00081j-Vn
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 14:55:32 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:32829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cLbMo-00081E-Gp
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 14:55:30 -0500
Received: by mail-ua0-x22b.google.com with SMTP id i68so64661422uad.0
	for <qemu-devel@nongnu.org>; Mon, 26 Dec 2016 11:55:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0505bf58-21d7-7f77-a0f8-25c5a9586c7f@freebsd.org>
References: <0505bf58-21d7-7f77-a0f8-25c5a9586c7f@freebsd.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Dec 2016 19:55:07 +0000
Message-ID: <CAFEAcA-PuTRPUOfpV6Y6aLpBMiFSWmJmKjgytL=Z1MDh3MXHJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Extra linked objects in qemu-system-aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sean Bruno <sbruno@freebsd.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 December 2016 at 15:01, Sean Bruno <sbruno@freebsd.org> wrote:
> FreeBSD detects undeclared dependencies when building "ports" and I've
> been ignoring a bunch of warnings from qemu-system-aarch64 that I'm a
> bit puzzled by.  It appears that we're linking qemu-system-aarch64
> differently than the other system emulator targets:
>
> https://gist.github.com/seanbruno/dd992cc1e425d708e53dc0fd0f958b92
>
> I would have expected that all the system targets have the same non-qemu
> objects linked against it.  Is this something specific to the aarc64
> emulator that needs to be there?

You don't give the other system targets for comparison so it's
hard to tell. I would expect for instance that the system
emulators would pull in various things like X11 for the GUI.
The link lines ought not to be any different, though -- often
aarch64 appears in warnings just because it happens to be
lexicographically the first target architecture. Is the
ports setup just suppressing later identical warnings about
the same libraries on other binaries?

In any case, it looks like a packaging problem to me.
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=209813
might or might not be relevant to whether this should be
fixed in the QEMU packaging or in the handling of the
things like Gnome we might be linking against (just a
random related-looking google hit).

thanks
-- PMM
