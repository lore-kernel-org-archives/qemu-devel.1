Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB9BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 07:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50AA2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 07:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LF33uuEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50AA2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9l2B-0001Ou-St
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 02:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1j9l1Y-0000u7-KS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1j9l1X-0000Ul-G3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:34:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1j9l1X-0000Sr-8l
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:34:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id m3so4543597wmi.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 23:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+pDy9FnIci/486fRFg3zNv+7rl2N5+6KSvJjal3zpd0=;
 b=LF33uuEcHbXStInwCscULzeg/nQ8rvs8HWq6u4U7eNxy27xg/qXa5NNUiVNATRypW0
 TScVGqIUzghxr8unsZuhhmk+5+ErBmEJus362zVc04HKvSSHYoKTvyV3G03sV5R3Ajhf
 QcD8u9L8WYsIbrqFTkBTkxF4xAHafVXpWjqAtuZO6XB4WDkLRNnIMkR0L60sCbuC9JTs
 haMoGdUJ4dlpoC/L9n5442HCix0y4MLGncD5MkR4AqvVXOoIL7fJEjm7QCDRzX6MRBPK
 598NZFtjNz8drgSV8INTQ284tgatEWfeaz9uQP0Qg+jkxgrYr80EE1EbDouxfr3J8qlK
 KFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+pDy9FnIci/486fRFg3zNv+7rl2N5+6KSvJjal3zpd0=;
 b=Sfld8KZf2LwU4jwSLstREgXlPl/S7EUPmUj1/nBhwCpRgw5wud+qoqVd+W3A7Ur9QK
 3aGgS5IUnmgPiybY3OZijRXmsXi2hTcUJjnIPDCWfQzHNA5qlPOUyYxd55qJkpO7AnsO
 zBqQNS3sgbZCUqzi2I8TXA+O5GEHKI8q2y9rwWwq726pYyxYujDS1LisCZbR0gfn4RyF
 B7Fjl8CdLsHhCgw9ni2atL2jG+RItO/CMOnKSJrhzfJY+NkMXPfyeF6Q/EDDz7X04L5Z
 Z2gixxtJAYMscj90VKATMZjp8SEoFeD3Dh6Jgc5W38Il/aXIVg5tQqCZErIYiFl6D6Vd
 EBFQ==
X-Gm-Message-State: ANhLgQ1qqogrStBJWKIFoEXVbxFmAGyAaNKZAhJOYLRr5aqGgNDYMdsH
 RbZeaoGmgibZO0ab2XPsjz/Tqg==
X-Google-Smtp-Source: ADFU+vs4wjNmcUt2L9LnLXgPtyLz/hcTmGUhS0258t3DyqHizn00VzqebH3/oJeWsdVfrHWDcaVOKw==
X-Received: by 2002:a05:600c:217:: with SMTP id
 23mr8161293wmi.32.1583393665441; 
 Wed, 04 Mar 2020 23:34:25 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c9sm9720274wmc.3.2020.03.04.23.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 23:34:24 -0800 (PST)
Date: Thu, 5 Mar 2020 08:34:17 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v16 00/10] VIRTIO-IOMMU device
Message-ID: <20200305073417.GA717767@myrica>
References: <20200214132745.23392-1-eric.auger@redhat.com>
 <20200227111717.GG1645630@redhat.com>
 <431cb39d-833c-6d02-d7b3-02b3e90446e2@redhat.com>
 <CAMj5Bkib3CTzCB02ScueFR84r28LGowF7uxYO8Ygmnj9X7oNOg@mail.gmail.com>
 <fea625f1-b58e-6da6-8e2a-f32fc9391fc8@redhat.com>
 <CAMj5Bkgm1LKbN3E2qTTxmrGhpmdL9NWarSfX-mYCWF0yt5E9eg@mail.gmail.com>
 <88e3b669-2998-41c0-83f7-de42a72a73e7@redhat.com>
 <20200304164717.GF646000@myrica>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7BDFBB@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7BDFBB@SHSMSX104.ccr.corp.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "kenneth-lee-2012@foxmail.com" <kenneth-lee-2012@foxmail.com>,
 "tnowicki@marvell.com" <tnowicki@marvell.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 Auger Eric <eric.auger@redhat.com>,
 "bharatb.linux@gmail.com" <bharatb.linux@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>,
 Zhangfei Gao <zhangfei.gao@gmail.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 02:56:20AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Thursday, March 5, 2020 12:47 AM
> >
> [...]
> > > >
> > > > * We can't use DVM in nested mode unless the VMID is shared with the
> > > > CPU. For that we'll need the host SMMU driver to hook into the KVM
> > VMID
> > > > allocator, just like we do for the ASID allocator. I haven't yet
> > > > investigated how to do that. It's possible to do vSVA without DVM
> > > > though, by sending all TLB invalidations through the SMMU command
> > queue.
> > > > "
> > 
> > Hm we're already mandating DVM for host SVA, so I'd say mandate it for
> > vSVA as well. We'd avoid a ton of context switches, especially for the zip
> > accelerator which doesn't require ATC invalidations. The host needs to pin
> > the VMID allocated by KVM and write it in the endpoint's STE.
> > 
> 
> Curious... what is DVM and how is it related to SVA? Is it SMMU specific?

Yes it stands for "Distributed Virtual Memory", an Arm interconnect
protocol. When sharing a process address space, TLB invalidations from the
CPU are broadcasted to the SMMU, so we don't have to send commands through
the SMMU queue to invalidate IOTLBs. However ATCs from PCIe endpoints do
not participate in DVM and still have to be invalidated by hand.

Thanks,
Jean

