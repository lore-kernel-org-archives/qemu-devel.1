Received: from eggs.gnu.org ([2001:4830:134:3::10]:46666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZmN-000402-0L
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZmM-0007VI-08
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:56:03 -0500
References: <1515425247-21730-1-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7813468a-6fc1-12f2-9234-32783e0d9cbc@redhat.com>
Date: Mon, 8 Jan 2018 09:55:50 -0600
MIME-Version: 1.0
In-Reply-To: <1515425247-21730-1-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iLbYhEg5CmrjZwcOJhfAMIX4U4whlujYx"
Subject: Re: [Qemu-devel] [PATCH] block/iscsi: fix initialization of iTask
 in iscsi_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, famz@redhat.com, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iLbYhEg5CmrjZwcOJhfAMIX4U4whlujYx
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, famz@redhat.com, qemu-stable@nongnu.org
Message-ID: <7813468a-6fc1-12f2-9234-32783e0d9cbc@redhat.com>
Subject: Re: [PATCH] block/iscsi: fix initialization of iTask in
 iscsi_co_get_block_status
References: <1515425247-21730-1-git-send-email-pl@kamp.de>
In-Reply-To: <1515425247-21730-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 09:27 AM, Peter Lieven wrote:
> in case of unaligned requests or on a target that does not support
> block provisioning we leave iTask uninitialized and check iTask.task
> for NULL later.
>=20
> Fixes: e38bc23454ef763deb4405ebdee6a1081aa00bc8
> Cc: qemu-stable@nongnu.org

qemu-stable isn't necessary right now, since e38bc23 is not part of 2.11
(backporting this patch is necessary only if that commit is first
backported to 2.11.1 or similar).

> Signed-off-by: Peter Lieven <pl@kamp.de>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/iscsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iLbYhEg5CmrjZwcOJhfAMIX4U4whlujYx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpTlIYACgkQp6FrSiUn
Q2otWwgAhYApctU7bp+1YW5pDXEQWAXZYz1DS2gPCR6A1K4VBVMnxuc7nQe8atKv
Zfx9PRIfTJAg7L+U44X1Jf3SAr4oZLXGa+wJKPPVH9YFwcJzMcl6f/vxuCH+UiQF
DR0MZJdTHEjGRMPHouAIgdHdW+p3ALE3BeOkKjqnfajUpBgbsuXQKYDl80sUyNie
x69ii1OMWLMGRy5QJ9KffTv7lpPUOCj/GXszEqlKnMSB0GOE8qWMgG+ME0pDqeE8
U3Us7gbV6g3Nyq3DAPimuUXohb/ao+9Wr+AYpL17Xd4c6BMJ5juTuor5n7z/C7I9
T+MrcoEHhm5V1RxJIGY8X4TNYPfGgw==
=Zh8Q
-----END PGP SIGNATURE-----

--iLbYhEg5CmrjZwcOJhfAMIX4U4whlujYx--
