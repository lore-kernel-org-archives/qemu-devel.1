Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88ABC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E1E20772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYeFwZDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E1E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3ST-0007yA-So
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Q4-0003rt-FX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Q3-0008Vi-BJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:37:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34667)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Q3-0008VJ-6R
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e8uDbgNKyIKNUi69nWJu7sUWP1XRvfHYpg8P8J1EGhI=;
 b=PYeFwZDnPeHenTF/n95VzWa1E2rjggTX8jdrdHycv91DrM2ZgU/bjfmBao+5CzopjooABm
 qTPkGFKJwDuIlXQbZMGYyX4k/R32MtckRZGtN5ILw4VnLJ5woBYBXwXPI9f5VeR89BTeil
 4TjuIKDOjnDy5HIskmfDgeLsIHWi184=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-UhxFWelzMEK-1r_-u3ZoVQ-1; Wed, 25 Mar 2020 06:37:53 -0400
X-MC-Unique: UhxFWelzMEK-1r_-u3ZoVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5998107ACCA;
 Wed, 25 Mar 2020 10:37:51 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC3CC1001DD8;
 Wed, 25 Mar 2020 10:37:49 +0000 (UTC)
Message-ID: <e42bd6d632853cb5e6350cdf43bbdd9123044d7f.camel@redhat.com>
Subject: Re: [PATCH v6 06/42] nvme: add identify cns values in header
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:37:48 +0200
In-Reply-To: <20200316142928.153431-7-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-7-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f716f690a594..b38d7e548a60 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -709,11 +709,11 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>      NvmeIdentify *c = (NvmeIdentify *)cmd;
>  
>      switch (le32_to_cpu(c->cns)) {
> -    case 0x00:
> +    case NVME_ID_CNS_NS:
>          return nvme_identify_ns(n, c);
> -    case 0x01:
> +    case NVME_ID_CNS_CTRL:
>          return nvme_identify_ctrl(n, c);
> -    case 0x02:
> +    case NVME_ID_CNS_NS_ACTIVE_LIST:
>          return nvme_identify_nslist(n, c);
>      default:
>          trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));

This is a very good candidate to be squished with the patch 5 IMHO,
but you can leave this as is as well. I don't mind.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky






