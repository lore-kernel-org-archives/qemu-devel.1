Received: from eggs.gnu.org ([2001:4830:134:3::10]:57466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNgZl-0001XY-Ks
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNgZc-0004zC-2d
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:02:29 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23c92cc5-029f-ec4c-03d0-d56045001cab@redhat.com>
Date: Fri, 16 Nov 2018 10:01:35 -0600
MIME-Version: 1.0
In-Reply-To: <20181116155325.22428-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6 for-3.1] nbd: fix whitespace in server
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> A space was missing after the option number was printed:
>=20
>    Option 0x8not permitted before TLS
>=20
> becomes
>=20
>    Option 0x8 not permitted before TLS
>=20
> This fixes
>=20
>    commit 3668328303429f3bc93ab3365c66331600b06a2d
>    Author: Eric Blake <eblake@redhat.com>
>    Date:   Fri Oct 14 13:33:09 2016 -0500
>=20
>      nbd: Send message along with server NBD_REP_ERR errors
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   nbd/server.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/nbd/server.c b/nbd/server.c
> index 4e8f5ae51b..12e8139f95 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1135,7 +1135,7 @@ static int nbd_negotiate_options(NBDClient *clien=
t, uint16_t myflags,
>  =20
>               default:
>                   ret =3D nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD, er=
rp,
> -                                   "Option 0x%" PRIx32
> +                                   "Option 0x%" PRIx32 " "
>                                      "not permitted before TLS", option=
);

Visually, I'd include the space in the next line instead of on its own=20
(but that's aesthetics, not semantic). Agree that this is 3.1 material;=20
I'll queue it up and send a PR on Monday.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
