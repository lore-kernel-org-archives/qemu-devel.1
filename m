Received: from eggs.gnu.org ([2001:4830:134:3::10]:34117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eGiO9-0002yd-EU
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eGiO6-00010X-BY
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:29:13 -0500
References: <20171120091520.86128-1-borntraeger@de.ibm.com>
	<5a4be37f-29b5-1d0d-91ab-9cb15c93e088@suse.de>
	<08cec003-1291-8302-1280-d53cba5c7538@de.ibm.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <5a6cd622-3064-a920-8f72-bc820aa13203@suse.de>
Date: Mon, 20 Nov 2017 10:29:08 +0100
MIME-Version: 1.0
In-Reply-To: <08cec003-1291-8302-1280-d53cba5c7538@de.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: build s390 bios with
 -fno-zero-initialized-in-bss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>

On 11/20/2017 10:27 AM, Christian Borntraeger wrote:
>
> On 11/20/2017 10:19 AM, Alexander Graf wrote:
>> On 11/20/2017 10:15 AM, Christian Borntraeger wrote:
>>> The QEMU ELF loader does not initialize the bss segment. This has
>>> triggered several bugs in the past, e.g. see commit 5d739a4787a5
>>> ("s390-ccw.img: Fix sporadic errors with ccw boot image - initialize
>>> css").
>>>
>>> Instead of fixing these things one-by-one we can build the BIOS
>>> with -fno-zero-initialized-in-bss. This will move the zero variables
>>> also into the data segment, which is then part of a LOAD section.
>> Doesn't this bloat the firmware? Why don't we just manually clear bss in the firmware itself? It's what all other firmwares do :)
> Yes the proper fix is to initialize bss in the bios itself.
> I was trying to come up with something for 2.11, but since the patch does not solve the original issues, lets drop it.


Initializing bss is quite simple. You can probably even do it from C. 
Just set two variables before and after .bss in the linker script and 
memset(0) from start to end :).

Alex
