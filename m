Received: from eggs.gnu.org ([2001:4830:134:3::10]:58886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dT3V1-0004dj-IB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dT3Ux-0003HV-Nk
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:55:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dT3Ux-0003H4-Gr
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:54:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C711334586
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 09:54:58 +0000 (UTC)
Date: Thu, 6 Jul 2017 05:54:55 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1885897934.47456724.1499334895441.JavaMail.zimbra@redhat.com>
In-Reply-To: <646ec17e-4baa-66b9-f54b-0ca840303fe6@redhat.com>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-8-marcandre.lureau@redhat.com>
	<646ec17e-4baa-66b9-f54b-0ca840303fe6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] MAINTAINERS: add Dump maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com

Hi

----- Original Message -----
> On 06/29/17 15:23, Marc-Andr=C3=A9 Lureau wrote:
> > Proposing myself, since I have some familiarity with the code now.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 839f7ca063..45a0eb4cb0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1272,6 +1272,13 @@ S: Maintained
> >  F: device_tree.c
> >  F: include/sysemu/device_tree.h
> > =20
> > +Dump
> > +S: Supported
> > +M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > +F: dump.c
> > +F: include/sysemu/dump.h
> > +F: include/sysemu/dump-arch.h
> > +
> >  Error reporting
> >  M: Markus Armbruster <armbru@redhat.com>
> >  S: Supported
> >=20
>=20
> That's very kind of you, thanks!
>=20
> Do you have suggestions for the following files?
>=20
> scripts/dump-guest-memory.py

This one is yours, no? :) But I am ok to "support" it, meaning I'll take ti=
me to review the patches, and eventually make the pull-requests.
=20
> stubs/dump.c

I can add that one, although it is also maintained by Paolo

> target/arm/arch_dump.c
> target/i386/arch_dump.c
> target/ppc/arch_dump.c
> target/s390x/arch_dump.c

I'd rather have those maintained by the respective arch maintainers, as the=
y are. But I imagine it would make sense to also cover them with the rest o=
f dump.

thanks
