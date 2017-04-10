Received: from eggs.gnu.org ([2001:4830:134:3::10]:45163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxhZ8-0000S8-NY
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 18:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxhZ5-00085i-H8
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 18:13:42 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:35996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cxhZ5-00084a-A6
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 18:13:39 -0400
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5A12E49CD6
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 00:13:34 +0200 (CEST)
Date: Tue, 11 Apr 2017 00:13:22 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170411001322.5925a3bb@bahia.lan>
In-Reply-To: <3b38d5f9-3611-6ec8-df14-a6054d574dc2@twiddle.net>
References: <20170410060655.32289-1-nikunj@linux.vnet.ibm.com>
	<fc0b737f-738a-1bc2-1b94-aa041ab8ae6c@twiddle.net>
	<CAFEAcA95xYVh6fwjNJ6QaXgwXsqH_zYMANfkdEUh7OkZ22aqRQ@mail.gmail.com>
	<20170410194414.7f829fee@bahia.lan>
	<3b38d5f9-3611-6ec8-df14-a6054d574dc2@twiddle.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/.oondsCnmnH0YrLVbFWDLr=";
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
To: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/.oondsCnmnH0YrLVbFWDLr=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Apr 2017 10:49:12 -0700
Richard Henderson <rth@twiddle.net> wrote:

> On 04/10/2017 10:44 AM, Greg Kurz wrote:
> > On Mon, 10 Apr 2017 18:29:57 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> > =20
> >> On 10 April 2017 at 18:26, Richard Henderson <rth@twiddle.net> wrote: =
=20
> >>> On 04/09/2017 11:06 PM, Nikunj A Dadhania wrote: =20
> >>>> --- a/cpus.c
> >>>> +++ b/cpus.c
> >>>> @@ -202,7 +202,7 @@ void qemu_tcg_configure(QemuOpts *opts, Error **=
errp)
> >>>>              } else if (use_icount) {
> >>>>                  error_setg(errp, "No MTTCG when icount is enabled");
> >>>>              } else {
> >>>> -#ifndef TARGET_SUPPORT_MTTCG
> >>>> +#ifndef TARGET_SUPPORTS_MTTCG =20
> >>>
> >>>
> >>> This sort of thing is why glibc moved to using -Wundef.
> >>>
> >>> It would be a huge amount of work to convert our existing sources, bu=
t it
> >>> would probably pay off in the long run. =20
> >>
> >> We already build with -Wundef...
> >> =20
> >
> > From the gcc info page:
> >
> > '-Wundef'
> >      Warn if an undefined identifier is evaluated in an '#if' directive.
> >
> > and BTW, isn't the purpose of #ifndef precisely to detect that the
> > identifier is undefined ? =20
>=20
> Yes, but it also has the typo problem above, whereas
>=20
>    #if !TARGET_SUPPORTS_MTTCG
>=20
> plus -Wundef would have caught that error.
>=20

Turning such #ifdef/#ifndef to #if/#if ! would indeed make sense, but
we'd still have to be careful that every new addition follows the rule.

>=20
> r~


--Sig_/.oondsCnmnH0YrLVbFWDLr=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljsA4IACgkQAvw66wEB28KvsgCglglbb75Ol9EkU2QJJdJj6bBI
pWgAn29Zwy8WpxXGVr81X3b5MwhA6te/
=L1Se
-----END PGP SIGNATURE-----

--Sig_/.oondsCnmnH0YrLVbFWDLr=--
