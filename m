Received: from eggs.gnu.org ([2001:4830:134:3::10]:46846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fGHuC-00019t-DR
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fGHuB-0003sL-Iq
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:44:48 -0400
Date: Wed, 9 May 2018 07:44:34 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180509074434.23de9dab.olaf@aepfle.de>
In-Reply-To: <d058d5e6-710b-2f34-9828-9ddde18069a1@redhat.com>
References: <20180418075045.27393-1-olaf@aepfle.de>
	<41df38a4-dc02-7c17-4877-26541fddd209@redhat.com>
	<d058d5e6-710b-2f34-9828-9ddde18069a1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Zizk_pDCJTyPFH+BLkmoTU2";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1] configure: recognize more rpmbuild
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org, "open list:All patches CC here" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

--Sig_/Zizk_pDCJTyPFH+BLkmoTU2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 9 May 2018 00:15:42 +0200
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> Actually, --program-prefix=3D and --exec-prefix=3D have a meaning, they
> cannot just be ignored.  For now I've removed this line; what is the
> exact incantation used by SUSE Linux?

Like in every other rpm.rpm I guess:

/usr/lib/rpm/macros:%_exec_prefix               %{_prefix}
/usr/lib/rpm/macros:    --program-prefix=3D%{?_program_prefix} \\\
/usr/lib/rpm/macros:    --exec-prefix=3D%{_exec_prefix} \\\

Are you saying your %configure is different from my %configure?
In any case, qemu has to tolerate both options.

Olaf

--Sig_/Zizk_pDCJTyPFH+BLkmoTU2
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWvKKwgAKCRBdQqD6ppg2
fodZAKDpoJorrDF+gP1OOyOT2nG74aQ/0gCgimOEXUjsevDUxTm7B4BBxZ80wG0=
=0MLq
-----END PGP SIGNATURE-----

--Sig_/Zizk_pDCJTyPFH+BLkmoTU2--
