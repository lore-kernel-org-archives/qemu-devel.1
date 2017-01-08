Received: from eggs.gnu.org ([2001:4830:134:3::10]:49022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cQ2Vn-00009E-AQ
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 20:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cQ2Vk-0007P4-8N
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 20:43:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cQ2Vk-0007Of-2G
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 20:43:04 -0500
Date: Sun, 8 Jan 2017 09:42:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170108014043.GA9148@lemon.Home>
References: <20131120230014.7464.50074.malonedeb@wampee.canonical.com>
	<20170107213614.14095.1814.malone@soybean.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170107213614.14095.1814.malone@soybean.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1253465] Re: qemu-img: 'image' uses a vmdk
 feature which is not supported by this qemu version: VMDK version 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1253465 <1253465@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

On Sat, 01/07 21:36, Patrick Schleizer wrote:
> > If you are aware of open source software which already supports
> version 3, please let us know!
> 
> VirtualBox can.
> 
> - VirtualBox uses VMDK version 3 disks.
> - When you export a VM with VirtualBox (creating an .ova), it will include VMDK version 3 disks.
> - VirtualBox can convert from vmkd to vdi. ('VBoxManage clonehd --format VDI "vmdk_file" "vdi_file"')
> 
> Does that help?

Can you try again with QEMU 2.8? Recent versions of QEMU should be able to
handle version 3 VMDK disks.

Fam
