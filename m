Received: from eggs.gnu.org ([2001:4830:134:3::10]:35706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3n5e-0007kh-6d
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3n5b-0001Eh-2P
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:24:58 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3n5a-0001Dy-Pm
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:24:54 -0400
Received: by mail-wm0-x244.google.com with SMTP id p9so43493770wmc.3
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 11:24:54 -0700 (PDT)
References: <20180207225540.31698-1-richard.henderson@linaro.org>
	<20180207225540.31698-17-richard.henderson@linaro.org>
	<20180404164908.GA7582@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180404164908.GA7582@flamenco>
Date: Wed, 04 Apr 2018 19:24:52 +0100
Message-ID: <878ta2de2z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 16/20] target/arm: Use vector infrastructure
 for aa64 compares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org


Emilio G. Cota <cota@braap.org> writes:

> On Wed, Feb 07, 2018 at 14:55:36 -0800, Richard Henderson wrote:
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Just bisected a segfault for aarch64 nbench on a PowerPC host
> to this commit (79d61de6bdc398). I've also tested on x86_64 and
> aarch64 hosts, and these do not seem to be affected.

I wonder about other hosts without TCG_vec backend support (powerpc is
one)? I suspect it must be the fall-back for the vector expanders is
wrong.

>
> To reproduce:
> 1. grab this binary:
>   http://cs.columbia.edu/~cota/qemu/nbench-aarch64
> 2. run it on a PowerPC host with:
>   $ aarch64-linux-user/qemu-aarch64 nbench-aarch64 -V
>
> Note: the "-V" (or "-v") flag is important! Without it, there's no segfau=
lt.
>
> I can reproduce this consistently on a Power8 host -- I'm using gcc112
> from the gcc compile farm.
>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
