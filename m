Received: from eggs.gnu.org ([2001:4830:134:3::10]:49630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cayYV-0007gG-1r
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 00:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cayYR-0006v7-Tn
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 00:43:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cayYR-0006ux-OR
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 00:43:03 -0500
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-10-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9b7fb7a7-611b-abfe-4b9c-e803782379cd@redhat.com>
Date: Tue, 7 Feb 2017 13:42:55 +0800
MIME-Version: 1.0
In-Reply-To: <1486110164-13797-10-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 09/18] intel_iommu: vtd_slpt_level_shift
 check level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B402=E6=9C=8803=E6=97=A5 16:22, Peter Xu wrote:
> This helps in debugging incorrect level passed in.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c672621..d74aa27 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -168,6 +168,7 @@ static gboolean vtd_hash_remove_by_domain(gpointer =
key, gpointer value,
>   /* The shift of an addr for a certain level of paging structure */
>   static inline uint32_t vtd_slpt_level_shift(uint32_t level)
>   {
> +    assert(level !=3D 0);
>       return VTD_PAGE_SHIFT_4K + (level - 1) * VTD_SL_LEVEL_BITS;
>   }
>  =20

No harm but not sure we really need this.

Reviewed-by: Jason Wang <jasowang@redhat.com>
