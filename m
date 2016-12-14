Received: from eggs.gnu.org ([2001:4830:134:3::10]:46043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHCA6-0007RH-2E
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHCA0-00036e-2u
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:12:10 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cHC9z-000365-OQ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:12:04 -0500
Received: by mail-wm0-f52.google.com with SMTP id t79so1455208wmt.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 08:12:03 -0800 (PST)
References: <20161201052844.31819-1-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161201052844.31819-1-bobby.prani@gmail.com>
Date: Wed, 14 Dec 2016 16:10:59 +0000
Message-ID: <87y3zisd7w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 0/3] Add litmus tests for MTTCG
 consistency tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net


Pranith Kumar <bobby.prani@gmail.com> writes:

> Hello,
>
> The following patch series adds litmus tests to test consistency for
> MTTCG enabled qemu. These patches apply on top of the clean up
> tests/tcg folder made by my previous patch series.
>
> The tests were generated using the litmus tool. The sources and
> instructions on how to generate these sources can be found in this
> repository: https://github.com/pranith/qemu-litmus
>
> I tested these on both an x86 and an Aarch64 machine. These tests are
> currently enabled for the trusty configuration on travis.

But how do I build them? The Makefile seems to be directly what the
litmus tool output. We either need the makefile in ../ to call the
litmus Makefile appropriately or massage the litmus Makefile to work
with out build system.

>
> Thanks,
> --
> Pranith
>
> *** BLURB HERE ***
>
> Pranith Kumar (3):
>   tests/tcg: Add i386 litmus test
>   tests/tcg: Add aarch64 litmus tests
>   travis: Enable litmus tests
>
>  .travis.yml                               |    8 +
>  tests/tcg/aarch64/litmus/ARMARM00.c       |  501 +++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM01.c       |  504 +++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM02.c       |  571 ++++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM03.c       |  498 +++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM04+BIS.c   |  556 ++++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM04+TER.c   |  538 ++++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM04.c       |  556 ++++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM05.c       |  553 ++++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM06+AP+AA.c |  581 +++++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM06+AP+AP.c |  581 +++++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM06.c       |  581 +++++++++++++++
>  tests/tcg/aarch64/litmus/ARMARM07+SAL.c   |  497 +++++++++++++
>  tests/tcg/aarch64/litmus/Makefile         |   53 ++
>  tests/tcg/aarch64/litmus/README.txt       |   22 +
>  tests/tcg/aarch64/litmus/affinity.c       |  159 ++++
>  tests/tcg/aarch64/litmus/affinity.h       |   34 +
>  tests/tcg/aarch64/litmus/comp.sh          |   30 +
>  tests/tcg/aarch64/litmus/litmus_rand.c    |   64 ++
>  tests/tcg/aarch64/litmus/litmus_rand.h    |   29 +
>  tests/tcg/aarch64/litmus/outs.c           |  148 ++++
>  tests/tcg/aarch64/litmus/outs.h           |   49 ++
>  tests/tcg/aarch64/litmus/run.sh           |  378 ++++++++++
>  tests/tcg/aarch64/litmus/show.awk         |    2 +
>  tests/tcg/aarch64/litmus/utils.c          | 1148 +++++++++++++++++++++++++++++
>  tests/tcg/aarch64/litmus/utils.h          |  275 +++++++
>  tests/tcg/i386/litmus/Makefile            |   42 ++
>  tests/tcg/i386/litmus/README.txt          |   22 +
>  tests/tcg/i386/litmus/SAL.c               |  491 ++++++++++++
>  tests/tcg/i386/litmus/affinity.c          |  159 ++++
>  tests/tcg/i386/litmus/affinity.h          |   34 +
>  tests/tcg/i386/litmus/comp.sh             |   10 +
>  tests/tcg/i386/litmus/litmus_rand.c       |   64 ++
>  tests/tcg/i386/litmus/litmus_rand.h       |   29 +
>  tests/tcg/i386/litmus/outs.c              |  148 ++++
>  tests/tcg/i386/litmus/outs.h              |   49 ++
>  tests/tcg/i386/litmus/run.sh              |   55 ++
>  tests/tcg/i386/litmus/show.awk            |    2 +
>  tests/tcg/i386/litmus/utils.c             | 1148 +++++++++++++++++++++++++++++
>  tests/tcg/i386/litmus/utils.h             |  275 +++++++
>  40 files changed, 11444 insertions(+)
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM00.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM01.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM02.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM03.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM04+BIS.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM04+TER.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM04.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM05.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM06+AP+AA.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM06+AP+AP.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM06.c
>  create mode 100644 tests/tcg/aarch64/litmus/ARMARM07+SAL.c
>  create mode 100644 tests/tcg/aarch64/litmus/Makefile
>  create mode 100644 tests/tcg/aarch64/litmus/README.txt
>  create mode 100644 tests/tcg/aarch64/litmus/affinity.c
>  create mode 100644 tests/tcg/aarch64/litmus/affinity.h
>  create mode 100644 tests/tcg/aarch64/litmus/comp.sh
>  create mode 100644 tests/tcg/aarch64/litmus/litmus_rand.c
>  create mode 100644 tests/tcg/aarch64/litmus/litmus_rand.h
>  create mode 100644 tests/tcg/aarch64/litmus/outs.c
>  create mode 100644 tests/tcg/aarch64/litmus/outs.h
>  create mode 100755 tests/tcg/aarch64/litmus/run.sh
>  create mode 100644 tests/tcg/aarch64/litmus/show.awk
>  create mode 100644 tests/tcg/aarch64/litmus/utils.c
>  create mode 100644 tests/tcg/aarch64/litmus/utils.h
>  create mode 100644 tests/tcg/i386/litmus/Makefile
>  create mode 100644 tests/tcg/i386/litmus/README.txt
>  create mode 100644 tests/tcg/i386/litmus/SAL.c
>  create mode 100644 tests/tcg/i386/litmus/affinity.c
>  create mode 100644 tests/tcg/i386/litmus/affinity.h
>  create mode 100644 tests/tcg/i386/litmus/comp.sh
>  create mode 100644 tests/tcg/i386/litmus/litmus_rand.c
>  create mode 100644 tests/tcg/i386/litmus/litmus_rand.h
>  create mode 100644 tests/tcg/i386/litmus/outs.c
>  create mode 100644 tests/tcg/i386/litmus/outs.h
>  create mode 100755 tests/tcg/i386/litmus/run.sh
>  create mode 100644 tests/tcg/i386/litmus/show.awk
>  create mode 100644 tests/tcg/i386/litmus/utils.c
>  create mode 100644 tests/tcg/i386/litmus/utils.h


--
Alex Bennée
