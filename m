Received: from eggs.gnu.org ([2001:4830:134:3::10]:57682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxjy-0006f5-4d
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxjv-0007qN-1v
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:49:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQxju-0007p3-PV
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:49:30 -0500
References: <1484052795-158195-1-git-send-email-imammedo@redhat.com>
	<1484052795-158195-4-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6fa24bf8-ea8f-65be-4a06-8721fbca7d27@redhat.com>
Date: Tue, 10 Jan 2017 08:49:27 -0600
MIME-Version: 1.0
In-Reply-To: <1484052795-158195-4-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="caTlhq2X8SGUlMo8HingxL99BDOKI6QAe"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] fix qmp/hmp query-memdev not
 reporting IDs of memory backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, afaerber@suse.de, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--caTlhq2X8SGUlMo8HingxL99BDOKI6QAe
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 afaerber@suse.de, pbonzini@redhat.com
Message-ID: <6fa24bf8-ea8f-65be-4a06-8721fbca7d27@redhat.com>
Subject: Re: [PATCH v2 3/3] fix qmp/hmp query-memdev not reporting IDs of
 memory backends
References: <1484052795-158195-1-git-send-email-imammedo@redhat.com>
 <1484052795-158195-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484052795-158195-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2017 06:53 AM, Igor Mammedov wrote:
> Considering 'id' is mandatory for user_creatable objects/backends
> and user_creatable_add_type() always has it as an argument
> regardless of where from it is called CLI/monitor or QMP,
> Fix issue by adding 'id' property to hostmem backends and
> set it in user_creatable_add_type() for every object that
> implements 'id' property. Then later at query-memdev time
> get 'id' from object directly.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/sysemu/hostmem.h |  1 +
>  backends/hostmem.c       | 26 ++++++++++++++++++++++++++
>  docs/qmp-commands.txt    |  1 +
>  hmp.c                    |  5 +----
>  numa.c                   |  3 +++
>  qapi-schema.json         |  3 +++
>  qom/object_interfaces.c  |  6 ++++++
>  7 files changed, 41 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--caTlhq2X8SGUlMo8HingxL99BDOKI6QAe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdPR3AAoJEKeha0olJ0Nq+JgH/jduZGdMNI29Lss5oMVBzx85
GEynkU+vuzbeznT4P0QMWcp9VAvRABrjhV/+zJDtQG3PGRwijrr1bu8vjYb2FAnj
QY4mYGLnkUr65ZFdDKdLgfwO9Z0JNqW2FUL8dZMx7F/V4T0okEeq6dTR1eQfzFup
LJ3lLevv5OArPTiFj0EM5YgIUznXByhjnDleIp1PKg+JMXAbJHQkjfMNpZ5XY1Ur
z+nmgc3nq+yvBUcmmgaX9vfep2WF7aBawzMeRCwCnfKMt5RaDS2wHZ9FPW44IZHk
Z8aoJCeY61MAtTqNYxCrpi/z2qG30b5+EePU6ggic1Gxb3CvcEKyj+PhrR51xn4=
=S+f4
-----END PGP SIGNATURE-----

--caTlhq2X8SGUlMo8HingxL99BDOKI6QAe--
