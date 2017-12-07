Received: from eggs.gnu.org ([2001:4830:134:3::10]:58505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMxSW-0005o1-KH
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMxST-0002wf-Hk
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:47:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eMxST-0002vu-BB
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:47:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-11-marcandre.lureau@redhat.com>
Date: Thu, 07 Dec 2017 15:47:20 +0100
In-Reply-To: <20170911110623.24981-11-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:05:43 +0200")
Message-ID: <87vahioarr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/50] qapi-introspect: modify to_qlit()
 to append ', ' on level > 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The following patch is going to break list entries with #if/#endif, so
> they should have the trailing ',' as suffix.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi-introspect.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index 56c1f9d548..b1d08ec97b 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -29,7 +29,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
>                  for elt in obj]
>          elts.append(indent(level + 1) + "{}")
>          ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
> -        ret +=3D ',\n'.join(elts) + '\n'
> +        ret +=3D '\n'.join(elts) + '\n'
>          ret +=3D indent(level) + '}))'
>      elif isinstance(obj, dict):
>          elts =3D []
> @@ -42,6 +42,8 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
>          ret +=3D indent(level) + '}))'
>      else:
>          assert False                # not implemented
> +    if level > 0:
> +        ret +=3D ','
>      return ret

Reviewed-by: Markus Armbruster <armbru@redhat.com>
