Received: from eggs.gnu.org ([2001:4830:134:3::10]:35822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEAnn-0006IR-J0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEAnj-00072a-L9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:45:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEAnj-00072E-8q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:45:23 -0400
Date: Thu, 3 May 2018 10:45:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180503094519.GH11382@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
	<20180502115844.GO3308@redhat.com>
	<CAFEAcA-e_=08658O8E3CAmYXvBbNWmznnhfMLUW+MXnxb_vKfQ@mail.gmail.com>
	<20180503093329.GF11382@redhat.com>
	<8af696b5-3985-ffd6-43fb-2bcbfe0d0493@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8af696b5-3985-ffd6-43fb-2bcbfe0d0493@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>

On Thu, May 03, 2018 at 11:42:23AM +0200, Thomas Huth wrote:
> On 03.05.2018 11:33, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, May 02, 2018 at 01:05:21PM +0100, Peter Maydell wrote:
> >> On 2 May 2018 at 12:58, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> >>> I'm curious what is the compelling benefit of having a single fat Q=
EMU
> >>> binary that included all archiectures at once ?
> >>
> >> The motivation is "I want to model a board with an SoC that has
> >> both Arm cores and Microblaze cores". One binary seems the most
> >> sensible way to do that, since otherwise we'd end up with some
> >> huge multiplication of binaries for all the possible architecture
> >> combinations. It also would reduce the number of times we end up
> >> recompiling and shipping any particular PCI device. From the
> >> perspective of QEMU as emulation environment, it's a nice
> >> simplification.
> >=20
> > Ah that's interesting - should have known there was wierd hardware
> > like that out there :-)
>=20
> It's not that weird. A lot of "normal" machines have a service processo=
r
> (aka. BMC - board management controller) on board - and this service
> processor is completely different to the main CPU. For example, the mai=
n
> CPU could be an x86 or PPC, and the service processor is an embedded AR=
M
> chip. To emulate a complete board, you'd need both CPU types in one QEM=
U
> binary. Or you need to come up with some fancy interface between two
> QEMU instances...

Hmm, yes, even Intel x86_64 boards these days all have the management eng=
ine
running an old 486 derived CPU. Perhaps one day we'll emulate a new x86
machine type with a ME :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
