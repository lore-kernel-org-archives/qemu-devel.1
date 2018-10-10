Received: from eggs.gnu.org ([2001:4830:134:3::10]:36455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gAD4r-0005MX-Be
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gAD4q-0004AQ-IJ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:54:57 -0400
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:43451
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1gAD4q-0004A9-Bi
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:54:56 -0400
References: <CALF8MVHZSWutrbc-X04OMLQA1WZ1rSznbrxS68Z7eRRxL8YPqg@mail.gmail.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <325a30bd-d62d-b846-4e23-fdd5d0089944@comstyle.com>
Date: Wed, 10 Oct 2018 07:54:54 -0400
MIME-Version: 1.0
In-Reply-To: <CALF8MVHZSWutrbc-X04OMLQA1WZ1rSznbrxS68Z7eRRxL8YPqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] OpenBSD with VirtIO networking causes QEMU to crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: viq <vicviq@gmail.com>, qemu-devel@nongnu.org

On 10/9/2018 2:42 PM, viq wrote:

> (please CC me as I'm not subscribed to the list)
> I verified the behaviour on two different machines, both running archlinux
> with QEMU 3.0.0 and reported it on https://bugs.archlinux.org/task/60141
> where it was suggested I bring it to the list.
>
> So what happens: if you try to run OpenBSD with VirtIO networking enabled,
> the moment OpenBSD brings up network the QEMU process crashes. Easiest
> steps to reproduce:
> Download for example
> https://ftp.halifax.rwth-aachen.de/pub/OpenBSD/6.3/amd64/install63.iso
> Create new VM under libvirt as OpenBSD 6.3, create disk, "change options
> before installation", change disk and network types to virtio
> Proceed with installation (basically enter-enter-enter-...)
> Observe qemu crash when network is brought up.
>
> Sorry, I don't really know how to proceed further with that.

A regression with 3.0.0.

https://marc.info/?l=qemu-devel&m=153635729122442&w=2
