Received: from eggs.gnu.org ([2001:4830:134:3::10]:37636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX1Ck-0006Ti-MP
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX1Cg-0000w9-SO
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:44:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cX1Cg-0000vg-MO
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:44:14 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD1603A76B2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:44:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170125130308.16104-1-marcandre.lureau@redhat.com>
	<20170125130308.16104-2-marcandre.lureau@redhat.com>
Date: Fri, 27 Jan 2017 08:44:11 +0100
In-Reply-To: <20170125130308.16104-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 25 Jan 2017 17:03:07 +0400")
Message-ID: <87k29h7xro.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi2texi: change texi formatters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

I don't like "change FOO" subject lines.  What about;

    qapi: Simplify qapi2texi.py a bit

This way, it's obvious that the commit isn't supposed to change
behavior.  Can touch up on commit.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> STRUCT_FMT is generic enough, rename it to TYPE_FMT, use it for unions.
>
> Rename COMMAND_FMT to MSG_FMT, since it applies to both commands and
> events.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi2texi.py | 46 +++++++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 83ded95c2d..e1b79c2ad3 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -9,7 +9,7 @@ import sys
>=20=20
>  import qapi
>=20=20
> -COMMAND_FMT =3D """
> +MSG_FMT =3D """

QMP_MSG_FMT?  Your choice, can rename on commit.

>  @deftypefn {type} {{}} {name}
>=20=20
>  {body}
[...]

With the commit message improved:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
