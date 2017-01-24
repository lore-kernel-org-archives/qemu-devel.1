Received: from eggs.gnu.org ([2001:4830:134:3::10]:54336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0Gr-0000YE-Oa
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0Gm-0000dt-Ot
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:32:21 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cW0Gm-0000dB-IZ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:32:16 -0500
Received: by mail-wm0-x244.google.com with SMTP id d140so34450660wmd.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 04:32:16 -0800 (PST)
Date: Tue, 24 Jan 2017 12:32:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170124123213.GD17221@stefanha-x1.localdomain>
References: <20170120170757.30308-1-pbonzini@redhat.com>
	<20170120170757.30308-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <20170120170757.30308-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/7] virtio: use MemoryRegionCache to
 access descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 06:07:54PM +0100, Paolo Bonzini wrote:
> For now, the cache is created on every virtqueue_pop.  Later on,
> direct descriptors will be able to reuse it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/virtio.c | 91 ++++++++++++++++++++++++++++++------------------=
------
>  1 file changed, 50 insertions(+), 41 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYh0lNAAoJEJykq7OBq3PIJfkIAJTPG6+pTgungzSAqx4Avb8Y
q3AsPfLTX9i4YtRKStjWrRLf5HbHCKYYaG57xQlrqjby+4t6C4bLxEnWwOs4oOY8
HQUJ6yoVZwXYsWELmnWt0ppScDKhiFuBLm4eFCzyKByT81no5bacQpktckszdGcU
XeGFBtk9Fk+GYYR9Pj3u3s9pxriZztX/kuesS10cFivTVOvD+Eq/Xhji3kd+6Sgb
OHiLwLXjoH4LVg1simL/X232oU86lYhO5GWW1lNtTKbkdolvV17wag3/07vE0wxt
9ARMj+dh/HOZElv7CcmqkZE7Vt6kIKX/KRtP6VlsQ70Mw6P7Axqz/DbvqDAwbGo=
=WdoO
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
