Received: from eggs.gnu.org ([2001:4830:134:3::10]:39780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvPgL-00064C-Cy
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvPgK-0008FD-NE
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:20:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fvPgG-0008AL-Pl
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:20:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id a108-v6so8583141wrc.13
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 09:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-6-marcandre.lureau@redhat.com>
	<87o9djzyto.fsf@dusky.pond.sub.org>
In-Reply-To: <87o9djzyto.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 30 Aug 2018 18:20:09 +0200
Message-ID: <CAJ+F1CJ3M4Up0z_icpzXfhJ+3h1DN6nOnjEe6q=W+pEhW6FjbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/9] char-fe: set_handlers() needs an
 associted chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Aug 30, 2018 at 4:58 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > It is futile to call qemu_chr_fe_set_handlers() without an associated
> > chardev, because the function is doing nothing in that case, not even
> > reporting an error, it would likely be a programming error. Let's not
> > handle that hypothetical case.
> >
> > (fwiw, I introduced the check in commit
> > 94a40fc56036b5058b0b194d9e372a22e65ce7be, that was a mistake imho)
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> In your subject, s/associted/associated/.

oops, fixed

same question as previous patch :)

thanks

--=20
Marc-Andr=C3=A9 Lureau
