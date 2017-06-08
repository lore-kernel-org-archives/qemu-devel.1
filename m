Received: from eggs.gnu.org ([2001:4830:134:3::10]:47563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adam@os.inf.tu-dresden.de>) id 1dJ4FI-00049T-QR
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adam@os.inf.tu-dresden.de>) id 1dJ4FF-0001Ph-OS
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:41:32 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:40331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <adam@os.inf.tu-dresden.de>)
	id 1dJ4FF-0001PL-HA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:41:29 -0400
Date: Thu, 8 Jun 2017 22:41:16 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Message-ID: <20170608204116.svjgt323qrbghyku@os.inf.tu-dresden.de>
References: <20170607044148.10481-1-anatol.pomozov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170607044148.10481-1-anatol.pomozov@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Remove restriction that prevents bootimg
 elf64 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: qemu-devel@nongnu.org


On Tue Jun 06, 2017 at 21:41:48 -0700, Anatol Pomozov wrote:
> It is possible to create a 64 bit elf image that has valid multiboot header.
> qemu should be able to boot such images.

But this 64bit image actually starts with 32bit code, right?
So it's a 32bit program and the check verifies that this is the case.



Adam
