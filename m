Received: from eggs.gnu.org ([209.51.188.92]:53841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMr88-0004TN-Id
	for qemu-devel@nongnu.org; Sat, 04 May 2019 05:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMr87-0000MX-Pe
	for qemu-devel@nongnu.org; Sat, 04 May 2019 05:38:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMr87-0000LW-I0
	for qemu-devel@nongnu.org; Sat, 04 May 2019 05:38:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id b10so9891219wmj.4
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 02:38:50 -0700 (PDT)
References: <20190501184306.15208-1-richard.henderson@linaro.org>
	<877eb74gc3.fsf@zen.linaroharston>
	<6206383e-d092-28cf-1549-ab01a306bb05@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <6206383e-d092-28cf-1549-ab01a306bb05@linaro.org>
Date: Sat, 04 May 2019 10:38:48 +0100
Message-ID: <87a7g2bluf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/alpha: add system boot.S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/3/19 10:07 AM, Alex Benn=C3=A9e wrote:
>> +	ldah	$sp, $stack_end($gp)	!gprelhigh
>> +	lda	$sp, $stack_end($gp)	!gprellow
>
> Bah.                           ^^^^ $sp
>
> As is, this works only because the test case is tiny, and this happens to
> evaluate to the middle of the stack allocation.

cool. that fixes the exception I was seeing while running the
cleaned up memory test.

--
Alex Benn=C3=A9e
