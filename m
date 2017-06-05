Received: from eggs.gnu.org ([2001:4830:134:3::10]:43086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHxn0-0003sz-LV
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHxmz-0007Kc-JB
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:35:46 -0400
References: <149669108916.4711.6037087433287142459@f98a8425f76e>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f68b225-34d7-e999-dc37-8437998c0157@redhat.com>
Date: Mon, 5 Jun 2017 14:35:31 -0500
MIME-Version: 1.0
In-Reply-To: <149669108916.4711.6037087433287142459@f98a8425f76e>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wJ827seamTXC31MN75WQA9R7LUKKst377"
Subject: Re: [Qemu-devel] [PATCH v3 0/4] more blkdebug tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wJ827seamTXC31MN75WQA9R7LUKKst377
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <5f68b225-34d7-e999-dc37-8437998c0157@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] more blkdebug tweaks
References: <149669108916.4711.6037087433287142459@f98a8425f76e>
In-Reply-To: <149669108916.4711.6037087433287142459@f98a8425f76e>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2017 02:31 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20

>   GTESTER tests/test-blockjob
>   GTESTER tests/test-blockjob-txn
>   GTESTER tests/test-x86-cpuid
>   GTESTER tests/test-xbzrle
>   GTESTER tests/test-vmstate
> Failed to load simple/primitive:b_1
> Failed to load simple/primitive:i64_2
> Failed to load simple/primitive:i32_1
> Failed to load simple/primitive:i32_1
> Failed to load test/with_tmp:a
> Failed to load test/tmp_child_parent:f
> Failed to load test/tmp_child:parent
> Failed to load test/with_tmp:tmp
> Failed to load test/tmp_child:diff
> Failed to load test/with_tmp:tmp
> Failed to load test/tmp_child:diff
> Failed to load test/with_tmp:tmp
>   GTESTER tests/test-cutils

Where is this noise coming from?


>   GTESTER tests/test-qmp-commands
>   GTESTER tests/test-string-input-visitor
>   GTESTER tests/test-string-output-visitor
>   GTESTER tests/test-qmp-event
>   GTESTER tests/test-opts-visitor
>   GTESTER tests/test-visitor-serialization
>   GTESTER tests/test-qht-par
> **
> ERROR:/tmp/qemu-test/src/tests/test-qga.c:894:test_qga_guest_exec: asse=
rtion failed: (exited)
> socket_accept failed: Resource temporarily unavailable

Looks like a false negative, or a problem with the tester?  I don't see
how my patch could affect test-qga.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wJ827seamTXC31MN75WQA9R7LUKKst377
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNbKDAAoJEKeha0olJ0Nq1qoH/As2EJfOZjvYuhndCEE4uagx
of+SVWIWmy9UJhnhsa/zDs9s+aJPCGfiI3/8xXRd2YuO2wyjPzu5ol+6vc+F/g4X
2ytSxID2IgEc8T6CL+NjkpJdx9kChkvbZDlEnk/Es09173ZGdNpfoAU06dtRLr6y
JdgJ7G2t0gJM2FHO6Zr9b24Q6IxXJVD5QPE+ClgJZgXL7GZMzAPD0EBd1YTeAWKd
rKObQpMrVBNbEZyVZ5xFAT7zBeN3ajsZ2h+v9qnWfjWCfjB/gyghQQ4snGESmPgs
B4RShr/oRHfx0Nhirb1c3neeAhJXndVEYR1a24LpOVHIr/keE7GhCXOG8fhQH98=
=bbpA
-----END PGP SIGNATURE-----

--wJ827seamTXC31MN75WQA9R7LUKKst377--
