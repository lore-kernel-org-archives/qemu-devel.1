Received: from eggs.gnu.org ([2001:4830:134:3::10]:59150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eGiEt-0005p0-Fq
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eGiEq-00051H-6X
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:19:39 -0500
References: <20171120091520.86128-1-borntraeger@de.ibm.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <5a4be37f-29b5-1d0d-91ab-9cb15c93e088@suse.de>
Date: Mon, 20 Nov 2017 10:19:31 +0100
MIME-Version: 1.0
In-Reply-To: <20171120091520.86128-1-borntraeger@de.ibm.com>
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

On 11/20/2017 10:15 AM, Christian Borntraeger wrote:
> The QEMU ELF loader does not initialize the bss segment. This has
> triggered several bugs in the past, e.g. see commit 5d739a4787a5
> ("s390-ccw.img: Fix sporadic errors with ccw boot image - initialize
> css").
>
> Instead of fixing these things one-by-one we can build the BIOS
> with -fno-zero-initialized-in-bss. This will move the zero variables
> also into the data segment, which is then part of a LOAD section.

Doesn't this bloat the firmware? Why don't we just manually clear bss in 
the firmware itself? It's what all other firmwares do :)

Alex
