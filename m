Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01233C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90582082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90582082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd2wI-0004G2-7M
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hd2td-0002mM-WD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hd2ta-0001SY-N1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:26:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hd2tY-0001Er-KY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:26:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id l128so7528328qke.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 18:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AHXtKDFFOfrWy+/0QdH+yW+H88/c/r0mZVx+SFFI2p0=;
 b=UZXAgDoG9V9DGrxogfwd5Stbbsl8YQBDvIMNu6aVPpKNDZ+3mOJL8U+UQluxnID2ql
 RtffKQxhXUUqy88o1on0y+pxUhJxAPkpuFVhckiHW/NjRNpT9D6hcTuo8YZRI94/saqK
 CRO2x66oWOU+lldeAHM1Te2CuZn0wovzLp6TYk5OXetPFO9DRTaWHNJPo1kh+EosviYQ
 fapjhtNJemGDDTJFHokQAK4NPxZxSSthmaE5H7jkCK4lDBMPf2S00Q9N4N7u8obuLxBM
 msqqTtRwm2eTahBD+p6mSBW+3Mus0TvGaceP4So2lry5Yk2d5HMNzuvufEs5zl+3TB6v
 We/A==
X-Gm-Message-State: APjAAAUDFWE58JG/vkkO+6B7Fnp8x8mMin5FLZT1AvosaFeE4DOdNN/S
 tM2GAZ8q1mvUGHMv7nM4LF5pqg==
X-Google-Smtp-Source: APXvYqzzSaqcJzy+4LleyXRFsgb62EQLPe9mcfk6WVhvp7E7bPNilukU5xReDJu3VphH3z4+PdtlUA==
X-Received: by 2002:a37:be85:: with SMTP id
 o127mr80947201qkf.194.1560821195013; 
 Mon, 17 Jun 2019 18:26:35 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id n18sm3316258qtr.28.2019.06.17.18.26.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 18:26:33 -0700 (PDT)
Date: Mon, 17 Jun 2019 21:26:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Message-ID: <20190617212626-mutt-send-email-mst@kernel.org>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
 <20190416013902.4941-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416013902.4941-4-andrew.smirnov@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.193
Subject: Re: [Qemu-devel] [PATCH 3/5] pci: designware: Update MSI mapping
 unconditionally
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 15, 2019 at 06:39:00PM -0700, Andrey Smirnov wrote:
> Expression to calculate update_msi_mapping in code handling writes to
> DESIGNWARE_PCIE_MSI_INTR0_ENABLE is missing an ! operator and should
> be:
> 
>     !!root->msi.intr[0].enable ^ !!val;
> 
> so that MSI mapping is updated when enabled transitions from either
> "none" -> "any" or "any" -> "none". Since that register shouldn't be
> written to very often, change the code to update MSI mapping
> unconditionally instead of trying to fix the update_msi_mapping logic.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/pci-host/designware.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 29ea313798..6affe823c0 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -296,16 +296,10 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>          root->msi.base |= (uint64_t)val << 32;
>          break;
>  
> -    case DESIGNWARE_PCIE_MSI_INTR0_ENABLE: {
> -        const bool update_msi_mapping = !root->msi.intr[0].enable ^ !!val;
> -
> +    case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
>          root->msi.intr[0].enable = val;
> -
> -        if (update_msi_mapping) {
> -            designware_pcie_root_update_msi_mapping(root);
> -        }
> +        designware_pcie_root_update_msi_mapping(root);
>          break;
> -    }
>  
>      case DESIGNWARE_PCIE_MSI_INTR0_MASK:
>          root->msi.intr[0].mask = val;
> -- 
> 2.20.1

