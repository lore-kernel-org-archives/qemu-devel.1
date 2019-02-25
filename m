Received: from eggs.gnu.org ([209.51.188.92]:44360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyEK5-0000hm-63
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 06:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyEK2-0002tH-MY
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 06:21:25 -0500
Date: Mon, 25 Feb 2019 12:21:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190225122110.22c829df.cohuck@redhat.com>
In-Reply-To: <20190222081153.14206-1-david@redhat.com>
References: <20190222081153.14206-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/3] s390x: SIGP + IRQ preparations for
 TCG vector register support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On Fri, 22 Feb 2019 09:11:50 +0100
David Hildenbrand <david@redhat.com> wrote:

> These are minor preparations for vector instruction support for TCG, also
> touching KVM code.
> 
> During SIGP STORE ADDITIONAL STATUS we have to properly convert the
> endianess. On machine checks, we have to also store the vector registers
> into the extended save area.
> 
> Both changes are not used by TCG code before we implement + enable
> vector instructions. KVM code shares the SIGP STORE ADDITIONAL STATUS
> implementation.
> 
> Note: Vector registers (128 bit) are modeled as two 64 bit values. Low and
> high 64 bit values correspond on big/little systems, however the values
> themself need conversion. Documentation for that will be added along with
> the actual vector instruction support.
> 
> David Hildenbrand (3):
>   s390x: Use cpu_to_be64 in SIGP STORE ADDITIONAL STATUS
>   s390x: use a QEMU-style typedef + name for SIGP save area struct
>   s390x/tcg: Save vregs to extended mchk save area
> 
>  target/s390x/excp_helper.c | 46 ++++++++++++++++++++++++++++++++++++--
>  target/s390x/helper.c      | 39 ++++++++++++++++++++------------
>  target/s390x/internal.h    |  4 +++-
>  3 files changed, 72 insertions(+), 17 deletions(-)
> 

Thanks, applied.
