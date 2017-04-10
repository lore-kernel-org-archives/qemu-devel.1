Received: from eggs.gnu.org ([2001:4830:134:3::10]:35620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxdMd-00077k-S1
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxdMZ-0004Jw-0r
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:44:31 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:43235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cxdMY-0004JX-Pg
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:44:26 -0400
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id EC26748891
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 19:44:24 +0200 (CEST)
Date: Mon, 10 Apr 2017 19:44:14 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170410194414.7f829fee@bahia.lan>
In-Reply-To: <CAFEAcA95xYVh6fwjNJ6QaXgwXsqH_zYMANfkdEUh7OkZ22aqRQ@mail.gmail.com>
References: <20170410060655.32289-1-nikunj@linux.vnet.ibm.com>
	<fc0b737f-738a-1bc2-1b94-aa041ab8ae6c@twiddle.net>
	<CAFEAcA95xYVh6fwjNJ6QaXgwXsqH_zYMANfkdEUh7OkZ22aqRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/yDwqDsFOOvP=sMn_.BULyro";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH fix for-2.9] cpus: fix wrong define name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/yDwqDsFOOvP=sMn_.BULyro
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Apr 2017 18:29:57 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 10 April 2017 at 18:26, Richard Henderson <rth@twiddle.net> wrote:
> > On 04/09/2017 11:06 PM, Nikunj A Dadhania wrote: =20
> >> --- a/cpus.c
> >> +++ b/cpus.c
> >> @@ -202,7 +202,7 @@ void qemu_tcg_configure(QemuOpts *opts, Error **er=
rp)
> >>              } else if (use_icount) {
> >>                  error_setg(errp, "No MTTCG when icount is enabled");
> >>              } else {
> >> -#ifndef TARGET_SUPPORT_MTTCG
> >> +#ifndef TARGET_SUPPORTS_MTTCG =20
> >
> >
> > This sort of thing is why glibc moved to using -Wundef.
> >
> > It would be a huge amount of work to convert our existing sources, but =
it
> > would probably pay off in the long run. =20
>=20
> We already build with -Wundef...
>=20

=46rom the gcc info page:

'-Wundef'
     Warn if an undefined identifier is evaluated in an '#if' directive.

and BTW, isn't the purpose of #ifndef precisely to detect that the
identifier is undefined ?

> thanks
> -- PMM
>=20


--Sig_/yDwqDsFOOvP=sMn_.BULyro
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljrxG4ACgkQAvw66wEB28JFYgCaAhF66ZCDjJ8G+uDY8niATQSd
290AnRtyBKogaVg1F23eMS+2SQQPloVJ
=kLQH
-----END PGP SIGNATURE-----

--Sig_/yDwqDsFOOvP=sMn_.BULyro--
