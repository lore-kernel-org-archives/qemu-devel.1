Received: from eggs.gnu.org ([2001:4830:134:3::10]:53784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVsC8-00026l-SC
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVsC8-0003dv-2R
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:27:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-29-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7d21bf8e-38af-e8de-9fc6-46cfc382a855@amsat.org>
Date: Fri, 14 Jul 2017 01:27:04 -0300
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-29-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 28/29] test-iov: replace
 g_malloc()+memcpy() with g_memdup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org

On 07/13/2017 01:32 PM, Marc-André Lureau wrote:
> I found these pattern via grepping the source tree. I don't have a
> coccinelle script for it!
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/test-iov.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/test-iov.c b/tests/test-iov.c
> index a22d71fd2c..fa3d75aee1 100644
> --- a/tests/test-iov.c
> +++ b/tests/test-iov.c
> @@ -167,8 +167,7 @@ static void test_io(void)
>       }
>       iov_from_buf(iov, niov, 0, buf, sz);
>   
> -    siov = g_malloc(sizeof(*iov) * niov);
> -    memcpy(siov, iov, sizeof(*iov) * niov);
> +    siov = g_memdup(iov, sizeof(*iov) * niov);
>   
>       if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) < 0) {
>          perror("socketpair");
> 
