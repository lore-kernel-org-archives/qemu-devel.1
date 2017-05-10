Received: from eggs.gnu.org ([2001:4830:134:3::10]:34586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WI2-00026w-Sr
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WI1-0008I3-Qe
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:24:46 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d8WI1-0008Ho-KS
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:24:45 -0400
Date: Wed, 10 May 2017 20:24:38 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170510182438.rqj765wtbmun2i3u@aurel32.net>
References: <20170509180715.22910-1-rth@twiddle.net>
	<20170509180715.22910-5-rth@twiddle.net>
	<20170510101620.q3mob35aivxz324g@aurel32.net>
	<6105454.pozpFHdzOs@perso>
	<7a84cbc8-ea93-ada5-eeaf-fc1ac143d826@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7a84cbc8-ea93-ada5-eeaf-fc1ac143d826@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 4/6] target/s390x: Implement LOAD PAIR
 DISJOINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?iso-8859-15?Q?=C9ric?= Bischoff <ebischoff@nerim.net>, qemu-devel@nongnu.org

On 2017-05-10 10:43, Richard Henderson wrote:
> On 05/10/2017 10:13 AM, =C9ric Bischoff wrote:
> > Le mercredi 10 mai 2017, 12:16:20 Aurelien Jarno a =E9crit :
> > > > +    /* In a parallel context, stop the world and single step.  */
> > > > +    if (parallel_cpus) {
> > > > +        potential_page_fault(s);
> > > > +        gen_helper_exit_atomic(cpu_env);
> > > > +        return EXIT_NORETURN;
> > > > +    }
> > >=20
> > > One small additional comment about this patch I haven't spotted at the
> > > first review. The exit_atomic helper is properly restoring the CPU st=
ate
> > > passing the return address to cpu_loop_exit_atomic, so I believe the
> > > potential_page_fault call is not necessary. That said, it doesn't hurt
> > > either.
> >=20
> > Merci pour la relecture Aur=E9lien.
> >=20
> > Richard, what do we do? We remove the potential_page_fault(s); or not?
>=20
> I'm thinking of using gen_exception(EXCP_ATOMIC) instead.
> The unwind associated with the regular helper_exit_atomic
> has more overhead than potential_page_fault().

That was just a remark to optimize the code a bit. That said I think the
current code can go like that, it is not wrong.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
