Received: from eggs.gnu.org ([2001:4830:134:3::10]:60396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJf9a-0008Vu-S2
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:33:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJf9X-0006VF-32
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:33:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cJf9W-0006Ul-Th
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:33:47 -0500
Date: Wed, 21 Dec 2016 11:33:41 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161221113341.GB2498@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAMxP3BREAp7wm8B8=z0d1qAcG18Pv19UpU7RrSikGBunScNNOw@mail.gmail.com>
	<20161221112342.GE9482@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161221112342.GE9482@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] QEMU -smp paramater: Will multiplue threads and
 cores improve performance?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Bob Chen <a175818323@gmail.com>, qemu-devel@nongnu.org

On Wed, Dec 21, 2016 at 11:23:42AM +0000, Stefan Hajnoczi wrote:
> On Wed, Dec 21, 2016 at 04:44:08PM +0800, Bob Chen wrote:
> > -smp 16
> > 
> > -smp cores=4,threads=4,sockets=1
> > 
> > 
> > Which one has better performance? The scenario is guest VMs running on
> > cloud server.
> 
> It's more complicated than that.
> 
> The CPU topology (cores, threads, sockets) can be used by guest kernels
> to make scheduling decisions.

cores vs sockets will have little difference, but cores or sockets
vs threads will definitely affect guest schedular.

> If you pin vcpu threads to host cpus and configure the guest with
> an accurate CPU topology then you can expect the guest kernel to make
> the best decisions.
> 
> If you do not pin vcpu threads then you cannot expect any consistent
> performance advantage by specifying the CPU topology.

In fact if you do not pin threads and you specify a CPU topology that
has > 1 hyperthread, you may well make performance of the guest worse.

Essentially you never want to use threads>1, unless pinning guest CPUs
to host CPUs 1:1

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
