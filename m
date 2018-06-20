Received: from eggs.gnu.org ([2001:4830:134:3::10]:55826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVeoV-0004C3-Ly
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVeoQ-0008Mx-Oh
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:14:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVeoQ-0008Ml-Jz
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:14:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35EB28163C40
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 15:14:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-8-marcandre.lureau@redhat.com>
Date: Wed, 20 Jun 2018 17:14:19 +0200
In-Reply-To: <20180321115211.17937-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 21 Mar 2018 12:51:29 +0100")
Message-ID: <878t79trqs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/49] qapi: mcgen() shouldn't indent #
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Skip preprocessor lines when adding indentation, since that would
> likely result in invalid code.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index bc4ecd6c76..47efe79758 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1931,8 +1931,8 @@ def cgen(code, **kwds):
>      if indent_level:
>          indent =3D genindent(indent_level)
>          # re.subn() lacks flags support before Python 2.7, use re.compil=
e()
> -        raw =3D re.subn(re.compile(r'^.', re.MULTILINE),
> -                      indent + r'\g<0>', raw)
> +        raw =3D re.subn(re.compile(r'^(?!(#|$))', re.MULTILINE),
> +                      indent, raw)
>          raw =3D raw[0]
>      return re.sub(re.escape(eatspace) + r' *', '', raw)

Reviewed-by: Markus Armbruster <armbru@redhat.com>
