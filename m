Received: from eggs.gnu.org ([2001:4830:134:3::10]:51773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5XWg-0003Ba-W6
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5XWc-0005ZD-TW
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:07:34 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5XWc-0005Ys-MP
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:07:30 -0400
Received: by mail-wr0-x242.google.com with SMTP id w50so17325904wrc.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 06:07:28 -0700 (PDT)
Date: Tue, 2 May 2017 14:07:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502130725.GC22502@stefanha-x1.localdomain>
References: <CADuF=xUDDOoMeVvPdH3BeqOnG+RONgwyzP5aj1kDeoYL97BtOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <CADuF=xUDDOoMeVvPdH3BeqOnG+RONgwyzP5aj1kDeoYL97BtOw@mail.gmail.com>
Subject: Re: [Qemu-devel] vhost-net - virtio - multiqueue - rx queue
 selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sujith Sankar <ssujith@avinetworks.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 10:07:33AM +0530, Sujith Sankar wrote:
> I have a question regarding the algorithm used to select rx queue of
> the VM in the case of multiqueue virtio-net on KVM.
>=20
> Given a 4-tuple, how can we calculate the index of the receive queue
> that virtio-net is going pick for that flow?  From some of the email
> threads in some of the relevant forums, it seems RSS is not used.  But
> documentations/threads do not talk about how a queue is picked.
>=20
> Could you please help me with this?

CCing Jason Wang, QEMU net maintainer.

Stefan

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCISNAAoJEJykq7OBq3PIbvMIAKqXf8ZAgKCI/UOymalFx+5f
BJjgmZcB6jbpoiq0dUv+dgF/wXJlgnDBGusLae1q9iaczf/Ve5H6G/ITjDD5SMMZ
dournlQDlflbFTX87xrWO9dWKRWncuRwGSEV5N5v409I5aVc9V3DbrmhCd3O/8nW
lpZvuA7qhm2TAY7fex+y+W2B4a80s8EolmUZVicOSc4y7KQuCMyLLrm1O/bq7m62
akyNdflmOd1OlgJTdupLfKwmXbnTUMb7rs9a3qsFN3YeSSiD+KOimBIWD6o4muo+
YxOTqPKJN8IvrQXzPfQCHl4M+dyNgHeEl01fSa1Rm+eQjpawKC/UoRPCPY0op7Q=
=SF9P
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
