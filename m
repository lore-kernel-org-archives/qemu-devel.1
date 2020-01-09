Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BF0C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9512067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvksNLeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9512067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVFj-0007R2-K9
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ipVF4-0006v2-OS
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ipVF3-0000FS-6B
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:40:42 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ipVF2-0000BI-TH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:40:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id f129so2259247wmf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=j0VIeGAp1BrnGHM7FD0UC10bMu2XPsedlX8Zb3gIIJs=;
 b=zvksNLeuJvnwYho66axt16D+BITBNZgNgXSacM7ISI4yHBDovfzxQuaZRTXrkbPDyp
 fOYgI62wKt1/inltNH5lLsZCl8L4msDYEVT0de9VcsnH9BpuOgDiM8iT4Vwn9+QAa1Iv
 KWaYpWyFyKzFouwDWIadPiNGS7oNPJftxDIGnHdGp8M4upaQjNe44TD82IpRnuuQG2af
 L8kPX33QYvlC76g2aDfpzV6ysyBWsQsEB4xjAdwfEuWdLJU+pwhHA+61iJb1gVcoAJqZ
 tY/WAoCkQj5rANyZW0eDxwP9ofFR9icTnDwgANvuiit3hLXGwoEDg2qnYzaptCAYCJzl
 zX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=j0VIeGAp1BrnGHM7FD0UC10bMu2XPsedlX8Zb3gIIJs=;
 b=DJV3xCQcfkr5eukJONpXRL69ceCaQamhBwpicq7qdnSD6h8h/zwzaAdfF+v05NQbi8
 HpB7RHhuJeGgvQcIb+Xq/Ld4JvOMA/Z1nEkjP1i70hLmG/5Uvz/gTJ+5qTf+OJsJmSZx
 Hmsavxy6JiIz9O6dO59QE1H+upujTaYl/Dvu3RZZUZ1yJj6WIDXZ2vxsWsjKI9BNK5cJ
 TWQXu2n7JXxWevLAhGIbCBiTHH+YivqkAbIrcniF8X6HvV64+8+9pPSvFHm6xu046sbv
 9magA18wP80mvUgyy/0kRqTcKpdJ8sAwdA0TQxCFDuhbK9lOMTHFTfWQL2CHtEBu+8yp
 7Z3Q==
X-Gm-Message-State: APjAAAUmVP2ABi3y5h+tcqxJJstGH8ehtwSzf1PeNQan2bE+bFaCXucF
 m6btwbDkzp9kFGED+OkCh1AAzA==
X-Google-Smtp-Source: APXvYqwluFdOQJmvludKGiqW7plTVV/lOVKH40RuB3Gr0uES7QXtKuipEsUJ0TCj622DblY17UMz/w==
X-Received: by 2002:a05:600c:10cd:: with SMTP id
 l13mr4274474wmd.102.1578566439546; 
 Thu, 09 Jan 2020 02:40:39 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id 16sm2421082wmi.0.2020.01.09.02.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 02:40:38 -0800 (PST)
Date: Thu, 9 Jan 2020 11:40:32 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20200109104032.GA937123@myrica>
References: <20191219144936.GB50561@xz-x1>
 <9ec9d0d5-062b-f96b-c72c-4d15865ff9a1@redhat.com>
 <20191220162642.GA2626852@myrica> <20191220165100.GA3780@xz-x1>
 <20200106170634.GF2062@myrica> <20200106175850.GC219677@xz-x1>
 <20200107101024.GB832497@myrica>
 <aa5fa9e6-6efd-e1a3-96c6-d02ba8eab4c8@redhat.com>
 <20200109084700.GA934975@myrica>
 <0beb9d61-05b8-3152-e967-64413def6ab7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0beb9d61-05b8-3152-e967-64413def6ab7@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

On Thu, Jan 09, 2020 at 09:58:49AM +0100, Auger Eric wrote:
> >> I share Peter's concern about having a different default policy than x86.
> > 
> > Yes I'd say just align with whatever policy is already in place. Do you
> > think we could add a command-line option to let people disable
> > default-bypass, though?  That would be a convenient way to make the IOMMU
> > protection airtight for those who need it.
> Yes I could easily add a device option to disable the default bypass.
> 
> Shall we change the meaning of the F_BYPASS feature then? If exposed by
> the device, the device does bypass by default, otherwise it doesn't.
> This would be controlled by the device option.

For a device that doesn't do bypass by default, the driver wouldn't have
the ability to enable bypass (feature bit not offered, not negotiable).

> The driver then could have means to overwrite this behavior once loaded?

Let's keep the bypass feature bit for this. If the bit is offered, the
driver chooses to enable or disable it. If the bit is not offered or not
negotiated, then the behavior is deny. If the bit is offered and
negotiated then the behavior is allow.

We can say that before features negotiation (latched at features register
write, I think, in practice?) the behavior is platform dependent. The
current wording about bypass intends to discourage unsafe choices but
makes a strong statement only about the device behavior after features
negotiation. 

We could add a second feature bit specifically for the boot bypass
behavior. It wouldn't be useful to the OS (the driver doesn't have a
choice) but could present a bit in config space that allows a firmware to
disable boot-bypass in a way that is sticky across reset. So when the OS
resets the device after taking it over, it doesn't accidentally enable
bypass. I wouldn't bother though. If a FW/bootloader is able to support
virtio-iommu, the user might as well instantiate the device with the
default-deny option.

Thanks,
Jean


