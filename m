Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D7EC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B007E206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhG4tgj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B007E206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3f8-0001es-Rx
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Wn-0007MP-Rc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Wm-0004G6-6p
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:44:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46520)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Wm-0004Ft-2C
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPeQSRU2H6G+mfBFLUx9rEAwDn3Huu1zVdXiFiKQHq4=;
 b=AhG4tgj5MWRiWpvSKVgx7+3xUpsQOR+bD1KfUmC0HKlPcVhvl9M+VbpTAWnFH11o2coqQ1
 b0Brl3xpXLWYmApn9jccb/ddxlV+J6XIJH+WZtrHeAJI538tRmbQv0Zz9aPNCOAN11vkNg
 tBK6z9pzC+WTtw7liCnU/VLPPRreFZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-dXaJ4NT9Mamxa9zSQCHvCw-1; Wed, 25 Mar 2020 06:44:50 -0400
X-MC-Unique: dXaJ4NT9Mamxa9zSQCHvCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92E17DBB7;
 Wed, 25 Mar 2020 10:44:48 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7761F5C3F8;
 Wed, 25 Mar 2020 10:44:46 +0000 (UTC)
Message-ID: <88dd3d32f0b1947292e4dc6b4681cc40287c378f.camel@redhat.com>
Subject: Re: [PATCH v6 21/42] nvme: bump supported version to v1.3
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:44:45 +0200
In-Reply-To: <20200316142928.153431-22-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-22-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 74061d08fd2e..26c4b6e69f72 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -44,6 +44,7 @@
>  #include "trace.h"
>  #include "nvme.h"
>  
> +#define NVME_SPEC_VER 0x00010300
>  #define NVME_CMB_BIR 2
>  #define NVME_TEMPERATURE 0x143
>  #define NVME_TEMPERATURE_WARNING 0x157
> @@ -1898,6 +1899,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>      id->ieee[0] = 0x00;
>      id->ieee[1] = 0x02;
>      id->ieee[2] = 0xb3;
> +    id->ver = cpu_to_le32(NVME_SPEC_VER);
>      id->oacs = cpu_to_le16(0);
>  
>      /*
> @@ -1942,7 +1944,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>      NVME_CAP_SET_CSS(n->bar.cap, 1);
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
>  
> -    n->bar.vs = 0x00010200;
> +    n->bar.vs = NVME_SPEC_VER;
>      n->bar.intmc = n->bar.intms = 0;
>  }
>  
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




