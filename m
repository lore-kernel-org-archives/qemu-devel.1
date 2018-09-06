Received: from eggs.gnu.org ([2001:4830:134:3::10]:45922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fxri8-0003H9-0q
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fxri3-0007wz-MI
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:40:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fxri3-0007se-H6
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:40:23 -0400
References: <153618529890.17241.16039771895973290192.malonedeb@chaenomeles.canonical.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <05c3d8dc-2d22-ceb8-3fef-30776797d171@redhat.com>
Date: Thu, 6 Sep 2018 12:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <153618529890.17241.16039771895973290192.malonedeb@chaenomeles.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1790975] [NEW] arm virt ecam pcie conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1790975 <1790975@bugs.launchpad.net>, qemu-devel@nongnu.org

Hi,

On 09/06/2018 12:08 AM, Jonathan Marler wrote:
> Public bug reported:
> 
> This occurs on qemu_v3.0.0 but not on qemu_v2.12.2 (built from
> qemu_v3.0.0 tag on github)
> 
> Symptom: You'll see something like this in the kernel output:
> 
> [    1.285210] OF: PCI: host bridge /pcie@10000000 ranges:
> [    1.286246] OF: PCI:    IO 0x3eff0000..0x3effffff -> 0x00000000
> [    1.287061] OF: PCI:   MEM 0x10000000..0x3efeffff -> 0x10000000
> [    1.287820] OF: PCI:   MEM 0x8000000000..0xffffffffff -> 0x8000000000
> [    1.289312] pci-host-generic 4010000000.pcie: can't claim ECAM area [mem 0x10000000-0x1fffffff]: address conflict with /pcie@10000000 [mem 0x10000000-0x3efeffff]
> [    1.290984] pci-host-generic: probe of 4010000000.pcie failed with error -16
> 
> 
> Qemu Command Line: qemu-system-arm -machine virt -m 1024M -kernel zImage -serial stdio

Please can you try using
qemu-system-arm -machine virt,highmem=off -m 1024M -kernel zImage
-serial stdio

Does your guest support LPAE? This may be the cause.

Thanks

Eric
> 
> I can post my zImage if anyone has problems reproducing with their own
> zImage.
> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> 
