Received: from eggs.gnu.org ([2001:4830:134:3::10]:56934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQze5-0001zE-9Y
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQze0-0002Pz-Ez
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:51:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQze0-0002Pq-5h
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:51:32 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45E521556C
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 16:51:32 +0000 (UTC)
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
Date: Tue, 10 Jan 2017 10:51:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170110163713.GA19869@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PoRdvb9ktiE0AC1GIQq7GGNLDXAtUXKop"
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PoRdvb9ktiE0AC1GIQq7GGNLDXAtUXKop
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
References: <20170106155543.12827-1-berrange@redhat.com>
 <20170106155543.12827-3-berrange@redhat.com>
 <20170110163713.GA19869@stefanha-x1.localdomain>
In-Reply-To: <20170110163713.GA19869@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2017 10:37 AM, Stefan Hajnoczi wrote:
> On Fri, Jan 06, 2017 at 03:54:58PM +0000, Daniel P. Berrange wrote:
>> diff --git a/io/channel-buffer.c b/io/channel-buffer.c
>> index 43d7959..b4e50d6 100644
>> --- a/io/channel-buffer.c
>> +++ b/io/channel-buffer.c
>> @@ -22,7 +22,7 @@
>>  #include "io/channel-buffer.h"
>>  #include "io/channel-watch.h"
>>  #include "qemu/sockets.h"
>> -#include "trace.h"
>> +#include "io/trace.h"
>=20
> Is this change necessary?

Yes - now that there are more than one trace.h files spread across
multiple directories, you need a prefix to ensure the correct one gets
included.  In this particular case, it also matches consistency in
including "io/channel-buffer.h" rather than just "channel-buffer.h".

>=20
> I think the per-subdir trace.h file should be generated in
> $BUILD_DIR/<sub-dir>/trace.h and gcc -I. can locate that file.

It can indeed locate it, but now you are depending on -I ordering to
make sure it locates the right one before any other wrong one, which
feels too fragile to me.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PoRdvb9ktiE0AC1GIQq7GGNLDXAtUXKop
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdRERAAoJEKeha0olJ0NqxEMH/1AiPh2h4esGwqCtmjLGHDTN
I95q11NFKjSpuqC08Y9V9S5mEYLstnoPz1H0nnby8lR8KFCCjycrbQlbud2N2zkL
k+JbzVnT5Wt9qTL5yjzA5L78YgDsXO0V53pUrXEuq8YSeKSNnlqweET5LKB1VdOj
3fhKuyqWRtHiI0XqEaTtJ/NxaaWoLZVmKVZVdCswvKIKjdA4sbfQLcN1owlX0s5B
Vpo6UytEWm80fJBWPZXNtacXJ7r/ZUMz+kW1pPHfwmuLsQz0aIuAF5qUWI6ITVpL
+9wVlywK1KhjKGqY99howozMFhygP6MKts0Dur6LhM4eZ6qa1GKLK62ldstj2FI=
=oAkI
-----END PGP SIGNATURE-----

--PoRdvb9ktiE0AC1GIQq7GGNLDXAtUXKop--
