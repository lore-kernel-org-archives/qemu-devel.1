Received: from eggs.gnu.org ([2001:4830:134:3::10]:56092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cqxxh-0000Yo-TM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cqxxe-00075b-Q3
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:19:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cqxxe-000751-Jp
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:19:10 -0400
Message-ID: <1490257145.463.24.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 23 Mar 2017 09:19:05 +0100
In-Reply-To: <da2bfbb8-c000-eaff-826f-904582f6e98a@redhat.com>
References: <87bmstu19t.fsf@dusky.pond.sub.org>
	<1f744cad-f67b-92d3-b4e4-32f8b05c643c@redhat.com>
	<da2bfbb8-c000-eaff-826f-904582f6e98a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] Minimum RAM size for PC machines?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, seabios@seabios.org, =?ISO-8859-1?Q?L=E1szl=F3_=C9rsek?= <lersek@redhat.com>

On Mi, 2017-03-22 at 11:19 +0100, David Hildenbrand wrote:
> On 22.03.2017 11:03, Thomas Huth wrote:
> > On 22.03.2017 10:08, Markus Armbruster wrote:
> > [...]
> >> Are we now ready to accept a simple & stupid patch that actually helps
> >> users, say letting boards that care declare minimum and maximum RAM
> >> size?  And make PC reject RAM size less than 1MiB, even though "someon=
e"
> >> might conceivably have firmware that works with less?
> >=20
> > I'd say enforce a minimum RAM size on the normal "pc" and "q35" machine=
,
> > but still allow smaller sizes on the "isapc" machine. So if "someone"
> > comes around and claims to have a legacy firmware that wants less memor=
y
> > than 1MiB, just point them to the isapc machine.
> > Just my 0.02 =E2=82=AC.
> >=20
> >  Thomas
>=20
> Or maybe simply warn the user that things may go wrong instead of
> enforcing it.

Why bother?  I have my doubts physical i440fx works with less than 1M
either, given that this memory is needed to shadow the roms.  Possibly
you can't even find dimms that are small to plug them into such a system
to try ...

I'd say just add a hard limit and be done with it.

Maybe exclude isapc.  That one hasn't shadow support so things have at
least a chance to work with less than 1M of memory.  But honestly I'd
rather drop isapc, together with ia64 and sparc.  I mean, what is the
use case?  'pc' machine type is compatible enough with vga and ide ports
being on the standard isa locations so even msdos which has no pci
support at all boots happily.

cheers,
  Gerd
