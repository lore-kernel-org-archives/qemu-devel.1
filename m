Received: from eggs.gnu.org ([2001:4830:134:3::10]:44556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csTfr-0002JU-0e
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csTfm-0000fa-Vh
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:23:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csTfm-0000fU-Pw
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:22:58 -0400
References: <20170325111424.21752-1-herongguang.he@huawei.com>
	<58D8BD6D.8080404@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c9e0c46-ac81-a455-e2ed-530ad916ff71@redhat.com>
Date: Mon, 27 Mar 2017 14:22:53 +0200
MIME-Version: 1.0
In-Reply-To: <58D8BD6D.8080404@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] KVM: pci-assign: do not map smm memory
 slot pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Herongguang (Stephen)" <herongguang.he@huawei.com>, rkrcmar@redhat.com, kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, wangxinxin.wang@huawei.com



On 27/03/2017 09:21, Herongguang (Stephen) wrote:
> From f6f0ee6831488bef7af841cb86f3d85a04848fe5 Mon Sep 17 00:00:00 2001
> From: herongguang <herongguang.he@huawei.com>
> Date: Mon, 27 Mar 2017 15:08:59 +0800
> Subject: [PATCH] KVM: pci-assign: do not map smm memory slot pages
>  in vt-d page table
> 
> or VM memory are not put thus leaked in kvm_iommu_unmap_memslots() when
> destroy VM.
> 
> This is consistent with current vfio implementation.

Oops, you forgot a Signed-off-by.

Paolo

> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 482612b..9018d06 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1052,7 +1052,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>       * changes) is disallowed above, so any other attribute changes
> getting
>       * here can be skipped.
>       */
> -    if ((change == KVM_MR_CREATE) || (change == KVM_MR_MOVE)) {
> +    if ((as_id == 0) && ((change == KVM_MR_CREATE) || (change ==
> KVM_MR_MOVE))) {
>          r = kvm_iommu_map_pages(kvm, &new);
>          return r;
>      }
