Received: from eggs.gnu.org ([2001:4830:134:3::10]:46777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVbv8-0004Oj-Gf
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVbv7-00070S-64
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:32:18 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:35058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVbv6-00070D-W9
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:32:17 -0500
Received: by mail-ua0-x234.google.com with SMTP id y9so106999161uae.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 02:32:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 10:31:55 +0000
Message-ID: <CAFEAcA_sCnqsOjxETBAN0WorJufc8rwf9ZPbHr4+kgycuDKiyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/26] New hppa-linux target support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 January 2017 at 02:17, Richard Henderson <rth@twiddle.net> wrote:
> This is a linux-user only port, emulating a 32-bit only version of a
> pa-2.0 cpu.  This is good enough to do well with both the gcc and glibc
> testsuites.  Helge Deller has provided invaluable assistance testing
> with a more complete debian chroot.
>
> What's missing:
>   * Space registers.  Since Linux sets them all equal (for a flat
>     address space) and uses them like address-space identifiers,
>     we can simply set them all to 0 and ignore them.
>
>   * Architecture subsets.  There's no markup for running a pure pa1.0
>     or pa1.1 cpu.  I happily accept everything up to pa2.0 at the moment.
>
>   * Wide mode.  While I have pa2.0 instructions, I don't support running
>     in 64-bit mode.  Since neither the linux kernel nor glibc support a
>     64-bit userland, it would be a lot more work than just adding the ins=
ns.
>
>   * Multimedia instructions.  These are tied to wide mode, so...
>
> When squashing the patches down from my development tree, I wanted to
> preserve Helge's contributions, so the linux-user part is more patches
> than I would normally have preserved.
>
>
> r~
>
>
>
> The following changes since commit d1c82f7cc34443841095f490345f86c9d8baca=
34:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170120-v2' in=
to staging (2017-01-20 15:53:58 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-hppa-20170122
>
> for you to fetch changes up to 0ce588d6c60c338c0856b0dac78d19fc7e698477:
>
>   target-hppa: Implement floating-point insns (2017-01-22 18:14:12 -0800)
>
> ----------------------------------------------------------------
> hppa-linux target support
>

Hi; I'm afraid this fails to build on a couple of my test hosts:

PPC64BE host, arm32, aarch64 host:
/home/pm215/qemu/linux-user/syscall.c: In function =E2=80=98do_setsockopt=
=E2=80=99:
/home/pm215/qemu/linux-user/syscall.c:2827:14: error:
=E2=80=98IPV6_RECVPATHMTU=E2=80=99 undeclared (first use in this function)
         case IPV6_RECVPATHMTU:
              ^
/home/pm215/qemu/linux-user/syscall.c:2827:14: note: each undeclared
identifier is reported only once for each function it appears in
/home/pm215/qemu/linux-user/syscall.c:2828:14: error:
=E2=80=98IPV6_TRANSPARENT=E2=80=99 undeclared (first use in this function)
         case IPV6_TRANSPARENT:
              ^
/home/pm215/qemu/linux-user/syscall.c:2829:14: error:
=E2=80=98IPV6_RECVORIGDSTADDR=E2=80=99 undeclared (first use in this functi=
on)
         case IPV6_RECVORIGDSTADDR:
              ^
/home/pm215/qemu/linux-user/syscall.c:2833:14: error:
=E2=80=98IPV6_UNICAST_IF=E2=80=99 undeclared (first use in this function)
         case IPV6_UNICAST_IF:
              ^
/home/pm215/qemu/linux-user/syscall.c:2839:14: error:
=E2=80=98IPV6_ADDR_PREFERENCES=E2=80=99 undeclared (first use in this funct=
ion)
         case IPV6_ADDR_PREFERENCES:
              ^
/home/pm215/qemu/linux-user/syscall.c:2840:14: error:
=E2=80=98IPV6_MINHOPCOUNT=E2=80=99 undeclared (first use in this function)
         case IPV6_MINHOPCOUNT:
              ^
/home/pm215/qemu/linux-user/syscall.c:2841:14: error: =E2=80=98IPV6_DONTFRA=
G=E2=80=99
undeclared (first use in this function)
         case IPV6_DONTFRAG:
              ^
/home/pm215/qemu/linux-user/syscall.c:2842:14: error:
=E2=80=98IPV6_AUTOFLOWLABEL=E2=80=99 undeclared (first use in this function=
)
         case IPV6_AUTOFLOWLABEL:
              ^

(same for all targets).

Looking at the systems in question these constants are #defined
in /usr/include/linux/in6.h. The difference from the working x86
host is I think that x86 also defines them in
/usr/include/x86-64-linux-gnu/bits/in.h.
Presumably they're being implicitly dragged in by some other header
and we need to explicitly #include something instead. I'm
not sure what, though.

thanks
-- PMM
