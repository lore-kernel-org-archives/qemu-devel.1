Received: from eggs.gnu.org ([2001:4830:134:3::10]:37105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYAI2-00042T-Lt
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYAHz-0005xT-CI
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:10:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYAHy-0005wl-Tb
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:10:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE627C04B317
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:10:41 +0000 (UTC)
References: <20170407143847.GM2138@work-vm> <20170720105004.GA26866@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df82cb0b-7444-9020-e527-55f5fbcb0055@redhat.com>
Date: Thu, 20 Jul 2017 07:10:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170720105004.GA26866@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0aSGGMqFKpi4vAuMXio6WUBk3NXDwCuuv"
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
--0aSGGMqFKpi4vAuMXio6WUBk3NXDwCuuv
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <df82cb0b-7444-9020-e527-55f5fbcb0055@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
References: <20170407143847.GM2138@work-vm>
 <20170720105004.GA26866@redhat.com>
In-Reply-To: <20170720105004.GA26866@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 05:50 AM, Daniel P. Berrange wrote:
> On Fri, Apr 07, 2017 at 03:38:47PM +0100, Dr. David Alan Gilbert wrote:=

>> Hi,
>>    Fedora 26 has gcc 7.0.1 which has the normal compliment
>> of new fussy warnings; so far I've posted :
>>

>> +++ b/include/qemu/iov.h
>> @@ -46,7 +46,7 @@ static inline size_t
>>  iov_from_buf(const struct iovec *iov, unsigned int iov_cnt,
>>               size_t offset, const void *buf, size_t bytes)
>>  {
>> -    if (__builtin_constant_p(bytes) && iov_cnt &&
>> +    if (__builtin_constant_p(bytes) && iov_cnt && bytes <=3D INT_MAX =
&&
>>          offset <=3D iov[0].iov_len && bytes <=3D iov[0].iov_len - off=
set) {
>>          memcpy(iov[0].iov_base + offset, buf, bytes);
>>          return bytes;

> Unless I've missed a patch somwhere, I think the problems that these tw=
o
> chunks are fixing are still needed for current git master, to stop warn=
ings
> in the unit tests.

Huh. I guess I'm not seeing warnings (aka -Werror failures) in those
spots there because I typically compile with -g instead of -O2 for
development.  (It's annoying that the set of warnings issued by gcc
depends on your optimization levels, but such is life)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0aSGGMqFKpi4vAuMXio6WUBk3NXDwCuuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllwncAACgkQp6FrSiUn
Q2rdTwgArDvReW/uZTtC5vqKOXBAuxjrwN+5BN3w0BWIJy3kTD6wPmRDms3X03Os
4Fsiy412ZwRc2AKLi5nbxqUeRxhk3SGGvtCnsiU2812BZq30Y8nzg1Vfm744D1g7
37fUeIWtHKg/xDXhUjMomo3+QWoSJ95ny+ERPCaS9jPl0SBk/msUVAnarF+ffl6E
IS+JKRx7dsbs8lwAZ8239NSt+sWbbIPWGcvhbn3szFQdWv02C0Ax7bxLC3qob/Dc
9QJGPuXvk/0V3vzpjC3pm/uP8K5KZOyheHYEJaYHNcbnXf3/6aCRV8qJqidJERWP
Qlq2crnTXEbV5Qd9+MN+W1hI/I82vg==
=iR7f
-----END PGP SIGNATURE-----

--0aSGGMqFKpi4vAuMXio6WUBk3NXDwCuuv--
