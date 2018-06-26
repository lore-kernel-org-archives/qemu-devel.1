Received: from eggs.gnu.org ([2001:4830:134:3::10]:56812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guninski@guninski.com>) id 1fXgb0-0003bg-KF
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 01:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guninski@guninski.com>) id 1fXgax-0004M2-I5
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 01:32:54 -0400
Date: Tue, 26 Jun 2018 08:32:46 +0300
From: Georgi Guninski <guninski@guninski.com>
Message-ID: <20180626053246.6kyvrj7jbuhgdkgv@sivokote.iziade.m$>
References: <20180622194736.GA5794@roeck-us.net>
	<126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
	<88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
Subject: Re: [Qemu-devel] s390 qemu boot failure in -next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On Mon, Jun 25, 2018 at 09:27:59AM +0200, Christian Borntraeger wrote:
> -            /* Overwrite parameters in the kernel image, which are "rom" */
> -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);

> +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);

Why not replace strcpy() with strncpy() or snprintf()?
strcpy() may overflow.
