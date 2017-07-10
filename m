Received: from eggs.gnu.org ([2001:4830:134:3::10]:55123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUZEH-0006Z6-3X
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUZED-00011v-5s
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:00:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dUZED-000116-03
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:59:57 -0400
Date: Mon, 10 Jul 2017 10:59:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170710135943.GG12152@localhost.localdomain>
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
	<5233eee1-a017-ccae-3458-762c9e86902c@redhat.com>
	<20170707133949.GH10776@localhost.localdomain>
	<20170707181642-mutt-send-email-mst@kernel.org>
	<20170707180358.GA12152@localhost.localdomain>
	<626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Laszlo Ersek <lersek@redhat.com>

On Mon, Jul 10, 2017 at 10:42:26AM +0300, Marcel Apfelbaum wrote:
> On 07/07/2017 21:03, Eduardo Habkost wrote:
> > On Fri, Jul 07, 2017 at 06:17:57PM +0300, Michael S. Tsirkin wrote:
> > > On Fri, Jul 07, 2017 at 10:39:49AM -0300, Eduardo Habkost wrote:
> > > > On Wed, Jul 05, 2017 at 12:32:10PM +0300, Marcel Apfelbaum wrote:
[...]
> > > > > 
> > > > > The upper layers should manage the defaults by themselves so
> > > > > are not supposed to be affected.
> > > > 
> > > > But they would be.  libvirt uses the default machine-type from
> > > > QEMU.
> > > 
> > > How about extending the command for supported machines with a
> > > recommended machine type, and teaching libvirt to use that?
> > 
> > I don't think QEMU has enough information to decide if it should
> > recommend "q35" or "pc".
> 
> We don't really need a complicated rule set, we would just recommend q35
> by default. Libvirt will try to create the default machine and if fails
> for some reason (what would it be?) it can switch to PC.
> 
> The advanced logic would be "old systems should use PC", where old
> means Windows XP and before and so on. But this logic should appear
> in management layers above.

In this case, is there any difference between "changing the
default to q35" and "recommending q35", for libvirt users?

-- 
Eduardo
