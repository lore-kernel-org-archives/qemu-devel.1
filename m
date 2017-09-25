Received: from eggs.gnu.org ([2001:4830:134:3::10]:48621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwQgx-0001XQ-LO
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwQgu-0008AP-Rw
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:32:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwQgu-0008A9-Li
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:32:44 -0400
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-16-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d2b2d4c9-b87f-b418-1f94-0c6ad168a731@redhat.com>
Date: Mon, 25 Sep 2017 12:32:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 15/27] s390x/kvm: drop two debug prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 18.09.2017 18:00, David Hildenbrand wrote:
> Preparation for moving it out of kvm.c.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/kvm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 01c4125d21..d759edf1c8 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1640,7 +1640,6 @@ int kvm_s390_cpu_restart(S390CPU *cpu)
>      SigpInfo si = {};
>  
>      run_on_cpu(CPU(cpu), sigp_restart, RUN_ON_CPU_HOST_PTR(&si));
> -    DPRINTF("DONE: KVM cpu restart: %p\n", &cpu->env);
>      return 0;
>  }
>  
> @@ -1742,7 +1741,6 @@ static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
>          run_on_cpu(CPU(dst_cpu), sigp_cpu_reset, RUN_ON_CPU_HOST_PTR(&si));
>          break;
>      default:
> -        DPRINTF("KVM: unknown SIGP: 0x%x\n", order);
>          set_sigp_status(&si, SIGP_STAT_INVALID_ORDER);
>      }

Reviewed-by: Thomas Huth <thuth@redhat.com>
