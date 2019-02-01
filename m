Received: from eggs.gnu.org ([209.51.188.92]:41621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbv6-0005fp-Ly
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbv2-0003eH-Tc
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:43:58 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpbv2-0003bE-Kt
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:43:56 -0500
Received: by mail-wr1-x442.google.com with SMTP id p4so7785492wrt.7
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:43:46 -0800 (PST)
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-6-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190201145035.22739-6-peter.maydell@linaro.org>
Date: Fri, 01 Feb 2019 16:43:43 +0000
Message-ID: <87imy3v4qo.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] docs/conf.py: Configure the
 'alabaster' theme
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

> Add the 'navigation' bar to the sidebar, which for some
> reason is not enabled by default. Remove 'relations', which
> is effectively disabled anyway and isn't useful for us.

I'm not sure what the title means... is the theme a reference to a
layout? I thought themes were colours and other such visual frippery
rather than actual content layout. But what do I know as a mere code
monkey...

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/conf.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/docs/conf.py b/docs/conf.py
> index e1d08a34a65..348e6358740 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -106,7 +106,8 @@ html_theme =3D 'alabaster'
>  # refs: http://alabaster.readthedocs.io/en/latest/installation.html#side=
bars
>  html_sidebars =3D {
>      '**': [
> -        'relations.html',  # needs 'show_related': True theme option to =
display
> +        'about.html',
> +        'navigation.html',
>          'searchbox.html',
>      ]
>  }


--
Alex Benn=C3=A9e
