Received: from eggs.gnu.org ([2001:4830:134:3::10]:43797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dX3O1-0004Bg-AX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dX3O0-0005jN-7w
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:36:21 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dX3Nz-0005hB-W9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:36:20 -0400
Received: by mail-lf0-x243.google.com with SMTP id z78so12849993lff.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20170717101700.23552-1-kraxel@redhat.com>
In-Reply-To: <20170717101700.23552-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Jul 2017 10:36:06 +0000
Message-ID: <CAJ+F1C+1pVwXxAH=g_5hx25VXBeMU7irpvkJ+guaqMEc7yS2Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] add scripts/indent.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hi

On Mon, Jul 17, 2017 at 12:18 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Script to reformat sources in qemu style.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

A quite powerful approach would be to use clang-format:
https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg01278.html

It comes with a bunch of editor integration and scripts. My config could
use a bit more tweaking though, I haven't been using it for a while, and
newer version have more options.


> ---
>  scripts/indent.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100755 scripts/indent.sh
>
> diff --git a/scripts/indent.sh b/scripts/indent.sh
> new file mode 100755
> index 0000000000..8f045ecb1d
> --- /dev/null
> +++ b/scripts/indent.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +#
> +# indent wrapper script, with args to format
> +# source code according to qemu coding style.
> +#
> +indent --ignore-profile        \
> +       --k-and-r-style         \
> +       --line-length 80        \
> +       --indent-level 4        \
> +       --no-tabs               \
> +       "$@"
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
