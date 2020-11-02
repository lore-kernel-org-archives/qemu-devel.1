Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE36BC4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A47223BD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="JzzAw5rH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A47223BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaIk-00038D-E8
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kZaHA-00027Y-QV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:53:36 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kZaH6-0003fL-06
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:53:36 -0500
Received: by mail-wm1-x343.google.com with SMTP id c9so7932118wml.5
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QZLkjyoD2YoBYtPVUGgMEg5LaEGBUP0gW184qg2JSG8=;
 b=JzzAw5rH1Sw2FC5J8PuzBm0LZksggnVwSs1MNmpqetf5xA75GPjRPnjpIAijKfcZN0
 lAojGIMql9R2mJBVth0h6066DiqzxYfce7IuwiYg171jOJEUgk2xuUSZ8GjtUa9dZE5y
 cnX3+RpZYUHk07jsOLR6dKVqlylD/EpOi1ckaWESZ+ByAml/f/jKP06sbiPAuUgLbcx7
 mAQA/YlILKQrzS2GFVXPhkOj/b/HsRGcIXUTQCEfPPiSDqkZkIZT82az5H/X1Wd7zaQz
 VxJPquY7Du/88QDuLZqN2jAefFTMcmiB6LIrBda9Jh3sCB0P5iZ2KsrwxD+p6oB6BXWe
 mIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QZLkjyoD2YoBYtPVUGgMEg5LaEGBUP0gW184qg2JSG8=;
 b=G+sE01ZQZ4NEBUn8dBh84cRakhRoO5fFQHlN04FNjBokoS9sQh5qi9gydKKGzapmIA
 0GSj2pUEicPxV8kfZGZH/DoEa3+nIBwzwBaFoWAIOYz204qnfmA36V5air45+sTwKZx7
 HbYIhervv5VMNQJG01ybETWL7KNvgD/ZsKA3X54b1j8Hm3TTPvV4UXrFgToPHgg8HX+d
 KdZuY5deOPCtVTegxtRgmzJ1mYXout51mTsppv/K4tOXrAvVEY2GQBFpQiV5g4CuPpKr
 LVpJyt65N7o34sLnlMVr0+lFnVDxlzjlmwhQcRQ/i2KKbHkrPjVXH09xCaVlKJQMZ5te
 mBPQ==
X-Gm-Message-State: AOAM5310ciaoALkK2OFh6ItT442GlSMCkbgQXaoHlX82a7OOdPJxnwHx
 Sm1xGHdHr2naMvVfKTcnojC99Q==
X-Google-Smtp-Source: ABdhPJyxkP+mkxtUH0eN4u0w/l1vYXB9pEVhMmFZda5dLrETMgzxKtN39HUr1gFd+jSPAUel1/MSDg==
X-Received: by 2002:a1c:26c3:: with SMTP id
 m186mr17145894wmm.115.1604325210104; 
 Mon, 02 Nov 2020 05:53:30 -0800 (PST)
Received: from xora-monster ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id y200sm12274006wmc.23.2020.11.02.05.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 05:53:29 -0800 (PST)
Date: Mon, 2 Nov 2020 13:53:27 +0000
From: Graeme Gregory <graeme@nuviainc.com>
To: Leif Lindholm <leif@nuviainc.com>
Subject: Re: [RFC PATCH] hw/arm/virt: use sbsa-ec for reboot and poweroff in
 secure mode
Message-ID: <20201102135327.wgltgvk2olqvamyp@xora-monster>
References: <20201028085918.14580-1-maxim.uvarov@linaro.org>
 <CAFEAcA8_1w=4qdE_AJxUP-uPoFL=Fsg9hy62Lw7bLDjKzL9Vvg@mail.gmail.com>
 <20201029111939.GI1664@vanye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029111939.GI1664@vanye>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?B?RnJhbsOnb2lz?= Ozog <francois.ozog@linaro.org>,
 Maxim Uvarov <maxim.uvarov@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, QEMU Developers <qemu-devel@nongnu.org>,
 tf-a@lists.trustedfirmware.org, qemu-arm <qemu-arm@nongnu.org>,
 ard.biesheuvel@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 11:19:39AM +0000, Leif Lindholm wrote:
> Hi Peter, (+Ard)
> 
> Graeme is on holiday this week, and I would like his input.
> 
> On Wed, Oct 28, 2020 at 20:31:41 +0000, Peter Maydell wrote:
> > On Wed, 28 Oct 2020 at 08:59, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> > >
> > > If we're emulating EL3 then the EL3 guest firmware is responsible for
> > > providing the PSCI ABI, including reboot, core power down, etc.
> > > sbsa-ref machine has an embedded controller to do reboot, poweroff. Machine
> > > virt,secure=on can reuse this code to do reboot inside ATF.
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > 
> > (I've cc'd the sbsa-ref machine maintainers.)
> > 
> > > ---
> > >  Hello,
> > >
> > >  This patch implements reboot for the secure machine inside ATF firmware. I.e. current qemu
> > >  patch should be used with [1] ATF patch. It looks like that Embedded Controller qemu
> > >  driver (sbsa-ec) can be common and widely used for other emulated machines. While if
> > >  there are plans to extend sbsa-ec then we might find some other solution.
> > >
> > >  So for the long term it looks like machine virt was used as an initial playground for secure
> > >  firmware.  While the original intent was a runner for kvm guests. Relation between kvm guest
> > >  and firmware  is not very clear now. If everyone agree it might be good solution to move secure
> > >  firmware things from virt machine to bsa-ref and make this machine reference for secure boot,
> > >  firmware updates  etc.
> > >
> > >  [1] https://github.com/muvarov/arm-trusted-firmware/commit/6d3339a0081f6f2b45d99bd7e1b67bcbce8f4e0e
> > 
> > 
> > Thanks for this patch. It is definitely a missing
> > bit of functionality that we intend to allow virt to run
> > EL3 guest code but don't provide a trigger-shutdown/reboot
> > device that works in that setup.
> > 
> > I think the key question here is whether we want to implement
> > this by:
> > (1) providing the sbsa-ec device in the virt board
> > (2) some other mechanism, eg a secure-only pl061 GPIO
> > some of whose output pins can trigger shutdown or reboot
> > 
> > The sbsa-ec device has the advantage of doing the
> > shutdown/reboot functionality at the moment. The question
> > I have for the sbsa-ref board folks is: what are your future
> > plans for that device? If the idea is that it's going to end
> > up stuffed full of sbsa-ref specific functionality that we
> > wouldn't want to try to expose in the virt board, then we
> > should probably go with the pl061 approach instead. But if
> > it's not likely to grow new functionality then it might be
> > simpler...
> > 
> > A couple of notes on this patch if we do go down that route:
> >  * we would need to arrange to only add the new device for
> >    new versions of the virt board (that is, the "virt-5.0"
> >    machine must not have this device because it must look
> >    like the version of "virt" that shipped with QEMU 5.0)
> >  * the device needs to be mapped into the Secure address
> >    space only, because Secure firmware wants control over
> >    it and doesn't want to allow NS code to reboot the system
> >    without asking the firmware
> >  * it would need to be described in the DTB (and maybe also
> >    ACPI tables? I forget whether we need to describe Secure-only
> >   devices there)
> 
> Would it? Could it be something that goes into the virt spec?
> We don't consume ACPI in firmware (but TF-A will of course have access
> to the DT regardless).
> 
> For sbsa-ref, I would ideally like to move to emulating communicating
> with an SCP over time, as opposed to TF-A directly controlling the EC.
> I am unsure if that leaves much opportunity for code sharing with
> virt.
> 
I would agree that would be the ideal end point for the sbsa-ref.

I am now kicking myself that the GPIO style solution did not occur to
me.

I do see the EC device being a stopgap until a proper comms protocol
can be implemented to replace it.

Graeme


