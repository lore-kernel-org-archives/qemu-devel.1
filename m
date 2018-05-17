Received: from eggs.gnu.org ([2001:4830:134:3::10]:49445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJP15-0002Qf-RM
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJP11-00038c-0Q
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:56:47 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:41700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJP10-00038Q-QN
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:56:42 -0400
Received: by mail-pf0-x242.google.com with SMTP id v63-v6so2590137pfk.8
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:56:42 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3175b6c9-2acc-8f93-c579-c08f71266b48@linaro.org>
Date: Thu, 17 May 2018 12:56:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 22/49] tests/tcg/i386: disable i386
 version of test-i386-ssse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 05/17/2018 10:46 AM, Alex Bennée wrote:
> It doesn't build for i386 easily and we probably need a better more
> methodical test for SSE et all in QEMU.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/i386/Makefile.target | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> index 94fa50abbc..290073a882 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -9,7 +9,7 @@ I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
>  I386_TESTS=$(I386_SRCS:.c=)
>  
>  # Update TESTS
> -TESTS+=$(I386_TESTS)
> +TESTS+=$(I386_ONLY_TESTS)

As I mentioned before, this belongs with the next patch.


r~
