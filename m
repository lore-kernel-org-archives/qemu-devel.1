Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F83C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69772053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYv/C8ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69772053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVoW-0005Yo-RU
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ipVn8-0004sf-Je
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ipVn7-0000UV-6p
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:15:54 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ipVn6-0000P9-QA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:15:53 -0500
Received: by mail-wm1-x344.google.com with SMTP id a5so2480966wmb.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pLeVCokKW+fOVWTgJDpb3D6qGp4EKoRi3k3tmToSbwc=;
 b=pYv/C8ikX34mJ+fA20ULSoqiTmuTQ4UaooXny4FGJQWvuY+zQPelkOalCkKH0Cu1rP
 uuYiomAPIe5z+RIhbeeSvhkzTiL1MIcGcD9ik2gtsV8R/Ou0WNEsatNhwhHGYA8Z1a3z
 fKkVnw9CTQlRFTOoSGpaMX4L4L3tozYVMG8AAFrz6tvNNCliqWMDBgy2lekxO8xNY5/A
 jp5CU8jsXIqXF/LpJt4bNkkCuOtOAJ6pW2WM31Vpr9lwa/0aPqynWGCvL3pPORGpwQxX
 4eUWBduxX5nKQKVmPAVZQluMDHHgVAg1trMH08X/gg38DWEh3d4LFSu2gnsamsC502i0
 JwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pLeVCokKW+fOVWTgJDpb3D6qGp4EKoRi3k3tmToSbwc=;
 b=UnWUAcYqX2NHjYsYpC0mj6xYbE4cdAXTZSkVpEcf/3a2uZ0HP8jqvhn41skGO9V91p
 b/sdFao3gYM3xsRc7IqMn9LN1sAfQ3iU6fRly3+7Dz6bqBBQ2PmborndxHIFxHZntbuv
 6qjrozB5Z1JLmnqbxxDggrgPVzSQjLn6WyKyhqlbpLkpYE9W2bn+N/uj4iMfiIl4yiA2
 Rr5yAWFtwEPkunTogM0wSh8Nj0I3qPEOrQlKJNO+/MfNKO0ICUYsX8MqSZ8NX54hHTDJ
 YUc9eDtxOGySBn7wrqK/qMp0I8u/yk3fD42SGVtGBaDNCMh1GDhujkujQxPRzXCYvTYS
 Hr0w==
X-Gm-Message-State: APjAAAUupkm8zXjoDXchwT/Xv/H6U3HNC33QOEYr1iaC7EKEguOO5uCN
 uB5vtOWoZBIWpIH4WhY1QVe1zQ==
X-Google-Smtp-Source: APXvYqzyzJMtOTnQSYBiWajR1phOzqARaEyzsFzZk7eB4ZUutLu44F8U/9NSsNcqLggMkgw839h6bA==
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr4110182wma.84.1578568551518; 
 Thu, 09 Jan 2020 03:15:51 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id v83sm2561889wmg.16.2020.01.09.03.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:15:50 -0800 (PST)
Date: Thu, 9 Jan 2020 12:15:44 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20200109111544.GA940335@myrica>
References: <20191220162642.GA2626852@myrica> <20191220165100.GA3780@xz-x1>
 <20200106170634.GF2062@myrica> <20200106175850.GC219677@xz-x1>
 <20200107101024.GB832497@myrica>
 <aa5fa9e6-6efd-e1a3-96c6-d02ba8eab4c8@redhat.com>
 <20200109084700.GA934975@myrica>
 <0beb9d61-05b8-3152-e967-64413def6ab7@redhat.com>
 <20200109104032.GA937123@myrica>
 <bcb585ef-f617-e870-72a2-f4028682547b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb585ef-f617-e870-72a2-f4028682547b@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 12:01:26PM +0100, Auger Eric wrote:
> Hi,
> 
> On 1/9/20 11:40 AM, Jean-Philippe Brucker wrote:
> > On Thu, Jan 09, 2020 at 09:58:49AM +0100, Auger Eric wrote:
> >>>> I share Peter's concern about having a different default policy than x86.
> >>>
> >>> Yes I'd say just align with whatever policy is already in place. Do you
> >>> think we could add a command-line option to let people disable
> >>> default-bypass, though?  That would be a convenient way to make the IOMMU
> >>> protection airtight for those who need it.
> >> Yes I could easily add a device option to disable the default bypass.
> >>
> >> Shall we change the meaning of the F_BYPASS feature then? If exposed by
> >> the device, the device does bypass by default, otherwise it doesn't.
> >> This would be controlled by the device option.
> > 
> > For a device that doesn't do bypass by default, the driver wouldn't have
> > the ability to enable bypass (feature bit not offered, not negotiable).
> > 
> >> The driver then could have means to overwrite this behavior once loaded?
> > 
> > Let's keep the bypass feature bit for this. If the bit is offered, the
> > driver chooses to enable or disable it. If the bit is not offered or not
> > negotiated, then the behavior is deny. If the bit is offered and
> > negotiated then the behavior is allow.
> > 
> > We can say that before features negotiation (latched at features register
> > write, I think, in practice?) the behavior is platform dependent. The
> > current wording about bypass intends to discourage unsafe choices but
> > makes a strong statement only about the device behavior after features
> > negotiation. 
> OK. May be worth adding in the spec later.
> 
> By the way what is the plan for the vote?

The ballot closed and the spec is accepted for virtio-v1.2-cs01, with the
condition that the stale statement about padding is removed
(https://lists.oasis-open.org/archives/virtio-dev/201911/msg00083.html)

Thanks,
Jean

