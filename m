Received: from eggs.gnu.org ([2001:4830:134:3::10]:42947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnQNH-0006pt-Ky
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnQND-00075p-1b
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:23:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnQNC-00075O-RY
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:23:10 -0400
Date: Thu, 31 Aug 2017 16:23:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170831162302.1826247f.cohuck@redhat.com>
In-Reply-To: <20170830170601.15855-3-david@redhat.com>
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 02/11] cpu: drop old comments describing
 members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On Wed, 30 Aug 2017 19:05:52 +0200
David Hildenbrand <david@redhat.com> wrote:

> These comments are obviously stale.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/qom/cpu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 25eefea7ab..6b4b838e8f 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -378,10 +378,10 @@ struct CPUState {
>      DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
>  
>      /* TODO Move common fields from CPUArchState here. */
> -    int cpu_index; /* used by alpha TCG */
> -    uint32_t halted; /* used by alpha, cris, ppc TCG */
> +    int cpu_index;
> +    uint32_t halted;
>      uint32_t can_do_io;
> -    int32_t exception_index; /* used by m68k TCG */
> +    int32_t exception_index;
>  
>      /* shared by kvm, hax and hvf */
>      bool vcpu_dirty;

Yup, no need to drag these around. In case I don't take this through
s390-next:

Acked-by: Cornelia Huck <cohuck@redhat.com>
