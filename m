Received: from eggs.gnu.org ([2001:4830:134:3::10]:48838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVJOu-0000ru-P6
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVJOs-0001EZ-3C
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:18:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dVJOr-0001EE-Pd
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:18:02 -0400
Date: Wed, 12 Jul 2017 12:17:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170712151752.GG6020@localhost.localdomain>
References: <20170707180358.GA12152@localhost.localdomain>
	<626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
	<20170710135943.GG12152@localhost.localdomain>
	<20170710194345-mutt-send-email-mst@kernel.org>
	<20170710174730.GL12152@localhost.localdomain>
	<063778b8-d517-dcac-3c83-95076604a16c@redhat.com>
	<1499760785.8257.5.camel@redhat.com>
	<20170711144215.GI4335@noname.str.redhat.com>
	<1cc3488e-d40b-ac73-9087-f2bf64f2cd1c@redhat.com>
	<8d6ed662-63e5-fe49-f41e-05f80a52bc20@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6ed662-63e5-fe49-f41e-05f80a52bc20@redhat.com>
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>

On Wed, Jul 12, 2017 at 09:39:39AM +0300, Marcel Apfelbaum wrote:
> On 11/07/2017 17:47, Paolo Bonzini wrote:
> > On 11/07/2017 16:42, Kevin Wolf wrote:
> > > > >   Concerning QEMU, could we maybe simply emit a warning a la
> > > > > 
> > > > >   "you did not specify a machine type with the -M option, so you are
> > > > >    currently running the the 'pc' machine type. Please note that
> > > > > future
> > > > >    versions of QEMU might use the 'q35' machine type instead. If you
> > > > >    require the 'pc' machine type for your setting, then please specify
> > > > >    it with the -M option."
> > > > Warnings tend to get ignored until things are actually break, so I
> > > > don't think this helps much.  I think simply not having a default
> > > > machine type (as already suggested elsewhere in this thread) is the
> > > > best way to deal with this.
> > > I would absolutely hate this. One of the nice things about qemu has
> > > always been that 'qemu disk.img' is enough to start a simple VM. You
> > > only need to touch any other options for things you care about. I
> > > wouldn't want to give this up.
> > 
> > I agree.  Don't change anything, leave "-M pc" aside, and let libosinfo
> > pick q35 for newer guests.
> > 
> 
> Hi Paolo,
> 
> While I do think it would be a good step moving forward, I am not
> convinced is "enough" to get more users using it. More so, a low
> level bug in upper layers (e.g. Open stack) will lead to difficulty
> to debug and result in the same "The machine is not steady enough,
> it doesn't worth the effort, let's move back to pc", or even
> frustration of the people that really need Q35.

I guess not being enough depends on which users we want to
affect.  People who run QEMU from the command-line don't get a
virtio drive or a modern CPU model chosen by default, either.  Is
the choice of machine-type different?  Why?

> [...]

-- 
Eduardo
