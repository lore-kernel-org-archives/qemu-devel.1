Received: from eggs.gnu.org ([2001:4830:134:3::10]:46233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1daPzj-0000LF-6q
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1daPzf-0003XQ-Ur
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1daPzf-0003Wz-Nr
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:21:07 -0400
Date: Wed, 26 Jul 2017 20:21:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170726195844-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714182012.4595-3-marcandre.lureau@redhat.com>
	<20170714222023-mutt-send-email-mst@kernel.org>
	<5d31f22d-e0ae-92f4-ea17-690419f72944@redhat.com>
	<20170714230852-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJW1pCqJMN3JmGunFKswNnR=J74+Z_m5Lj5WYT2Z1ZoPQ@mail.gmail.com>
	<20170715012551-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJP2DSo-khn+do0YG_ALDXrqBi6wEPH=m+W59rPfRTuiA@mail.gmail.com>
	<20170715023159-mutt-send-email-mst@kernel.org>
	<CAJ+F1C+F+HjHxzrq0usibfYUidpBW8DQUS72pDAv7xC6O14t3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+F+HjHxzrq0usibfYUidpBW8DQUS72pDAv7xC6O14t3Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/8] acpi: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Dave Anderson <anderson@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Sat, Jul 15, 2017 at 01:47:50AM +0200, Marc-Andr=E9 Lureau wrote:
> >
> > There's more info scattered in other places.
> >
> > Why do you get to document it? Because you are the one exposing it
> > across the hypervisor/vm boundary where it will need to be
> > understood by people/tools not running within guest.
> >
> > So "just read the script in qemu source" is not how an interface
> > should be documented.
>=20
> I don't understand the issue, it's a kernel ELF note that qemu passes
> for dump/crash tools in the dump headers/sections.

The way it looks to me, this patchset is exposing an internal kernel
detail and making it part of ABI maybe it already is, my point was 1.
should we get a confirmation from upstream it's not going to change? 2.
if it's ABI let's document what do we expect to be there.

But again since there's not a whole lot of documentation here
that you provided, I might be misunderstanding completely.


> >
> >> >
> >> > BTW why does it pass ELF header size? Any idea?
> >>
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dd3bf37955d46718ee1a7f1fc69f953d2328ba7c2
> >
> > Right but I mean, ELF header has two options: 32 and 64 bit, that's a=
ll.
> >
> > --
> > MST
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
