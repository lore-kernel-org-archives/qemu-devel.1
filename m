Received: from eggs.gnu.org ([2001:4830:134:3::10]:41251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCUPc-0005f9-S1
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCUPY-0004mI-JI
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:45:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCUPY-0004lv-Dj
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:45:12 -0500
Date: Wed, 8 Nov 2017 17:45:06 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108174506.GI12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171107104653.8913-1-paul.durrant@citrix.com>
	<20171108174227.GC8403@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171108174227.GC8403@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3] xen-disk: use an IOThread per instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paul Durrant <paul.durrant@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

On Wed, Nov 08, 2017 at 05:42:27PM +0000, Stefan Hajnoczi wrote:
> On Tue, Nov 07, 2017 at 05:46:53AM -0500, Paul Durrant wrote:
> > This patch allocates an IOThread object for each xen_disk instance and
> > sets the AIO context appropriately on connect. This allows processing
> > of I/O to proceed in parallel.
> > 
> > The patch also adds tracepoints into xen_disk to make it possible to
> > follow the state transtions of an instance in the log.
> 
> virtio-blk and virtio-scsi allow the user to specify an IOThread object.
> This allows users to configure the device<->IOThread mapping any way
> they like (e.g. 1:1, M:N).  Are you sure you want to hard-code the
> IOThread mapping?

I certainly think it'd be better for mgmt apps if all disks had the same
approach to IOThread mapping.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
