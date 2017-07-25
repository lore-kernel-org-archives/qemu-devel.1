Received: from eggs.gnu.org ([2001:4830:134:3::10]:40198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZuFf-0006NS-TD
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZuFb-0006kZ-S9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:27:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZuFb-0006kH-Lb
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:27:27 -0400
Date: Tue, 25 Jul 2017 09:27:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170725092718.689401ac@gondolin>
In-Reply-To: <20170724143452.55534-1-pasic@linux.vnet.ibm.com>
References: <20170724143452.55534-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/css: fix ilen in IO instruction
 handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On Mon, 24 Jul 2017 16:34:52 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> When initiating a program check interruption by calling program_interrupt
> the instruction length (ilen) of the current instruction is supplied as
> the third parameter.
> 
> On s390x all the IO instructions are of instruction format S and their
> ilen is 4.  The calls to program_interrupt (introduced by commits
> 7b18aad543 ("s390: Add channel I/O instructions.", 2013-01-24) and
> 61bf0dcb2e ("s390x/ioinst: Add missing alignment checks for IO
> instructions", 2013-06-21)) however use ilen == 2.
> 
> This is probably due to a confusion between ilen which specifies the
> instruction length in bytes and ILC which does the same but in halfwords.
> If kvm_enabled() this does not actually matter, because the ilen
> parameter of program_interrupt is effectively unused.
> 
> Let's provide the correct ilen to program_interrupt.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Fixes:  7b18aad543 ("s390: Add channel I/O instructions.")
> Fixes: 61bf0dcb2e ("s390x/ioinst: Add missing alignment checks for IO instructions")
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/ioinst.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Thanks, applied.
