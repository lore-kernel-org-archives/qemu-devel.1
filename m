Received: from eggs.gnu.org ([208.118.235.92]:46077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1geh5h-00044n-7J
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1geh5d-0005KH-1G
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:01:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1geh5c-0005I4-Nb
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:01:44 -0500
Date: Wed, 2 Jan 2019 14:01:39 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190102140139.GR24009@stefanha-x1.localdomain>
References: <20180404103440.19546-1-stefanha@redhat.com>
	<008ac6e8-1e68-b0f6-7e75-77453721d031@virtuozzo.com>
	<20180410020823.GB11203@stefanha-x1.localdomain>
	<fefd54c0-d5f2-dc31-ff3c-24eb29fd2101@simark.ca>
	<788e662d-0fb6-8db8-a049-3714eaa32869@redhat.com>
	<0ebf0044-d45c-74b4-d323-2391daa12a0c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7L9kolmstoDTZ4pm"
Content-Disposition: inline
In-Reply-To: <0ebf0044-d45c-74b4-d323-2391daa12a0c@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] scripts/qemugdb: support coroutine
 backtrace in coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Pedro Alves <palves@redhat.com>, Simon Marchi <simark@simark.ca>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "gdb@sourceware.org" <gdb@sourceware.org>


--7L9kolmstoDTZ4pm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 27, 2018 at 05:36:04PM +0000, Vladimir Sementsov-Ogievskiy wrot=
e:
> 23.04.2018 16:28, Pedro Alves wrote:
> > On 04/23/2018 02:37 AM, Simon Marchi wrote:
> >> On 2018-04-09 10:08 PM, Stefan Hajnoczi wrote:
> >>> I wonder what the point of select-frame is then...
> >>>
> >>> I have CCed the GDB mailing list.  Maybe someone can help us.  Contex=
t:
> >>>
> >>> QEMU implements coroutines using jmpbuf.  We'd like to print coroutine
> >>> call stacks in GDB and have a script that works when a process is bei=
ng
> >>> debugged (it sets the registers).
> >>>
> >>> Now we'd like to extend the script to work on core dumps where it's n=
ot
> >>> possible to set registers (since there is no process being debugged).
> >>>
> >>> Is there a way to backtrace an arbitrary call stack in a core dump?
> >>
> >> Not that I know of.  The "frame <stack-addr> <pc-addr>" form of the fr=
ame
> >> command sounds like it should be usable to achieve that, but it doesn't
> >> seem to work in that way.  I really wonder if it's working as it was
> >> intended initially.  I guess using that form of the frame command shou=
ld
> >> override/mask the real current values of $sp and $pc?
> >=20
> > Yeah, "frame <args>" has a lot of problems.
> >=20
> > This series was working toward sorting out the "frame" command:
> >=20
> >    https://sourceware.org/ml/gdb-patches/2015-09/msg00248.html
> >=20
> > Follow the urls there for more background.
> >=20
> > To me, the important questions to answer are here:
> >   https://sourceware.org/ml/gdb-patches/2015-09/msg00658.html
> >=20
> > Unfortunately, I don't think the series moved past that point.
> >=20
> > Thanks,
> > Pedro Alves
> >=20
>=20
>=20
> Hi Pedro!
>=20
> Hmm, returned to this topic. I've spent this day digging in gdb code, and=
 found it much
> more difficult than qemu)..
>=20
> I've failed to find something like
>=20
> create_frame_with_registers, or create_thread_with_registers.. Looks like=
 registers comes
> from some register caches, backed by different sources of registers or so=
mething like this.
>=20
> So, I'd like to ask several questions:
>=20
> 1. Any news on the topic since April?

Not on my side, sorry.

Stefan

--7L9kolmstoDTZ4pm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLMRDAAoJEJykq7OBq3PIzr0H/3JgxuOiiDz1UQqFYGH0k/Uk
2h78ERlQku+DoQJOZGOnip/btanxeFAUHEAdRK5Dr68wx/3rcDzQc/xW8Eq5TvIY
D0aiZItMluSJjhXS002k9otMZcrpcKnma4ztGFdJjlnrjq7+5dV/iAqKj7hulmTR
xkV6lnzsvNE1XxMWJmVxWxGA4mD9F0NI/j4nlh92qKQvdmigjlCyn4qfVGQifTYc
T70Pdm15XayROMuE0+f+9K+LecTrOJhHUAWDL3C5R9OpJRCzCar5DX6f9j6pIBAT
2CE6Kn0IYldoSIqcNgP7JgLwtzLRUKZmx7CuOZsiwt2g3u2o3+Rk2SjwDhu97h4=
=1cbv
-----END PGP SIGNATURE-----

--7L9kolmstoDTZ4pm--
