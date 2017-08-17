Received: from eggs.gnu.org ([2001:4830:134:3::10]:54480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diJSw-00049M-44
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diJSs-0000vL-4J
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:59:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diJSr-0000vB-US
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:59:54 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-7-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cd4b14e0-546f-7d11-d21f-e0c36084b43e@redhat.com>
Date: Thu, 17 Aug 2017 13:59:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 06/10] target/s390x: introduce
 internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 17.08.2017 11:22, David Hildenbrand wrote:
> cpu.h should only contain what really has to be accessed outside of
> target/s390x/. Add internal.h which can only be used inside target/s390x/.
> 
> Move everything that isn't fast enough to run away and restructure it
> right away. We'll move all kvm_* stuff later.
> 
> Minor style fixes to avoid checkpatch warning to:
> - struct Lowcore: "{" goes into same line as typedef
> - struct LowCore: add spaces around "-" in array length calculations
> - time2tod() and tod2time(): move "{" to separate line
> - get_per_atmid(): add space between ")" and "?". Move cases by one char.
> - get_per_atmid(): drop extra paremthesis around (1 << 6)
> 
> Change license of new file to GPL2+ and keep copyright notice.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/arch_dump.c   |   1 +
>  target/s390x/cc_helper.c   |   1 +
>  target/s390x/cpu.c         |   1 +
>  target/s390x/cpu.h         | 343 ---------------------------------------
>  target/s390x/cpu_models.c  |   1 +
>  target/s390x/diag.c        |   1 +
>  target/s390x/excp_helper.c |   1 +
>  target/s390x/fpu_helper.c  |   1 +
>  target/s390x/gdbstub.c     |   1 +
>  target/s390x/helper.c      |   1 +
>  target/s390x/int_helper.c  |   1 +
>  target/s390x/internal.h    | 391 +++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/interrupt.c   |   1 +
>  target/s390x/ioinst.c      |   1 +
>  target/s390x/kvm.c         |   1 +
>  target/s390x/machine.c     |   1 +
>  target/s390x/mem_helper.c  |   1 +
>  target/s390x/misc_helper.c |   1 +
>  target/s390x/mmu_helper.c  |   1 +
>  target/s390x/translate.c   |   1 +
>  20 files changed, 409 insertions(+), 343 deletions(-)
>  create mode 100644 target/s390x/internal.h

Reviewed-by: Thomas Huth <thuth@redhat.com>
