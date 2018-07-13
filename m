Received: from eggs.gnu.org ([2001:4830:134:3::10]:44741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdrl0-0007K9-7y
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 02:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdrkz-0002JW-8P
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 02:40:46 -0400
References: <20180709154549.7df475b9.cohuck@redhat.com>
	<20180711130617.GH31228@stefanha-x1.localdomain>
	<20180711151545.7e55234a.cohuck@redhat.com>
	<20180711153321.15d2237a.cohuck@redhat.com>
	<20180712163014.GB23738@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb3dd1ec-a420-1ede-d42a-4a01c8e9892f@redhat.com>
Date: Fri, 13 Jul 2018 08:40:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180712163014.GB23738@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9vrbD9XlTPMMYMOfKNUHYBW8MUVxYORKR"
Subject: Re: [Qemu-devel] qemu-nbd vs 'simple' trace backend vs iotest 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9vrbD9XlTPMMYMOfKNUHYBW8MUVxYORKR
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <eb3dd1ec-a420-1ede-d42a-4a01c8e9892f@redhat.com>
Subject: Re: [Qemu-devel] qemu-nbd vs 'simple' trace backend vs iotest 147
References: <20180709154549.7df475b9.cohuck@redhat.com>
 <20180711130617.GH31228@stefanha-x1.localdomain>
 <20180711151545.7e55234a.cohuck@redhat.com>
 <20180711153321.15d2237a.cohuck@redhat.com>
 <20180712163014.GB23738@stefanha-x1.localdomain>
In-Reply-To: <20180712163014.GB23738@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/07/2018 18:30, Stefan Hajnoczi wrote:
> On Wed, Jul 11, 2018 at 03:33:21PM +0200, Cornelia Huck wrote:
>> The other qemu-nbds (the inet and the unix socket ones from the first
>> run, the second inet one from the second run) have a single thread wit=
h
>> the same backtrace I posted above.
>=20
> We just discussed this on IRC, but for the record:
>=20
> qemu-nbd --fork will fork the process after the simpletrace write-out
> thread has been spawned.  The child process lacks this thread (due to
> how fork(2) handles multithreading).  Either qemu-nbd needs to
> initialize tracing later (but that means we cannot trace early init) or=

> simpletrace needs a way to respawn the write-out thread.

You can use pthread_atfork for this.

Paolo


--9vrbD9XlTPMMYMOfKNUHYBW8MUVxYORKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAltISVgACgkQv/vSX3jH
roN/jAf9EMUJ7USqXfvtvc1T20v7LDx5cANS609FUC9ZuzyPrhQ+f4LSQwLfCtxB
GrSed1yBj1aaePGB98RhlMuuRA2AFtqX+QlCOypPKqyoRTYvpQ8YrPUaJzrqEibm
QJhWPOzV18DwtNNSXvOCTpTLWtMhUsBTGfCgnlVt5HVjabTXxTRs6jCVzihtK+En
5UE/S2ymrGCPfh285sjTQ0eyd5UDJocTOoex+smoakMKlN9FUgA6/niNrEOOBhJN
eL71Y63dPNKa6SAg4Aew7S91fOKmg0PhUNrDk5r7n5AdGEE/c9nolCWsoqL32qvF
48rpHXcgn4LHkkAUTzs70nFGdv/NLw==
=lkw7
-----END PGP SIGNATURE-----

--9vrbD9XlTPMMYMOfKNUHYBW8MUVxYORKR--
