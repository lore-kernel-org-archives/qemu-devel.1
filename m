Received: from eggs.gnu.org ([2001:4830:134:3::10]:38874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gHWEO-0004H6-P7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gHWEK-00026m-GB
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:47:00 -0400
Date: Tue, 30 Oct 2018 16:46:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181030164633.2c8f21d3.cohuck@redhat.com>
In-Reply-To: <6fd9e9f8-838a-a13c-e957-a8e6bcb74c42@redhat.com>
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
	<20181030140030.gh5aa7jcgszrfajs@sirius.home.kraxel.org>
	<6fd9e9f8-838a-a13c-e957-a8e6bcb74c42@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 30 Oct 2018 15:13:45 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 30/10/18 15:00, Gerd Hoffmann wrote:
> > On Tue, Oct 30, 2018 at 02:32:40PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote: =20
> >>> +##
> >>> +# @SupportState:
> >>> +#
> >>> +# Indicate Support level of qemu devices, backends, subsystems, ...
> >>> +#
> >>> +# Since: 3.2
> >>> +##
> >>> +{ 'enum': 'SupportState',
> >>> +  'data': [ 'unknown', =20
> >>
> >> 'unknown' is scary and should be fixed. =20
> >=20
> > 'unknown' maps to "0" due to being first in list, so this is what you
> > get when it isn't explicitly set to something else.  Which make sense
> > IMHO. =20
>=20
> Yes, I understand in your next patch, this case won't display warning to=
=20
> the user.
>=20
> I wanted to say "we should fix those entries in the MAINTAINERS file".

I think that has been an ongoing quest for years :)

>=20
> >  =20
> >>> +            'supported',
> >>> +            'maintained',
> >>> +            'odd-fixes', =20
> >>
> >> All those fit in 'supported'
> >> =20
> >>> +            'orphan',
> >>> +            'obsolete',
> >>> +            'deprecated' ] } =20
> >>
> >> And all those should appear as 'deprecated' IMHO. =20
> >=20
> > See minutes on deprecation discussion.  Seems there is agreement we
> > need something more finegrained than "supported" and "deprecated". =20
>=20
> I read again the "Minutes of KVM Forum BoF on deprecating stuff" thread=20
> and don't find details on finegrains, can you point it to me?
>=20
> I think these are fine in the MAINTAINERS entries, but don't give useful=
=20
> information to a QEMU user that is not custom to MAINTAINERS.

We might squash 'supported' and 'maintained' together (as their only
real difference is whether someone gets paid for it), but 'odd fixes'
is different IMO (you have someone to talk to, but they don't dedicate
much of their time to it.)

>=20
> As a user I'd expect anything not "supported" to be eventually "deprecate=
d".

But there are differences:
- 'orphan' - nobody is looking after it; should become 'deprecated' if
  nobody steps up, but may move to one of the 'someone looks after it'
  states
- 'obsolete' - don't use this; should move to 'deprecated' once a
  replacement is ready (or it is not needed anymore)
- 'deprecated' - on the removal schedule; has not necessarily been in
  'orphan' or 'obsolete' before

>=20
> Should we continue this discussion on the "Minutes of KVM Forum BoF on=20
> deprecating stuff" thread?
>=20
> Thanks,
>=20
> Phil.
>=20
> >=20
> > cheers,
> >    Gerd
> >=20
> >  =20
>=20
