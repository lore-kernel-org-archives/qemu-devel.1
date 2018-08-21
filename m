Received: from eggs.gnu.org ([2001:4830:134:3::10]:43381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs1Wp-0002t7-4P
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs1Wl-0001wo-VD
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:56:39 -0400
References: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3e2a3c5f-bab4-0a15-a34a-3e4423c37024@redhat.com>
Date: Tue, 21 Aug 2018 09:56:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] Some improvements in z/Arch
 instructions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, richard.henderson@linaro.org

On 21.08.2018 04:50, Pavel Zbitskiy wrote:
> Found while attempting to run an old tool in qemu.
> 
> * BAL and BALR:    Added.
> * CSST:            Qemu crashed after an accidental jump to garbage.
> * IPM:             A tool produced an incorrect output.
> * EX TRT/TRTR:     A tool ran quite slow.
> * PACK:            A tool produced an incorrect output.
> * CVB, CVBY, CVBG: Added.
> 

Thanks again for the fixes. When you resend patches

1. Use "git format-patch ... --subject-prefix="PATCH v2" --cover-letter"
   in order to include a version number

2. Try to keep R-bs as part of your patches, so they don't get lost.


@Conny, can you pick up Patch 1-6? Ran kvm-unit-tests and booted the
ususal fedora system

I remember there were some R-by from Thomas.

Thanks!

> Changes since v2:
> * Updated MAINTAINERS.
> * Updated BAL and BAS not to overwrite high 32 bits
>   in 24- and 31- bit modes.
> 
> Changes since v1:
> * Tests.
> * Call pc_to_link_info() instead of op_bas().
> * Clarified CSST commit message.
> * Rewrote IPM using extract/deposit.
> * Clarified PACK commit message.
> * Do not use LowCore for CONFIG_USER_ONLY.
> * Reduce duplication in CVB code.
> 
> Pavel Zbitskiy (7):
>   tests/tcg: add a simple s390x test
>   target/s390x: add BAL and BALR instructions
>   target/s390x: fix CSST decoding and runtime alignment check
>   target/s390x: fix IPM polluting irrelevant bits
>   target/s390x: add EX support for TRT and TRTR
>   target/s390x: fix PACK reading 1 byte less and writing 1 byte more
>   target/s390x: implement CVB, CVBY and CVBG
> 
>  MAINTAINERS                     |  1 +
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  7 +++
>  target/s390x/int_helper.c       | 50 +++++++++++++++++++
>  target/s390x/mem_helper.c       | 24 +++++++--
>  target/s390x/translate.c        | 86 +++++++++++++++++++++++++--------
>  tests/tcg/s390x/Makefile.target |  9 ++++
>  tests/tcg/s390x/csst.c          | 43 +++++++++++++++++
>  tests/tcg/s390x/cvb.c           | 18 +++++++
>  tests/tcg/s390x/exrl-trt.c      | 48 ++++++++++++++++++
>  tests/tcg/s390x/exrl-trtr.c     | 48 ++++++++++++++++++
>  tests/tcg/s390x/hello-s390x.c   |  7 +++
>  tests/tcg/s390x/ipm.c           | 22 +++++++++
>  tests/tcg/s390x/pack.c          | 21 ++++++++
>  14 files changed, 362 insertions(+), 23 deletions(-)
>  create mode 100644 tests/tcg/s390x/Makefile.target
>  create mode 100644 tests/tcg/s390x/csst.c
>  create mode 100644 tests/tcg/s390x/cvb.c
>  create mode 100644 tests/tcg/s390x/exrl-trt.c
>  create mode 100644 tests/tcg/s390x/exrl-trtr.c
>  create mode 100644 tests/tcg/s390x/hello-s390x.c
>  create mode 100644 tests/tcg/s390x/ipm.c
>  create mode 100644 tests/tcg/s390x/pack.c
> 


-- 

Thanks,

David / dhildenb
