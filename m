Received: from eggs.gnu.org ([209.51.188.92]:41697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbv9-0005jW-ET
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbv8-0003hy-C8
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:44:03 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpbv8-0003g5-2P
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:44:02 -0500
Received: by mail-wm1-x344.google.com with SMTP id y139so6732883wmc.5
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:44:01 -0800 (PST)
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-7-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190201145035.22739-7-peter.maydell@linaro.org>
Date: Fri, 01 Feb 2019 16:43:59 +0000
Message-ID: <87h8dnv4q8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/11] docs/conf.py: Don't include rST
 sources in HTML build
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

> Sphinx defaults to including all the rST source files
> in the HTML build and making each HTML page link to the
> source file. Disable that.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/conf.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/docs/conf.py b/docs/conf.py
> index 348e6358740..6ddaa549f28 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -112,6 +112,9 @@ html_sidebars =3D {
>      ]
>  }
>
> +# Don't copy the rST source files to the HTML output directory,
> +# and don't put links to the sources into the output HTML.
> +html_copy_source =3D False
>
>  # -- Options for HTMLHelp output ---------------------------------------=
---


--
Alex Benn=C3=A9e
