Received: from eggs.gnu.org ([2001:4830:134:3::10]:39254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvPeb-000438-9o
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvPea-0007Ct-AL
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:18:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fvPeZ-0007Bz-VJ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:18:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id w11-v6so8606298wrc.5
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 09:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-5-marcandre.lureau@redhat.com>
	<87sh2vzyux.fsf@dusky.pond.sub.org>
In-Reply-To: <87sh2vzyux.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 30 Aug 2018 18:18:27 +0200
Message-ID: <CAJ+F1CJLFGgM8QcY1HpfnRjOYfPUW_7F4ZSZ7ksvPfnDoNO5dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] char: update the mux hanlders in class
 callback
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
> > Instead of handling mux chardev in a special way in
> > qemu_chr_fe_set_handlers(), we may use the chr_update_read_handler
> > class callback instead.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> In your subject, s/hanlders/handlers/.

oops, fixed

does it get you r-b ?
thanks

--=20
Marc-Andr=C3=A9 Lureau
