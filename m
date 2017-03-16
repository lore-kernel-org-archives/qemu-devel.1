Received: from eggs.gnu.org ([2001:4830:134:3::10]:48584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coXG4-0001SX-4T
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coXG3-0000cI-A1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:24:08 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coXG3-0000bT-3s
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:24:07 -0400
Received: by mail-wr0-x22f.google.com with SMTP id u108so34405318wrb.3
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 08:24:07 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 15:23:45 +0000
Message-ID: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

OK, here's a concrete proposal for deprecating/dropping out of
date host OS and architecture support.

We'll put this in the ChangeLog 'Future incompatible changes'
section:
-----
* Removal of support for untested host OS and architectures:

The QEMU Project intends to drop support in a future release for any
host OS or architecture which we do not have access to a build and test
machine for. This affects the following host OSes:
 * Native CYGWIN building
 * GNU/kFreeBSD
 * FreeBSD
 * DragonFly BSD
 * NetBSD
 * OpenBSD
 * Solaris
 * AIX
 * Haiku
and the following host CPU architectures:
 * ia64
 * sparc

Specifically, if we do not have a build and test system available
to us by the time we release QEMU 2.10, we will remove support in the
release that follows 2.10.
-----

I'm not sure here if we want to just have this as a bald list,
or to have some kind of two tier setup with OSes we expect to
dump in one tier and OSes where we're really trolling for a build
machine in the other tier (the "unlikely to dump" category would
get most of the BSD variants in it). Putting out a changelog
that says "we're gonna drop all the BSDs" seems like it might
produce a lot of yelling?

Should "native CYGWIN" be in the drop list? I only test
mingw cross compile, but configure has a separate section for
CYGWIN in its $targetos case statement.

It would also not be too difficult to make configure warn when it
is run on the deprecated OS or architecture, so we should probably
sneak that into 2.9.

(Technically right this instant 'mips' and 's390' would be in the
'dump' list, since I don't personally have access yet. But we have
a plan for s390, and it turns out there is a mips machine in the
gcc compile farm which I'm just checking out.)

thanks
-- PMM
