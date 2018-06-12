Received: from eggs.gnu.org ([2001:4830:134:3::10]:47489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSeLS-0006i5-Cg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSeLR-0003U4-Co
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:08:02 -0400
Date: Tue, 12 Jun 2018 09:07:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180612080748.GF23739@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
	<20180611205203.2624-11-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180611205203.2624-11-mreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/10] iotests: qcow2's encrypt.format
 is now optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, Jun 11, 2018 at 10:52:03PM +0200, Max Reitz wrote:
> Remove the encrypt.format option from the two blockdev-add test cases
> for encrypted qcow2 images in 087 to explicitly test that this paramete=
r
> is now optional.
>=20
> Additionally, show that explicitly specifying encrypt.format=3Dauto wor=
ks
> just as well, the same for specifying the correct format
> (encrypt.format=3Dluks here), and that specifying the wrong format
> (encrypt.format=3Daes) results in an error.
>=20
> While touching this test case, reduce the LUKS iteration time to 10 so
> the test stays reasonably fast.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/087     | 65 +++++++++++++++++++++++---------------
>  tests/qemu-iotests/087.out | 26 ++++++++++++++-
>  2 files changed, 64 insertions(+), 27 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
