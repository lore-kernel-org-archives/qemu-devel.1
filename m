Received: from eggs.gnu.org ([2001:4830:134:3::10]:34305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG1Wk-0006yf-GD
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG1Wj-0004qT-HD
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:10:58 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:33649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dG1Wj-0004qP-8A
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:10:57 -0400
Received: by mail-lf0-x234.google.com with SMTP id m18so6929377lfj.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 04:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-15-marcandre.lureau@redhat.com>
	<871srmqq46.fsf@dusky.pond.sub.org>
In-Reply-To: <871srmqq46.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2017 11:10:45 +0000
Message-ID: <CAJ+F1CJ8K=i_nZex49Gm7SMs4bPHyw_U_HZ0GNiQaAch9GwtrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/17] acpi: fix s3/s4 disabled type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, May 18, 2017 at 4:58 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Use a more specific bool type.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Why doesn't this run afoul backward compatibility?  To answer the
> question, we need to enumerate affected external interfaces.
>
>
Right, this will break if we have users such as:

 -global PIIX4_PM.disable_s3=3D2

With this change, it will now error with:

qemu-system-x86_64: can't apply global PIIX4_PM.disable_s3=3D2: Invalid
parameter type for 'disable_s3', expected: boolean

Acceptable? otherwise, I drop the patch

thanks
--=20
Marc-Andr=C3=A9 Lureau
