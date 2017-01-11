Received: from eggs.gnu.org ([2001:4830:134:3::10]:54172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRM7L-0007lb-2Y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRM7G-0001jg-4k
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:51:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cRM7F-0001jC-TI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:51:14 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12AFF61BA0
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:51:14 +0000 (UTC)
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-3-pbonzini@redhat.com>
	<20170111163535.GB9269@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90d94a40-a90c-efcb-d4b8-31045ca1344a@redhat.com>
Date: Wed, 11 Jan 2017 17:51:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170111163535.GB9269@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mmjpVWCQm49OcaWb2QcA1fjlgKxG8eo0p"
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-thread: introduce QemuLockCnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mmjpVWCQm49OcaWb2QcA1fjlgKxG8eo0p
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com
Message-ID: <90d94a40-a90c-efcb-d4b8-31045ca1344a@redhat.com>
Subject: Re: [PATCH 02/10] qemu-thread: introduce QemuLockCnt
References: <20170104132625.28059-1-pbonzini@redhat.com>
 <20170104132625.28059-3-pbonzini@redhat.com>
 <20170111163535.GB9269@stefanha-x1.localdomain>
In-Reply-To: <20170111163535.GB9269@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 11/01/2017 17:35, Stefan Hajnoczi wrote:
> On Wed, Jan 04, 2017 at 02:26:17PM +0100, Paolo Bonzini wrote:
>> +/* Decrement a counter, and return locked if it is decremented to zer=
o.
>> + * It is impossible for the counter to become nonzero while the mutex=

>> + * is taken.
>> + */
>> +bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt)
>> +{
>> +    int val =3D atomic_read(&lockcnt->count);
>=20
> Why does qemu_lockcnt_inc() use atomic_mb_read() while this function
> uses plain atomic_read()?

qemu_lockcnt_inc can use atomic_read indeed.

In both cases, the actual synchronization happens in atomic_cmpxchg or
qemu_lockcnt_lock.  This is just an "advisory" read to decide what path
to go through.  The worst case that can happen is that you go uselessly
once through the while-cmpxchg loop, or that you don't use the fast path
even though you could have.

In contrast, qemu_lockcnt_dec_if_lock needs atomic_mb_read to do a
load-acquire.

Paolo


--mmjpVWCQm49OcaWb2QcA1fjlgKxG8eo0p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYdmJ8AAoJEL/70l94x66DgpkIAIVdhye2PDIvS8hWefskNTs7
IoQyy2Ev+lGSvRnFAvGkRgpLo5qxAG5UuL2vM6YhCAamgbvAi+4XoDhvoIV8lEIR
1SaVvUqwBcmRmbBgHjQ/orFcLYbPt40czTu/145zhBf6bDIwXwS+Jo0w2jzKBBiz
OJNOnS8Zc81jlxUeUP79VgR1ajPIqbv7hFgw7pGVcggvhiwRsSZD0OWm0U4D7Us1
9r9z4cu1tS8C1n1eXkBpOQXBn3Egwi2NerxHGaE7NvEgQcNYVgaC4s7riqqvAqeI
Dxz6B8k9GLYRntyb/jKImJ+cYc1vhDRds2xTYwFGGofwI4A/zZQefCyZFXHEZe0=
=CSfa
-----END PGP SIGNATURE-----

--mmjpVWCQm49OcaWb2QcA1fjlgKxG8eo0p--
