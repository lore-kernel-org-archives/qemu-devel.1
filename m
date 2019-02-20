Received: from eggs.gnu.org ([209.51.188.92]:51539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwUdJ-0007Ar-1O
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwUdH-0006aM-Mu
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:22:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gwUdH-0006Mu-9U
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:22:03 -0500
References: <20190220154253.26982-1-marcandre.lureau@redhat.com>
	<20190220154253.26982-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42b31625-c9f9-4578-8558-5fad41fd044d@redhat.com>
Date: Wed, 20 Feb 2019 10:21:39 -0600
MIME-Version: 1.0
In-Reply-To: <20190220154253.26982-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qga: process_event() simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 2/20/19 9:42 AM, Marc-Andr=C3=A9 Lureau wrote:
> Simplify the code around qmp_dispatch():
> - rely on qmp_dispatch/check_obj() for message checking
> - have a single send_response() point
> - constify send_response() argument
>=20
> It changes a couple of error messages:
>=20
> * When @req isn't a dictionary, from
>     Invalid JSON syntax
>   to
>     QMP input must be a JSON object
>=20
> * When @req lacks member "execute", from
>     this feature or command is not currently supported
>   to
>     QMP input lacks member 'execute'
>=20
> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/main.c | 47 +++++++++--------------------------------------
>  1 file changed, 9 insertions(+), 38 deletions(-)

Nice simplification.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
