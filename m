Received: from eggs.gnu.org ([2001:4830:134:3::10]:60138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEAcT-0004qF-CZ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEAcQ-0002gj-65
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:33:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEAcQ-0002gY-1v
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:33:42 -0400
Date: Thu, 3 May 2018 10:33:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180503093329.GF11382@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
	<20180502115844.GO3308@redhat.com>
	<CAFEAcA-e_=08658O8E3CAmYXvBbNWmznnhfMLUW+MXnxb_vKfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-e_=08658O8E3CAmYXvBbNWmznnhfMLUW+MXnxb_vKfQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, May 02, 2018 at 01:05:21PM +0100, Peter Maydell wrote:
> On 2 May 2018 at 12:58, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:
> > I'm curious what is the compelling benefit of having a single fat QEM=
U
> > binary that included all archiectures at once ?
>=20
> The motivation is "I want to model a board with an SoC that has
> both Arm cores and Microblaze cores". One binary seems the most
> sensible way to do that, since otherwise we'd end up with some
> huge multiplication of binaries for all the possible architecture
> combinations. It also would reduce the number of times we end up
> recompiling and shipping any particular PCI device. From the
> perspective of QEMU as emulation environment, it's a nice
> simplification.

Ah that's interesting - should have known there was wierd hardware
like that out there :-)   So from that POV, it would be good to
try to aim for making the CPU emulation loadable modules to avoid
degrading our current level of modularization.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
