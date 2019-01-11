Received: from eggs.gnu.org ([209.51.188.92]:33723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gho3q-0004ld-QH
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 23:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gho3o-0005Nv-V5
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 23:04:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gho3n-0005MZ-2r
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 23:04:43 -0500
References: <20190108114720.21760-1-peterx@redhat.com>
	<20190108114720.21760-3-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3688ca81-c7f9-9cb9-c357-76976b4ae9cf@redhat.com>
Date: Fri, 11 Jan 2019 12:04:16 +0800
MIME-Version: 1.0
In-Reply-To: <20190108114720.21760-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] intel_iommu: reset intr_enabled when
 system reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>


On 2019/1/8 =E4=B8=8B=E5=8D=887:47, Peter Xu wrote:
> This is found when I was debugging another problem.  Until now no bug
> is reported with this but we'd better reset the IR status correctly
> after a system reset.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6d5cc1d039..ee22e754f0 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3138,6 +3138,7 @@ static void vtd_init(IntelIOMMUState *s)
>       s->root =3D 0;
>       s->root_extended =3D false;
>       s->dmar_enabled =3D false;
> +    s->intr_enabled =3D false;
>       s->iq_head =3D 0;
>       s->iq_tail =3D 0;
>       s->iq =3D 0;


Acked-by: Jason Wang <jasowang@redhat.com>
