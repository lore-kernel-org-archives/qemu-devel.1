Received: from eggs.gnu.org ([2001:4830:134:3::10]:43964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYd6K-00078a-LF
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYd6H-0001kQ-KF
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:56:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dYd6H-0001k8-Di
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:56:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8DFC25B96
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 18:56:31 +0000 (UTC)
Date: Fri, 21 Jul 2017 15:56:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170721185625.GE2757@localhost.localdomain>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-11-ldoktor@redhat.com>
	<20170720184211.GZ2757@localhost.localdomain>
	<2bf739d6-1860-b064-6366-ac3b406c23da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bf739d6-1860-b064-6366-ac3b406c23da@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/11] qtest.py: Few pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com

On Fri, Jul 21, 2017 at 08:57:34AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 20.7.2017 v 20:42 Eduardo Habkost napsal(a):
> > On Thu, Jul 20, 2017 at 06:28:14PM +0200, Luk=C3=A1=C5=A1 Doktor wrot=
e:
> > [...]
> >> @@ -83,8 +80,11 @@ class QEMUQtestMachine(qemu.QEMUMachine):
> >>                   socket_scm_helper=3DNone):
> >>          if name is None:
> >>              name =3D "qemu-%d" % os.getpid()
> >> -        super(QEMUQtestMachine, self).__init__(binary, args, name=3D=
name, test_dir=3Dtest_dir,
> >> -                                               socket_scm_helper=3D=
socket_scm_helper)
> >> +        scm_helper =3D socket_scm_helper
> >=20
> > Why is this necessary?
> >=20
> to avoid > 80 chars line. It should be optimized-out by the
> python compiler so it should not slow down the execution.
> Alternative solution is to use:
>=20
>     super(QEMUQtestMachine,
>           self.__init__(...)
>=20
> which looks IMO uglier, but I can use that in v2, should that be your p=
referred style.

I think that would be better.  The purpose of the extra variable
isn't clear when reading the code, making it more confusing.

--=20
Eduardo
