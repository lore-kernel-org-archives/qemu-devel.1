Received: from eggs.gnu.org ([2001:4830:134:3::10]:51322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eRKKx-00029J-Vh
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eRKKt-0007V9-JY
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:01:48 -0500
Date: Tue, 19 Dec 2017 17:01:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171219170136.239cd55b.cohuck@redhat.com>
In-Reply-To: <20171219082807.84494-1-borntraeger@de.ibm.com>
References: <20171219082807.84494-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/sclp: fixup highest CPU address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

On Tue, 19 Dec 2017 09:28:07 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> the highest cpu address is not the same as max_cpus. max_cpus

s/the/The/

> counts from 1 while the cpu address starts at 0.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> ---
>  hw/s390x/sclp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 9be0cb80ad..21351ffffc 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -67,7 +67,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>      prepare_cpu_entries(sclp, read_info->entries, &cpu_count);
>      read_info->entries_cpu = cpu_to_be16(cpu_count);
>      read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
> -    read_info->highest_cpu = cpu_to_be16(max_cpus);
> +    read_info->highest_cpu = cpu_to_be16(max_cpus - 1);
>  
>      read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
>  

Thanks, applied.
