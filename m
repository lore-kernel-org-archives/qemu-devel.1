Received: from eggs.gnu.org ([2001:4830:134:3::10]:51477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cpxCH-00006V-8V
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cpxCE-00057T-0q
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:18:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cpxCD-000573-RM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:18:01 -0400
Date: Mon, 20 Mar 2017 09:18:00 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1732861283.9812678.1490015880135.JavaMail.zimbra@redhat.com>
In-Reply-To: <1490015515-25851-3-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
	<1490015515-25851-3-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/6] qapi2texi: Fix to actually
 fail when 'doc-required' is false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre lureau <marcandre.lureau@redhat.com>, eblake@redhat.com, mdroth@linux.vnet.ibm.com



----- Original Message -----
> Messed up in commit bc52d03.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  scripts/qapi2texi.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 8eed11a..5c4db78 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -292,6 +292,7 @@ def main(argv):
>      if not qapi.doc_required:
>          print >>sys.stderr, ("%s: need pragma 'doc-required' "
>                               "to generate documentation" % argv[0])
> +        sys.exit(1)
>      print texi_schema(schema)
> =20
> =20
> --
> 2.7.4
>=20
>=20
