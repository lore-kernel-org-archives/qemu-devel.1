Received: from eggs.gnu.org ([2001:4830:134:3::10]:57554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d6K4n-0004Nv-DQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d6K4k-0006oU-Cf
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d6K4k-0006o1-6h
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:57:58 -0400
Date: Thu, 4 May 2017 17:57:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170504165753.GD2078@work-vm>
References: <VI1PR05MB167887445F80A38FED81EFABC9EA0@VI1PR05MB1678.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR05MB167887445F80A38FED81EFABC9EA0@VI1PR05MB1678.eurprd05.prod.outlook.com>
Subject: Re: [Qemu-devel] Issue with a manually compiled QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabien GREGOIRE <fabien.gregoire@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Fabien GREGOIRE (fabien.gregoire@outlook.com) wrote:
> Hello,
> 
> 
> 
> I have an issue with a manually compiled QEMU working with virt-manager/libvirt :
> 
> Internal Error: process exited while connecting to monitor:
> 
> qemu could not load PC BIOS 'bios-256k.bin'.
> 
> 
> 
> Here are the steps in order to reproduce :
> 
> - QEMU was previously installed from an "apt-get" : QEMU version is 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.11)
> 
> - To compile QEMU I use the following arguments :
> 
> --target-list=x86_64-softmmu --disable-vnc --enable-sdl --enable-spice --enable-usb-redir --enable-kvm
> 
> with this version : https://github.com/qemu/qemu/archive/v2.5.0.zip
> 
> - I replace the QEMU binary (/usr/bin/qemu-system-x86_64-spice) and I have the issue with error message written above.
> 
> 
> 
> Do you have any advice / information about this error ? Any workaround ?

You need to get a seabios binary from somewhere - the PC bios for the
emulator to run;  you should find one somewhere in your existing
install previously had a qemu install.

Dave

> 
> 
> Kind regards,
> 
> 
> 
> Fabien
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
