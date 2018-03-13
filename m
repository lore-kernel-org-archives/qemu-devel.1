Received: from eggs.gnu.org ([2001:4830:134:3::10]:41095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evYgr-00059h-Qt
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 21:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evYgo-0000hW-At
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 21:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evYgo-0000gh-3y
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 21:25:18 -0400
Date: Mon, 12 Mar 2018 22:25:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180313012515.GZ3417@localhost.localdomain>
References: <20180312185503.5746-1-ehabkost@redhat.com>
	<20180312185503.5746-2-ehabkost@redhat.com>
	<f8185612-019e-aa2d-7c45-bd1923099f1f@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8185612-019e-aa2d-7c45-bd1923099f1f@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu.py: Use items() instead of
 iteritems()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Tue, Mar 13, 2018 at 12:02:39AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 03/12/2018 07:55 PM, Eduardo Habkost wrote:
> > items() is less efficient on Python 2.x, but makes the code work
> > on both Python 2 and Python 3.
> >=20
> > Cc: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> > Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Cc: Cleber Rosa <crosa@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  scripts/qemu.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index 305a946562..08a3e9af5a 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -277,7 +277,7 @@ class QEMUMachine(object):
> >      def qmp(self, cmd, conv_keys=3DTrue, **args):
> >          '''Invoke a QMP command and return the response dict'''
> >          qmp_args =3D dict()
> > -        for key, value in args.iteritems():
> > +        for key, value in args.items():
> >              if conv_keys:
> >                  qmp_args[key.replace('_', '-')] =3D value
> >              else:
> >=20
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg04046.html

Oops, that series had fallen through the cracks, sorry!

I remember merging a series with fixes for Python 3, but now I
see there were two separate series: "Support building with py2 or
py3=C2=A8 (already merged), and yours ("iotests: python3
compatibility=C2=A8).

--=20
Eduardo
