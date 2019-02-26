Received: from eggs.gnu.org ([209.51.188.92]:50345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gydL5-0002Bf-Gb
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gydKz-0006Tu-Q1
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:04:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gydKx-0006Ox-SO
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:04:01 -0500
References: <20190225152015.26089-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1bf0de1d-65b3-d33b-6ab2-0a4120c672bd@redhat.com>
Date: Tue, 26 Feb 2019 08:03:48 -0600
MIME-Version: 1.0
In-Reply-To: <20190225152015.26089-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] NBD patches for 2019-02-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Nir Soffer <nsoffer@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 2/25/19 9:20 AM, Eric Blake wrote:
> The following changes since commit 59a568b57848b10e8a44518a889323f12ccd=
d8f4:
>=20
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190222-pull-r=
equest' into staging (2019-02-25 12:49:07 +0000)
>=20
> are available in the Git repository at:
>=20
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-02-25
>=20
> for you to fetch changes up to f62b3c953fae63e627cfe86333efb6294bb48a14=
:
>=20
>   iotests: avoid broken pipe with certtool (2019-02-25 08:20:17 -0600)
>=20
> ----------------------------------------------------------------
> nbd patches for 2019-02-25
>=20
> - iotest failure fixes for tests related to NBD
>=20
> ----------------------------------------------------------------
> Andrey Shinkevich (1):
>       iotests: handle TypeError for Python3 in test 242

NACK - there will be a v2 pull request with an update for this patch.

>=20
> Daniel P. Berrang=C3=A9 (2):
>       iotests: ensure we print nbd server log on error
>       iotests: avoid broken pipe with certtool
>=20
>  tests/qemu-iotests/common.tls | 48 ++++++++++++++++++++++++++++-------=
--------
>  tests/qemu-iotests/233        |  3 +++
>  tests/qemu-iotests/242        |  8 ++++++--
>  3 files changed, 41 insertions(+), 18 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
