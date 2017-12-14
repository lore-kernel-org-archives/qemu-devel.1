Received: from eggs.gnu.org ([2001:4830:134:3::10]:37728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePRR2-00070V-Ia
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePRQz-0005jD-Aq
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:12:16 -0500
Date: Thu, 14 Dec 2017 11:12:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214111200.GD14433@stefanha-x1.localdomain>
References: <20171207201320.19284-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <20171207201320.19284-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] block: avoid recursive AioContext
 acquire in bdrv_inactivate_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 08:13:14PM +0000, Stefan Hajnoczi wrote:
> v2:
>  * Added docs/devel/multiple-iothreads.txt doc update [Kevin]
>  * Added qemu-iotests 203 test case [Kevin]
>  * Added iothread_stop() race fix to make 203 reliable
>=20
> Patch 1 is Paolo's recursive locking removal in bdrv_inactivate_all().  T=
his
> solve migration hangs and is the main point of the patch series.
>=20
> Patches 2-6 add a qemu-iotests test case and update the multiple-iothread=
s.txt
> documentation to discourage recursive AioContext locking.
>=20
> Based-on: <20171206144550.22295-1-stefanha@redhat.com>
>=20
> Paolo Bonzini (1):
>   block: avoid recursive AioContext acquire in bdrv_inactivate_all()
>=20
> Stefan Hajnoczi (5):
>   docs: mark nested AioContext locking as a legacy API
>   blockdev: add x-blockdev-set-iothread force boolean
>   iotests: add VM.add_object()
>   iothread: fix iothread_stop() race condition
>   qemu-iotests: add 203 savevm with IOThreads test
>=20
>  docs/devel/multiple-iothreads.txt |  7 +++--
>  qapi/block-core.json              |  6 +++-
>  include/sysemu/iothread.h         |  3 +-
>  block.c                           | 14 ++++++++--
>  blockdev.c                        | 11 ++++----
>  iothread.c                        | 20 +++++++++----
>  tests/qemu-iotests/203            | 59 +++++++++++++++++++++++++++++++++=
++++++
>  tests/qemu-iotests/203.out        |  6 ++++
>  tests/qemu-iotests/group          |  1 +
>  tests/qemu-iotests/iotests.py     |  5 ++++
>  10 files changed, 114 insertions(+), 18 deletions(-)
>  create mode 100755 tests/qemu-iotests/203
>  create mode 100644 tests/qemu-iotests/203.out
>=20
> --=20
> 2.14.3
>=20

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMlx/AAoJEJykq7OBq3PIHBsH/1CWsYkXAUQJ25G2LAqvv7H2
T2VoXd1kft9dsVhC/+dc82jxvfmznFLMXjTOaC2TK9Eg9Ldt3rFP3CVnPI2EckER
n6MSEFxuXmT/qzgisY2/o2DDvfsBumC4SqXMERWFVEISCRmAxZtiIzG0O+EvP204
divGtdighMHGXXyKU5cbjwPhWCT8GYogDB+IfhFOkpK948altCmo2qetrPlZS/hf
iJtphmDmItjm4G+vak4wXhVM/mFbdWCW4sPelblld5CgwYeYWdYA0hjy/zpE8nJ/
z6e6TeC8daauwhYE1d7pud54YO5XAZRakt+FsliLgHIjrSWJhooLKfNFAMMjKjI=
=9IJo
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
