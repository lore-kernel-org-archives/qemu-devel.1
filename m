Received: from eggs.gnu.org ([2001:4830:134:3::10]:35263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1egpHU-0000bi-VR
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 05:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1egpHL-0003lY-CO
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 05:06:16 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1egpHL-0003l8-3y
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 05:06:07 -0500
Received: by mail-wm0-x241.google.com with SMTP id r78so6825490wme.0
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 02:06:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180131053318.13109-1-famz@redhat.com>
References: <20180131053318.13109-1-famz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 Jan 2018 11:06:05 +0100
Message-ID: <CAJ+F1C+v8B4STJS6v7ujGfu83oYFG6x9gcbu4D3T5VaDg382kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Hi

On Wed, Jan 31, 2018 at 6:33 AM, Fam Zheng <famz@redhat.com> wrote:
> git-publish [1] is a convenient tool to send patches and has been
> popular among QEMU developers.  Recently it has been made available in
> Fedora official repo thanks to Stefan's work.
>
> One nice feature of the tool is a per-project configuration with
> profiles, especially in which the cccmd option is a handy method to
> create the Cc list.
>
> [1]: https://github.com/stefanha/git-publish

It would be worth to update README "Submitting patches" with an example
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  .gitpublish | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 57 insertions(+)
>  create mode 100644 .gitpublish
>
> diff --git a/.gitpublish b/.gitpublish
> new file mode 100644
> index 0000000000..2099c1520f
> --- /dev/null
> +++ b/.gitpublish
> @@ -0,0 +1,57 @@
> +#
> +# Common git-publish profiles that can be used to send patches to QEMU u=
pstream.
> +#
> +# See https://github.com/stefanha/git-publish for more information
> +#
> +[gitpublishprofile "qemu"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-rfc"]
> +base =3D master
> +prefix =3D RFC PATCH
> +to =3D qemu-devel@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-stable"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-stable@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-trivial"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org

cc qemu-trivial@nongnu.org ?

> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-block"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-block@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-arm"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-arm@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-s390"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-s390@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-ppc"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-pcc@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
