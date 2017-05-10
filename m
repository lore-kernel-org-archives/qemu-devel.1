Received: from eggs.gnu.org ([2001:4830:134:3::10]:42708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@nerim.net>) id 1d8VAm-0000NU-Gf
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ebischoff@nerim.net>) id 1d8VAj-0007fc-Cn
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:13:12 -0400
Received: from mail.workshop-chapina.com ([91.121.12.144]:36570
	helo=ks23324.kimsufi.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ebischoff@nerim.net>) id 1d8VAj-0007fQ-6w
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:13:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ks23324.kimsufi.com (Postfix) with ESMTP id 2CBFC9FCC8
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 19:13:06 +0200 (CEST)
From: =?ISO-8859-1?Q?=C9ric?= Bischoff <ebischoff@nerim.net>
Date: Wed, 10 May 2017 19:13:05 +0200
Message-ID: <6105454.pozpFHdzOs@perso>
In-Reply-To: <20170510101620.q3mob35aivxz324g@aurel32.net>
References: <20170509180715.22910-1-rth@twiddle.net>
	<20170509180715.22910-5-rth@twiddle.net>
	<20170510101620.q3mob35aivxz324g@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Le mercredi 10 mai 2017, 12:16:20 Aurelien Jarno a =E9crit :
> > +    /* In a parallel context, stop the world and single step.  */
> > +    if (parallel_cpus) {
> > +        potential_page_fault(s);
> > +        gen_helper_exit_atomic(cpu_env);
> > +        return EXIT_NORETURN;
> > +    }
>=20
> One small additional comment about this patch I haven't spotted at th=
e
> first review. The exit_atomic helper is properly restoring the CPU st=
ate
> passing the return address to cpu_loop_exit_atomic, so I believe the
> potential_page_fault call is not necessary. That said, it doesn't hur=
t
> either.

Merci pour la relecture Aur=E9lien.

Richard, what do we do? We remove the potential_page_fault(s); or not?


--=20
=C9ric Bischoff
