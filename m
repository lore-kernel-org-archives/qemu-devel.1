Received: from eggs.gnu.org ([2001:4830:134:3::10]:57067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cxX2U-0000HL-Ve
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cxX2U-0006Go-8J
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:59:19 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:32881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cxX2T-0006GS-VK
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:59:18 -0400
Received: by mail-lf0-x22e.google.com with SMTP id h125so68452602lfe.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 03:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20170410102746.24889-1-kraxel@redhat.com>
	<CAJ+F1C+0rfVXxfXNRLkXx0qeE1u3jrH27kEQ7Ty3niTq1aSwaA@mail.gmail.com>
	<1491821505.30990.4.camel@redhat.com>
In-Reply-To: <1491821505.30990.4.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Apr 2017 10:59:06 +0000
Message-ID: <CAJ+F1CJGhbPLpJnwWk-N1+xdkenp7uY8SOnk-Bf1N-QEkt4e1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, 1635339@bugs.launchpad.net

Hi

On Mon, Apr 10, 2017 at 12:51 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > > +                if (!qxl->migration_blocker) {
> > > +                    Error *local_err =3D NULL;
> > > +                    error_setg(&qxl->migration_blocker,
> > > +                               "qxl: guest bug: command not in ram
> bar");
> > > +                    migrate_add_blocker(qxl->migration_blocker,
> > > &local_err);
> > >
> >
> > What do you do with the local_err? error_report_err() perhaps ?
>
> We can't error out at that point, unlike most migration blockers this
> isn't added at device initialization time.
>
> So, yes, we could error_report it, but the message would end up in the
> logfile unnoticed, so I'm not sure how useful that is ...
>

Well, it may eventually be read if something breaks. Otherwise, you may
just pass a NULL pointer, no?

thanks
--=20
Marc-Andr=C3=A9 Lureau
