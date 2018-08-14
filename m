Received: from eggs.gnu.org ([2001:4830:134:3::10]:48575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpYws-0007ww-OX
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpYwo-0005vK-W4
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:01:22 -0400
Date: Tue, 14 Aug 2018 15:01:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180814130109.GL5025@dhcp-200-186.str.redhat.com>
References: <20180814123947.13904-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180814123947.13904-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: fix regression copying
 secrets during convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org

Am 14.08.2018 um 14:39 hat Daniel P. Berrang=E9 geschrieben:
> When the convert command is creating an output file that needs
> secrets, we need to ensure those secrets are passed to both the
> blk_new_open and bdrv_create API calls.
>=20
> This is done by qemu-img extracting all opts matching the name
> suffix "key-secret". Unfortunately the code doing this was run after th=
e
> call to bdrv_create(), which meant the QemuOpts it was extracting
> secrets from was now empty.
>=20
> Previously this worked by luks as a bug meant the "key-secret"
> parameters were not purged from the QemuOpts. This bug was fixed in
>=20
>   commit b76b4f604521e59f857d6177bc55f6f2e41fd392
>   Author: Kevin Wolf <kwolf@redhat.com>
>   Date:   Thu Jan 11 16:18:08 2018 +0100
>=20
>     qcow2: Use visitor for options in qcow2_create()
>=20
> Exposing the latent bug in qemu-img. This fix simply moves the copying
> of secrets to before the bdrv_create() call.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin
