Received: from eggs.gnu.org ([2001:4830:134:3::10]:49805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elKKT-0000JI-LP
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elKKP-0008Hd-Q0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:03:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elKKP-0008H6-M5
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:03:53 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-16-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b649e58-d5ba-05eb-bc57-0d11771a0690@redhat.com>
Date: Mon, 12 Feb 2018 14:03:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/29] qapi: Record 'include' directives
 in parse tree
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
> The parse tree is a list of expressions.  Except include expressions
> currently get replaced by the included file's parse tree.
>=20
> Instead of throwing away the include expression, keep it with the file
> name expanded so you don't have to track the including file's
> directory to make sense of it.
>=20
> A future commit will put this include expression to use.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/qapi/common.py | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
