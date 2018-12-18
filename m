Received: from eggs.gnu.org ([2001:4830:134:3::10]:57596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gZKpa-0003v8-QG
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gZKoT-00068y-VO
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:13:58 -0500
Date: Tue, 18 Dec 2018 17:13:43 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181218191343.GE19442@habkost.net>
References: <20181218115615.1499-1-philmd@redhat.com>
	<20181218115615.1499-11-philmd@redhat.com>
	<20f62f62-f677-6d0f-09dc-3759cc813d8f@redhat.com>
	<20181218152239.GB19442@habkost.net>
	<94e8bd71-302e-bced-665d-78538ea3aba3@redhat.com>
	<2ae5b6cd-7227-fab5-1bd1-4d3ebb88feee@redhat.com>
	<20181218155731.GC19442@habkost.net>
	<e5f62788-4b59-223c-c85e-562daf3a27d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e5f62788-4b59-223c-c85e-562daf3a27d9@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/12] MAINTAINERS: Orphanize the 'CPU
 (QOM)' subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Helge Deller <deller@gmx.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Dec 18, 2018 at 06:15:06PM +0100, Paolo Bonzini wrote:
> On 18/12/18 16:57, Eduardo Habkost wrote:
> > On Tue, Dec 18, 2018 at 04:44:25PM +0100, Thomas Huth wrote:
> >> On 2018-12-18 16:31, Philippe Mathieu-Daud=E9 wrote:
> >>> Hi Paolo, Eduardo,
> >>>
> >>> On 12/18/18 4:22 PM, Eduardo Habkost wrote:
> >>>> On Tue, Dec 18, 2018 at 01:34:52PM +0100, Paolo Bonzini wrote:
> >>>>> On 18/12/18 12:56, Philippe Mathieu-Daud=E9 wrote:
> >>>>>> Nobody is looking at those files, downgrade this subsystem as or=
phan.
> >>>>>>
> >>>>>> Remove the qemu-devel@nongnu.org entry because the list is alway=
s
> >>>>>> selected by the 'All patches CC here' section.
> >>>>>>
> >>>>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
> >>>>>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >>>>>> ---
> >>>>>>  MAINTAINERS | 3 +--
> >>>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>>>> index e50f8c6b97..e6a73820f1 100644
> >>>>>> --- a/MAINTAINERS
> >>>>>> +++ b/MAINTAINERS
> >>>>>> @@ -1745,8 +1745,7 @@ S: Supported
> >>>>>>  F: scripts/coverity-model.c
> >>>>>> =20
> >>>>>>  CPU
> >>>>>> -L: qemu-devel@nongnu.org
> >>>>>> -S: Supported
> >>>>>> +S: Orphan
> >>>>>>  F: qom/cpu.c
> >>>>>>  F: include/qom/cpu.h
> >>>>>> =20
> >>>>>>
> >>>>>
> >>>>> I don't think that's accurate.  Simply there's not much going on.=
  If
> >>>>> patches are sent, get-maintainers's git fallback will do somethin=
g
> >>>>> (probably sending the patch to Eduardo, Igor or me).
> >>>
> >>> I followed Markus suggestion from
> >>> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05414.html=
:
> >>>
> >>>   If we take the definition of S: in MAINTAINERS seriously,
> >>>   we need to appoint a maintainer (a person, not a mailing list),
> >>>   or downgrade to S: Orphan.
> >>
> >> I agree with Markus and Philippe. Having "S: Supported" but no names
> >> available is just confusing. So either put a maintainer name in here=
, or
> >> downgrade to "Orphan".
> >=20
> > I volunteer to maintain it, but I don't want to be the only
> > maintainer.  Any other volunteer?
>=20
> I can volunteer since I'd take the patches anyway.  We can also mark it
> as Odd Fixes, and also make it a single thing with all of qom/ and
> include/qom/.

Actually, I consider qom/cpu.c distinct from QOM core, and I was
planning to move it to hw/cpu, and add hw/cpu/core.c to the same
section.

Anyway, I guess this means you're also volunteering to be listed
as QOM maintainer?

--=20
Eduardo
