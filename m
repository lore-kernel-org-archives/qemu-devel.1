Received: from eggs.gnu.org ([2001:4830:134:3::10]:48395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIBC4-0007Cy-9E
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIBC1-00070h-Ml
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dIBC1-00070Q-GC
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:54:29 -0400
Date: Tue, 6 Jun 2017 10:54:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170606095425.GA19655@stefanha-x1.localdomain>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
	<20170601195544.GB10517@flamenco>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20170601195544.GB10517@flamenco>
Subject: Re: [Qemu-devel] [PATCH v7 0/7] trace: [tcg] Optimize per-vCPU
 tracing states with separate TB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 03:55:44PM -0400, Emilio G. Cota wrote:
> On Fri, Jan 13, 2017 at 21:48:09 +0100, Llu=EDs Vilanova wrote:
> (snip)
> > To handle both issues, this series integrates the dynamic tracing event=
 state
> > into the TB hashing function, so that vCPUs tracing different events wi=
ll use
> > separate TBs. Note that only events with the 'vcpu' property are used f=
or
> > hashing (as stored in the bitmap of CPUState->trace_dstate).
>=20
> Is this going to be picked up by anyone? AFAICT the patchset is close
> to being merge-ready.

You left comments and the discussion with Richard Henderson is also not
complete yet.

Once there is consensus I will merge it.

Stefan

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZNnvRAAoJEJykq7OBq3PIuTYIAI5ketctiB0jHrPTrvAhinvg
Jcm4AgKRt5XavhRPdWPeRLwet+MvDn/NpdXp+W0zp7nGdPgLcCWDS4HsQyH6foya
va9xFdIjgphMMiVBKq/1irP+1+Q8exIkkIjHWwIY8Zjh8tGZADK0R+UJKJVnkPXe
zYIokJ+ftab8fvDlwIFkbbGxU8tYwFt2BgfnUFlaECmAbaz1Gh1adC+zYHX5cE4U
kAT0q6wcXAC8gb5Ju7bkipEM9HrbmbDHiTJpw8CEtK1RzfYa+ZmdjDv6fIYwdXa2
RzGQvv18jExu6myU+AqeZ+kOsGE2jAcjdOFa5rFolMo+UMt3uZOXmcQtpdsdHcw=
=0oUq
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
