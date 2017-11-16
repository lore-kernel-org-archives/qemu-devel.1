Received: from eggs.gnu.org ([2001:4830:134:3::10]:41127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFR2U-0001ml-LS
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFR2Q-000724-Nx
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:45:34 -0500
References: <20171116170526.12643-1-david@redhat.com>
	<20171116170526.12643-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <79c05cdb-6aec-b2bf-f4b9-167e8df6214f@redhat.com>
Date: Thu, 16 Nov 2017 21:45:19 +0100
MIME-Version: 1.0
In-Reply-To: <20171116170526.12643-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.11 1/3] s390x: fix
 storing CPU status (again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 16.11.2017 18:05, David Hildenbrand wrote:
> Looks like the last fix + cleanup introduced another bug. (for now Linux
> guests don't seem to care) - we store the crs into ars.
> 
> Fixes: 947a38bd6f13 ("s390x/kvm: fix and cleanup storing CPU status")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index f78983dd6a..246ba20f0d 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -279,7 +279,7 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
>          sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
>      }
>      for (i = 0; i < 16; ++i) {
> -        sa->ars[i] = cpu_to_be64(cpu->env.cregs[i]);
> +        sa->crs[i] = cpu_to_be64(cpu->env.cregs[i]);
>      }
>  
>      cpu_physical_memory_unmap(sa, len, 1, len);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
