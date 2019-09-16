Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F15C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA70520650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA70520650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ltP-0004PI-29
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 03:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9lry-0003Ob-S3
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9lrx-0004Ty-Uf
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:56:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9lrx-0004Tf-Oh
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:56:21 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1117E369C4
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:56:21 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id f2so26626458pfk.13
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 00:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8bG60DqdwV5Z9mJOdj6YMzMYw8IxPiOQzy6Z89mG764=;
 b=Y0IEyp5kLwOaERf2sm5H1WrCGws7IsXL8Pykij5gw6YT3Lq69rtYDLGvhUVI74D6eB
 nmVHMfFFhHHQSrHfHAPwMOS6R7xBtn10ola+25FwdKUiFiW9fHVwMf3tWucqECnj8zNH
 p2eCsywuml14DVFXt5+lheVcBPQVB8Y+AdxUCHK98sDvBuFfiRd74E/Gf9OzCXfRiVMJ
 ZCaX0TUPKACBEN+IDzsTfiFTwPG/ExSn913KYq/3Jk2lTf1B1lc9udTk7iENO3DYUuoY
 5pFJ30+6WSKsjq1Btbn10CXr1W38vPGKW4yPfSRk+XBVjtTEhQF83Q+IbNBiIYnnAdWF
 Vj2g==
X-Gm-Message-State: APjAAAX69QaTG7ZIUaHOr2eZfFIdGlit6FGAMjrLTzKTm5Six3fBlU6h
 HZN1tIBsCJH5/DAgOUoBPYVLAQf/tVSpQ2NLCEhnHPfVZLjLNaI3+Z1t0ZqTpPbOBa90zciYLtU
 nPBL68WrqERTEl5A=
X-Received: by 2002:a17:902:a50a:: with SMTP id
 s10mr53846328plq.336.1568620580605; 
 Mon, 16 Sep 2019 00:56:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyPuZ6TmAuiAtsl6+KZnnjuruQ9VDTwzXqRvHx+m4w3dJQnugtyvy8EMXWZvCrdtq/+8G15Vw==
X-Received: by 2002:a17:902:a50a:: with SMTP id
 s10mr53846304plq.336.1568620580298; 
 Mon, 16 Sep 2019 00:56:20 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 127sm62675024pfy.56.2019.09.16.00.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 00:56:19 -0700 (PDT)
Date: Mon, 16 Sep 2019 15:56:09 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190916075609.GA30562@xz-x1>
References: <20190812074531.28970-1-peterx@redhat.com>
 <20190812074531.28970-2-peterx@redhat.com>
 <57ddb99c-3c38-db87-0763-c4a0d8039e45@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57ddb99c-3c38-db87-0763-c4a0d8039e45@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 1/4] intel_iommu: Sanity check vfio-pci
 config on machine init done
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bandan Das <bsd@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 16, 2019 at 09:11:50AM +0200, Auger Eric wrote:
> >  static void vtd_realize(DeviceState *dev, Error **errp)
> >  {
> >      MachineState *ms = MACHINE(qdev_get_machine());
> > @@ -3741,6 +3772,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
> >      pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
> >      /* Pseudo address space under root PCI bus. */
> >      pcms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
> > +    qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
> This does not compile anymore on master. I think sysemu/sysemu.h needs
> to be included as declaration of qemu_add_machine_init_done_notifier is
> not found.

Indeed.  It's probably because we've changed some header inclusions
recently between each other.  I'll repost a new version with it added.

> 
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for the reviews!

-- 
Peter Xu

