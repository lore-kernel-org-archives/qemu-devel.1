Received: from eggs.gnu.org ([209.51.188.92]:41838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbvc-0006F0-6P
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbvb-0003qk-FU
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:44:32 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpbvX-0003oL-IO
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:44:31 -0500
Received: by mail-wm1-x344.google.com with SMTP id a62so6778719wmh.4
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:44:20 -0800 (PST)
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-8-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190201145035.22739-8-peter.maydell@linaro.org>
Date: Fri, 01 Feb 2019 16:44:18 +0000
Message-ID: <87ftt7v4pp.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/11] docs/conf.py: Disable option warnings
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

> sphinx-build complains about using :option: to mark up option
> flags that it doesn't know about (because they were not defined
> using the "option::" directive):
> docs/pr-manager.rst:68: WARNING: unknown option: -d
>
> Suppress these warnings. This way we get the semantic markup
> of the option flag but no cross-referencing hyperlink.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/conf.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/docs/conf.py b/docs/conf.py
> index 6ddaa549f28..c04000e78e4 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -76,6 +76,9 @@ pygments_style =3D 'sphinx'
>  # If true, `todo` and `todoList` produce output, else they produce nothi=
ng.
>  todo_include_todos =3D False
>
> +# Sphinx defaults to warning about use of :option: for options not defin=
ed
> +# with "option::" in the document being processed. Turn that off.
> +suppress_warnings =3D ["ref.option"]
>
>  # -- Options for HTML output -------------------------------------------=
---


--
Alex Benn=C3=A9e
