Received: from eggs.gnu.org ([2001:4830:134:3::10]:36889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMD92-0008M4-Bp
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fMD8x-000491-P5
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:52:36 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:44274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fMD8x-00048o-KQ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:52:31 -0400
Received: by mail-oi0-x243.google.com with SMTP id e80-v6so4626355oig.11
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 06:52:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180524223458.5651-1-f4bug@amsat.org>
References: <20180524223458.5651-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 14:52:10 +0100
Message-ID: <CAFEAcA-eD4w35zEDJRvpMfhYBYYL70KtE1az4Lft_K28DNRr6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Prevent fd leakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

On 24 May 2018 at 23:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Since 2f652224f7, we now check if socket_set_nodelay() errored,
> but forgot to close the socket before reporting an error.
>
> Fixes: Coverity CID 1391290 (RESOURCE_LEAK)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  gdbstub.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index e4ece2f5bc..9c860cd81c 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1836,6 +1836,7 @@ static bool gdb_accept(void)
>      /* set short latency */
>      if (socket_set_nodelay(fd)) {
>          perror("setsockopt");
> +        close(fd);
>          return false;
>      }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
