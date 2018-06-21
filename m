Received: from eggs.gnu.org ([2001:4830:134:3::10]:41996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVu9d-0006Sp-Am
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVu9a-0002Jh-8k
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:37:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVu9a-0002JI-34
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:37:14 -0400
Date: Thu, 21 Jun 2018 08:37:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180621073708.GB3615@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180613180508.GD24764@localhost.localdomain>
	<20180614080948.GF6355@redhat.com>
	<20180615025056.GB7451@localhost.localdomain>
	<20180615090314.GA31552@redhat.com>
	<20180618171431.GK7451@localhost.localdomain>
	<20180618201612-mutt-send-email-mst@kernel.org>
	<CAFEAcA_qRKA6QK42YdpbVRifXoCitxq-ZMZkVz=ESy9f3GdwOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_qRKA6QK42YdpbVRifXoCitxq-ZMZkVz=ESy9f3GdwOw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jun 20, 2018 at 06:33:51PM +0100, Peter Maydell wrote:
> On 18 June 2018 at 18:18, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Mon, Jun 18, 2018 at 02:14:31PM -0300, Eduardo Habkost wrote:
> >> > Sure if someone does that, we'll have no choice, but as long as 'pc' is
> >> > shipped we shouldn't gratuitously break apps by changing the default.
> >>
> >> Right.  I just want to make sure "omitting the machine-type may
> >> stop working in the future" is documented somehow.
> >
> > I still think we should just add links to the qemu binary and
> > use ARGV to detect the machine type.
> >
> > qemu-pc-i386
> > qemu-q35-x86_64
> 
> Do you really want 60 different qemu-something-arm symlinks?

Absolutely not !

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
