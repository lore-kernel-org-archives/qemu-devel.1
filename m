Received: from eggs.gnu.org ([2001:4830:134:3::10]:38487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZyfu-0004kJ-V8
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZyfp-0002V7-Rr
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:15:26 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:50768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fZyfp-0002Ui-89
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:15:21 -0400
Received: by mail-wm0-x22f.google.com with SMTP id v25-v6so8058958wmc.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:15:21 -0700 (PDT)
Date: Mon, 2 Jul 2018 14:15:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702131518.GF2155@stefanha-x1.localdomain>
References: <86b43998-fc9e-75bf-564c-a64d72163793@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <86b43998-fc9e-75bf-564c-a64d72163793@huawei.com>
Subject: Re: [Qemu-devel] question: disk missing in the guest contingently
 when hotplug several virtio scsi disks consecutively.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: l00284672 <lizhengui@huawei.com>
Cc: famz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 06:33:16PM +0800, l00284672 wrote:
> Hi, I found a bug that disk missing (not all disks missing ) in the guest
> contingently when hotplug several virtio scsi disks consecutively.=A0 Aft=
er
> rebooting the guest,

For the record, there is also a bug report here:

https://bugs.launchpad.net/qemu/+bug/1779120

I plan to reproduce this issue soon.

Stefan

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOiVmAAoJEJykq7OBq3PIfDIH/1BcBSAnSx9jdOK7Fk7R0MvP
8lIxGKheQlpjytcBjCW3u3S/WxXH9aKYsHR/7Y1U8KDde6RFclIis0yBVWm0kKA5
i7rrzdBXb4D1q9fJIuNUNss8h0jE2xqbjM9Ne1vQRLpSF0B7fbuX8+ffOhyCpT2I
VVN3LYqNtgoh9DkJU1AsYMOgtfQuBbpSOB4seHzFTNOK49QNnGQsBQNTaCv+7LSV
ePKK4YghDIw3xIvmaFn2Om36WxpIT/uwuxU+WU9p0h4Imhj6PrO7bA4EO3pLWufc
FVV4XegBsTF/HqVSZZDofwSFb1sQ2dM1hHH0fBXK7e7H6X/5ptk1EALfoICjMg8=
=dVBv
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
