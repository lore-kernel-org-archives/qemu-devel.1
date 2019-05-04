Received: from eggs.gnu.org ([209.51.188.92]:47314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnxY-0002T8-Df
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnxX-0001WM-KF
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:15:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:38565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnxX-0001Ta-Db
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:15:43 -0400
Received: by mail-pl1-x636.google.com with SMTP id a59so3745093pla.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 23:15:43 -0700 (PDT)
References: <20190501184306.15208-1-richard.henderson@linaro.org>
	<877eb74gc3.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6206383e-d092-28cf-1549-ab01a306bb05@linaro.org>
Date: Fri, 3 May 2019 23:15:39 -0700
MIME-Version: 1.0
In-Reply-To: <877eb74gc3.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/alpha: add system boot.S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 5/3/19 10:07 AM, Alex Bennée wrote:
> +	ldah	$sp, $stack_end($gp)	!gprelhigh
> +	lda	$sp, $stack_end($gp)	!gprellow

Bah.                           ^^^^ $sp

As is, this works only because the test case is tiny, and this happens to
evaluate to the middle of the stack allocation.


r~
