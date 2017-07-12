Received: from eggs.gnu.org ([2001:4830:134:3::10]:54505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVD0W-0000UL-KD
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVD0S-0007hV-Kv
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dVD0S-0007gp-Eh
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:28:24 -0400
Date: Wed, 12 Jul 2017 10:28:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170712082813.GB4917@noname.str.redhat.com>
References: <20170707181642-mutt-send-email-mst@kernel.org>
	<20170707180358.GA12152@localhost.localdomain>
	<626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
	<20170710135943.GG12152@localhost.localdomain>
	<20170710194345-mutt-send-email-mst@kernel.org>
	<20170710174730.GL12152@localhost.localdomain>
	<063778b8-d517-dcac-3c83-95076604a16c@redhat.com>
	<1499760785.8257.5.camel@redhat.com>
	<20170711144215.GI4335@noname.str.redhat.com>
	<1499838706.18762.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499838706.18762.1.camel@redhat.com>
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Am 12.07.2017 um 07:51 hat Gerd Hoffmann geschrieben:
> > > I think simply not having a default
> > > machine type (as already suggested elsewhere in this thread) is the
> > > best way to deal with this.
> > 
> > I would absolutely hate this. One of the nice things about qemu has
> > always been that 'qemu disk.img' is enough to start a simple VM.
> 
> Well, not really.  There is no "qemu" any more, and there are other
> defaults like default memory size which need tweaks, so the minimum
> command line isn't that short any more and looks more like this:
> 
>     qemu-system-x86_64 -enable-kvm -m 1G disk.img

Depends on what you want to do, but in the common case yes. So we have
already moved in the wrong direction. Not a good reason to do more of
it.

Actually, I think changing the defaults to -m 1G and -machine
accel=kvm:tcg would be much less problematic than -M q35, so maybe that
should be our first step towards better defaults. (Or at least something
to schedule for 3.0.)

And even changing the default to -M q35, however problematic, would
still be nicer than making -M non-optional.

Kevin
