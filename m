Received: from eggs.gnu.org ([2001:4830:134:3::10]:46482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZeUB-0005Qu-Hn
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZeU8-0003fE-Sx
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dZeU8-0003eR-Mf
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:37:24 -0400
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1b898c34-3bda-c31d-b212-a2c090a01f62@redhat.com>
Date: Mon, 24 Jul 2017 16:37:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170721125609.11117-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/6] target/s390x: fix pgm irq ilen in
 translate_pages()
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

On 21.07.2017 14:56, David Hildenbrand wrote:
> 0 is certainly wrong. Let's use ILEN_AUTO.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mmu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index a873dc4..1ad0158 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -440,7 +440,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
>          }
>          if (!address_space_access_valid(&address_space_memory, pages[i],
>                                          TARGET_PAGE_SIZE, is_write)) {
> -            program_interrupt(env, PGM_ADDRESSING, 0);
> +            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
>              return -EFAULT;
>          }
>          addr += TARGET_PAGE_SIZE;
> 

That makes more sense, indeed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
