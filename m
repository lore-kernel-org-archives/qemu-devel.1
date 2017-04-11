Received: from eggs.gnu.org ([2001:4830:134:3::10]:44355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxrl9-0005dV-Eu
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxrl6-0000s6-6Y
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:06:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cxrl5-0000q6-VM
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:06:44 -0400
Date: Tue, 11 Apr 2017 10:06:38 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170411090638.GB12640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CACpTSGuo31hQf6gEto2oFVW7WPuaVqEURQRm+mfjKuXyaFN_cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACpTSGuo31hQf6gEto2oFVW7WPuaVqEURQRm+mfjKuXyaFN_cA@mail.gmail.com>
Subject: Re: [Qemu-devel] quick question about live VM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinod Chegu <vinodchegu@gmail.com>
Cc: qemu-devel@nongnu.org

On Mon, Apr 10, 2017 at 01:07:14PM -0700, Vinod Chegu wrote:
> Hello,
> 
> A very basic question...
> 
> In a vanilla KVM env. (i.e. non open stack etc) when  a VM is live migrated
> to another host does the MAC address of the vNICs and the DHCP IP address
> for these interfaces remain the same ?

*All* aspects of the virtual machine hardware *must* remain the same. If you
have any differences in configuration of QEMU on the target host you are likely
to either prevent live migration working, or break the guest OS after migration
is finished. This includes MAC address, PCI addresses, device versions, etc,
etc

> Thought the answer was a yes as the goal is to minimize disruption to the
> apps etc. in the VM, but wanted to double check (couldn't verify as I don't
> have a ready test env handy at the moment).
> 
> BTW, please assume that the MAC address for the vNIC interfaces were not
> explicitly specified at the time of VM creation.

It is the responsibility of whoever/whatever launches QEMU on the target
host to ensure the hardware config is identical. The only safe way todo
this is ensure you specify every single aspect of guest hardware when
launching QEMU, including the MAC address. 

FWIW, if you are using libvirt to manage QEMU, then libvirt goes to great
lengths to ensure this happens (which is why QEMU command lines generated
by libvirt are so huge :-)

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
