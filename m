Received: from eggs.gnu.org ([2001:4830:134:3::10]:49091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYGOz-0001nq-Ma
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYGOv-0000wt-PB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dYGOv-0000wp-If
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:42:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57FD385547
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 18:42:16 +0000 (UTC)
Date: Thu, 20 Jul 2017 15:42:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170720184211.GZ2757@localhost.localdomain>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-11-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170720162815.19802-11-ldoktor@redhat.com>
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

On Thu, Jul 20, 2017 at 06:28:14PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
[...]
> @@ -83,8 +80,11 @@ class QEMUQtestMachine(qemu.QEMUMachine):
>                   socket_scm_helper=3DNone):
>          if name is None:
>              name =3D "qemu-%d" % os.getpid()
> -        super(QEMUQtestMachine, self).__init__(binary, args, name=3Dna=
me, test_dir=3Dtest_dir,
> -                                               socket_scm_helper=3Dsoc=
ket_scm_helper)
> +        scm_helper =3D socket_scm_helper

Why is this necessary?

> +        super(QEMUQtestMachine, self).__init__(binary, args, name=3Dna=
me,
> +                                               test_dir=3Dtest_dir,
> +                                               socket_scm_helper=3Dscm=
_helper)
> +        self._qtest =3D None
>          self._qtest_path =3D os.path.join(test_dir, name + "-qtest.soc=
k")
> =20
>      def _base_args(self):
> --=20
> 2.9.4
>=20

--=20
Eduardo
