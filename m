Received: from eggs.gnu.org ([2001:4830:134:3::10]:55420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cxWvI-00064g-Qn
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cxWvE-0002Ja-Sg
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:51:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cxWvE-0002JK-Mx
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:51:48 -0400
Message-ID: <1491821505.30990.4.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 10 Apr 2017 12:51:45 +0200
In-Reply-To: <CAJ+F1C+0rfVXxfXNRLkXx0qeE1u3jrH27kEQ7Ty3niTq1aSwaA@mail.gmail.com>
References: <20170410102746.24889-1-kraxel@redhat.com>
	<CAJ+F1C+0rfVXxfXNRLkXx0qeE1u3jrH27kEQ7Ty3niTq1aSwaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] qxl: add migration blocker to avoid
 pre-save assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, 1635339@bugs.launchpad.net

  Hi,

> > +                if (!qxl->migration_blocker) {
> > +                    Error *local_err =3D NULL;
> > +                    error_setg(&qxl->migration_blocker,
> > +                               "qxl: guest bug: command not in ram bar=
");
> > +                    migrate_add_blocker(qxl->migration_blocker,
> > &local_err);
> >
>=20
> What do you do with the local_err? error_report_err() perhaps ?

We can't error out at that point, unlike most migration blockers this
isn't added at device initialization time.

So, yes, we could error_report it, but the message would end up in the
logfile unnoticed, so I'm not sure how useful that is ...

cheers,
  Gerd
