Received: from eggs.gnu.org ([2001:4830:134:3::10]:39399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eZDMH-0002Yv-Q2
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eZDME-00039F-Jl
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:11:45 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eZDME-000384-Cj
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:11:42 -0500
Received: by mail-wr0-x241.google.com with SMTP id w107so16818687wrb.9
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 02:11:42 -0800 (PST)
References: <20180110063337.21538-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180110063337.21538-1-richard.henderson@linaro.org>
Date: Wed, 10 Jan 2018 10:11:39 +0000
Message-ID: <877esqnhus.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: split out vfp_expand_imm
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

> One more piece of target/arm prep work from my SVE branch.
>
> I saw that Alex was touching the same bit of code in his ARMv8.2
> fp16 patch set and thought we should coordinate on this.


Thanks, I'll roll them into my series.

>
>
> r~
>
>
> Richard Henderson (2):
>   target/arm: Split out vfp_expand_imm
>   target/arm: Add fp16 support to vfp_expand_imm
>
>  target/arm/translate-a64.c | 49 +++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 33 insertions(+), 16 deletions(-)


--
Alex Benn=C3=A9e
