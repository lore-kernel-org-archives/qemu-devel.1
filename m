Received: from eggs.gnu.org ([209.51.188.92]:41092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbt7-0003sh-W0
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbt7-0002hW-4n
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:41:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpbt6-0002h0-V9
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:41:57 -0500
Received: by mail-wm1-x342.google.com with SMTP id d15so6791408wmb.3
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:41:56 -0800 (PST)
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-5-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190201145035.22739-5-peter.maydell@linaro.org>
Date: Fri, 01 Feb 2019 16:41:54 +0000
Message-ID: <87k1ijv4tp.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/11] docs/conf.py: Disable unused _static
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> We don't yet have any custom static files, so disable this
> config file setting to avoid a warning from sphinx about
> not being able to find the directory.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>  docs/conf.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/docs/conf.py b/docs/conf.py
> index 53a17506615..e1d08a34a65 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -93,7 +93,11 @@ html_theme =3D 'alabaster'
>  # Add any paths that contain custom static files (such as style sheets) =
here,
>  # relative to this directory. They are copied after the builtin static f=
iles,
>  # so a file named "default.css" will overwrite the builtin "default.css".
> -html_static_path =3D ['_static']
> +# QEMU doesn't yet have any static files, so comment this out so we don't
> +# get a warning about a missing directory.
> +# If we do ever add this then it would probably be better to call the
> +# subdirectory sphinx_static, as the Linux kernel does.
> +# html_static_path =3D ['_static']
>
>  # Custom sidebar templates, must be a dictionary that maps document names
>  # to template names.


--
Alex Benn=C3=A9e
