Received: from eggs.gnu.org ([2001:4830:134:3::10]:51330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dahJj-0006II-Oi
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dahJf-00010G-Qx
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:50:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dahJf-0000zy-KB
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:50:55 -0400
Date: Thu, 27 Jul 2017 12:50:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170727115042.GL2555@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<CAFEAcA_t8EDNnWTeRzuHEcdfq3DJFTN3ug=DHnGvWef3=wyFzA@mail.gmail.com>
	<20170727105348.GG7970@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170727105348.GG7970@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL
 to avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>

On Thu, Jul 27, 2017 at 08:53:48PM +1000, David Gibson wrote:
> On Thu, Jul 27, 2017 at 10:11:48AM +0100, Peter Maydell wrote:
> > On 27 July 2017 at 02:30, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > > In particular, Mellanox CX4 adapters on PowerNV hosts might not be fully
> > > quiesced by vfio-pci's finalize() routine until up to 6s after the
> > > DEVICE_DELETED was emitted, leading to detach-device on the libvirt side pretty
> > > much always crashing the host.
> > 
> > My initial naive thought is that if the host kernel can crash then
> > this is a host kernel bug... shouldn't the host kernel refuse
> > the subsequent libvirt rebind if it would cause a crash ?
> 
> I think so too, but I haven't been able to convince Alex.  Nor
> find time to fix it in the kernel myself.

I think we need to fix both the QEMU premature sending of DEVICE_DELETED
and the kernel bug that allowed the crash.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
