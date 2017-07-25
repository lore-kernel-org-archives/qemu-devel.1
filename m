Received: from eggs.gnu.org ([2001:4830:134:3::10]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0Kh-0003Sf-E0
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0Ke-0004wI-Da
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:57:07 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da0Ke-0004vQ-6M
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:57:04 -0400
Received: by mail-wm0-x244.google.com with SMTP id r123so7065715wmb.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:57:04 -0700 (PDT)
Date: Tue, 25 Jul 2017 14:57:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725135701.GI23343@stefanha-x1.localdomain>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-3-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oxV4ZoPwBLqAyY+a"
Content-Disposition: inline
In-Reply-To: <1500645206-13559-3-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/9] qtest: Document calling conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--oxV4ZoPwBLqAyY+a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 03:53:19PM +0200, Markus Armbruster wrote:
> From: Eric Blake <eblake@redhat.com>
>=20
> We have two flavors of vararg usage in qtest; make it clear that
> qmp() has different semantics than hmp(), and let the compiler
> enforce that hmp() is used correctly. However, qmp() (and friends)
> only accept a subset of printf flags look-alikes (namely, those
> that our JSON parser understands), and what is worse, qmp("true")
> (the JSON keyword 'true') is different from qmp("%s", "true")
> (the JSON string '"true"'), so marking those as printf-like would
> produce more harm from bogus warnings than it helps (we may have
> made a mistake in previously marking qobject_from_jsonf(), but
> this patch is not addressing that).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20170720214008.28494-5-eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/libqtest.h | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oxV4ZoPwBLqAyY+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd04tAAoJEJykq7OBq3PIIkMH/AyueKPUv50sevHOpcH2lx/V
SzFEege9RG3sTg+KGV7FsuZkRPp8593Wj0qbQ72wbfW/h718JX/SUGx2i4/D7BVF
4YON3WuBadwi0Kqi8f02vTOxNwId6X5/bboAqP5PctsXuP+8IOA/4fJjdSq3i0s5
bmLEVAOox4gdvLNzo/PniJvmKQOS3C9PAQUL6YYACBJJdG2cPZZBT3RD/ryN9VcK
6H/YD9CdwuoQBOTDEre8iVjRgQC2KMFJKuXoiAVL8hx3wD0/vPcWtkrUC5ICRG2V
zFjG8rCcKswZhqe0MjD7X3waztL0UQxwrpEioLEb3p95lk7lXB7q00GmUno6/Gc=
=RRkB
-----END PGP SIGNATURE-----

--oxV4ZoPwBLqAyY+a--
