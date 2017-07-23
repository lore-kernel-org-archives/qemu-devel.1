Received: from eggs.gnu.org ([2001:4830:134:3::10]:57076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dZN7N-00066d-JC
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dZN7K-00085Z-FX
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:04:45 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:33497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1dZN7K-00084M-9l
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:04:42 -0400
Received: by mail-qk0-x235.google.com with SMTP id k2so4192209qkf.0
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 13:04:42 -0700 (PDT)
Date: Sun, 23 Jul 2017 16:04:40 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170723200440.GA3718@morn.lan>
References: <767EFADFF809234DB6CAABD6D2F93847C5D31539@IRSMSX107.ger.corp.intel.com>
	<3319b641-b7f3-0ee8-e5ed-9c378e723eb4@redhat.com>
	<bc619876-bca3-15c8-0ef0-0fc5f833bab3@intel.com>
	<14b1b111-d2d6-6954-2d12-8e0ac791ae44@redhat.com>
	<d06866b6-e089-0427-2d57-40c4648734da@intel.com>
	<97068eca-2788-8396-0f8d-1990c651bdfc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97068eca-2788-8396-0f8d-1990c651bdfc@redhat.com>
Subject: Re: [Qemu-devel] >256 Virtio-net-pci hotplug Devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, "Kinsella, Ray" <ray.kinsella@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, seabios@seabios.org, Gerd Hoffmann <kraxel@redhat.com>, Michael Tsirkin <mst@redhat.com>

On Sun, Jul 23, 2017 at 07:28:01PM +0300, Marcel Apfelbaum wrote:
> On 22/07/2017 2:57, Kinsella, Ray wrote:
> > When scaling up to 512 Virtio-net devices SeaBIOS appears to really slow
> > down when configuring PCI Config space - haven't manage to get this to
> > work yet.

If there is a slowdown in SeaBIOS, it would help to produce a log with
timing information - see:
https://www.seabios.org/Debugging#Timing_debug_messages

It may also help to increase the debug level in SeaBIOS to get more
fine grained timing reports.

-Kevin
