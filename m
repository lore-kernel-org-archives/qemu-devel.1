Received: from eggs.gnu.org ([2001:4830:134:3::10]:41379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Rr5-0002O2-Pz
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Rr4-0000ql-Uy
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:29:35 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9Rr4-0000q6-ON
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:29:34 -0400
Received: by mail-ot1-x341.google.com with SMTP id q50so14797595otd.0
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 02:29:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538964972-3223-1-git-send-email-liq3ea@gmail.com>
References: <1538964972-3223-1-git-send-email-liq3ea@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 10:29:11 +0100
Message-ID: <CAFEAcA9wzVR1XH=Q_Lr6p83XtjGEDykMCgdfvwLqDp5ojqT5_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] util: aio-posix: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 8 October 2018 at 03:16, Li Qiang <liq3ea@gmail.com> wrote:
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  util/aio-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 621b302..51c41ed 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -40,7 +40,7 @@ struct AioHandler
>
>  #ifdef CONFIG_EPOLL_CREATE1
>
> -/* The fd number threashold to switch to epoll */
> +/* The fd number threshold to switch to epoll */
>  #define EPOLL_ENABLE_THRESHOLD 64
>
>  static void aio_epoll_disable(AioContext *ctx)
> --
> 1.8.3.1
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
