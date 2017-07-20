Received: from eggs.gnu.org ([2001:4830:134:3::10]:48140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGJb-0006sI-3a
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGJX-0007KT-2K
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:36:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYGJW-0007KA-P1
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:36:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99A97C000676
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 18:36:41 +0000 (UTC)
References: <20170407143847.GM2138@work-vm>
	<20170720105004.GA26866@redhat.com> <20170720161548.GC2456@work-vm>
	<20170720164730.GP21566@redhat.com> <20170720170443.GG2456@work-vm>
	<20170720170640.GQ21566@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <82b8f161-aab0-0924-5587-b9c60ad8530d@redhat.com>
Date: Thu, 20 Jul 2017 13:36:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170720170640.GQ21566@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="95jvNXPk2n45Wuo7Bhhb79KVPAXTOJqx4"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--95jvNXPk2n45Wuo7Bhhb79KVPAXTOJqx4
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <82b8f161-aab0-0924-5587-b9c60ad8530d@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
References: <20170407143847.GM2138@work-vm>
 <20170720105004.GA26866@redhat.com> <20170720161548.GC2456@work-vm>
 <20170720164730.GP21566@redhat.com> <20170720170443.GG2456@work-vm>
 <20170720170640.GQ21566@redhat.com>
In-Reply-To: <20170720170640.GQ21566@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 12:06 PM, Daniel P. Berrange wrote:
>>> IMHO your patch is ok, or we could be alittle more explicit about
>>> catching just the case where you pass -1 for bytes, and have
>>>
>>>   && bytes !=3D -1
>>
>> This seems bizarre to me since bytes is   size_t bytes   and size_t
>> is unsigned, so I'd have sympathy for a compiler that warned that
>> bytes !=3D -1 was always true.
>=20
> Could be paranoid and do    "&& bytes !=3D  (size_t)-1"

Any compiler that treats 'bytes !=3D -1' differently from 'bytes !=3D
(size_t)-1' is broken, since those two are equivalent per C99 promotion
rules (unsigned op signed produces unsigned, and conversion of signed to
unsigned is well-defined).  I prefer the form without a cast.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--95jvNXPk2n45Wuo7Bhhb79KVPAXTOJqx4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllw+DgACgkQp6FrSiUn
Q2rZ9wf+LMLwc1rQIdJvaPbSdGfFNj5vxBhG/Vk0vk7Whfy+eYmhd2B4E4/Ng2/I
hvcEQ/AxWGvGY02G5rC5Bm9pw59ad+E5r3LGiHOLau2j3Ez2whHpECKpMbKHbuQU
yn2KaUS0P1BFwe/RJ8WPtgcWT7HVt8Ifso/QF5K8y5x9AS5KOsBwarMM52g1VAd1
woMM1OXN5Vk/p3cuYSBjqsJL0wPX5eTcC1EXYVFGfnHMux1iSmwR+Xa/uvyBnY/d
MMjRUpq948AbnQEaNHMJ3+AkyMWmRk6+xA+367KMzMT7/7WCprLQ64hCFDi20/09
WX2n5xLxpWV9WuxG7P/etiIr/Ky2Lg==
=Z/A1
-----END PGP SIGNATURE-----

--95jvNXPk2n45Wuo7Bhhb79KVPAXTOJqx4--
