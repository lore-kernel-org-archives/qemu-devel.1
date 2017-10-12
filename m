Received: from eggs.gnu.org ([2001:4830:134:3::10]:38165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2eDQ-0003HB-4l
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2eDM-0007OR-2x
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:12:00 -0400
References: <150781692103.288.8938679290451561790@b58463cdfd5f>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8bb407a-9f1b-4679-e630-764b96b79edf@redhat.com>
Date: Thu, 12 Oct 2017 09:11:41 -0500
MIME-Version: 1.0
In-Reply-To: <150781692103.288.8938679290451561790@b58463cdfd5f>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FocrWPwe6jVMw7CbN7HjqkPIfbNDvIvMk"
Subject: Re: [Qemu-devel] [PATCH 00/31] Allow configuring the qcow2 L2 cache
 entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, berto@igalia.com
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, den@openvz.org, mreitz@redhat.comFam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FocrWPwe6jVMw7CbN7HjqkPIfbNDvIvMk
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, no-reply@patchew.org, berto@igalia.com
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, den@openvz.org,
 mreitz@redhat.com, Fam Zheng <famz@redhat.com>
Message-ID: <f8bb407a-9f1b-4679-e630-764b96b79edf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/31] Allow configuring the qcow2 L2 cache
 entry size
References: <150781692103.288.8938679290451561790@b58463cdfd5f>
In-Reply-To: <150781692103.288.8938679290451561790@b58463cdfd5f>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fam,

On 10/12/2017 09:02 AM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20

>   CC      block/qed.o
>   CC      block/qed-l2-cache.o
> =1B[01m=1B[K/tmp/qemu-test/src/block/qcow2.c:=1B[m=1B[K In function '=1B=
[01m=1B[Kqcow2_update_options_prepare=1B[m=1B[K':
> =1B[01m=1B[K/tmp/qemu-test/src/block/qcow2.c:899:25:=1B[m=1B[K =1B[01;3=
1m=1B[Kerror: =1B[m=1B[K'=1B[01m=1B[Kl2_cache_entry_size=1B[m=1B[K' may b=
e used uninitialized in this function [=1B[01;31m=1B[K-Werror=3Dmaybe-uni=
nitialized=1B[m=1B[K]
>      r->l2_table_cache =3D =1B[01;31m=1B[Kqcow2_cache_create(bs, l2_cac=
he_size,=1B[m=1B[K
>                          =1B[01;31m=1B[K^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~=1B[m=1B[K
>  =1B[01;31m=1B[K                                           l2_cache_ent=
ry_size)=1B[m=1B[K;
>                                             =1B[01;31m=1B[K~~~~~~~~~~~~=
~~~~~~~~=1B[m=1B[K

Any chance we can tweak patchew to tell gcc to NOT use color escape
sequences on errors?  While useful in an ANSI terminal, it tends to come
across awkwardly in email clients that don't render ANSI escapes, and
just adds bulk to the transcript.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FocrWPwe6jVMw7CbN7HjqkPIfbNDvIvMk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnfeB0ACgkQp6FrSiUn
Q2rvuAf+LuwTMINMIRt7qWxpu+k01vlAz1570Ue+4lTWWrp1qhBNkrD+8jdGDTyh
SwC2Bmd1OPBVIxyqAdimGQBdUzu6nCHlqN67PFx3PeDWTuAQAdbCtvNp5tcGC4Th
CLtXBPzQr3cbNWODlrZljF8iB8Xan/De+f89USHipnHxw/Q2TtsUagAOY18EN82I
PXFqPg3vZhCSiGGMt57tJnE8G5ma6zq+/ktAYanR8Vo3WQBd5Ughas/7olGQ5kgd
5UB0a9gJMPY2L6kDVg8WZDWcT6LJvQBW2nXQ3IQnNoLRdTE0bl60VLuqM0lDzYsb
vL4uNHirsYrDiBrXfPpK48xhaHpuUg==
=x1+f
-----END PGP SIGNATURE-----

--FocrWPwe6jVMw7CbN7HjqkPIfbNDvIvMk--
