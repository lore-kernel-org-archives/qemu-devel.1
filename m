Received: from eggs.gnu.org ([2001:4830:134:3::10]:52940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBL4S-0005gf-9H
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBL4N-0000cl-In
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:06:56 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:39193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBL4N-0000cb-Ch
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:06:51 -0400
Received: by mail-qt0-x244.google.com with SMTP id f1-v6so9748047qtj.6
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 07:06:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-26-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d0beb769-372d-3007-2bfc-759e3eec65b4@amsat.org>
Date: Wed, 25 Apr 2018 11:06:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-26-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 25/46] tests/tcg/i386/test-i386: fix
 printf format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/i386/test-i386.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
> index caef4da176..a29b41e764 100644
> --- a/tests/tcg/i386/test-i386.c
> +++ b/tests/tcg/i386/test-i386.c
> @@ -2258,7 +2258,7 @@ SSE_OP(a ## sd);
>          "pop %0\n"\
>          : "=rm" (eflags)\
>          : "x" (a.dq), "x" (b.dq));\
> -    printf("%-9s: a=%f b=%f cc=%04x\n",\
> +    printf("%-9s: a=%f b=%f cc=%04lx\n",\
>             #op, a1, b1,\
>             eflags & (CC_C | CC_P | CC_Z | CC_S | CC_O | CC_A));\
>  }
> 
