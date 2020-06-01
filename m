Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF67206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzPS1RFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF67206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfdaz-0008WH-Ek
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 02:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfda8-00085m-9T
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 02:05:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20289
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfda6-0006Qg-8r
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 02:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590991553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QOtnOyKDkWTpkmYDxUxqiKJH1GjZUvMX0AKTPueGfng=;
 b=bzPS1RFlr4hc1qJT/tv6rjfppMHSPNeHLHhguYQ8uUn/gedgfDLloneAxsJrWsRqsvzfy/
 AqtK+JQAlQESd5r7GhjZtty7iZuh59pf3aMu9glygl5namGRubu7fsWo0icPpQ3+r7huzj
 qMUiAJqBeHLpYEKBQBslQT6DNiiWOVc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-zxVeyG1OMIKxSy9edwl4Dw-1; Mon, 01 Jun 2020 02:05:51 -0400
X-MC-Unique: zxVeyG1OMIKxSy9edwl4Dw-1
Received: by mail-wr1-f70.google.com with SMTP id n6so4462712wrv.6
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 23:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QOtnOyKDkWTpkmYDxUxqiKJH1GjZUvMX0AKTPueGfng=;
 b=dJMLPxWjzqNd+Ns/8mE4OBFjbzpmBbZuMInnL0VqmIpztJXsOcBtHS/vh8WzMK5jEg
 PDDBb+UG7P9FTsORSuvdYHAP36j/fWoxRkP8NoaiGG5t1rjm4/wREo7a1JUn/BxQI4b8
 xxyw2qW0VBLnVhkd5hZwiZDf6XeRHnNyPtuvba+//e66FV3vJ+DUu+YqPeMn2tPWdoew
 VFylgvlXkYF/Ozr40N57LzxaJ4mLA60AeY1KSmMjlyZODLHbaXNgEbmGRT8ssOKgmQ/V
 fICZFgMSN1NfaNcFemW4mPpleM0VNg4FGfLl6hvpB2We6CIh8f0o2ZF6w/ME8dTdvVA4
 PwNw==
X-Gm-Message-State: AOAM533I3D4rZnLE/EEB7nuZw2wW/ZRZxZDWK6heSBRPOPcQbcngSfRi
 eWV5bHn/Qpl/fwBOIE0EBw3YiKUfGj1GS3LowOFeDmfdLt00D3k3Rzys+BHcs4OOW+c6Nyv+UDg
 ACtKuLFNRMv1b5cE=
X-Received: by 2002:a05:6000:90:: with SMTP id
 m16mr20985369wrx.191.1590991550354; 
 Sun, 31 May 2020 23:05:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLoIqZ412l+seGnmlNJ4rDWZEnZKcO50T3aktt2VQxa+mDPXRWRZ+c+FKwW3kwYozcTJkK1w==
X-Received: by 2002:a05:6000:90:: with SMTP id
 m16mr20985359wrx.191.1590991550189; 
 Sun, 31 May 2020 23:05:50 -0700 (PDT)
Received: from redhat.com ([212.92.123.95])
 by smtp.gmail.com with ESMTPSA id z206sm11419482wmg.30.2020.05.31.23.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 23:05:49 -0700 (PDT)
Date: Mon, 1 Jun 2020 02:05:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] msix: add valid.accepts methods to check address
Message-ID: <20200601020410-mutt-send-email-mst@kernel.org>
References: <20200601051454.826415-1-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200601051454.826415-1-ppandit@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 02:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, Ren Ding <rding@gatech.edu>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 01, 2020 at 10:44:54AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While doing msi-x mmio operations, a guest may send an address
> that leads to an OOB access issue. Add valid.accepts methods to
> ensure that ensuing mmio r/w operation don't go beyond regions.
> 
> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

IMHO this is just messed up, memory core needs to guarantee this.
I'm working on a patch to do that.


> ---
>  hw/pci/msix.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 29187898f2..d90d66a3b8 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -193,6 +193,15 @@ static void msix_table_mmio_write(void *opaque, hwaddr addr,
>      msix_handle_mask_update(dev, vector, was_masked);
>  }
>  
> +static bool msix_table_accepts(void *opaque, hwaddr addr, unsigned size,
> +                                    bool is_write, MemTxAttrs attrs)
> +{
> +    PCIDevice *dev = opaque;
> +    uint16_t tbl_size = dev->msix_entries_nr * PCI_MSIX_ENTRY_SIZE;
> +
> +    return dev->msix_table + addr + 4 <= dev->msix_table + tbl_size;
> +}
> +
>  static const MemoryRegionOps msix_table_mmio_ops = {
>      .read = msix_table_mmio_read,
>      .write = msix_table_mmio_write,
> @@ -200,6 +209,7 @@ static const MemoryRegionOps msix_table_mmio_ops = {
>      .valid = {
>          .min_access_size = 4,
>          .max_access_size = 4,
> +        .accepts = msix_table_accepts
>      },
>  };
>  
> @@ -221,6 +231,15 @@ static void msix_pba_mmio_write(void *opaque, hwaddr addr,
>  {
>  }
>  
> +static bool msix_pba_accepts(void *opaque, hwaddr addr, unsigned size,
> +                                    bool is_write, MemTxAttrs attrs)
> +{
> +    PCIDevice *dev = opaque;
> +    uint16_t pba_size = QEMU_ALIGN_UP(dev->msix_entries_nr, 64) / 8;
> +
> +    return dev->msix_pba + addr + 4 <= dev->msix_pba + pba_size;
> +}
> +
>  static const MemoryRegionOps msix_pba_mmio_ops = {
>      .read = msix_pba_mmio_read,
>      .write = msix_pba_mmio_write,
> @@ -228,6 +247,7 @@ static const MemoryRegionOps msix_pba_mmio_ops = {
>      .valid = {
>          .min_access_size = 4,
>          .max_access_size = 4,
> +        .accepts = msix_pba_accepts
>      },
>  };
>  
> -- 
> 2.26.2


