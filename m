Received: from eggs.gnu.org ([2001:4830:134:3::10]:44102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dQaQV-0002xB-Ui
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dQaQP-0003LP-W8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:28:11 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:32854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dQaQP-0003Ku-Iv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:28:05 -0400
Received: by mail-lf0-x242.google.com with SMTP id t72so7866649lff.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 07:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20170611074817.13621-1-sf@sfritsch.de>
	<d95a3198-3ad0-4a75-dda2-a3b7502ede28@redhat.com>
In-Reply-To: <d95a3198-3ad0-4a75-dda2-a3b7502ede28@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Jun 2017 14:27:52 +0000
Message-ID: <CAJ+F1CKs+Q7Z2mkbGK3GFaM9xJ=rTp9A-Gz+9um5pgpA2ef=Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Jun 27, 2017 at 9:46 PM Eric Blake <eblake@redhat.com> wrote:

> On 06/11/2017 02:48 AM, Stefan Fritsch wrote:
> > Sending a break on a serial console can be useful for debugging the
> > guest. But not all chardev backends support sending breaks (only telnet
> > and mux do). The chardev-send-break command allows to send a break even
> > if using other backends.
> >
> > Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Looks good to me,
 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> > v2: added tests and Acked-by line
> >
>
> > +++ b/hmp-commands.hx
> > @@ -1745,6 +1745,22 @@ Removes the chardev @var{id}.
> >  ETEXI
> >
> >      {
> > +        .name       =3D "chardev-send-break",
> > +        .args_type  =3D "id:s",
> > +        .params     =3D "id",
> > +        .help       =3D "send break on chardev",
>
> Compare this wording,...
>
> > +STEXI
> > +@item chardev-send-break id
> > +@findex chardev-send-break
> > +Sends break on the chardev @var{id}.
>
> repeated here,
>
> > +++ b/qapi-schema.json
> > @@ -5114,6 +5114,26 @@
> >  { 'command': 'chardev-remove', 'data': {'id': 'str'} }
> >
> >  ##
> > +# @chardev-send-break:
> > +#
> > +# Send a break to a character device
>
> ...with this wording.  I like 'send a break' better than 'send break',
> but even better might be 'send a break sequence' or even 'emulate a
> break sequence' (by definition, a break is NOT a character, but on bare
> metal character devices it IS a defined electrical sequence distinct
> from characters to make the recipient aware that the sender is trying to
> get attention).
>
> Otherwise, the patch looks fine to me.  If all that changes is some
> word-smithing (and the maintainer may be willing to do that), you can add=
:
> Reviewed-by: Eric Blake <eblake@redhat.com>
>

Paolo would you take it (perhaps on the next iteration)?

thanks
--=20
Marc-Andr=C3=A9 Lureau
