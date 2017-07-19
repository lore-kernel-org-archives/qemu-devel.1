Received: from eggs.gnu.org ([2001:4830:134:3::10]:60794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXwgI-0006RR-AS
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXwgE-0006QB-6D
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:38:54 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXwgE-0006Pv-0V
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:38:50 -0400
Received: by mail-qt0-x244.google.com with SMTP id h47so1582043qta.5
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 14:38:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20161201052844.31819-1-bobby.prani@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <72e650bf-3bb2-1ed4-6c51-46c55f28fb70@amsat.org>
Date: Wed, 19 Jul 2017 18:38:45 -0300
MIME-Version: 1.0
In-Reply-To: <20161201052844.31819-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

Hi Pranith,

On 12/01/2016 02:28 AM, Pranith Kumar wrote:
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
> 
> Thanks,
> --
> Pranith
> 
> *** BLURB HERE ***
> 
> Pranith Kumar (3):
>    tests/tcg: Add i386 litmus test
>    tests/tcg: Add aarch64 litmus tests
>    travis: Enable litmus tests
> 
>   .travis.yml                               |    8 +
>   tests/tcg/aarch64/litmus/ARMARM00.c       |  501 +++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM01.c       |  504 +++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM02.c       |  571 ++++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM03.c       |  498 +++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM04+BIS.c   |  556 ++++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM04+TER.c   |  538 ++++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM04.c       |  556 ++++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM05.c       |  553 ++++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM06+AP+AA.c |  581 +++++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM06+AP+AP.c |  581 +++++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM06.c       |  581 +++++++++++++++
>   tests/tcg/aarch64/litmus/ARMARM07+SAL.c   |  497 +++++++++++++
>   tests/tcg/aarch64/litmus/Makefile         |   53 ++
>   tests/tcg/aarch64/litmus/README.txt       |   22 +
>   tests/tcg/aarch64/litmus/affinity.c       |  159 ++++
>   tests/tcg/aarch64/litmus/affinity.h       |   34 +
>   tests/tcg/aarch64/litmus/comp.sh          |   30 +
>   tests/tcg/aarch64/litmus/litmus_rand.c    |   64 ++
>   tests/tcg/aarch64/litmus/litmus_rand.h    |   29 +
>   tests/tcg/aarch64/litmus/outs.c           |  148 ++++
>   tests/tcg/aarch64/litmus/outs.h           |   49 ++
>   tests/tcg/aarch64/litmus/run.sh           |  378 ++++++++++
>   tests/tcg/aarch64/litmus/show.awk         |    2 +
>   tests/tcg/aarch64/litmus/utils.c          | 1148 +++++++++++++++++++++++++++++
>   tests/tcg/aarch64/litmus/utils.h          |  275 +++++++
>   tests/tcg/i386/litmus/Makefile            |   42 ++

can you add an entry for both folders into MAINTAINERS please?

>   tests/tcg/i386/litmus/README.txt          |   22 +
>   tests/tcg/i386/litmus/SAL.c               |  491 ++++++++++++
>   tests/tcg/i386/litmus/affinity.c          |  159 ++++
>   tests/tcg/i386/litmus/affinity.h          |   34 +
>   tests/tcg/i386/litmus/comp.sh             |   10 +
>   tests/tcg/i386/litmus/litmus_rand.c       |   64 ++
>   tests/tcg/i386/litmus/litmus_rand.h       |   29 +
>   tests/tcg/i386/litmus/outs.c              |  148 ++++
>   tests/tcg/i386/litmus/outs.h              |   49 ++
>   tests/tcg/i386/litmus/run.sh              |   55 ++
>   tests/tcg/i386/litmus/show.awk            |    2 +
>   tests/tcg/i386/litmus/utils.c             | 1148 +++++++++++++++++++++++++++++
>   tests/tcg/i386/litmus/utils.h             |  275 +++++++
>   40 files changed, 11444 insertions(+)
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM00.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM01.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM02.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM03.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM04+BIS.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM04+TER.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM04.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM05.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM06+AP+AA.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM06+AP+AP.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM06.c
>   create mode 100644 tests/tcg/aarch64/litmus/ARMARM07+SAL.c
>   create mode 100644 tests/tcg/aarch64/litmus/Makefile
>   create mode 100644 tests/tcg/aarch64/litmus/README.txt
>   create mode 100644 tests/tcg/aarch64/litmus/affinity.c
>   create mode 100644 tests/tcg/aarch64/litmus/affinity.h
>   create mode 100644 tests/tcg/aarch64/litmus/comp.sh
>   create mode 100644 tests/tcg/aarch64/litmus/litmus_rand.c
>   create mode 100644 tests/tcg/aarch64/litmus/litmus_rand.h
>   create mode 100644 tests/tcg/aarch64/litmus/outs.c
>   create mode 100644 tests/tcg/aarch64/litmus/outs.h
>   create mode 100755 tests/tcg/aarch64/litmus/run.sh
>   create mode 100644 tests/tcg/aarch64/litmus/show.awk
>   create mode 100644 tests/tcg/aarch64/litmus/utils.c
>   create mode 100644 tests/tcg/aarch64/litmus/utils.h
>   create mode 100644 tests/tcg/i386/litmus/Makefile
>   create mode 100644 tests/tcg/i386/litmus/README.txt
>   create mode 100644 tests/tcg/i386/litmus/SAL.c
>   create mode 100644 tests/tcg/i386/litmus/affinity.c
>   create mode 100644 tests/tcg/i386/litmus/affinity.h
>   create mode 100644 tests/tcg/i386/litmus/comp.sh
>   create mode 100644 tests/tcg/i386/litmus/litmus_rand.c
>   create mode 100644 tests/tcg/i386/litmus/litmus_rand.h
>   create mode 100644 tests/tcg/i386/litmus/outs.c
>   create mode 100644 tests/tcg/i386/litmus/outs.h
>   create mode 100755 tests/tcg/i386/litmus/run.sh
>   create mode 100644 tests/tcg/i386/litmus/show.awk
>   create mode 100644 tests/tcg/i386/litmus/utils.c
>   create mode 100644 tests/tcg/i386/litmus/utils.h
> 
