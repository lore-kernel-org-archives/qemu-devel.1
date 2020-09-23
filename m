Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD58EC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B50121D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhkMmmtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B50121D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6Ip-0007NE-5q
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kL6Hu-0006rs-OQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kL6Hs-0000yr-VD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600873347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eYRJUqSok4H32+MQzl6WbCMiPhJ9DxNeuBPTaaSzz2Q=;
 b=bhkMmmtHMU/VyMKS8rcNNSPSvEahElYDwstdyetQJ7Ry8XUT0AORGLFZKsZ1gPEOpi8O/K
 OhmZ+3s8vS9LDKOiljvoKgXTftPKjgJm4Pis1qSIicogIv0OrthM2EZmy4jHIh+AEMK2lo
 ldCZMcZCvs6YZi0SeYcVsYscD4Vpgbs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-zpAzpUcTNSK5a4aKHmuajg-1; Wed, 23 Sep 2020 11:02:20 -0400
X-MC-Unique: zpAzpUcTNSK5a4aKHmuajg-1
Received: by mail-wr1-f69.google.com with SMTP id g6so8956783wrv.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 08:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eYRJUqSok4H32+MQzl6WbCMiPhJ9DxNeuBPTaaSzz2Q=;
 b=CcsNmn3B2aEXE8GToo2uuIQG6oThgHUBV7Hx9ukyVjoPQceIETzsyOb3wRQYhWVQAH
 uc91dYJeZmxOvwCuldkIHgr1j08dlt3ZuOf6FPQhWw0HtpCM1d7gRWE8v4E+qZTnzIRB
 PLOuUhHVMSWrVEiZIHIX1ZuNjWIwAiJwnTVnz84aeNE2f6s7/HWzebGG0WpVl/k02ue6
 n6xO9Zl2009M6vnaJ1l5fNFSfza03cisXVJPr23lLspkxTK1IKLKUXkRcB4BsIIcFCKL
 5MR8feaSV/00oEFXK26/V52n0DVmO5eQSlQOEaXf7u36CId2GxCaBQoxlTCNc2uDAxTX
 01Cg==
X-Gm-Message-State: AOAM532c7CgwlRrupigGIVUnWfcnPgYIWxadQT04xYjlILILEhzeSF14
 2tcphiKse24PmDaMD+2P6w0E8plBTw3tLG0+ticJkz/Yh2pQU5pVdhB4Dgyd6YQt4n3m4SyVHqg
 r9LJeCa+CKecgB6M=
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr6849086wmj.3.1600873339698;
 Wed, 23 Sep 2020 08:02:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZG8styV7fc8wBwLaum2g3t/1CO+kiIcaOCD1ryK7E9vtm4SBuiL83EwzbhiPQnQwmRimmOw==
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr6849049wmj.3.1600873339403;
 Wed, 23 Sep 2020 08:02:19 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id a81sm64629wmf.32.2020.09.23.08.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 08:02:18 -0700 (PDT)
Date: Wed, 23 Sep 2020 11:02:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] hw/pci/pci: Fix slot check for plugged devices
Message-ID: <20200923110141-mutt-send-email-mst@kernel.org>
References: <20200923092636.118676-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200923092636.118676-1-jusual@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 11:26:36AM +0200, Julia Suvorova wrote:
> If devfn is assigned automatically, 'else' clauses will never be
> executed. And if it does not matter for the reserved and available
> devfn, because we have already checked it, the check for function0
> needs to be done again.
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>

This is just cosmetics right? I wouldn't describe this as
a "fix" then - "simplify" would be clearer.

> ---
>  hw/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index de0fae10ab..ae132b0b52 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1034,8 +1034,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     PCI_SLOT(devfn), PCI_FUNC(devfn), name,
>                     bus->devices[devfn]->name);
>          return NULL;
> -    } else if (dev->hotplugged &&
> -               pci_get_function_0(pci_dev)) {
> +    };
> +
> +    if (dev->hotplugged && pci_get_function_0(pci_dev)) {
>          error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
>                     " new func %s cannot be exposed to guest.",
>                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> -- 
> 2.25.4


