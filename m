Received: from eggs.gnu.org ([2001:4830:134:3::10]:42425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXkTl-00031O-Cz
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXkTg-0001fo-B8
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:41:41 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXkTg-0001fV-2j
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:41:36 -0400
Received: by mail-wr0-x241.google.com with SMTP id g18-v6so16517748wro.7
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 02:41:35 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180621015359.12018-1-richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 10:41:33 +0100
Message-ID: <87po0dx4tu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/35] target/arm SVE patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This is the remainder of the SVE enablement patches,
> with an extra bonus patch to enable ARMv8.2-DotProd.

Have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Passes the whole sve-all-short test set with this series applied.

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
>   target/arm: Implement SVE Floating Point Unary Operations-Unpredicated =
Group
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
>  target/arm/helper-sve.h    |  682 ++++++++++++++
>  target/arm/helper.h        |   44 +-
>  linux-user/elfload.c       |    1 +
>  target/arm/cpu.c           |    8 +
>  target/arm/cpu64.c         |    2 +
>  target/arm/helper.c        |    2 +-
>  target/arm/sve_helper.c    | 1827 ++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c |   57 +-
>  target/arm/translate-sve.c | 1691 ++++++++++++++++++++++++++++++++-
>  target/arm/translate.c     |   81 +-
>  target/arm/vec_helper.c    |  283 +++++-
>  target/arm/sve.decode      |  422 +++++++++
>  13 files changed, 5039 insertions(+), 62 deletions(-)


--
Alex Benn=C3=A9e
