Received: from eggs.gnu.org ([2001:4830:134:3::10]:52059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fT16V-0006VA-Kx
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fT16R-0000WT-N8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:26:07 -0400
Date: Wed, 13 Jun 2018 10:25:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180613102556.40293b9c.cohuck@redhat.com>
In-Reply-To: <20180612125933.262679-1-borntraeger@de.ibm.com>
References: <20180612125933.262679-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/1] s390x/ipl: Try to detect Linux vs
 non Linux for initial IPL PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Tue, 12 Jun 2018 14:59:33 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Right now the IPL device always starts from address 0x10000 (the usual
> Linux entry point). To run other guests (e.g. test programs) it is
> useful to use the IPL PSW from address 0. We can use the Linux magic
> at 0x10008 to decide.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> v3->v4:
> 	- iplpsw-> ipl_psw
> 	- move check for load failures into the non-elf case
> 	- change comment about ipl psw
> v2->v3:
> 	- check for iplpsw to avoid assert on file errors
> 	- use 4 bytes at 4 instead of 8 bytes at 0
> v1->v2:
> 	- use LINUX_MAGIC_ADDR define
> 	- use assert for valid iplpsw pointer
> 	- add endianess conversion
>  hw/s390x/ipl.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Thanks, applied.
