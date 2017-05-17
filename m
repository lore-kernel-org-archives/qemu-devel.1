Received: from eggs.gnu.org ([2001:4830:134:3::10]:54407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB5H0-0006Kb-F5
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB5Gz-00044V-Jl
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:10:18 -0400
References: <20170517170941.25850-1-stefanha@redhat.com>
	<20170517170941.25850-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c53489e-56ac-1f35-f511-e67c7f069a56@redhat.com>
Date: Wed, 17 May 2017 15:09:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170517170941.25850-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7adxxepQW3Ow10hJx4arAFC10BjhLe71s"
Subject: Re: [Qemu-devel] [PATCH 1/3] block: count bdrv_co_rw_vmstate()
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7adxxepQW3Ow10hJx4arAFC10BjhLe71s
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org
Message-ID: <5c53489e-56ac-1f35-f511-e67c7f069a56@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: count bdrv_co_rw_vmstate()
 requests
References: <20170517170941.25850-1-stefanha@redhat.com>
 <20170517170941.25850-2-stefanha@redhat.com>
In-Reply-To: <20170517170941.25850-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 12:09 PM, Stefan Hajnoczi wrote:
> Call bdrv_inc/dec_in_flight() for vmstate reads/writes.  This seems
> unnecessary at first glance because vmstate reads/writes are done
> synchronously while the guest is stopped.  But we need the bdrv_wakeup(=
)
> in bdrv_dec_in_flight() so the main loop sees request completion.
> Besides, it's cleaner to count vmstate reads/writes like ordinary
> read/write requests.
>=20
> The bdrv_wakeup() partially fixes a 'savevm' hang with -object iothread=
=2E
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/io.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7adxxepQW3Ow10hJx4arAFC10BjhLe71s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHK4PAAoJEKeha0olJ0NqC0oH/1DWOlRAb5/GQPyM0An+mBHb
j1eAF0SdkW6dEyysrx55vqtFozS4vhTospSOHMdWtaXR0zoVn7RKFpDf/mrU5gOD
u6fv2Pu2HQ/Wr6sIbtXnb2hfI49zy2pjU1ZAusIfCcg9fFMex6zYPrUMBNfWWM4f
SYb09BpHjvJGLOY+I9CPXHVnndMkyJmTvuRngN3hjRl9uwXLlftpM4KFSgqIHpHM
+WyfiPMYfJaNlVnV5RCYduyOJCnY9g8dL4uULCG7SSdDcsAbgGe+FeUzZdUNVZsf
1tuTnGKyrVR5vuherOs4xPwwy4IqgiNBWFXcqD3k7xnVipYe7d/vaaUgqfETCjU=
=dW0y
-----END PGP SIGNATURE-----

--7adxxepQW3Ow10hJx4arAFC10BjhLe71s--
