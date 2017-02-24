Received: from eggs.gnu.org ([2001:4830:134:3::10]:39215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chDTO-0005DR-50
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chDTN-0007lY-2J
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:51:38 -0500
References: <148776029578.5865.5785337570950575739.stgit@bahia>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d34307e3-6fcd-53bd-d134-5f9de21516d7@redhat.com>
Date: Fri, 24 Feb 2017 11:51:33 +0100
MIME-Version: 1.0
In-Reply-To: <148776029578.5865.5785337570950575739.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr/pci: populate PCI DT in reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

On 22.02.2017 11:56, Greg Kurz wrote:
> From: Greg Kurz <gkurz@linux.vnet.ibm.com>
[...]
> This patch reverts to the historical SLOF ordering by walking PCI devices
> in reverse order. This reconciles pseries with x86 machine types behavior.
> It is expected to make things easier when porting existing applications to
> power.
[...]
> This patch was posted and already discussed during 2.5 development:
> 
> http://patchwork.ozlabs.org/patch/549925/
> 
> The "consensus" at the time was that guests should not rely on device
> ordering (i.e. use persistent naming instead).
> 
> I got recently contacted by OpenStack people who had several complaints
> about the reverse ordering of PCI devices in pseries: different behavior
> between ppc64 and x86, lots of time spent in debugging when porting
> applications from x86 to ppc64 before realizing that it is caused by the
> reverse ordering, necessity to carry hacky workarounds...
> 
> One strong argument against handling this properly with persistent naming
> is that it requires systemd/udev. This option is considered as painful
> with CirrOS, which aims at remaining as minimal as possible and is widely
> used in the OpenStack ecosystem.
> 
> Would you re-consider your position and apply this patch ?

+1 for applying the patch.

During the past months, I've also run one or two times into issues with
the reversed ordering... fortunately, I was able to work around them (or
fix other bugs triggered by this), but I think it would be better to
return the the ascending order again to avoid further future problems.

 Thomas
