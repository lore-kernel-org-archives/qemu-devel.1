Received: from eggs.gnu.org ([2001:4830:134:3::10]:41209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7PyV-0005qX-3w
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7PyU-0006X5-50
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:04:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g7PyT-0006WY-TA
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:04:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id g15-v6so814124wru.9
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 12:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-10-marcandre.lureau@redhat.com>
	<87mut42c0c.fsf@dusky.pond.sub.org>
In-Reply-To: <87mut42c0c.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Oct 2018 23:04:36 +0400
Message-ID: <CAJ+F1C+WiGAd02PC=s50=kb4TT8kLmrHnYEhgyyvdGAQUbbVSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/10] qga: process_event()
 simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Hi
On Thu, Aug 30, 2018 at 6:03 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Simplify the code around qmp_dispatch():
> > - rely on qmp_dispatch/check_obj() for message checking
> > - have a single send_response() point
> > - constify send_response() argument
> >
> > It changes a couple of error messages:
> >
> > * When @req isn't a dictionary, from
> >     Invalid JSON syntax
> >   to
> >     QMP input must be a JSON object
> >
> > * When @req lacks member "execute", from
> >     this feature or command is not currently supported
> >   to
> >     QMP input lacks member 'execute'
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Can someone take the patch? thanks

--=20
Marc-Andr=C3=A9 Lureau
