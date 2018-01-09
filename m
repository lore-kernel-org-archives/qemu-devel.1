Received: from eggs.gnu.org ([2001:4830:134:3::10]:53456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYvGt-0007JC-Eb
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYvGq-0002hA-8V
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:52:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYvGq-0002fz-10
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:52:56 -0500
Date: Tue, 9 Jan 2018 14:52:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180109145225.GI31400@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-26-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-26-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 25/27] docs: update QMP documents for OOB
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 19, 2017 at 04:45:55PM +0800, Peter Xu wrote:
> +To add OOB execution support for a command, we need to make sure the
> +command handler satisfies at least the following:

It would help to rephrase this in the imperative mood (telling the
reader what to do rather than describing what would need to be done):

"OOB command handlers must satisfy the following conditions:"

That way it's shorter and easier to read, and it communicates that these
conditions are absolutely necessary.

> +
> +- It executes extremely fast,
> +- It does not take any lock (or, it can take very small locks, but in
> +  very predictable ways),

"it can take very small locks, but in very predictable ways" does not
explain what is allowed and what isn't.

I suggest: "it can take very small locks if all critical regions also
follow the rules for OOB command handler code".

> +- It does not invoke system calls that may block,
> +- It does not access guest RAM that may block when userfaultfd is
> +  enabled for postcopy live migration.
> +
> +If someone is unsure about whether a command handler can be run in OOB
> +way, then it possibly means that it does not suite for OOB execution.

"If in doubt, do not implement OOB execution support."

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVNcpAAoJEJykq7OBq3PIap0H/Rx3/q8eQeUOpcNOgZCDEtuF
RESEGL5bzrfxN7wChncxm6bBnXTkoMW4fjoqY9jzpCg02eITjW28/+c+973q0+g+
5Bu4x1vQ24KZq0Kd62qrpy/awr0bth/NrDnxJuxRppnjspOAFQV2I9ivaUm+1GXw
Y/R8awbS5zsYu2oxoZ69z5EAQphPPZQtPZImZDYxz4FpYDknk/6dOznS47W1hEIo
q/cfS6OhjdeQFzocw6AahxPDdRTpx8E9hbcF/ETC/utqkO2P2z0BPwowR42mCYCX
ci8TM74i5v0gCSK8hF82rLX2ch0AvbLI/YUBRWocK3PQ2fhxSxlGSREqoxjwogk=
=+Bx6
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
