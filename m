Received: from eggs.gnu.org ([2001:4830:134:3::10]:57879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVvII-0002ru-7B
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVvIH-0004vU-DV
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:50:18 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:44522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVvIH-0004vA-1a
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:50:17 -0400
Received: by mail-ot0-x241.google.com with SMTP id w13-v6so2674783ote.11
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 01:50:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621062605.941-2-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
	<20180621062605.941-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Jun 2018 09:49:55 +0100
Message-ID: <CAFEAcA8WQD26TW+zfd-f=qeUP7QFxHixV-AENWEmWyyNU3bseg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 01/57] docker: docker.py wrap StringIO
 import for python3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>

On 21 June 2018 at 07:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Although the docker.py is nominally python2 we actually invoke it with
> the configured python from the configure script.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 306e14cf69..e4095270eb 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -26,7 +26,10 @@ import tempfile
>  import re
>  import signal
>  from tarfile import TarFile, TarInfo
> -from StringIO import StringIO
> +try:
> +    from StringIO import StringIO
> +except ImportError:
> +    from io import StringIO
>  from shutil import copy, rmtree
>  from pwd import getpwuid

This is fairly trivial, but it is a new unreviewed patch:
would one of the python experts like to review it ?

thanks
-- PMM
