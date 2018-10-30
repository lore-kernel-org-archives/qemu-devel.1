Received: from eggs.gnu.org ([2001:4830:134:3::10]:34714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHUZi-0004HI-CD
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHUZX-000393-Kl
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:00:54 -0400
Date: Tue, 30 Oct 2018 15:00:30 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181030140030.gh5aa7jcgszrfajs@sirius.home.kraxel.org>
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Oct 30, 2018 at 02:32:40PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Gerd,
>=20
> On 30/10/18 12:13, Gerd Hoffmann wrote:
> > Indicates support state for somerhing (device, backend, subsystem, ..=
.)
>=20
> "something"

Oops, I'll fix.

> > +##
> > +# @SupportState:
> > +#
> > +# Indicate Support level of qemu devices, backends, subsystems, ...
> > +#
> > +# Since: 3.2
> > +##
> > +{ 'enum': 'SupportState',
> > +  'data': [ 'unknown',
>=20
> 'unknown' is scary and should be fixed.

'unknown' maps to "0" due to being first in list, so this is what you
get when it isn't explicitly set to something else.  Which make sense
IMHO.

> > +            'supported',
> > +            'maintained',
> > +            'odd-fixes',
>=20
> All those fit in 'supported'
>=20
> > +            'orphan',
> > +            'obsolete',
> > +            'deprecated' ] }
>=20
> And all those should appear as 'deprecated' IMHO.

See minutes on deprecation discussion.  Seems there is agreement we
need something more finegrained than "supported" and "deprecated".

cheers,
  Gerd
