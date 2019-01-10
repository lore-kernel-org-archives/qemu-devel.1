Received: from eggs.gnu.org ([209.51.188.92]:54026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghZCu-0001dZ-8i
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghZCs-0004wb-Bb
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:13:08 -0500
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:52793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ghZCs-0004pT-4g
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:13:06 -0500
Received: from player796.ha.ovh.net (unknown [10.109.159.7])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8624D10C257
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 13:12:52 +0100 (CET)
Date: Thu, 10 Jan 2019 13:12:38 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190110131238.7a65eb20@bahia.lan>
In-Reply-To: <20190110101243.GE2178@redhat.com>
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-2-git-send-email-thuth@redhat.com>
	<3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
	<20190109172801.GB3998@redhat.com>
	<d72673fa-52a5-a6ff-6aa8-34f2b4b6855f@redhat.com>
	<60b7e2bf-6822-6e0b-7184-b38594eb38ed@redhat.com>
	<20190110101243.GE2178@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] include/hw/ppc: Fix
 compilation with clang -std=gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 10 Jan 2019 10:12:43 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Jan 09, 2019 at 03:25:53PM -0600, Eric Blake wrote:
> > On 1/9/19 3:20 PM, Paolo Bonzini wrote: =20
> > > On 09/01/19 18:28, Daniel P. Berrang=C3=A9 wrote: =20
> > >>> so both files include each other, how nice ... =20
> > >> If the header files are mutually dependent it makes me wonder what t=
he
> > >> point of having them split up is ?
> > >>
> > >> Feels like either they need to be merged, or they need to be split up
> > >> and refactored even more to remove the mutual dependancy. =20
> > >=20
> > > If they include each other only for the typedefs, then prehaps the
> > > solution is to change the coding style and allow using struct in
> > > function prototypes.  I'm pretty sure there are several examples of t=
his
> > > already. =20
> >=20
> > Or stick the typedef in <typedefs.h>, instead of trying to find (or
> > create) some other common header. =20
>=20
> Probably better to just have a local  spapr_types.h instead of
> polluting the global namespace.
>=20

I personally like this approach because it would allow to use the
typedefs everywhere, for the sake of consistency.

>=20
> Regards,
> Daniel
