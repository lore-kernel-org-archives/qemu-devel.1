Received: from eggs.gnu.org ([2001:4830:134:3::10]:59167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTLOq-0008Tk-QF
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTLOm-0002iC-4F
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:34:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eTLOl-0002h5-VK
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 00:34:04 -0500
Date: Mon, 25 Dec 2017 13:33:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171225053355.GH2443@xz-mi>
References: <20171225024704.19540-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171225024704.19540-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] irq: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, arei.gonglei@huawei.com, mst@redhat.com

On Mon, Dec 25, 2017 at 10:47:04AM +0800, linzhecheng wrote:
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
> -- 
> 2.12.2.windows.2
> 
> 
> 

My INBOX didn't really catch this email, don't know why.  Anyway,
thanks for fixing that.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
