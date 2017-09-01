Received: from eggs.gnu.org ([2001:4830:134:3::10]:49130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqw4-0005p3-M0
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqw1-0003KP-K5
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqw1-0003K9-B1
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:44:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BF1CC056784
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:44:52 +0000 (UTC)
References: <150429070706.231.1744967003803393863@b5667b65043c>
From: Eric Blake <eblake@redhat.com>
Message-ID: <246d9e59-ff55-a86d-57ab-4a3bbf26b246@redhat.com>
Date: Fri, 1 Sep 2017 13:44:48 -0500
MIME-Version: 1.0
In-Reply-To: <150429070706.231.1744967003803393863@b5667b65043c>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cujCjnhW2ufr3hdgFe4fADWnFlIQA4FK2"
Subject: Re: [Qemu-devel] [PATCH v6 00/29] Preliminary libqtest cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cujCjnhW2ufr3hdgFe4fADWnFlIQA4FK2
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, armbru@redhat.com
Message-ID: <246d9e59-ff55-a86d-57ab-4a3bbf26b246@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/29] Preliminary libqtest cleanups
References: <150429070706.231.1744967003803393863@b5667b65043c>
In-Reply-To: <150429070706.231.1744967003803393863@b5667b65043c>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 01:31 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20
>   CC      tests/libqos/pci.o
>   CC      tests/libqos/fw_cfg.o
>   CC      tests/libqos/malloc.o
> In file included from /tmp/qemu-test/src/tests/libqos/fw_cfg.c:18:
> /tmp/qemu-test/src/tests/libqtest.h:22: error: redefinition of typedef =
=E2=80=98QTestState=E2=80=99
> /tmp/qemu-test/src/tests/libqos/fw_cfg.h:18: note: previous declaration=
 of =E2=80=98QTestState=E2=80=99 was here
> make: *** [tests/libqos/fw_cfg.o] Error 1
> make: *** Waiting for unfinished jobs....

Legitimate complaint due to different gcc version; I'll send a fixup
patch for the offending commit.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cujCjnhW2ufr3hdgFe4fADWnFlIQA4FK2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmpqqAACgkQp6FrSiUn
Q2psGQf/TvgzSO7THliQwfWz8ZzmwuDhL01QaWdcehHPkLglSUaK2LGvoYmnbuDc
neWwTv5In0ZYb3CvyZzjygwbWkn5urdkiHDA6v8pLPFUgg0z5B7WqBmujccNoHdn
igUVFf+vp4pyH9QX6Eu0Bujj5RsAWM5qrfcvQ5PuLe3E0clCG8AQjd1EOKDZFBWe
LfQGpnU8xFv94NgYSnpynSQLTIdluRyVs/ixPvhe5XF8FewEfcX8judLp4gA6AHg
GYrs6tt+hmqkO6CZnJhnVFoNnKws24EnaaS9JhzA5G2kKKEMBz1XaKg+rZVOYID0
SNlWXlaWqPrWNcjakM0K2OePvKhZVA==
=TSx/
-----END PGP SIGNATURE-----

--cujCjnhW2ufr3hdgFe4fADWnFlIQA4FK2--
