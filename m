Received: from eggs.gnu.org ([209.51.188.92]:38271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz0Fr-0002G9-OE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz0Fp-0000UR-K7
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:32:15 -0500
References: <20190227115152.1906-1-berrange@redhat.com>
	<20190227115152.1906-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2be9f39-4178-7ad9-8d15-c2f50042b31f@redhat.com>
Date: Wed, 27 Feb 2019 08:30:08 -0600
MIME-Version: 1.0
In-Reply-To: <20190227115152.1906-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/2] nbd: allow authorization with
 nbd-server-start QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>

On 2/27/19 5:51 AM, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> As with the previous patch to qemu-nbd, the nbd-server-start QMP comman=
d
> also needs to be able to specify authorization when enabling TLS encryp=
tion.
>=20

> They can then reference this in the new 'tls-authz' parameter when
> executing the 'nbd-server-start' command:
>=20
>    {
>      'execute': 'nbd-server-start',
>      'arguments': {
>        'addr': {
>            'type': 'inet',
>            'host': '127.0.0.1',
>            'port': '9000'
>        },
>        'tls-creds': 'tls0',
>        'tls-authz': 'authz0'
>      }
>    }
>=20

> +++ b/qapi/block.json
> @@ -225,6 +225,11 @@
>  #
>  # @addr: Address on which to listen.
>  # @tls-creds: (optional) ID of the TLS credentials object. Since 2.6
> +# @tls-authz: ID of the QAuthZ authorization object used to validate
> +#             the client's x509 distinguished name. This object is
> +#             is only resolved at time of use, so can be deleted and
> +#             recreated on the fly while the NBD server is active.
> +#             If missing, it will default to denying access. Since 4.0

Pre-existing formatting nit - per-variable release notes tend to be
wrapped in (), as in '(since 4.0)'. tls-creds would need fixing, if we
also want that for tls-authz.  But we aren't 100% consistent, and it is
minor, so it does not stop me from:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
