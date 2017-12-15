Received: from eggs.gnu.org ([2001:4830:134:3::10]:42506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePq52-0007Rs-Ux
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePq4t-0004pq-8O
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:31:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePq4t-0004oS-1r
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:31:03 -0500
Date: Fri, 15 Dec 2017 13:30:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215133054.GI26982@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171215104101.GE15187@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Content-Disposition: inline
In-Reply-To: <20171215104101.GE15187@lemon>
Subject: Re: [Qemu-devel] [RFC v5 00/26] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 06:41:01PM +0800, Fam Zheng wrote:
> On Tue, 12/05 13:51, Peter Xu wrote:
> > This version is mostly document update, and dropped the single patch
> > that is migration related (will be put into postcopy recovery
> > series).
>=20
> Sorry if I'm asking an already answered question, if so please remind me =
with
> some pointers..
>=20
> Can we completely hide the "OOB" concept from QMP to avoid the interface
> complication? In other words, the new "migrate-recover" command can be
> implemented in a way that it always try to run out of band as if it has
> "run-oob=3Dtrue", without user specifying it or even negotiating it.
>=20
> Because it seems "migrate-recover" is only useful with "run-oob=3Dtrue".
>=20
> Of course without introducing the whole OOB concept in QMP, what this com=
mand
> does will sound very hacky, but the bahavior can be documented just well =
on the
> single command. I don't see a big advantage in generalizing OOB at the QM=
P level
> so far. Do we have a list of other commands to be made OOB?

No, that's not possible because the batching behavior changes between
oob enabled vs disabled:

Clients that don't enable oob can send several commands at once.  They
expect them to be reliably executed in sequence.

When oob is enabled batched commands can be dropped because the queue is
full.  This is necessary because otherwise the client can fill the
monitors socket receive buffer with normal commands and then it's
impossible to get an oob command through to the monitor.

Stefan

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaM86OAAoJEJykq7OBq3PINO0H/1x8N8z7sUIknrUwnctbRkvB
oncA+/Cp+Xk88qdtiSF0n3OOKt8OArEtmO+Jge9XgxPrkszILnGT7+7Mx7feDAMe
xLA9EBaQvezs3jP8uk39w1X+M5mk/W6n9aBw+0tv0GjPrNA2m5ESbn9sVcaisvuN
OjUfnkAQhcdjm314IO4VjcGZiRKIXLWyfCFczj/nwSQfN0jfdznasK7aVkz31DH6
f5EVrVZxg4qMGVIO1bFBGU1japV46nsmPbQvaeeVSntiI1GPBjQK2zezEoYCpX7N
UebbVYXF/2dIoZpuNuq3v55B0nfvB6GA9PmBkmp7/vwGnQzHpmRlXgM4XYKPhlQ=
=wLNc
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--
