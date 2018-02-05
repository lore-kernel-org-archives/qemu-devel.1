Received: from eggs.gnu.org ([2001:4830:134:3::10]:46879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eiYqo-0008Gx-N1
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 23:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eiYql-0008SV-KO
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 23:57:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33938
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eiYql-0008OY-EZ
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 23:57:51 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w154s7LF008215
	for <qemu-devel@nongnu.org>; Sun, 4 Feb 2018 23:57:50 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxdbdwjxd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 23:57:49 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Sun, 4 Feb 2018 23:57:49 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180202063412.22466-2-famz@redhat.com>
References: <20180202063412.22466-1-famz@redhat.com>
	<20180202063412.22466-2-famz@redhat.com>
Date: Sun, 04 Feb 2018 22:55:28 -0600
Message-Id: <151780652875.30594.1924586523823645179@sif>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, stefanha@redhat.com

Quoting Fam Zheng (2018-02-02 00:34:11)
> git-publish [1] is a convenient tool to send patches and has been
> popular among QEMU developers.  Recently it has been made available in
> Fedora official repo thanks to Stefan's work.
> =

> One nice feature of the tool is a per-project configuration with
> profiles, especially in which the cccmd option is a handy method to
> create the Cc list.
> =

> [1]: https://github.com/stefanha/git-publish
> =

> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  .gitpublish | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 57 insertions(+)
>  create mode 100644 .gitpublish
> =

> diff --git a/.gitpublish b/.gitpublish
> new file mode 100644
> index 0000000000..170bd2ed48
> --- /dev/null
> +++ b/.gitpublish
> @@ -0,0 +1,57 @@
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
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null

Someone previously suggested +cc =3D qemu-trivial@nongnu.org

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
> +cc =3D qemu-pcc@nongnu.org

should be qemu-ppc@nongnu.org

> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> -- =

> 2.14.3
> =

>=20
