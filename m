Received: from eggs.gnu.org ([2001:4830:134:3::10]:40049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZGku-00032x-6x
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZGkr-0005d9-3C
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:49:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZGkq-0005cj-TQ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:49:21 -0500
References: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2fe03c3-3d5f-dc6a-4a18-b26cf7e35122@redhat.com>
Date: Wed, 10 Jan 2018 14:49:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpu: flush TB cache when loading VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru

On 10/01/2018 14:48, Pavel Dovgalyuk wrote:
> Flushing TB cache is required because TBs key in the cache may match
> different code which existed in the previous state.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> ---
>  exec.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/exec.c b/exec.c
> index 4722e52..ff31e71 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -622,6 +622,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
>         version_id is increased. */
>      cpu->interrupt_request &= ~0x01;
>      tlb_flush(cpu);
> +    tb_flush(cpu);
>  
>      return 0;
>  }
> 

Queued, thanks.

Paolo
