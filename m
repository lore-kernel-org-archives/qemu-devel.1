Received: from eggs.gnu.org ([209.51.188.92]:60192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDot6-00086w-36
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDot3-0001oR-LX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:26:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hDot3-0001o1-3t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:25:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id g3so20359018wrx.9
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 04:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-4-armbru@redhat.com>
	<CAMxuvayc+RnpmFpUVFaLW2Uh8y6bZo2N4o6wu6YVyE1XRHtdWg@mail.gmail.com>
	<87bm1gr83k.fsf@dusky.pond.sub.org>
	<1f1ab942-49e9-0714-c6bc-65c7a0c4fa27@redhat.com>
In-Reply-To: <1f1ab942-49e9-0714-c6bc-65c7a0c4fa27@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Apr 2019 13:25:43 +0200
Message-ID: <CAJ+F1C+7gBUPFY5hJ8aCg4_KWJHiNMNx_6CjAQExOVKqmG7FOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/15] char-pty: Drop "char device
 redirected to" message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi

On Tue, Apr 9, 2019 at 12:40 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 4/8/19 2:31 PM, Markus Armbruster wrote:
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >
> >> Hi
> >>
> >> On Mon, Apr 8, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.com> =
wrote:
> >>>
> >>> char_pty_open() prints a "char device redirected to PTY_NAME (label
> >>> LABEL)" message to the current monitor or else to stderr.  No other
> >>> ChardevClass::open() prints anything on success.  Drop the message.
> >>>
> >>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>> ---
> >>>  chardev/char-pty.c | 2 --
> >>>  1 file changed, 2 deletions(-)
> >>>
> >>
> >> I guess that was printed for convenience.
> >>
> >> Allocated pty can be read from "info chardev", so I suppose we can
> >> make qemu more silent. Fine with me:
> >>
> >> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Thanks!
> >
> > If we should decide the message is still useful enough to be worth
> > keeping, I could direct it to stdout instead of dropping it.
>
> I prefer this, if Marc-Andr=C3=A9 is still OK.

I don't mind, but I wonder if we really have users that care. Power
users can easily get the associated pty from a monitor query.


--=20
Marc-Andr=C3=A9 Lureau
