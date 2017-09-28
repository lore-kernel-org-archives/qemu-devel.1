Received: from eggs.gnu.org ([2001:4830:134:3::10]:35225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxYjF-0000ky-Tr
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxYjA-0006zs-2A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:19:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxYj9-0006zS-Se
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:19:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7C3680A45
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 13:19:42 +0000 (UTC)
Date: Thu, 28 Sep 2017 10:19:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170928131940.GR4115@localhost.localdomain>
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-2-ehabkost@redhat.com>
	<655d9ac0-f36e-a764-0e3c-d1d28818bd9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <655d9ac0-f36e-a764-0e3c-d1d28818bd9a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] guestperf: Configure logging on all
 shell frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On Thu, Sep 28, 2017 at 11:15:47AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
[...]
> > @@ -231,6 +239,7 @@ class PlotShell(object):
> > =20
> >      def run(self, argv):
> >          args =3D self._parser.parse_args(argv)
>=20
> This class is not inherited from the `BaseShell`, therefor it
> does not contain `init_logging` method. Apart from this it
> looks good.

Oops.  I will fix this in v2.  Thanks!

>=20
> > +        self.init_logging(args)
> > =20
> >          if len(args.reports) =3D=3D 0:
> >              print >>sys.stderr, "At least one report required"
> >=20

--=20
Eduardo
