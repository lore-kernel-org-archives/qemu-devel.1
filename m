Received: from eggs.gnu.org ([2001:4830:134:3::10]:46940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhcNl-0003ZI-2C
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhcNk-0008U2-7L
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:59:45 -0400
References: <20170815130740.31229-1-famz@redhat.com>
	<20170815130740.31229-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d552e805-c6bd-326c-56a4-34aea9e4db1a@redhat.com>
Date: Tue, 15 Aug 2017 08:59:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170815130740.31229-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mn2mDehgDIGMHMVImlRasF1m0hwOjvHJg"
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 1/4] stubs: Add vm state change
 handler stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mn2mDehgDIGMHMVImlRasF1m0hwOjvHJg
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 stefanha@redhat.com
Message-ID: <d552e805-c6bd-326c-56a4-34aea9e4db1a@redhat.com>
Subject: Re: [PATCH for-2.10 v2 1/4] stubs: Add vm state change handler stubs
References: <20170815130740.31229-1-famz@redhat.com>
 <20170815130740.31229-2-famz@redhat.com>
In-Reply-To: <20170815130740.31229-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 08:07 AM, Fam Zheng wrote:
> They will be used by BlockBackend code in block-obj-y, which doesn't
> always get linked with common-obj-y. Add stubs to keep ld happy.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  stubs/Makefile.objs          |  1 +
>  stubs/change-state-handler.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>  create mode 100644 stubs/change-state-handler.c

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mn2mDehgDIGMHMVImlRasF1m0hwOjvHJg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmS/kEACgkQp6FrSiUn
Q2qZkQf8CVtVs1DtA1imI/HybBwz4Nft0dWrq0hCAg2dIOmtiHu9SQLD7mDB2y/J
NjH0RCCeFQ+0Z4DrHNjb8uUu3+oWc9b9L0NS318Cd7DcRCQ4/7VH/zWtAUNYw6eM
8fngVnBtdlN4/koPkfKQbKM4BVGiBNU2YJlhlSYWi7/VY9ptAohw1qdPdiGkxH/o
zUWqrsd57VfU939jU51HY3mMamApZiEKkSo3n4qcxBDUeyUMchQ/1q/HgI/JjZQy
15huLbad8KIdaVxHRHGwr3NN+pCExJFS932MG5FwpQYYUqbJl/m20ySCbKopCQ6R
Rpf/KwKblcUInC2J4cQX+8NZHRIYLA==
=y7Rr
-----END PGP SIGNATURE-----

--mn2mDehgDIGMHMVImlRasF1m0hwOjvHJg--
