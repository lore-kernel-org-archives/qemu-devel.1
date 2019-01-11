Received: from eggs.gnu.org ([209.51.188.92]:51606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi1cE-0002Kr-Em
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi1cD-0003sE-OI
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:33:10 -0500
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:59706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gi1cD-0003hY-Gn
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:33:09 -0500
Received: from player694.ha.ovh.net (unknown [10.109.159.123])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 4943920E7E7
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 19:33:00 +0100 (CET)
Date: Fri, 11 Jan 2019 19:32:54 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190111193254.15849683@bahia.lan>
In-Reply-To: <3b4aa1f9-c18a-e2d7-abdd-f688bed9f4a1@redhat.com>
References: <20190111143815.26107-1-alex.bennee@linaro.org>
	<89afa3af-940d-7f3b-ee7c-25027bfd18f5@redhat.com>
	<87sgxzusb7.fsf@linaro.org>
	<3b4aa1f9-c18a-e2d7-abdd-f688bed9f4a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests: replace rem = sleep(time) with
 g_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, cota@braap.org, qemu-devel@nongnu.org, ehabkost@redhat.com

On Fri, 11 Jan 2019 16:41:41 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/01/19 16:28, Alex Benn=C3=A9e wrote:
> >> Why not g_usleep?  It already does a while loop around nanosleep (which
> >> returns the remaining time in the wait, like select but unlike sleep a=
nd
> >> poll). =20
> > Yeah I'm testing that now. However I have managed to trigger:
> >=20
> >   ERROR:tests/test-qht-par.c:20:test_qht: assertion failed (rc =3D=3D 0=
): (35584 =3D=3D 0) =20
>=20
> I think that's a good old SIGSEGV (0x8B00).
>=20

Hmmm... system() returns a "wait status" that can  be examined using the
macros described in waitpid(2), and we have:

/* If WIFEXITED(STATUS), the low-order 8 bits of the status.  */
#define	__WEXITSTATUS(status)	(((status) & 0xff00) >> 8)

So this rather looks like a 139 exit status to me... Not sure how
this can happen though.

> Paolo
>=20
