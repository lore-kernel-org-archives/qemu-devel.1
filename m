Received: from eggs.gnu.org ([2001:4830:134:3::10]:56639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elJyH-0002MV-Ko
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elJyE-0007vH-JB
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:41:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elJyE-0007um-FL
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:40:58 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6755f71c-95e6-312e-d8be-1304638a81ab@redhat.com>
Date: Mon, 12 Feb 2018 13:40:39 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/29] qapi: Generate up-to-date
 copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:35 AM, Markus Armbruster wrote:
> Each generator carries a copyright notice for the generator itself,
> and another one for the files it generates.  Only the former have been
> updated along the way, the latter have not, and are all out of date.
>=20
> Fix by copying the generator's copyright notice to the generated files
> instead.  Note that the fix doesn't copy the "Authors:" part; the
> generated files' outdated Authors list goes away without replacement.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/scripts/qapi-commands.py

> @@ -257,16 +258,11 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisit=
or):
>  =20
>   blurb =3D '''
>    * Schema-defined QAPI/QMP commands
> - *
> - * Copyright IBM, Corp. 2011
> - *
> - * Authors:
> - *  Anthony Liguori   <aliguori@us.ibm.com>
>   '''

This is where we could shorten blurb to a one-line assignment instead of=20
a multiline '''...''' string, if desired.  R-b stands either way, though.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
