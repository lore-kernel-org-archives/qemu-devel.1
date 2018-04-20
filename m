Received: from eggs.gnu.org ([2001:4830:134:3::10]:39113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9bLO-0005Yo-Sq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9bLL-0001EZ-CH
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:05:14 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56719)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f9bLL-0001E2-68
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 15:05:11 -0400
Date: Fri, 20 Apr 2018 15:05:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180420190509.GA29671@flamenco>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<0b1a0dd5-4b79-5e60-5b45-8ee8f2de07c8@linaro.org>
	<87tvs69y61.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvs69y61.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 00/43] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Fri, Apr 20, 2018 at 07:42:14 +0100, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
(snip)
> >> Finally the end of the series has me adding Emilio's fp-test to the
> >> per-target builds. Unfortunately although some osdep.h and softfloat.c
> >> fiddling allows us to build in most cases I still can't build for
> >> example an i386 fp-test on an x86_64 host using the cross compiler as
> >> it triggers incompatibilities with config-host.h - in this case Int128
> >> support. Currently I just hackily disable fp-test for non-64 bit
> >> platforms.
> >
> > It seems I can't even build fp-test for x86_64.
> >
> >   CROSS-BUILD x86_64 guest-tests with cc
> > In file included from /home/rth/work/qemu/qemu/tests/fp/fp-test.c:14:0:
> > /home/rth/work/qemu/qemu/include/qemu/osdep.h:30:10: fatal error:
> > config-host.h: No such file or directory
> >  #include "config-host.h"
> >           ^~~~~~~~~~~~~~~
> > compilation terminated.
> 
> Weird as that works for me. Has configure been run? Are you in a
> external build dir?

config-host.h is generated when running "make" (to build whatever
targets were configured), so the recipe in tests/fp expects that
to have happened. I think this is commonly expected when building
tests/, but if I'm mistaken we could fix it by adding a rule
for config-host.h as a prerequisite.

		E.
