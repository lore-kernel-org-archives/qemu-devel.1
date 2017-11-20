Received: from eggs.gnu.org ([2001:4830:134:3::10]:59323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGiFQ-0006DC-14
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGiFM-0005Fe-Th
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:20:12 -0500
References: <20171120091520.86128-1-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <918202bd-83c1-e6af-d356-6ce7da4e31fa@redhat.com>
Date: Mon, 20 Nov 2017 10:20:04 +0100
MIME-Version: 1.0
In-Reply-To: <20171120091520.86128-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] pc-bios/s390-ccw: build s390
 bios with -fno-zero-initialized-in-bss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 20.11.2017 10:15, Christian Borntraeger wrote:
> The QEMU ELF loader does not initialize the bss segment. This has
> triggered several bugs in the past, e.g. see commit 5d739a4787a5
> ("s390-ccw.img: Fix sporadic errors with ccw boot image - initialize
> css").
> 
> Instead of fixing these things one-by-one we can build the BIOS
> with -fno-zero-initialized-in-bss. This will move the zero variables
> also into the data segment, which is then part of a LOAD section.

It fixes the problem only for variables that are explicitely intialized
to 0 along with their declaration - it does not fix the problem for
uninitialized variables.

 Thomas
