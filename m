Received: from eggs.gnu.org ([2001:4830:134:3::10]:58511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXVdF-0004s6-KO
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXVdE-00017N-Dt
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:45:57 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <1500395194-21455-2-git-send-email-peter.maydell@linaro.org>
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
	<1500395194-21455-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 13:45:52 -0300
Message-ID: <CAAdtpL7WjJWC1KT2fuZv=b2obT9dJwPgYp=QQK0agdVNhhn=tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/4] bsd-user/mmap.c: Move
 __thread attribute to right place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, patches@linaro.org

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Le 18 juil. 2017 1:29 PM, "Peter Maydell" <peter.maydell@linaro.org> a
=C3=A9crit :

> Avoid a compiler warning on OpenBSD:
> bsd-user/mmap.c:28:1: warning: '__thread' is not at beginning of
> declaration [-Wold-style-declaration]
> by moving the __thread attribute to its proper place.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  bsd-user/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 7f2018e..20cd29d 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -25,7 +25,7 @@
>  //#define DEBUG_MMAP
>
>  static pthread_mutex_t mmap_mutex =3D PTHREAD_MUTEX_INITIALIZER;
> -static int __thread mmap_lock_count;
> +static __thread int mmap_lock_count;
>
>  void mmap_lock(void)
>  {
> --
> 2.7.4
>
>
>
