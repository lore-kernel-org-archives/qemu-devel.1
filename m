Received: from eggs.gnu.org ([2001:4830:134:3::10]:42843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj8bA-0003Rn-Tq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj8b7-0002Df-5N
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:03:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cj8b6-0002CS-VI
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:03:33 -0500
Date: Wed, 1 Mar 2017 20:03:28 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170301200153-mutt-send-email-mst@kernel.org>
References: <20170301125414.GD10160@redhat.com>
	<OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
	<CAJ+F1C+h7iyCSxE6p91NtEoTZSLtLBuF53=6yuWH+n-tBdV5=A@mail.gmail.com>
	<05b271a3-4bf9-729b-d662-c9886951f26d@linux.vnet.ibm.com>
	<20170301181146-mutt-send-email-mst@kernel.org>
	<20170301163104.GJ10160@redhat.com>
	<20170301185414-mutt-send-email-mst@kernel.org>
	<1d155a66-8806-8792-b82d-4bebabcd4971@linux.vnet.ibm.com>
	<20170301191459-mutt-send-email-mst@kernel.org>
	<20170301172013.GL10160@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170301172013.GL10160@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "SERBAN, CRISTINA" <cs1731@att.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH, CHING C" <cs1815@att.com>

On Wed, Mar 01, 2017 at 05:20:13PM +0000, Daniel P. Berrange wrote:
> > > > > QEMU's defined the vhost-user ABI/API and delegated
> > > > > impl to something else.
> > > > The vhost ABI isn't easy to maintain at all though. So I would not
> > > > commit to that lightly without a good reason.
> > > > 
> > > > It will be way more painful if the ABI is dictated by a 3rd party
> > > > library.
> > > 
> > > Who should define it?
> > 
> > No one. Put it in same source tree with QEMU and forget ABI stability
> > issues.
> 
> That doesn't work very well in practice as you have to make sure the
> vTPM process that is running, provides exactly the same ABI as the QEMU
> process that's connecting to it. You could have a single vTPM process
> on the host serving many QEMU processes, each of which could be a
> different QEMU version, due to upgraded RPMs/Debs.
> 
> Regards,
> Daniel

I might be wrong but last time I looked each QEMU instance had to use
its own CUSE device. So the pain seems entirely self-inflicted, you
could have a process per QEMU instance, start and stop it from within
QEMU.


> -- 
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
