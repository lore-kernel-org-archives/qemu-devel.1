Received: from eggs.gnu.org ([2001:4830:134:3::10]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw7Qm-0003ui-Jh
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw7Qi-0007qy-Ly
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:26:32 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:53866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cw7Qi-0007qR-FQ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:26:28 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 08B3D7BF7D
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 15:26:26 +0200 (CEST)
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
Date: Thu, 6 Apr 2017 15:26:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC v1 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: programmingkidx@gmail.com, alex.bennee@linaro.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Hello Nikunj,

On 04/06/2017 12:22 PM, Nikunj A Dadhania wrote:
> The series enables Multi-Threaded TCG on PPC64
> 
> Patch 01: Use atomic_cmpxchg in store conditional
>       02: Handle first write to page during atomic operation
>       03: Generate memory barriers for sync/isync and load/store conditional
> 
> Patches are based on ppc-for-2.10
> 
> Tested using following:
> ./ppc64-softmmu/qemu-system-ppc64 -cpu POWER8 -vga none -nographic -machine pseries,usb=off -m 2G  -smp 8,cores=8,threads=1 -accel tcg,thread=multi  f23.img

I tried it with a Ubuntu 16.04.2 guest using stress --cpu 8. It looked 
good : the CPU usage of QEMU reached 760% on the host.

> Todo:
> * Enable other machine types and PPC32.

I am quite ignorant on the topic. Have you looked at what it would
take to emulate support of the HW threads ? and the PowerNV machine ?

Thanks,

C. 

> * More testing for corner cases.
> 
> Nikunj A Dadhania (3):
>   target/ppc: Emulate LL/SC using cmpxchg helpers
>   cputlb: handle first atomic write to the page
>   target/ppc: Generate fence operations
> 
>  cputlb.c               |  8 +++++++-
>  target/ppc/translate.c | 29 ++++++++++++++++++++++++++---
>  2 files changed, 33 insertions(+), 4 deletions(-)
> 
