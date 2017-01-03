Received: from eggs.gnu.org ([2001:4830:134:3::10]:35469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOFzV-000491-QT
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 22:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOFzS-0000ck-QF
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 22:42:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOFzS-0000bu-Kl
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 22:42:22 -0500
Date: Tue, 3 Jan 2017 11:42:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170103034217.GF22664@pxdev.xzpeter.org>
References: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
	<1483092559-24488-10-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483092559-24488-10-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V4 09/10] memory: handle alias in
 memory_region_is_iommu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com

On Fri, Dec 30, 2016 at 06:09:18PM +0800, Jason Wang wrote:
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  include/exec/memory.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 358edfb..bec9756 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -628,6 +628,9 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
>   */
>  static inline bool memory_region_is_iommu(MemoryRegion *mr)
>  {
> +    if (mr->alias) {
> +        return memory_region_is_iommu(mr->alias);
> +    }
>      return mr->iommu_ops;
>  }
>  
> -- 
> 2.7.4
> 

-- peterx
