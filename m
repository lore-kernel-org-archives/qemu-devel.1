Received: from eggs.gnu.org ([2001:4830:134:3::10]:59122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZCVF-0006sL-Ra
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZCVA-0002ur-1z
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:21:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gZCV9-0002tn-Pr
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:21:23 -0500
References: <20181217204046.14861-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <63117208-d369-1e99-d928-7a2471076aa5@redhat.com>
Date: Tue, 18 Dec 2018 11:21:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181217204046.14861-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: fix flat union on uncovered branches
 conditionals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

On 2018-12-17 21:40, Marc-Andr=C3=A9 Lureau wrote:
> Default branches variant should use the member conditional.
>=20
> This fixes compilation with --disable-replication.
>=20
> Fixes: 335d10cd8e2c3bb6067804b095aaf6371fc1983e
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 8c2d97369e..d385a08270 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1460,7 +1460,7 @@ class QAPISchemaObjectTypeVariants(object):
>              cases =3D set([v.name for v in self.variants])
>              for m in self.tag_member.type.members:
>                  if m.name not in cases:
> -                    v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty=
')
> +                    v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty=
', m.ifcond)
>                      v.set_owner(self.tag_member.owner)
>                      self.variants.append(v)
>          for v in self.variants:

This fixes the compilation problem for me, indeed!

Tested-by: Thomas Huth <thuth@redhat.com>
