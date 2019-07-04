Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EC1C0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 05:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEBF21882
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 05:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEBF21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiuV8-0000XW-44
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 01:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hiuT2-0007lz-JK
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hiuT0-0005Ad-FK
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hiuSy-00057v-H8
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7F9E308FC4E;
 Thu,  4 Jul 2019 05:39:27 +0000 (UTC)
Received: from [10.72.12.202] (ovpn-12-202.pek2.redhat.com [10.72.12.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A454B86BA5;
 Thu,  4 Jul 2019 05:39:18 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190624091811.30412-1-peterx@redhat.com>
 <20190624091811.30412-2-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6b1efecf-64eb-3306-d2a8-86f731b07d08@redhat.com>
Date: Thu, 4 Jul 2019 13:39:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190624091811.30412-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 04 Jul 2019 05:39:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] intel_iommu: Fix incorrect "end"
 for vtd_address_space_unmap
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Auger Eric <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/6/24 =E4=B8=8B=E5=8D=885:18, Peter Xu wrote:
> From: Yan Zhao <yan.y.zhao@intel.com>
>
> IOMMUNotifier is with inclusive ranges, so we should check
> against (VTD_ADDRESS_SIZE(s->aw_bits) - 1).
>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> [peterx: split from another bigger patch]
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 44b1231157..719ce19ab3 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3379,12 +3379,12 @@ static void vtd_address_space_unmap(VTDAddressS=
pace *as, IOMMUNotifier *n)
>        * VT-d spec), otherwise we need to consider overflow of 64 bits.
>        */
>  =20
> -    if (end > VTD_ADDRESS_SIZE(s->aw_bits)) {
> +    if (end > VTD_ADDRESS_SIZE(s->aw_bits) - 1) {
>           /*
>            * Don't need to unmap regions that is bigger than the whole
>            * VT-d supported address space size
>            */
> -        end =3D VTD_ADDRESS_SIZE(s->aw_bits);
> +        end =3D VTD_ADDRESS_SIZE(s->aw_bits) - 1;
>       }
>  =20
>       assert(start <=3D end);


Acked-by: Jason Wang <jasowang@redhat.com>



