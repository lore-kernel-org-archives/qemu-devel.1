Received: from eggs.gnu.org ([2001:4830:134:3::10]:32927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etNrv-0007Xp-Oj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etNrs-0005JB-K8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:27:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1etNrs-0005J1-FM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:27:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04AECEAEAA
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 01:27:44 +0000 (UTC)
Date: Wed, 7 Mar 2018 09:27:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180307012739.GD13844@lemon.usersys.redhat.com>
References: <20180306154625.23910-1-berrange@redhat.com>
	<152035231744.1395.14112582467019213006@bdbb90650ae5>
	<20180306162034.GQ6163@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180306162034.GQ6163@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] trace: only permit standard C types and
 fixed size integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Tue, 03/06 16:20, Daniel P. Berrang=E9 wrote:
> On Tue, Mar 06, 2018 at 08:05:18AM -0800, no-reply@patchew.org wrote:
> > Hi,
> >=20
> > This series failed docker-mingw@fedora build test. Please find the te=
sting commands and
> > their output below. If you have Docker installed, you can probably re=
produce it
> > locally.
> >=20
> > Type: series
> > Message-id: 20180306154625.23910-1-berrange@redhat.com
> > Subject: [Qemu-devel] [PATCH] trace: only permit standard C types and=
 fixed size integer types
> >=20
> > Traceback (most recent call last):
> >   File "/tmp/qemu-test/src/scripts/tracetool.py", line 154, in <modul=
e>
> >     main(sys.argv)
> >   File "/tmp/qemu-test/src/scripts/tracetool.py", line 145, in main
> >     events.extend(tracetool.read_events(fh))
> >   File "/tmp/qemu-test/src/scripts/tracetool/__init__.py", line 358, =
in read_events
> >     event =3D Event.build(line)
> >   File "/tmp/qemu-test/src/scripts/tracetool/__init__.py", line 280, =
in build
> >     args =3D Arguments.build(groups["args"])
> >   File "/tmp/qemu-test/src/scripts/tracetool/__init__.py", line 134, =
in build
> >     validate_type(arg_type)
> >   File "/tmp/qemu-test/src/scripts/tracetool/__init__.py", line 87, i=
n validate_type
> >     "declared as 'void *'" % name)
> > ValueError: Error on line 95: Argument type 'hwaddr' is not in whitel=
ist. Only standard C types and fixed size integer types should be used. s=
truct, union, and other complex pointer types should be declared as 'void=
 *'
>=20
>=20
> This nicely illustrates this patch working as documented !
>=20
> The fix for the "hwaddr" mistake was just merged in QEMU git master, so
> if patchew can be re-run, applying to latest master it should pass.

Manually initiated re-apply and re-run.

Fam
