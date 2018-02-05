Received: from eggs.gnu.org ([2001:4830:134:3::10]:52325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih55-0000Rp-DK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih50-0002vT-GD
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:11 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih50-0002vB-BF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:06 -0500
Received: by mail-qk0-f173.google.com with SMTP id m130so7590745qke.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:45:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-11-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-11-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:45:05 +0100
Message-ID: <CAMxuvawfEjEMj9Pj3wPgxVRZjehWU03m3sy_U2aVXjPaM_MWKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 10/21] qapi/common: Eliminate
 QAPISchema.exprs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>, mdroth@linux.vnet.ibm.com

On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/common.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 6c6962a364..78e960d07c 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1457,13 +1457,13 @@ class QAPISchema(object):
>      def __init__(self, fname):
>          try:
>              parser =3D QAPISchemaParser(open(fname, 'r'))
> -            self.exprs =3D check_exprs(parser.exprs)
> +            exprs =3D check_exprs(parser.exprs)
>              self.docs =3D parser.docs
>              self._entity_dict =3D {}
>              self._predefining =3D True
>              self._def_predefineds()
>              self._predefining =3D False
> -            self._def_exprs()
> +            self._def_exprs(exprs)
>              self.check()
>          except QAPIError as err:
>              print >>sys.stderr, err
> @@ -1648,8 +1648,8 @@ class QAPISchema(object):
>                  name, info, doc, 'arg', self._make_members(data, info))
>          self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed))
>
> -    def _def_exprs(self):
> -        for expr_elem in self.exprs:
> +    def _def_exprs(self, exprs):
> +        for expr_elem in exprs:
>              expr =3D expr_elem['expr']
>              info =3D expr_elem['info']
>              doc =3D expr_elem.get('doc')
> --
> 2.13.6
>
