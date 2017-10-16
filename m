Received: from eggs.gnu.org ([2001:4830:134:3::10]:44837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e44Vl-0000ib-OE
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e44Vj-0002Qs-1U
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:28:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e44Vi-0002Pv-PY
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:28:46 -0400
Date: Mon, 16 Oct 2017 13:28:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171016122842.GB10968@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CADak6y6tAEZoO544xK3A5EnJ_mL4hQNJOZA6-_WOYrio9_Krgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADak6y6tAEZoO544xK3A5EnJ_mL4hQNJOZA6-_WOYrio9_Krgg@mail.gmail.com>
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
Cc: qemu-devel@nongnu.org

On Mon, Oct 16, 2017 at 08:19:36PM +0800, Paul Schlacter wrote:
> qemu-kvm: -device
> virtio-blk-pci,scsi=off,bus=pci.0,addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1:
> Property '.x-data-plane' not found
> 
> What is wrong with this report? is Compiler qemu lost parameters?

This option was deleted almost 2 years ago.

It was only ever a temporary hack to let people do performance testing,
while the proper long term solution was implemented. It is replaced by
the 'iothread' concept - see docs/devel/multiple-iothreads.txt

NB any property whose name starts with 'x-' is a temporary hack that is
liable to be deleted at any time.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
