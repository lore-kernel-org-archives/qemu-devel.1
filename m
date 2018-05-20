Received: from eggs.gnu.org ([2001:4830:134:3::10]:45162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fKTQm-00027h-4b
	for qemu-devel@nongnu.org; Sun, 20 May 2018 14:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fKTQl-0002QF-6c
	for qemu-devel@nongnu.org; Sun, 20 May 2018 14:51:44 -0400
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
	<886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
	<20180518131303.6f0778eb@bahia.lan>
	<e9333edf-fa2a-6ad8-412b-459b0b8002e9@xenosoft.de>
	<20180518141642.6ad639ac@bahia.lan>
	<8bde9b6f-b80f-e87e-e4d3-ace15454cf3d@xenosoft.de>
	<3db651e3-a237-fbaa-6ffe-ecc5db43ad0f@tuxfamily.org>
	<E9FA9AA6-FDA6-467F-9B72-B331756464A7@xenosoft.de>
	<ccaa7d46-79d4-c223-3828-ae22a59392db@tuxfamily.org>
	<7d552162-5165-c022-ce6d-4903da7d2262@xenosoft.de>
	<20180519171949.0031d971@thl530.multi.box>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <62700eb1-e13e-6262-ed2d-31feb6b38dd0@xenosoft.de>
Date: Sun, 20 May 2018 20:51:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180519171949.0031d971@thl530.multi.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Subject: Re: [Qemu-devel] [Qemu-ppc] [PPC64] P5020DS: Booting from img
 possible (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, qemu-devel@nongnu.org

On 19 May 2018 at 5:19PM, Thomas Huth wrote:
> On Sat, 19 May 2018 16:03:02 +0200
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>
>
>> Unfortunately mouse and keyboard doesn't work in the virtual machine.
> I guess with the ppce500 machine, you've also got to specify them
> manually, too. You've got two options, virtio and USB. For virtio, try:
>
>   -device virtio-mouse-pci -device virtio-keyboard-pci
>
> And for USB, try something like:
>
>   -device qemu-xhci -device usb-mouse -device usb-kbd
>
> If "qemu-xhci" does not work, you could also try "pci-ohci" instead.
>
>   HTH,
>    Thomas
>
Yes, you're right. Mouse and keyboard work!

Screenshot: 
https://plus.google.com/u/0/photos/photo/115515624056477014971/6557728521525034386

Many thanks for your help! :-)
