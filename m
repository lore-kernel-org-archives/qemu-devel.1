Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN47l-0004Rz-LH
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN47k-0004Bh-QR
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:54:33 -0500
References: <20171206144550.22295-1-stefanha@redhat.com>
	<20171206144550.22295-9-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ede7cdd7-74d9-da98-7484-8ae80379f862@redhat.com>
Date: Thu, 7 Dec 2017 15:54:19 -0600
MIME-Version: 1.0
In-Reply-To: <20171206144550.22295-9-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jA2ja0SJN91OU7XKfmGHRMaDeEquIfRs9"
Subject: Re: [Qemu-devel] [PATCH v2 8/9] blockdev: add
 x-blockdev-set-iothread testing command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jA2ja0SJN91OU7XKfmGHRMaDeEquIfRs9
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <ede7cdd7-74d9-da98-7484-8ae80379f862@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 8/9] blockdev: add x-blockdev-set-iothread
 testing command
References: <20171206144550.22295-1-stefanha@redhat.com>
 <20171206144550.22295-9-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-9-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 08:45 AM, Stefan Hajnoczi wrote:
> Currently there is no easy way for iotests to ensure that a BDS is boun=
d
> to a particular IOThread.  Normally the virtio-blk device calls
> blk_set_aio_context() when dataplane is enabled during guest driver
> initialization.  This never happens in iotests since -machine
> accel=3Dqtest means there is no guest activity (including device driver=

> initialization).
>=20
> This patch adds a QMP command to explicitly assign IOThreads in test
> cases.  See qapi/block-core.json for a description of the command.

The x- prefix is perfect for this.

>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-core.json | 36 ++++++++++++++++++++++++++++++++++++
>  blockdev.c           | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>=20

> +##
> +# @x-blockdev-set-iothread:
> +#
> +# Move @node and its children into the @iothread.  If @iothread is nul=
l then
> +# move @node and its children into the main loop.
> +#
> +# The node must not be attached to a BlockBackend.
> +#
> +# @node-name: the name of the block driver node
> +#
> +# @iothread: the name of the IOThread object or null for the main loop=

> +#
> +# Note: this command is experimental and intended for test cases that =
need
> +# control over IOThreads only.

I'd place 'only' sooner; it fits better as 'intended only for ...'.

As a wording tweak is minor,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jA2ja0SJN91OU7XKfmGHRMaDeEquIfRs9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopuIsACgkQp6FrSiUn
Q2o4uwgAgIGmO3CNLex35OXLBbZJzV7aR6AWiPAqpJHwbemOLG0yErPql2eBWnkl
z+hvnRxk8F8xSo5HH9SwdzW2TzmOUCiy+CzICAYsKmsQHILl9l3gaoCQVucCxRnU
zWbUgw0V2Mlq06f2mOkmnPupsve3JJTplEsKWZZM8SFlw9vN7HK4prpycY0MMYcI
c2ptPgOrm3BWwLKlvPh9oiKLKb+q+paPd25aTUNSAJ+GlCae2CTdDJObyOd/PqLW
Z7vt8g35V2IzuFK5aJeG2thdJWXqq1RCU8jS+uiajjPbQA9YloTZAw/x9ipbYDp5
mIX+xIyCDBxINJc8ANoVMU5s5WEOQA==
=00Zk
-----END PGP SIGNATURE-----

--jA2ja0SJN91OU7XKfmGHRMaDeEquIfRs9--
