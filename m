Received: from eggs.gnu.org ([2001:4830:134:3::10]:37519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZxNk-0001z6-Lt
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZxNj-00028S-Jt
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:20:20 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZxNj-00027Y-1x
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:20:19 -0500
Received: by mail-wm0-x22c.google.com with SMTP id b76so11177034wmg.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:20:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
References: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jan 2018 12:20:17 +0100
Message-ID: <CAJ+F1CKEzDRifyv8nd3EYNLgX3khAH858f7szwYSDdpTszW+Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: change Fedora base image to
 fedora:27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

Hi

On Fri, Jan 12, 2018 at 12:11 PM, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> Using "fedora:latest" makes behavior different depending on when you
> actually pulled the image from the docker repository.  In my case,
> the supposedly "latest" image was a Fedora 25 download from 8 months
> ago, and the new "test-debug" test was failing.
>
> Use "27" to improve reproducibility and make it clear when the image
> is obsolete.

Use rawhide instead? :)

>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index 32de731..714adad 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,4 +1,4 @@
> -FROM fedora:latest
> +FROM fedora:27
>  ENV PACKAGES \
>      ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostna=
me \
>      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
> --
> 1.8.3.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
