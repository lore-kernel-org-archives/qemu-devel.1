Received: from eggs.gnu.org ([209.51.188.92]:43492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glbKz-0005P2-1I
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glbKy-0001eQ-CP
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:18:09 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glbKy-0001e6-72
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:18:08 -0500
Received: by mail-ot1-x343.google.com with SMTP id s13so20827499otq.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 07:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20190121144841.24467-1-anthony.perard@citrix.com>
In-Reply-To: <20190121144841.24467-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 15:17:54 +0000
Message-ID: <CAFEAcA_ytAb-K-HB3wL5baMBDkY71ksBK8hsUSFxuUeqVDFyHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Don't add Xen's libs to LDFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Michael Tokarev <mjt@tls.msk.ru>

On Mon, 21 Jan 2019 at 14:49, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> When Xen is detected via pkg-config, it isn't necessary to modify
> LDFLAGS as modifying libs_softmmu is enough.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/configure b/configure
> index 12fd34f30b..98b270974d 100755
> --- a/configure
> +++ b/configure
> @@ -2355,7 +2355,6 @@ if test "$xen" != "no" ; then
>      fi
>      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
>      libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
> -    LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
>    else
>
>      xen_libs="-lxenstore -lxenctrl -lxenguest"
> --
> Anthony PERARD

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Cc'ing MJT, who first pointed out to me that this bug
was resulting in various binaries like the linux-user ones
getting linked against the Xen libs unnecessarily.

thanks
-- PMM
