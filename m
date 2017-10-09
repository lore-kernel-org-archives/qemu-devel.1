Received: from eggs.gnu.org ([2001:4830:134:3::10]:50148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1aMZ-0006fv-CU
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1aMT-0005Qi-RM
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:53:03 -0400
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
	<62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
	<20171006135425.GF26575@redhat.com>
	<CAEfK_444_fPwjnj1M8w8XNFFwiMJW-pdN7R1Tdu+FfvB38ZBtw@mail.gmail.com>
	<20171006140137.GH26575@redhat.com>
	<CAEfK_455Hr1afv-H6=9QMQErDGZJtOBgFMk2F8QJshYTLgOa1Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e46a6b2d-83e2-d558-028c-94ad41af8fa2@redhat.com>
Date: Mon, 9 Oct 2017 10:52:48 -0500
MIME-Version: 1.0
In-Reply-To: <CAEfK_455Hr1afv-H6=9QMQErDGZJtOBgFMk2F8QJshYTLgOa1Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OfJAko1KLJptSEnQ0hDwR2Rw5wU0DPBV2"
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, keith.busch@intel.com, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OfJAko1KLJptSEnQ0hDwR2Rw5wU0DPBV2
From: Eric Blake <eblake@redhat.com>
To: Doug Gale <doug16k@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, keith.busch@intel.com,
 kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <e46a6b2d-83e2-d558-028c-94ad41af8fa2@redhat.com>
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
 <62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
 <20171006135425.GF26575@redhat.com>
 <CAEfK_444_fPwjnj1M8w8XNFFwiMJW-pdN7R1Tdu+FfvB38ZBtw@mail.gmail.com>
 <20171006140137.GH26575@redhat.com>
 <CAEfK_455Hr1afv-H6=9QMQErDGZJtOBgFMk2F8QJshYTLgOa1Q@mail.gmail.com>
In-Reply-To: <CAEfK_455Hr1afv-H6=9QMQErDGZJtOBgFMk2F8QJshYTLgOa1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/07/2017 02:51 AM, Doug Gale wrote:
> Completely re-implemented patch, with significant improvements (now
> specifies values in several places I missed, also reduced the amount
> of redundant lines). I used the nvme_ as the tracing infrastructure
> prefix. Tested with -trace nvme_* on the qemu command line, worked for
> me.

This information belongs...

>=20
>>From 166f57458d60d363a10a0933c3e860985531ac96 Mon Sep 17 00:00:00 2001
> From: Doug Gale <doug16k@gmail.com>
> Date: Thu, 5 Oct 2017 19:02:03 -0400
> Subject: [PATCH] Add tracing output to NVMe emulation to help driver au=
thors.
>=20
> This uses the tracing infrastructure using nvme_ as the prefix.
>=20
> Signed-off-by: Doug Gale <doug16k@gmail.com>
> ---

=2E..here, after the --- separator.  It is useful to the patch reviewer,
but does not need to be in the 'git log' history.  The maintainers use
'git am' to process incoming patches, which automatically prunes review
comments located in this location.

Also, since this is a version 2 patch, it is best if your subject line
includes 'v2', and if you send the patch as a new top-level thread
rather than in-reply-to v1.  This can be done with 'git send-email -v2'.

The subject line is atypical; we tend to prefer 'topic: Short summary',
where you are missing the topic, you had a trailing dot that is not
typical, and where your line is longer than usual.  A better subject
line might be:

nvme: Add tracing output


For more helpful information on patch submission:

https://wiki.qemu.org/Contribute/SubmitAPatch

I didn't look closely at the patch itself, but did notice:

> +nvme_mmio_start_failed(void) "setting controller enable bit failed!"
> +nvme_mmio_start_success(void) "setting controller enable bit succeeded=
"
> +nvme_mmio_stopped(void) "cleared controller enable bit"
> +nvme_mmio_shutdown_set(void) "shutdown bit set"
> +nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
> +nvme_mmio_ignored(uint64_t offset, uint64_t data) "invalid MMIO
> write, offset=3D0x%"PRIx64", data=3D%"PRIx64"!"

You have a couple of traces with a trailing '!'; that is atypical,
because we don't need our traces to shout at the user.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OfJAko1KLJptSEnQ0hDwR2Rw5wU0DPBV2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnbm1AACgkQp6FrSiUn
Q2pVrAf+KjPs2SWhzScnFof07N0nDgfTa/rXmwO7jZF/hFjjH5gpY8lOw9FIAFdg
XSRYDOoa8/EfbgSXnft8TcJLQnzcGG350Kk1TrRAFMyisCH9oyjBcGSg2MNbgGP8
WuAsQZ39eLtgDKGr2e24M+8WedxzgUiqaUiWP5i+++JvIfQy5CFSy4iTC01qcG02
viY9TGaop3+7trB60ZKsBbj0SVYoY2cOH41YI1BWEgb7baSZVTYZija2QbejIYpc
XApau4JwtJ9vZc6OBFtuTnc4wOnQ2G3IF9ojKkOzJNhD5g680PNQjp6dUbpckPzG
WIDbhgJRPjzU9COT8AB6E4HwoAmE4A==
=DG2Y
-----END PGP SIGNATURE-----

--OfJAko1KLJptSEnQ0hDwR2Rw5wU0DPBV2--
