Received: from eggs.gnu.org ([209.51.188.92]:37813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqhmR-0002YA-59
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqhmL-0004nU-AY
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:11:32 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqhmC-0004gj-2I
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:11:21 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so940339ota.12
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 09:11:18 -0800 (PST)
MIME-Version: 1.0
References: <1549299863-42415-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549299863-42415-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 17:11:04 +0000
Message-ID: <CAFEAcA9Sx-AOY-VRrBn+T9BJU97WinQkjp7drJ=u+oLSodY16g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docker: fix test-mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 4 Feb 2019 at 17:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> --with-sdlabi has been removed.  Drop it from the test-mingw docker test.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/test-mingw | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
> index b078f22..4b84cfe 100755
> --- a/tests/docker/test-mingw
> +++ b/tests/docker/test-mingw
> @@ -27,8 +27,7 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
>          --enable-curl \
>          --enable-vnc \
>          --enable-bzip2 \
> -        --enable-guest-agent \
> -        --with-sdlabi=2.0
> +        --enable-guest-agent
>      install_qemu
>      make clean

This is already in master, as commit 335dbb5de1e98c4dc7359.

thanks
-- PMM
