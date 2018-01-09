Received: from eggs.gnu.org ([2001:4830:134:3::10]:45288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYy7U-0002xq-Ku
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYy7Q-0004dG-1f
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:55:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eYy7P-0004ca-RF
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:55:23 -0500
References: <20171225024704.19540-1-linzhecheng@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24d9419b-8e8d-5bf6-3f13-08a901999010@redhat.com>
Date: Tue, 9 Jan 2018 18:55:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171225024704.19540-1-linzhecheng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] irq: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, peterx@redhat.com, mst@redhat.com

On 25/12/2017 03:47, linzhecheng wrote:
> entry is moved from list but is not freed.
> 
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 351b64f77c..3c920db79a 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -3494,6 +3494,7 @@ int kvm_arch_release_virq_post(int virq)
>          if (entry->virq == virq) {
>              trace_kvm_x86_remove_msi_route(virq);
>              QLIST_REMOVE(entry, list);
> +            g_free(entry);
>              break;
>          }
>      }
> 

Queued, thanks.

Paolo
