Received: from eggs.gnu.org ([2001:4830:134:3::10]:45835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8K0R-0004fZ-K4
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8K0N-0000br-N0
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:03 -0400
References: <20171024230758.31779-1-riggle@google.com>
	<20171025033442.44872-1-zachriggle@gmail.com>
	<CAMP9c5=whCgR4qkOPDRKZ+adpWEPiVM=BwZp_r7qCAR7UAsWAQ@mail.gmail.com>
	<20171027093600.GA29513@kos.to>
	<CAMP9c5mm7icy06goXr3iiOEgqPbzyaWDt775+9+L=oxnqwRhpA@mail.gmail.com>
	<CAMP9c5kTQmKd7GVE8DZzvY8tTtWV=tLsgV1ptWPKhEAh=J-maQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2251f54e-4c55-7495-8f60-af40cdd80594@redhat.com>
Date: Sat, 28 Oct 2017 07:14:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAMP9c5kTQmKd7GVE8DZzvY8tTtWV=tLsgV1ptWPKhEAh=J-maQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G1jk8dkvPQnhlteKMkI7Jxu0iEk1JgwSu"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix is_proc_myself to check
 the paths via realpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zach Riggle <zachriggle@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, "open list:All patches CC here" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G1jk8dkvPQnhlteKMkI7Jxu0iEk1JgwSu
From: Eric Blake <eblake@redhat.com>
To: Zach Riggle <zachriggle@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Message-ID: <2251f54e-4c55-7495-8f60-af40cdd80594@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix is_proc_myself to check
 the paths via realpath
References: <20171024230758.31779-1-riggle@google.com>
 <20171025033442.44872-1-zachriggle@gmail.com>
 <CAMP9c5=whCgR4qkOPDRKZ+adpWEPiVM=BwZp_r7qCAR7UAsWAQ@mail.gmail.com>
 <20171027093600.GA29513@kos.to>
 <CAMP9c5mm7icy06goXr3iiOEgqPbzyaWDt775+9+L=oxnqwRhpA@mail.gmail.com>
 <CAMP9c5kTQmKd7GVE8DZzvY8tTtWV=tLsgV1ptWPKhEAh=J-maQ@mail.gmail.com>
In-Reply-To: <CAMP9c5kTQmKd7GVE8DZzvY8tTtWV=tLsgV1ptWPKhEAh=J-maQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/27/2017 09:07 PM, Zach Riggle wrote:
> Another case that may be more relevant for general QEMU use, is that th=
e
> current code fails if the software under test has poor path-handling co=
de.
> For example, any of
>=20
> - //proc/self/maps
> - /proc//self/maps
> - /proc/self//maps
>=20
> Will all return the non-emulated results.  Those examples are just path=

> canonicalization issues and could be resolved with e.g.
> canonicalize_file_name, but I'm not sure if QEMU allows GNU extensions =
--
> and realpath() is portable.

By definition, in linux-user, we ARE using glibc; therefore, you are
free to use all GNU extensions.

And you'd be surprised at how many non-glibc implementations of
realpath() are not POSIX-compliant, even though that is not relevant here=
=2E

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--G1jk8dkvPQnhlteKMkI7Jxu0iEk1JgwSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln0EkUACgkQp6FrSiUn
Q2q9eAf8D5opCz0OcGhDUH0DcNAsN7GMC70YfRczq7L90OsT44LXI0hkQYgFBZ+H
1YYl2f2vPt2BBpfzZyFdmkI6qDeP4F8sOfOq/YOFHaoOUtIh64HRNyKwMGF7Nx7p
oxkLJoFFPbK6wVsn9Dx1CaTC1k44n0bICc3LcmeuHcPfKlhuZaEQ50PkSYChqC5o
HuqFcOtMUUZ708lguw6ceKRkAtOj3UDaQplhc37RXuGK/kQWRKkpSCm3cCfu//DR
E39GWbjVMet5AHPCue4GrXFNb6vUTTOH/Cde1R0htwyV1lpeDgeHke+TpuaUfDah
o0e+Zf1pQ1VibaMR5B/z/J6d9hvltg==
=GYoB
-----END PGP SIGNATURE-----

--G1jk8dkvPQnhlteKMkI7Jxu0iEk1JgwSu--
