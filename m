Received: from eggs.gnu.org ([2001:4830:134:3::10]:42643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e2JIY-0007Rp-Nn
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e2JIU-0003gy-Rz
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:51:54 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:52192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e2JIU-0003fg-KB
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:51:50 -0400
Received: by mail-wm0-x22e.google.com with SMTP id f4so6126074wme.0
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 08:51:49 -0700 (PDT)
Date: Wed, 11 Oct 2017 16:51:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171011155146.GE8121@stefanha-x1.localdomain>
References: <150737816601.1214.11131017369010701335.malonedeb@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150737816601.1214.11131017369010701335.malonedeb@chaenomeles.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1721952] [NEW] Network issue above 2.5.1.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1721952 <1721952@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org, Joan Moreau <jom@grosjo.net>

On Sat, Oct 07, 2017 at 12:09:25PM -0000, Joan Moreau via Qemu-devel wrote:
> WHen running a QEMU guest (Windows7) on a linux x86-64 server, the network stops working after some time for any version above 2.5.1.1
> 
> In 2.5.1.1, all is fine (no issue with network)
> Any version ablve (trying 2.10.1 now), the application in windows stops accessing the internet after a while
> 
> THis is my starting line:
> /usr/bin/qemu-system-x86_64 -machine pc-i440fx-1.7,accel=kvm -usb -usbdevice tablet -usbdevice keyboard -enable-kvm -cpu core2duo -smp 2 -drive file=winpro.qcow,index=0,media=disk,format=qco
> w2 -m 4096 -vga vmware -vnc :3 -k en-us -device e1000,netdev=nic1 -netdev user,id=nic1,smb=/data/vps/files/,hostfwd=tcp::10053-:10053,hostfwd=tcp::3387-:3389 -rtc base=utc,clock=host -daemon
> ize
> 
> Thisis my configure line:
> ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-kvm --disable-gtk --disable-xen --disable-user --enable-vnc-sasl --disable-libusb --disable-debug-info --disable-spi
> ce --enable-lzo --enable-pie --disable-werror --enable-linux-aio --enable-vhost-net --disable-tcmalloc --enable-vde --enable-nettle --disable-smartcard --enable-curl

Does tcpdump on the host show outgoing connections to an external IP
address (not a domain name)?  For example, try opening to
http://172.99.69.163/ from inside the guest and check that there is a
TCP SYN packet sent from the host to 172.99.69.163.

Do the hostfwd ports still work while internet access is down?

Stefan
