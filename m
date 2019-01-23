Received: from eggs.gnu.org ([209.51.188.92]:49830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmIF6-0006kM-0d
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmIF3-0003Kz-NL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:06:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmIF3-0003Ko-Dp
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:06:53 -0500
References: <20190123120759.7162-1-jusual@mail.ru>
	<20190123120759.7162-2-jusual@mail.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cef51c72-801e-7747-13d2-7852ec357617@redhat.com>
Date: Wed, 23 Jan 2019 14:06:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190123120759.7162-2-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/3] tests/libqtest: Introduce
 qtest_init_with_serial()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>

On 2019-01-23 13:07, Julia Suvorova wrote:
> Run qtest with a socket that connects QEMU chardev and test code.
> 
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/libqtest.c | 25 +++++++++++++++++++++++++
>  tests/libqtest.h | 11 +++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 55750dd68d..6fb30855fa 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -315,6 +315,31 @@ QTestState *qtest_initf(const char *fmt, ...)
>      return s;
>  }
>  
> +QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd)
> +{
> +    int sock_fd_init;
> +    char *sock_path, sock_dir[] = "/tmp/qtest-serial-XXXXXX";
> +    QTestState *qts;
> +
> +    g_assert_true(mkdtemp(sock_dir) != NULL);

Oh, nice, I wasn't aware of g_assert_true yet, that's a good idea here,
indeed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
