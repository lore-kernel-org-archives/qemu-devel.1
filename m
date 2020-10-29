Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F50C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5580E2076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="XgNRv2a7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5580E2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY5zv-0004co-7h
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 07:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kY5y9-0003kS-7G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:19:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kY5y3-0002tV-Ic
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:19:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id m13so2317958wrj.7
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 04:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=c24jJwlsSK4vKPNtuAEW1ol9EUy1Gb3qW4lu7PIi+yI=;
 b=XgNRv2a7FjAENjp5UjR1LHb027MBj1nn28QFxwBb6V7Duvt38QQzTj4UYV5jkKHHvt
 Wf9BhzZVb7Pn6CCP+OFsJDSGOlUqZBtismCMijtnNxQXwrHxevkNWPcm9GwDp7ItFfJj
 fQaHwKRGAAuWD7DSFsEMHPIxRru46wnpqzP6TX1WtOTIbRJRPgiQt/i9YfUtGDK3Ti4F
 WA2M67gIylef2nFkCaxVFyp0JmzReTPtlO7ShevGOvcNfAJjI8pbpFaRxtvPcFx1/bfF
 faOGOAhg7YXiSOTRNdQ1JgFj7XislWRhrvdjoInVDN8+T4WYfTetlIyOxZa6M+YZGVX6
 GAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=c24jJwlsSK4vKPNtuAEW1ol9EUy1Gb3qW4lu7PIi+yI=;
 b=JaRPU7j2LuaAUlDzgIWkuLIiLtzS+b4vfVQvbA1kr8cUXtgs7Afj7TmAmHXu+78d3y
 F7Ez1dm+V59QT6TnjF9q9HSV276321tmDCoNqw34zAtFSYMzC3zCBY0YkFKfMXcLh8Hg
 V4xbhKFA/uQgLcwjL1qFAKJc4x3MZOuq1jEhGYmOGbvtAjXI/LqPoxb/K5x4q40+Uqtw
 P0MwdiBej/F77MxGcJ/O0taG1i3klnHdkvI6eSwHQdpoWTMyqW+WsGbojdcWr58VGnk1
 aL9gOt40btUtgbxdIn/baAHTAY25IKQgD4w/t5s6KRKjHz62a6GcrqYJYl2w7eDq6Unr
 dOww==
X-Gm-Message-State: AOAM530zJPcdM/9P2bO/x5YygM1E4tjGPHQRKIOu7jFujZdiflm9I3bP
 rsi9HnjPINvtxYIeAC9brOKgrA==
X-Google-Smtp-Source: ABdhPJwpILwy05KjrTo7hqCVa+eTgbHlE+Sh15/aCGgjCGdeThYtAaew6TjmYLqYrA4C7L3kjUptbA==
X-Received: by 2002:a5d:60c4:: with SMTP id x4mr5197288wrt.175.1603970381598; 
 Thu, 29 Oct 2020 04:19:41 -0700 (PDT)
Received: from vanye (cpc92880-cmbg19-2-0-cust79.5-4.cable.virginm.net.
 [82.27.104.80])
 by smtp.gmail.com with ESMTPSA id z6sm3670708wmi.1.2020.10.29.04.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 04:19:41 -0700 (PDT)
Date: Thu, 29 Oct 2020 11:19:39 +0000
From: Leif Lindholm <leif@nuviainc.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] hw/arm/virt: use sbsa-ec for reboot and poweroff in
 secure mode
Message-ID: <20201029111939.GI1664@vanye>
References: <20201028085918.14580-1-maxim.uvarov@linaro.org>
 <CAFEAcA8_1w=4qdE_AJxUP-uPoFL=Fsg9hy62Lw7bLDjKzL9Vvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8_1w=4qdE_AJxUP-uPoFL=Fsg9hy62Lw7bLDjKzL9Vvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x441.google.com
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Maxim Uvarov <maxim.uvarov@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 QEMU Developers <qemu-devel@nongnu.org>, tf-a@lists.trustedfirmware.org,
 qemu-arm <qemu-arm@nongnu.org>, ard.biesheuvel@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter, (+Ard)

Graeme is on holiday this week, and I would like his input.

On Wed, Oct 28, 2020 at 20:31:41 +0000, Peter Maydell wrote:
> On Wed, 28 Oct 2020 at 08:59, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > If we're emulating EL3 then the EL3 guest firmware is responsible for
> > providing the PSCI ABI, including reboot, core power down, etc.
> > sbsa-ref machine has an embedded controller to do reboot, poweroff. Machine
> > virt,secure=on can reuse this code to do reboot inside ATF.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> 
> (I've cc'd the sbsa-ref machine maintainers.)
> 
> > ---
> >  Hello,
> >
> >  This patch implements reboot for the secure machine inside ATF firmware. I.e. current qemu
> >  patch should be used with [1] ATF patch. It looks like that Embedded Controller qemu
> >  driver (sbsa-ec) can be common and widely used for other emulated machines. While if
> >  there are plans to extend sbsa-ec then we might find some other solution.
> >
> >  So for the long term it looks like machine virt was used as an initial playground for secure
> >  firmware.  While the original intent was a runner for kvm guests. Relation between kvm guest
> >  and firmware  is not very clear now. If everyone agree it might be good solution to move secure
> >  firmware things from virt machine to bsa-ref and make this machine reference for secure boot,
> >  firmware updates  etc.
> >
> >  [1] https://github.com/muvarov/arm-trusted-firmware/commit/6d3339a0081f6f2b45d99bd7e1b67bcbce8f4e0e
> 
> 
> Thanks for this patch. It is definitely a missing
> bit of functionality that we intend to allow virt to run
> EL3 guest code but don't provide a trigger-shutdown/reboot
> device that works in that setup.
> 
> I think the key question here is whether we want to implement
> this by:
> (1) providing the sbsa-ec device in the virt board
> (2) some other mechanism, eg a secure-only pl061 GPIO
> some of whose output pins can trigger shutdown or reboot
> 
> The sbsa-ec device has the advantage of doing the
> shutdown/reboot functionality at the moment. The question
> I have for the sbsa-ref board folks is: what are your future
> plans for that device? If the idea is that it's going to end
> up stuffed full of sbsa-ref specific functionality that we
> wouldn't want to try to expose in the virt board, then we
> should probably go with the pl061 approach instead. But if
> it's not likely to grow new functionality then it might be
> simpler...
> 
> A couple of notes on this patch if we do go down that route:
>  * we would need to arrange to only add the new device for
>    new versions of the virt board (that is, the "virt-5.0"
>    machine must not have this device because it must look
>    like the version of "virt" that shipped with QEMU 5.0)
>  * the device needs to be mapped into the Secure address
>    space only, because Secure firmware wants control over
>    it and doesn't want to allow NS code to reboot the system
>    without asking the firmware
>  * it would need to be described in the DTB (and maybe also
>    ACPI tables? I forget whether we need to describe Secure-only
>   devices there)

Would it? Could it be something that goes into the virt spec?
We don't consume ACPI in firmware (but TF-A will of course have access
to the DT regardless).

For sbsa-ref, I would ideally like to move to emulating communicating
with an SCP over time, as opposed to TF-A directly controlling the EC.
I am unsure if that leaves much opportunity for code sharing with
virt.

Ard: is this a config supported/able by ArmVirtPkg?

Best Regards,

Leif

> But let's find out if that's the route we want to take first.
> 
> thanks
> -- PMM

