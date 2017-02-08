Received: from eggs.gnu.org ([2001:4830:134:3::10]:59643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbGO1-00063O-TG
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbGO0-0005al-Ty
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:45:29 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-13-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b64bf91d-fe72-4586-5079-711d7f54482b@redhat.com>
Date: Wed, 8 Feb 2017 01:45:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-13-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eBXcLctVGUAK2njQEwWJ9eAhjOmuSAPev"
Subject: Re: [Qemu-devel] [PATCH v12 12/16] tests: Use null-co:// instead of
 /dev/null as the dummy image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eBXcLctVGUAK2njQEwWJ9eAhjOmuSAPev
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <b64bf91d-fe72-4586-5079-711d7f54482b@redhat.com>
Subject: Re: [PATCH v12 12/16] tests: Use null-co:// instead of /dev/null as
 the dummy image
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-13-famz@redhat.com>
In-Reply-To: <20170123123056.30383-13-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/drive_del-test.c    | 2 +-
>  tests/nvme-test.c         | 2 +-
>  tests/usb-hcd-uhci-test.c | 2 +-
>  tests/usb-hcd-xhci-test.c | 2 +-
>  tests/virtio-blk-test.c   | 2 +-
>  tests/virtio-scsi-test.c  | 4 ++--
>  6 files changed, 7 insertions(+), 7 deletions(-)

Let me just say that null(-co) has turned out to be a really useful
driver indeed.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--eBXcLctVGUAK2njQEwWJ9eAhjOmuSAPev
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliaaiASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Alm0IALZzzRGr5hSUgaLJFwZIUJ40KBN9Hf8M
2fcE5T9hiIZ0wOhWoV3iTUL5k8/7vcmg7nPmZT8VdmL0bv0KWFVzr2uk+9bTYfhN
3j9sykp4kB/GLVljPWzLVOjTflVNyCfFFjL4xVNbCUkE2LlkrM6BgBUD0gnolU91
hGEYIyb7IkV2q1+RH0Ol41TzgW4YZ1gZN1lKIc//yqjjRSr8z/5TwseT44pONEW0
izD/8N2EHa/qv3DFXPCLCO71dSayqhrKZP3pLOKe89Z0wBMgNX6qv7jq72rUwdC1
9FHzcdosr8nIc4fNtIhD4HkvL7lG5GjpFLb4bdKF0sA0Ycf5xFjApnQ=
=wquk
-----END PGP SIGNATURE-----

--eBXcLctVGUAK2njQEwWJ9eAhjOmuSAPev--
