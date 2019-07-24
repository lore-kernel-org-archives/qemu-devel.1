Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233D3C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB728229FA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB728229FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqHGj-0005H4-3a
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 09:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39181)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqHGX-0004r9-JY
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqHGW-0006qK-KC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:25:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqHGW-0006ps-ES
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:25:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so32004557wrr.9
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 06:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wVl294tYdAGP3ub6BGUk5foedSGeHXEzwEkD42zt4FE=;
 b=ia5W7k9GP/UhfNXDQ8avihQ1ekBHA8IXbHejKIRZgluYMN2hJn3Xa3Lu/otI92qgxX
 XrKrhlt2FK1yPdesbW32MwfvS6UkC2VuCe+S1fUBni35DVlgp4kB4Cd39caSV1EUAgyV
 3hSZf7NI7Fi0qkKml4YWvHZOO1+gaMrm4LkWk/+osGKH5tVREb6ofuLVkR/YpznXOk8T
 ciyfQaIeiy16d9MRr8ER9TlVTIR/YoJjXR5xQGHuAhZPql2Iys8lBpCbyLN15WNbF26L
 DcZA1Qx+CSwRPmcDB8B3j4FmJz+NkiQebe97JemHuRmNc8ZnJoU4GUdOsbbXIfc2LiZM
 q+uQ==
X-Gm-Message-State: APjAAAVzfJE3Bh+CPuVhJaTXFh8QRAubHuVpMq/zVYaFM8AheVLRIyga
 3enAXPeIBdfqQ5pCVVsN1IWNPg==
X-Google-Smtp-Source: APXvYqwSHw3dLdUv89DpwC+/KaCRg6blJ0XCQmvMtXrzl2vdnuYB91T+AtqGW5YkuceODz/8uTHvLA==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr88717727wra.273.1563974707495; 
 Wed, 24 Jul 2019 06:25:07 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id f204sm67800421wme.18.2019.07.24.06.25.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 06:25:06 -0700 (PDT)
Date: Wed, 24 Jul 2019 15:25:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Montes, Julio" <julio.montes@intel.com>
Message-ID: <20190724132504.s5kjx3grjkppj4eg@steredhat>
References: <20190723140445.12748-1-sgarzare@redhat.com>
 <4d2967a1637b3ab93ff79fa016fd4a42f5638204.camel@intel.com>
 <20190724073657.ldisme6i4u55axga@steredhat>
 <e548f60000894db2404eaaa77657b1ed551a8099.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e548f60000894db2404eaaa77657b1ed551a8099.camel@intel.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 0/2] pc: mmap kernel (ELF image) and
 initrd
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "slp@redhat.com" <slp@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 01:03:42PM +0000, Montes, Julio wrote:
> Hi Stefano
> 
> On Wed, 2019-07-24 at 09:36 +0200, Stefano Garzarella wrote:
> > On Tue, Jul 23, 2019 at 05:37:18PM +0000, Montes, Julio wrote:
> > > Stefano, Brilliant job!
> > > 
> > > I can confirm that with these patches the memory footprint is
> > > smaller
> > > and the boot time is the same for kata
> > > 
> > > Here the results using kata metrics
> > > 
> > > https://pasteboard.co/Ipl06Q0.png
> > > https://pasteboard.co/Ipl3p4d.png
> > > 
> > 
> > Hi Julio,
> > thank you very much for testing :)
> > 
> > When you measure the PPS, how many QEMU instances did you start?
> > Did you use also the initrd?
> 
> 50 VMs with a nvdimm/pmem device as rootfs, I will test your v3 with
> initrd :)

Cool :)

Okay, I'm sending a v4 to fix some issues...

Thanks,
Stefano

