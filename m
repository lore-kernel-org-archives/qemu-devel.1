Received: from eggs.gnu.org ([2001:4830:134:3::10]:60717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej4su-0002JO-Cp
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej4sp-0001QZ-Jf
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:10:12 -0500
References: <20180206105204.14817-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f72831d5-6990-d37d-6c20-6e43c1a7a171@redhat.com>
Date: Tue, 6 Feb 2018 09:09:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180206105204.14817-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: include original filename when
 reporting invalid URIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 02/06/2018 04:52 AM, Daniel P. Berrang=C3=A9 wrote:
> Consider passing a JSON based block driver to "qemu-img commit"
>=20
> $ qemu-img commit 'json:{"driver":"qcow2","file":{"driver":"gluster",\
>                    "volume":"gv0","path":"sn1.qcow2",
>                    "server":[{"type":\
> 		  "tcp","host":"10.73.199.197","port":"24007"}]},}'
>=20
> Currently it will commit the content and then report an incredibly
> useless error message when trying to re-open the committed image:
>=20
>    qemu-img: invalid URI
>    Usage: file=3Dgluster[+transport]://[host[:port]]volume/path[?socket=
=3D...][,file.debug=3DN][,file.logfile=3D/path/filename.log]
>=20
> With this fix we get:
>=20
>    qemu-img: invalid URI json:{"server.0.host": "10.73.199.197",
>        "driver": "gluster", "path": "luks.qcow2", "server.0.type":
>        "tcp", "server.0.port": "24007", "volume": "gv0"}
>=20
> Of course the root cause problem still exists, but now we know
> what actually needs fixing.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   block/gluster.c  | 2 +-
>   block/sheepdog.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
