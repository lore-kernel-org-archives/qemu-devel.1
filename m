Received: from eggs.gnu.org ([2001:4830:134:3::10]:38333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e5URK-0002lo-N3
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e5URF-0005Lt-Lp
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:22:06 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:56123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e5URF-0005LZ-DQ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:22:01 -0400
Received: by mail-wr0-x242.google.com with SMTP id z99so8471785wrc.12
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 03:22:01 -0700 (PDT)
Date: Fri, 20 Oct 2017 12:21:58 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171020102158.GH21393@stefanha-x1.localdomain>
References: <CADak6y6tAEZoO544xK3A5EnJ_mL4hQNJOZA6-_WOYrio9_Krgg@mail.gmail.com>
	<20171016122842.GB10968@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016122842.GB10968@redhat.com>
Subject: Re: [Qemu-devel] use qemu dataplane report '.x-data-plane' not found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Schlacter <wlfightup@gmail.com>
Cc: qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>

On Mon, Oct 16, 2017 at 01:28:42PM +0100, Daniel P. Berrange wrote:
> On Mon, Oct 16, 2017 at 08:19:36PM +0800, Paul Schlacter wrote:
> > qemu-kvm: -device
> > virtio-blk-pci,scsi=off,bus=pci.0,addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1:
> > Property '.x-data-plane' not found
> > 
> > What is wrong with this report? is Compiler qemu lost parameters?
> 
> This option was deleted almost 2 years ago.
> 
> It was only ever a temporary hack to let people do performance testing,
> while the proper long term solution was implemented. It is replaced by
> the 'iothread' concept - see docs/devel/multiple-iothreads.txt
> 
> NB any property whose name starts with 'x-' is a temporary hack that is
> liable to be deleted at any time.

In addition to what Dan has posted, libvirt has added domain XML syntax
for IOThreads.  That means it's no longer necessary to manually pass
QEMU command-line options if you use libvirt:

https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation

Stefan
