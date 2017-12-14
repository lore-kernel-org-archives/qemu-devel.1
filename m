Received: from eggs.gnu.org ([2001:4830:134:3::10]:33627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePXsR-0003Uh-IO
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePXsO-0000wG-5s
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:04:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePXsN-0000vf-Vs
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:04:56 -0500
Date: Thu, 14 Dec 2017 18:04:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214180449.GU14433@stefanha-x1.localdomain>
References: <20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<5A3211CC.60607@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="czRehjsqUdpaVUeF"
Content-Disposition: inline
In-Reply-To: <5A3211CC.60607@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>


--czRehjsqUdpaVUeF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2017 at 01:53:16PM +0800, Wei Wang wrote:
> 3rd one: I'm not able to solve this one, as discussed, there are too many
> differences and it's too complex. I prefer the direction of simply gating
> the vhost-user protocol and deliver to the guest what it should see (just
> what this patch series shows). You would need to solve this issue to show
> this direction is simpler :)

At the moment the main issue deciding what to do seems to be that we
have no patches for the approach I've described.  I'll begin working on
a patch series.

If there is something else you think I could help with, please let me
know.  I'd like to contribute to vhost-pci.

Stefan

--czRehjsqUdpaVUeF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMr1AAAoJEJykq7OBq3PIFvQH/RAi3gBpD/q6kJYUVifaS3cE
grZ6O7cv6GpElcI233as+iRFBp+majF/YLKkcfGphURRxONp5381LLZOgnqmXrE9
Xaj/e36JTLCHnoa4NExoY9BKoYo30qkuMbToxEbIfraxDIlzPfJzAEohsBhzrY9e
ev/T3xxATroFZqgrWNCMFiX7irT4pwgRVgPA/9HBz96YWYqmbsGwtbecOKvHXrQR
oj79P8UAJW4AK8PqlcibSM7kRmw+4B5c+uvXVek4lQybnaxAi+nCbtYZK8fEE4tJ
Nt7poKe/EyYryWJyNUWMu163yCUKYToI2qBsrZmrJuNHL0gcUOaba1SEqPKYDx4=
=bn72
-----END PGP SIGNATURE-----

--czRehjsqUdpaVUeF--
