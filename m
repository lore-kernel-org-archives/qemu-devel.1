Received: from eggs.gnu.org ([2001:4830:134:3::10]:58129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eidif-0005ud-4D
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eidid-0000Fb-Tg
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:09:49 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eidid-0000Dq-Mv
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:09:47 -0500
Received: by mail-wm0-x241.google.com with SMTP id r78so24713629wme.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 02:09:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180205054725.25634-2-famz@redhat.com>
References: <20180205054725.25634-1-famz@redhat.com>
	<20180205054725.25634-2-famz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 5 Feb 2018 11:09:46 +0100
Message-ID: <CAJ+F1CLFGVMW-qQ12qHnxZ54jO=24_tdBYfkQo49djA=n_RXdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hi

On Mon, Feb 5, 2018 at 6:47 AM, Fam Zheng <famz@redhat.com> wrote:
> git-publish [1] is a convenient tool to send patches and has been
> popular among QEMU developers.  Recently it has been made available in
> Fedora official repo thanks to Stefan's work.
>
> One nice feature of the tool is a per-project configuration with
> profiles, especially in which the cccmd option is a handy method to
> create the Cc list.
>
> [1]: https://github.com/stefanha/git-publish
>
> Signed-off-by: Fam Zheng <famz@redhat.com>

pretty good set of default profiles,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  .gitpublish | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  1 file changed, 58 insertions(+)
>  create mode 100644 .gitpublish
>
> diff --git a/.gitpublish b/.gitpublish
> new file mode 100644
> index 0000000000..ed48f6e52c
> --- /dev/null
> +++ b/.gitpublish
> @@ -0,0 +1,58 @@
> +#
> +# Common git-publish profiles that can be used to send patches to QEMU u=
pstream.
> +#
> +# See https://github.com/stefanha/git-publish for more information
> +#
> +[gitpublishprofile "default"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "rfc"]
> +base =3D master
> +prefix =3D RFC PATCH
> +to =3D qemu-devel@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "stable"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-stable@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "trivial"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-trivial@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "block"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-block@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "arm"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-arm@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "s390"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-s390@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> +
> +[gitpublishprofile "ppc"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-ppc@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> --
> 2.14.3
>



--=20
Marc-Andr=C3=A9 Lureau
