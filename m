Received: from eggs.gnu.org ([2001:4830:134:3::10]:42019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGOLR-0001y3-Tr
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGOLN-0007gj-0W
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:32:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGOLM-0007g7-Qk
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:32:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7F0180E7E
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 11:32:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-7-marcandre.lureau@redhat.com>
Date: Thu, 01 Jun 2017 13:32:40 +0200
In-Reply-To: <20170531135709.345-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:30 +0400")
Message-ID: <874lw0t02v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/45] object: fix potential leak in
 getters
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> If the property is not of the requested type, the getters will leak a
> QObject.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Missing
Reviewed-by: Eric Blake <eblake@redhat.com>

> ---
>  qom/object.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index eb4bc924ff..c7b8079df6 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1122,7 +1122,7 @@ char *object_property_get_str(Object *obj, const ch=
ar *name,
>          retval =3D g_strdup(qstring_get_str(qstring));
>      }
>=20=20
> -    QDECREF(qstring);
> +    qobject_decref(ret);
>      return retval;
>  }
>=20=20
> @@ -1183,7 +1183,7 @@ bool object_property_get_bool(Object *obj, const ch=
ar *name,
>          retval =3D qbool_get_bool(qbool);
>      }
>=20=20
> -    QDECREF(qbool);
> +    qobject_decref(ret);
>      return retval;
>  }
>=20=20
> @@ -1214,7 +1214,7 @@ int64_t object_property_get_int(Object *obj, const =
char *name,
>          retval =3D qint_get_int(qint);
>      }
>=20=20
> -    QDECREF(qint);
> +    qobject_decref(ret);
>      return retval;
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
