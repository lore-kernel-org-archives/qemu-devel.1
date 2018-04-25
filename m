Received: from eggs.gnu.org ([2001:4830:134:3::10]:49069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBP4-0005sK-IA
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBOz-0004w7-U7
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:47:34 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBOz-0004vv-PS
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:47:29 -0400
Received: by mail-qt0-x242.google.com with SMTP id q13-v6so25120539qtl.3
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 20:47:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-25-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c07c5222-9cdb-d4ab-fe2f-e0d657884078@amsat.org>
Date: Wed, 25 Apr 2018 00:47:24 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-25-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 24/46] tests/tcg/i386/test-i386: use
 modern vector_size attributes
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
> The compiler complains about the old __mode__ style attributes.

old [school]

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/i386/test-i386.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
> index cae6a7773a..caef4da176 100644
> --- a/tests/tcg/i386/test-i386.c
> +++ b/tests/tcg/i386/test-i386.c
> @@ -2106,8 +2106,8 @@ static void test_enter(void)
>  
>  #ifdef TEST_SSE
>  
> -typedef int __m64 __attribute__ ((__mode__ (__V2SI__)));
> -typedef float __m128 __attribute__ ((__mode__(__V4SF__)));
> +typedef int __m64 __attribute__ ((vector_size(8)));
> +typedef float __m128 __attribute__ ((vector_size(16)));
>  
>  typedef union {
>      double d[2];
> 
