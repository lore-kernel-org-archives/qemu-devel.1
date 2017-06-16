Received: from eggs.gnu.org ([2001:4830:134:3::10]:49945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLnJU-0003cR-Jj
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLnJR-0006s7-UB
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:13:08 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dLnJR-0006ru-Mb
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:13:05 -0400
Received: by mail-wm0-x244.google.com with SMTP id d64so3790109wmf.2
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 02:13:05 -0700 (PDT)
Date: Fri, 16 Jun 2017 10:13:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170616091302.GD31462@stefanha-x1.localdomain>
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-2-stefanha@redhat.com>
	<20170616062512-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <20170616062512-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio-pci: use ioeventfd even when
 KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 06:26:01AM +0300, Michael S. Tsirkin wrote:
> On Thu, Jun 15, 2017 at 05:38:09PM +0100, Stefan Hajnoczi wrote:
> > Old kvm.ko versions only supported a tiny number of ioeventfds so
> > virtio-pci avoids ioeventfds when kvm_has_many_ioeventfds() returns 0.
> >=20
> > Do not check kvm_has_many_ioeventfds() when KVM is disabled since it
> > always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a6f
> > ("memory: emulate ioeventfd") it has been possible to use ioeventfds in
> > qtest or TCG mode.
> >=20
> > This patch makes -device virtio-blk-pci,iothread=3Diothread0 work even
> > when KVM is disabled.
> >=20
> > I have tested that virtio-blk-pci works under TCG both with and without
> > iothread.
> >=20
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Don't we need to check we are on a host that supports eventfd?

That is not necessary because the ioeventfd memory API is based on
EventNotifier instead of raw eventfds.

EventNotifier falls back to pipes on POSIX platforms and uses native
Event objects on Windows.

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQ6EeAAoJEJykq7OBq3PIrlcH/jqq0CFjXngn0SmAL97jq8E1
Vqv1mW4EadHc5eFvYXnywrJg+8WwX1N1EhebtduF0uCYXLXycXbmD94SWlQucz9N
acbln2woOdWT7M5BmoPa4rMs0zgTD8/kSb1jPXg3Iip3KoFahLRgkrzp5JD4LyOK
GRd51KsROUOkIHRqRkN7k3U+NbsvtLjPaaSubNCSPW4Lud05oMqJSWKwnPItB333
a6WUiy7HxADxYMyC2dIepe5dzY5h8JDbGGhXLk1SKaBg09u03lUGjra7AkTa0T4k
3sUUTw5dOFiDImMjby0Els8uyW48FzcW1/++7EUB5JdfuIPIuECsDC917IqyB88=
=9r6V
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
