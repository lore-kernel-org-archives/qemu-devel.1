Received: from eggs.gnu.org ([2001:4830:134:3::10]:48231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQadU-0001kv-NI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQadQ-0002Hy-M3
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:41:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQadQ-0002He-E4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:41:32 -0400
Date: Thu, 29 Jun 2017 15:41:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170629144125.GH2894@work-vm>
References: <20170611074817.13621-1-sf@sfritsch.de>
	<d95a3198-3ad0-4a75-dda2-a3b7502ede28@redhat.com>
	<CAJ+F1CKs+Q7Z2mkbGK3GFaM9xJ=rTp9A-Gz+9um5pgpA2ef=Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKs+Q7Z2mkbGK3GFaM9xJ=rTp9A-Gz+9um5pgpA2ef=Hg@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> On Tue, Jun 27, 2017 at 9:46 PM Eric Blake <eblake@redhat.com> wrote:
>=20
> > On 06/11/2017 02:48 AM, Stefan Fritsch wrote:
> > > Sending a break on a serial console can be useful for debugging the
> > > guest. But not all chardev backends support sending breaks (only te=
lnet
> > > and mux do). The chardev-send-break command allows to send a break =
even
> > > if using other backends.
> > >
> > > Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> > > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
>=20
> Looks good to me,
>  Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
>=20
> > ---
> > > v2: added tests and Acked-by line
> > >
> >
> > > +++ b/hmp-commands.hx
> > > @@ -1745,6 +1745,22 @@ Removes the chardev @var{id}.
> > >  ETEXI
> > >
> > >      {
> > > +        .name       =3D "chardev-send-break",
> > > +        .args_type  =3D "id:s",
> > > +        .params     =3D "id",
> > > +        .help       =3D "send break on chardev",
> >
> > Compare this wording,...
> >
> > > +STEXI
> > > +@item chardev-send-break id
> > > +@findex chardev-send-break
> > > +Sends break on the chardev @var{id}.
> >
> > repeated here,
> >
> > > +++ b/qapi-schema.json
> > > @@ -5114,6 +5114,26 @@
> > >  { 'command': 'chardev-remove', 'data': {'id': 'str'} }
> > >
> > >  ##
> > > +# @chardev-send-break:
> > > +#
> > > +# Send a break to a character device
> >
> > ...with this wording.  I like 'send a break' better than 'send break'=
,
> > but even better might be 'send a break sequence' or even 'emulate a
> > break sequence' (by definition, a break is NOT a character, but on ba=
re
> > metal character devices it IS a defined electrical sequence distinct
> > from characters to make the recipient aware that the sender is trying=
 to
> > get attention).
> >
> > Otherwise, the patch looks fine to me.  If all that changes is some
> > word-smithing (and the maintainer may be willing to do that), you can=
 add:
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> >
>=20
> Paolo would you take it (perhaps on the next iteration)?

I can take it through HMP; I'm just doing a pull now.

Dave

> thanks
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
