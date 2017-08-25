Received: from eggs.gnu.org ([2001:4830:134:3::10]:41678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl8dA-0002Me-NM
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl8d4-0004VA-VL
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:02:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dl8d4-0004V0-PR
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:02:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A773F4E341
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 07:02:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-10-marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 09:02:02 +0200
In-Reply-To: <20170824103350.16400-10-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 24 Aug 2017
	12:33:45 +0200")
Message-ID: <87ziaoyvth.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/14] qlit: replace
 assert(qnum_get_try_int)
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

> qnum_get_int() will assert if underlying type isn't compatible.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qobject/qlit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qobject/qlit.c b/qobject/qlit.c
> index 07ad6b05e8..7e4bf92862 100644
> --- a/qobject/qlit.c
> +++ b/qobject/qlit.c
> @@ -53,7 +53,7 @@ bool qlit_equal_qobject(const QLitObject *lhs, const QO=
bject *rhs)
>      case QTYPE_QBOOL:
>          return lhs->value.qbool =3D=3D qbool_get_bool(qobject_to_qbool(r=
hs));
>      case QTYPE_QNUM:
> -        g_assert(qnum_get_try_int(qobject_to_qnum(rhs), &val));
> +        val =3D qnum_get_int(qobject_to_qnum(rhs));
>          return lhs->value.qnum =3D=3D val;
>      case QTYPE_QSTRING:
>          return (strcmp(lhs->value.qstr,

Suggest commit message

    qlit: Replace open-coded qnum_get_int() by call

    Bonus: rids us of a side effect in an assertion.

Can do on commit.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
