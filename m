Received: from eggs.gnu.org ([2001:4830:134:3::10]:34286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHS-0002Fw-7i
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHO-0003GF-C0
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHO-0003EW-2G
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:14 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJd0as090781
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:12 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g80gr3xjy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:06 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:06 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-13-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-13-armbru@redhat.com>
Date: Sun, 18 Feb 2018 17:13:15 -0600
Message-Id: <151899559524.12376.11892117886800475973@sif>
Subject: Re: [Qemu-devel] [PATCH v2 12/29] qapi/common: Eliminate
 QAPISchema.exprs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2018-02-11 03:35:50)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  scripts/qapi/common.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 3e92b38ade..d72c339ad5 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1461,13 +1461,13 @@ class QAPISchema(object):
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
>              print(err, file=3Dsys.stderr)
> @@ -1652,8 +1652,8 @@ class QAPISchema(object):
>                  name, info, doc, 'arg', self._make_members(data, info))
>          self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed))
> =

> -    def _def_exprs(self):
> -        for expr_elem in self.exprs:
> +    def _def_exprs(self, exprs):
> +        for expr_elem in exprs:
>              expr =3D expr_elem['expr']
>              info =3D expr_elem['info']
>              doc =3D expr_elem.get('doc')
> -- =

> 2.13.6
>=20
