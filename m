Received: from eggs.gnu.org ([209.51.188.92]:51130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtxsv-0003wv-Bd
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtxst-00047c-B0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:59:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtxsr-000451-P7
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:59:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id x7so3299691wmj.0
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 08:59:41 -0800 (PST)
References: <20190205190224.2198-1-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190205190224.2198-1-alex.bennee@linaro.org>
Date: Wed, 13 Feb 2019 16:59:38 +0000
Message-ID: <87d0nvipz9.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH  v2 0/6] HWCAP_CPUID registers for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> I've re-spun the cpuid patches with the changes suggested by Peter's
> review. The biggest change is the squashing of bits is now all data
> driven with ARMCPRegUserSpaceInfo being used to control how bits are
> altered for userspace presentation. This includes using glob matching
> to set whole bunches to RAZ.

Ping (+ CC'd which I missed on the submission)

>
> The testcase isn't as comprehensive as it could be because you need a
> fairly new compiler (binutils) to emit all the various system register
> id's to test. I did look into upgrading debian-arm64-cross with Buster
> but I managed to find a bug in Debian's dependencies which rules out
> upgrading for now.

We have a newer compiler so I can add more on the next re-spin, reviews
pending.

>
> checkpatch is complaining about the _m macro I used to group together
> words in the masks I defined. I'm not sure adding the spaces makes it
> as readable though.
>
> The following patches need review:
>  patch 0001/target arm relax permission checks for HWCAP_CPUI.patch
>  patch 0002/target arm expose CPUID registers to userspace.patch
>  patch 0003/target arm expose MPIDR_EL1 to userspace.patch
>  patch 0004/target arm expose remaining CPUID registers as RA.patch
>  patch 0006/tests tcg aarch64 userspace system register test.patch
>
>
> Alex Benn=C3=A9e (6):
>   target/arm: relax permission checks for HWCAP_CPUID registers
>   target/arm: expose CPUID registers to userspace
>   target/arm: expose MPIDR_EL1 to userspace
>   target/arm: expose remaining CPUID registers as RAZ
>   linux-user/elfload: enable HWCAP_CPUID for AArch64
>   tests/tcg/aarch64: userspace system register test
>
>  linux-user/elfload.c              |   1 +
>  target/arm/cpu.h                  |  36 +++++++
>  target/arm/helper.c               | 106 ++++++++++++++++--
>  tests/tcg/aarch64/Makefile.target |   4 +-
>  tests/tcg/aarch64/sysregs.c       | 172 ++++++++++++++++++++++++++++++
>  5 files changed, 310 insertions(+), 9 deletions(-)
>  create mode 100644 tests/tcg/aarch64/sysregs.c


--
Alex Benn=C3=A9e
