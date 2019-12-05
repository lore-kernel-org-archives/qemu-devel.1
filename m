Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B31C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBA7224F8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKc4acAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBA7224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icml4-0002mN-12
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 03:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1icmis-0001XI-Ai
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1icmir-0006TH-3t
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:42:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26588
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1icmiq-0006Qu-UF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575535372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgdqmmKVdMbSsk9weGSCSEzICTE6qo/wwWVP4u9Ohaw=;
 b=cKc4acAgkbsEV4d0otivhxjtMqro7oJcoSskCC7kmfjgkTxoT8pNsbZ6lFWu3R+T/ZHyQQ
 C2o3BOyfPjvaUhsKp3rU59XjbIyIBE5qc6uYuOZbDbkbsdPZA4nEMNLOC0WM7DBOysb19n
 Gu77PtWmFdSP0oAH6MHV9p0NeqbhofU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-sWwO2_LGMDWnLSVuuO7Q0A-1; Thu, 05 Dec 2019 03:42:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31C4C800C7D;
 Thu,  5 Dec 2019 08:42:48 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 407275D6A5;
 Thu,  5 Dec 2019 08:42:46 +0000 (UTC)
Subject: Re: [PATCH 1/5] hw/arm/smmuv3: Apply address mask to linear strtab
 base address
To: Simon Veith <sveith@amazon.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1575467748-28898-1-git-send-email-sveith@amazon.de>
 <1575467748-28898-2-git-send-email-sveith@amazon.de>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0f01a30e-5b27-f97c-903a-a8a2a74a1cdd@redhat.com>
Date: Thu, 5 Dec 2019 09:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1575467748-28898-2-git-send-email-sveith@amazon.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sWwO2_LGMDWnLSVuuO7Q0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Simon,

On 12/4/19 2:55 PM, Simon Veith wrote:
> In the SMMU_STRTAB_BASE register, the stream table base address only
> occupies bits [51:6]. Other bits, such as RA (bit [62]), must be masked
> out to obtain the base address.
> 
> The branch for 2-level stream tables correctly applies this mask by way
> of SMMU_BASE_ADDR_MASK, but the one for linear stream tables does not.
> 
> Apply the missing mask in that case as well so that the correct stream
> base address is used by guests which configure a linear stream table.
> 
> Linux guests are unaffected by this change because they choose a 2-level
> stream table layout for the QEMU SMMUv3, based on the size of its stream
> ID space.
> 
> ref. ARM IHI 0070C, section 6.3.23.
> 
> Signed-off-by: Simon Veith <sveith@amazon.de>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---
>  hw/arm/smmuv3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e2fbb83..eef9a18 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -429,7 +429,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>          }
>          addr = l2ptr + l2_ste_offset * sizeof(*ste);
>      } else {
> -        addr = s->strtab_base + sid * sizeof(*ste);
> +        addr = (s->strtab_base & SMMU_BASE_ADDR_MASK) + sid * sizeof(*ste);
Not related to this patch but I noticed SMMU_BASE_ADDR_MASK should be
0xffffffffffc0 and not 0xffffffffffe0. I can fix it separately or if you
respin, you may fix it as well?
>      }
>  
>      if (smmu_get_ste(s, addr, ste, event)) {
> 
Besides
Acked-by: Eric Auger <eric.auger@redhat.com>


Thanks

Eric


