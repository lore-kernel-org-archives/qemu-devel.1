Received: from eggs.gnu.org ([2001:4830:134:3::10]:55281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fksnE-0005s1-0Y
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fksn9-0001Yx-2m
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:12:03 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fksn8-0001Xu-QW
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:11:59 -0400
Received: by mail-wm0-x243.google.com with SMTP id y2-v6so7417851wma.1
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 08:11:58 -0700 (PDT)
References: <20180801123111.3595-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180801123111.3595-1-richard.henderson@linaro.org>
Date: Wed, 01 Aug 2018 16:11:56 +0100
Message-ID: <874lgeazpf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm sve fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> These four patches are minor, reported by Laurent this week.
>
> If there happens to be an -rc4 release, it would be nice if
> they were included.  But if not, no biggie.  I suspect that
> other minor issues will be found past these four, so I would
> hope everyone who cares about sve is just as happy working
> from a branch anyway.

All the RISU tests are still passing so:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>
> r~
>
>
> Richard Henderson (4):
>   target/arm: Fix sign of sve_cmpeq_ppzw/sve_cmpne_ppzw
>   target/arm: Fix typo in do_sat_addsub_64
>   target/arm: Reorganize SVE WHILE
>   target/arm: Fix typo in helper_sve_movz_d
>
>  target/arm/sve_helper.c    | 19 ++++++--------
>  target/arm/translate-sve.c | 51 ++++++++++++++++++++++++--------------
>  2 files changed, 40 insertions(+), 30 deletions(-)


--
Alex Benn=C3=A9e
