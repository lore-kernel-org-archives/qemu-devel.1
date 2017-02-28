Received: from eggs.gnu.org ([2001:4830:134:3::10]:43016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1cidcA-0002f8-C1
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:58:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1cidc5-0006iv-Hj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:58:34 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:56194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ebischoff@suse.com>) id 1cidc5-0006if-88
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:58:29 -0500
From: =?ISO-8859-1?Q?=C9ric?= Bischoff <ebischoff@suse.com>
Date: Tue, 28 Feb 2017 09:58:24 +0100
Message-ID: <2947530.VpE9bGVYKe@eric>
In-Reply-To: <10570286-fa33-485a-0773-94ed493d4ef0@twiddle.net>
References: <20170227112219.29313-1-ebischoff@suse.com>
	<20170227112219.29313-2-ebischoff@suse.com>
	<10570286-fa33-485a-0773-94ed493d4ef0@twiddle.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Qemu-devel] [PATCH] Adding support for LPD and LPDG
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Michal Marek <mmarek@suse.cz>, QEmu developers <qemu-devel@nongnu.org>, Miroslav Benes <mbenes@suse.cz>

Le mardi 28 f=E9vrier 2017, 06:10:45 CET Richard Henderson a =E9crit :
> On 02/27/2017 10:22 PM, Eric Bischoff wrote:
> > From: Eric Bischoff <ebischoff@nerim.net>
> >=20
> > LPD =3D LOAD PAIR DISJOINT
> > ---
> >=20
> >  target/s390x/insn-data.def |  4 +++-
> >  target/s390x/translate.c   | 21 +++++++++++++++++++++
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> > index 075ff59..e427988 100644
> > --- a/target/s390x/insn-data.def
> > +++ b/target/s390x/insn-data.def
> > @@ -504,7 +504,9 @@
> >=20
> >      C(0xb9e2, LOCGR,   RRF_c, LOC, r1, r2, r1, 0, loc, 0)
> >      C(0xebf2, LOC,     RSY_b, LOC, r1, m2_32u, new, r1_32, loc, 0)
> >      C(0xebe2, LOCG,    RSY_b, LOC, r1, m2_64, r1, 0, loc, 0)
> >=20
> > -/* LOAD PAIR DISJOINT TODO */
> > +/* LOAD PAIR DISJOINT */
> > +    C(0xc804, LPD,     SSF,   ILA, m1_32s, m2_32s, 0, r3_P32, movx, ze=
ro)
> > +    C(0xc805, LPDG,    SSF,   ILA, m1_64, m2_64, 0, r3_P64, movx, zero)
>=20
> The think is, in order to be able to say that the two loads were
> interlocked, which is what you're doing with CC=3D0, we need to provide s=
ome
> atomicity.
>=20
> In general, this is going to require that you check parallel_cpus, and if
> true, signal cpu_loop_exit_atomic.
>=20
> As a special case, it would be possible to check for two loads that happen
> to be sequential and perform them as an atomic read.  Whether that happens
> often enough to be worthwhile I don't know.

Understood now.

I'm working on a v3 patch based on the code kindly sent in private mail by=
=20
Richard.


=2D-=20
Eric Bischoff - SUSE Manager QA Engineer
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Jennifer Guild, Di=
lip=20
Upmanyu, Graham Norton, HRB 21284 (AG N=FCrnberg)
