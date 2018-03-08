Received: from eggs.gnu.org ([2001:4830:134:3::10]:52589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etxQv-0004t7-L3
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etxQq-0005I6-Jj
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:26:17 -0500
Date: Thu, 8 Mar 2018 16:26:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180308152603.x6ysyb4vq5py67mb@sirius.home.kraxel.org>
References: <7c67e799-f4d8-6bf5-004e-6e1106fe053a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c67e799-f4d8-6bf5-004e-6e1106fe053a@de.ibm.com>
Subject: Re: [Qemu-devel] qemu crashes with vnc and multiple outputs +
 console redirection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>

  Hi,

> I am playing with the virtio-gpu support on s390 and for that I also wanted to multiplex
> the existing consoles.
> So I basically used the max_outputs=2 of virtio gpu to be able
> to switch with ctrl+alt+1 and 3 between the virtio gpu and the sclplm console.

Why max_outputs=2?  Do you want two fbdev devices?

> -chardev pty,id=charconsole0 -device sclpconsole,chardev=charconsole0,id=console0
> -chardev vc,id=charconsole1 -device sclplmconsole,chardev=charconsole1,id=console1
> -device virtio-keyboard-ccw,id=input0,devno=fe.0.0001
> -vnc 0.0.0.0:0
> -k en-us
> -device virtio-gpu-ccw,id=video0,max_outputs=2,devno=fe.0.0008 
> 
> 
> This seems to work fine, vrtio-gpu is on 1 and sclplm is on 3. Problem is, 
> when I randomly do ctrl+alt+[^1..9] sooner or later qemu crashes with

Any chance this is ctrl-alt-2 ?

cheers,
  Gerd
