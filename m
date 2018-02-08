Received: from eggs.gnu.org ([2001:4830:134:3::10]:43392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejpRi-0003I3-GO
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejpRh-0005ip-GV
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:53:14 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:32824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejpRh-0005i8-Az
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:53:13 -0500
Received: by mail-ot0-x242.google.com with SMTP id q9so4955367oti.0
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:53:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208162447.10851-1-marcandre.lureau@redhat.com>
References: <20180208162447.10851-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 16:52:51 +0000
Message-ID: <CAFEAcA_WixzeBt-pJtgpqptd47nAq40GYPxqH4r0VpH8V6qENQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] misc: fix spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 8 February 2018 at 16:24, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> s/pupulate/populate
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  util/qemu-coroutine-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
> index 846ff9167f..3d0152ebec 100644
> --- a/util/qemu-coroutine-lock.c
> +++ b/util/qemu-coroutine-lock.c
> @@ -87,7 +87,7 @@ void qemu_co_queue_run_restart(Coroutine *co)
>       * invalid memory.  Therefore, use a temporary queue and do not touc=
h
>       * the "co" coroutine as soon as you enter another one.
>       *
> -     * In its turn resumed "co" can pupulate "co_queue_wakeup" queue wit=
h
> +     * In its turn resumed "co" can populate "co_queue_wakeup" queue wit=
h
>       * new coroutines to be woken up.  The caller, who has resumed "co",
>       * will be responsible for traversing the same queue, which may caus=
e
>       * a different wakeup order but not any missing wakeups.
> --
> 2.16.1.73.g5832b7e9f2
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
