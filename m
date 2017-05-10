Received: from eggs.gnu.org ([2001:4830:134:3::10]:56258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8Xao-0002iN-Pt
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8Xak-0000mS-Q6
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:48:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8Xak-0000mD-G3
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:48:10 -0400
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170510161201.387edc47@bahia.kaod.org>
	<22325f3a-133a-a1e3-77ae-57e0c8235696@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce4f0817-64a0-a3c9-2e2c-1617c0c1bd62@redhat.com>
Date: Wed, 10 May 2017 14:48:05 -0500
MIME-Version: 1.0
In-Reply-To: <22325f3a-133a-a1e3-77ae-57e0c8235696@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TvvxfMWjCpVb9f1jHwA3d4XcBwmUfw7e9"
Subject: Re: [Qemu-devel] [PATCH v4 1/4] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Greg Kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TvvxfMWjCpVb9f1jHwA3d4XcBwmUfw7e9
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Greg Kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: alberto garcia <berto@igalia.com>,
 jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
Message-ID: <ce4f0817-64a0-a3c9-2e2c-1617c0c1bd62@redhat.com>
Subject: Re: [PATCH v4 1/4] throttle: factor out duplicate code
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1494405683-20877-2-git-send-email-pradeep.jagadeesh@huawei.com>
 <20170510161201.387edc47@bahia.kaod.org>
 <22325f3a-133a-a1e3-77ae-57e0c8235696@huawei.com>
In-Reply-To: <22325f3a-133a-a1e3-77ae-57e0c8235696@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/10/2017 10:27 AM, Pradeep Jagadeesh wrote:

>>
>> Isn't it a bit overkill to introduce a new file for a single function =
?
>> Maybe you could simply move this to util/throttle.c ?
>>
> OK, but I will add one more function later patch. Still do you think
> better to move to util/thottle.c?

As long as util/throttle.c is not already huge, adding multiple new
functions to that file over the course of the series should be just fine.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TvvxfMWjCpVb9f1jHwA3d4XcBwmUfw7e9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE252AAoJEKeha0olJ0NqTKAH/iO3Kge04Dw7TP2bEC/moi8V
0Jq0ezwu/Qdkd6bZuDpdgBM7OXqwUHpj8Qa5Woggq3JJYTN5DrJS8qqC2HwVEBIR
vuOw2IMEovRkMflEl/rdXza3JDJS/onRnx2wSnqPPmHihnm82LsgpPbxRdjqLGqF
+idcot+6tplhPTMk9DApfsEFQpQT8UCQlgKAFridBKp+CuWY+gX/Z57C8GrmlsvT
JgK2a6+k1A08tYlZcsW8RyLEtgl0tTyzVcTqwLzL0TulZ4QtwcfLllWqMCtEJR8K
H65oaNQ35A3E9W3Pidf5hULEO0IbdU++N+Mh1iyH9WCvSPDAqPKQxmk+kqcGaVA=
=j+3V
-----END PGP SIGNATURE-----

--TvvxfMWjCpVb9f1jHwA3d4XcBwmUfw7e9--
