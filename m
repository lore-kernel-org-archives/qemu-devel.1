Received: from eggs.gnu.org ([2001:4830:134:3::10]:44430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fT4yM-0005lf-1j
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fT4yG-00075i-Se
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:33:58 -0400
Date: Wed, 13 Jun 2018 14:33:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180613143345.3c70a3de.cohuck@redhat.com>
In-Reply-To: <20180613081819.147178-1-borntraeger@de.ibm.com>
References: <20180613081819.147178-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/cpumodels: add z14 Model ZR1
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

On Wed, 13 Jun 2018 10:18:19 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> introduce the new z14 Model ZR1 cpu model. Mostly identical to z14, only
> the cpu type differs (3906 vs. 3907)
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_models.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index e10035aaa8..cfdbccf46d 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -79,6 +79,7 @@ static S390CPUDef s390_cpu_defs[] = {
>      CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"),
>      CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
> +    CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
>  };
>  
>  #define QEMU_MAX_CPU_TYPE 0x2827

Thanks, applied.
