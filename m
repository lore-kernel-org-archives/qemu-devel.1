Received: from eggs.gnu.org ([2001:4830:134:3::10]:57704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXgic-0004TB-4D
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 01:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXgiZ-0007NP-1l
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 01:40:46 -0400
References: <20180622194736.GA5794@roeck-us.net>
	<126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
	<88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
	<20180626053246.6kyvrj7jbuhgdkgv@sivokote.iziade.m$>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f6c25172-573e-a7d2-8264-f44f0a5a0a27@redhat.com>
Date: Tue, 26 Jun 2018 07:40:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180626053246.6kyvrj7jbuhgdkgv@sivokote.iziade.m$>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] s390 qemu boot failure in -next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Georgi Guninski <guninski@guninski.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>

On 26.06.2018 07:32, Georgi Guninski wrote:
> On Mon, Jun 25, 2018 at 09:27:59AM +0200, Christian Borntraeger wrote:
>> -            /* Overwrite parameters in the kernel image, which are "rom" */
>> -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> 
>> +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> 
> Why not replace strcpy() with strncpy() or snprintf()?
> strcpy() may overflow.

This will be fixed by
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04227.html by
adding a check for a valid size.

 Thomas
