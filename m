Received: from eggs.gnu.org ([2001:4830:134:3::10]:37334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rkV-0003WG-RC
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rkS-0000tU-Lm
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:11:59 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rkS-0000tI-HE
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:11:56 -0400
Received: by mail-qt0-x242.google.com with SMTP id s2so13605964qti.2
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 17:11:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8223b521-7b6f-4399-19a1-12f6971cd9c7@amsat.org>
Date: Sun, 15 Apr 2018 21:11:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 12/24] tests/tcg/i386: Build fix for
 hello-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, famz@redhat.com
Cc: cota@braap.org

Hi Fam, Alex,

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> From: Fam Zheng <famz@redhat.com>
> 
> We have -Werror=missing-prototype, add a dummy prototype to avoid that
> warning.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/tcg/i386/hello-i386.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/tcg/i386/hello-i386.c b/tests/tcg/i386/hello-i386.c
> index fa00380de2..cfeb24b2f5 100644
> --- a/tests/tcg/i386/hello-i386.c
> +++ b/tests/tcg/i386/hello-i386.c
> @@ -20,6 +20,7 @@ static inline int write(int fd, const char * buf, int len)
>    return status;
>  }
>  
> +void _start(void);

What about adding that in a common base file include by all tcg tests?
Such tests/tcg/include/tcg-common.h or better name...

>  void _start(void)
>  {
>      write(1, "Hello World\n", 12);
> 
