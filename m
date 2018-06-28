Received: from eggs.gnu.org ([2001:4830:134:3::10]:53674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYV8l-0008RS-LO
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYV8g-0005If-Iv
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:31:07 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:44527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYV8g-0005H8-94
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:31:02 -0400
Received: by mail-wr0-x233.google.com with SMTP id p12-v6so5140314wrn.11
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 04:31:02 -0700 (PDT)
References: <20180627043328.11531-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180627043328.11531-1-richard.henderson@linaro.org>
Date: Thu, 28 Jun 2018 12:30:59 +0100
Message-ID: <87y3ezuozw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v6 00/35] target/arm SVE patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This is the remainder of the SVE enablement patches,
> with an extra bonus patch to enable ARMv8.2-DotProd.
>
> V6 updates based on review.

One failure from the VQ3 test set:

../qemu.git/aarch64-linux-user/qemu-aarch64 \
  ./risu --test-sve=3D3 \
  sve-all-short-v8.3+sve@vq3/insn_sdiv_z_p_zz___INC.risu.bin \
  --trace=3Dsve-all-short-v8.3+sve@vq3/insn_sdiv_z_p_zz___INC.risu.bin.trace

Gives:

  loading test image
  sve-all-short-v8.3+sve@vq3/insn_sdiv_z_p_zz___INC.risu.bin...
  starting apprentice image at 0x4000801000
  starting image
  fish: =E2=80=9C../qemu.git/aarch64-linux-user/=E2=80=A6=E2=80=9D terminat=
ed by signal SIGFPE
  (Floating point exception)

From:

  http://people.linaro.org/~alex.bennee/testcases/arm64.risu/sve-all-short-=
v8.3+sve@vq3.tar.xz

>
> Patches with changes:
>   0002-target-arm-Implement-SVE-Contiguous-Load-first-fa.patch
>   0007-target-arm-Implement-SVE-FP-Multiply-Add-Group.patch
>   0009-target-arm-Implement-SVE-load-and-broadcast-eleme.patch
>   0010-target-arm-Implement-SVE-store-vector-predicate-r.patch
>   0011-target-arm-Implement-SVE-scatter-stores.patch
>   0013-target-arm-Implement-SVE-gather-loads.patch
>   0023-target-arm-Implement-SVE-floating-point-convert-p.patch
>   0027-target-arm-Implement-SVE-MOVPRFX.patch
>   0030-target-arm-Pass-index-to-AdvSIMD-FCMLA-indexed.patch
>   0033-target-arm-Implement-SVE-dot-product-indexed.patch
>   0034-target-arm-Enable-SVE-for-aarch64-linux-user.patch
>   0035-target-arm-Implement-ARMv8.2-DotProd.patch
>
> Patches lacking reviews:
>   0002-target-arm-Implement-SVE-Contiguous-Load-first-fa.patch
>   0007-target-arm-Implement-SVE-FP-Multiply-Add-Group.patch
>   0013-target-arm-Implement-SVE-gather-loads.patch
>   0030-target-arm-Pass-index-to-AdvSIMD-FCMLA-indexed.patch
>   0031-target-arm-Implement-SVE-fp-complex-multiply-add-.patch
>   0033-target-arm-Implement-SVE-dot-product-indexed.patch
>
>
> r~
>
>
> Richard Henderson (35):
>   target/arm: Implement SVE Memory Contiguous Load Group
>   target/arm: Implement SVE Contiguous Load, first-fault and no-fault
>   target/arm: Implement SVE Memory Contiguous Store Group
>   target/arm: Implement SVE load and broadcast quadword
>   target/arm: Implement SVE integer convert to floating-point
>   target/arm: Implement SVE floating-point arithmetic (predicated)
>   target/arm: Implement SVE FP Multiply-Add Group
>   target/arm: Implement SVE Floating Point Accumulating Reduction Group
>   target/arm: Implement SVE load and broadcast element
>   target/arm: Implement SVE store vector/predicate register
>   target/arm: Implement SVE scatter stores
>   target/arm: Implement SVE prefetches
>   target/arm: Implement SVE gather loads
>   target/arm: Implement SVE first-fault gather loads
>   target/arm: Implement SVE scatter store vector immediate
>   target/arm: Implement SVE floating-point compare vectors
>   target/arm: Implement SVE floating-point arithmetic with immediate
>   target/arm: Implement SVE Floating Point Multiply Indexed Group
>   target/arm: Implement SVE FP Fast Reduction Group
>   target/arm: Implement SVE Floating Point Unary Operations -
>     Unpredicated Group
>   target/arm: Implement SVE FP Compare with Zero Group
>   target/arm: Implement SVE floating-point trig multiply-add coefficient
>   target/arm: Implement SVE floating-point convert precision
>   target/arm: Implement SVE floating-point convert to integer
>   target/arm: Implement SVE floating-point round to integral value
>   target/arm: Implement SVE floating-point unary operations
>   target/arm: Implement SVE MOVPRFX
>   target/arm: Implement SVE floating-point complex add
>   target/arm: Implement SVE fp complex multiply add
>   target/arm: Pass index to AdvSIMD FCMLA (indexed)
>   target/arm: Implement SVE fp complex multiply add (indexed)
>   target/arm: Implement SVE dot product (vectors)
>   target/arm: Implement SVE dot product (indexed)
>   target/arm: Enable SVE for aarch64-linux-user
>   target/arm: Implement ARMv8.2-DotProd
>
>  target/arm/cpu.h           |    1 +
>  target/arm/helper-sve.h    |  682 +++++++++++++
>  target/arm/helper.h        |   44 +-
>  linux-user/elfload.c       |    2 +
>  target/arm/cpu.c           |    8 +
>  target/arm/cpu64.c         |    2 +
>  target/arm/helper.c        |    2 +-
>  target/arm/sve_helper.c    | 1855 ++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c |   57 +-
>  target/arm/translate-sve.c | 1688 +++++++++++++++++++++++++++++++-
>  target/arm/translate.c     |  102 +-
>  target/arm/vec_helper.c    |  311 +++++-
>  target/arm/sve.decode      |  427 +++++++++
>  13 files changed, 5116 insertions(+), 65 deletions(-)


--
Alex Benn=C3=A9e
