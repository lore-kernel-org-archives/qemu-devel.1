Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1BEC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BC324801
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rk18SVW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BC324801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXs8a-0000tk-SU
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXs72-000083-Nn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:32:04 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:43142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXs6s-00019A-JB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:31:59 -0400
Received: by mail-ed1-x541.google.com with SMTP id dn5so824808edb.10
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A60WitzBwUcQrRVGfN8Ljoa+Za+envdNm8g+RcTq0wc=;
 b=rk18SVW1Dyv/PrlgmyN0i32GHExFumZ8sA099ubn7lYjDWtdamg0pJZ374nCSSP5ed
 JZU4bRQdHG+vim7lH7r1uYcxdsyTCBmwCgnszdZq1R3+76JHt8x0wYmoGenkyK1/ttdv
 V2lgjq/Eb0ddw384MrRumbzH97Ue1APrsLpNjboJXgefRrX5OnSjWCXlYU314F5c5s3T
 oWkzQKVE8A26Hr2wnemM6NiTyuYQVVqbxBWslZCU8gpxfWOB4NtBPxe3neU4ujDs7z7h
 tYuuB/mc1RYM5PoF/5hZSH/q2TUCJ5fGWJDPysFsIDjMUo7x5LPMAsyvJELYnmuZ7Xr/
 oIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A60WitzBwUcQrRVGfN8Ljoa+Za+envdNm8g+RcTq0wc=;
 b=kbqvxv1rqKv1oSAwQL5SBbxflP9JF6rfi0fdD5AeJ3+cQQcWs0nfGfwsnDgaUAmrg1
 nDAk/u24oZVzrh7bVrPmKB9Y7ICBR5lsHTa5xrF9fn6R2x38Jc9l15t4b+wmy1iWj4A5
 QgCrs+yaBgfX5kL0GsrMiZ9ejniWubE4T/06s4jHncCqROQhxJ8vkI0I1rdGziZ+7cgw
 1RjO12dVXHlqQjCLUfFR3/Cq9x9+cR9EFWp8oOCjo9ldm9VhKUGwMidm4QnUPnssbOBH
 TTIpqf+EtKJnQtDKB8lbzvrW6xIHOYaayIVGgUayU4qAtSKwYp5HetTuIqbBTR9lNu6J
 rhhw==
X-Gm-Message-State: AOAM531oz1R6xGfPgMeYpNj4y/Sx+zF5NhiXS3UGKu/XAj3K3VITNmM7
 nTj0fWeXT9fJwlBKGg0u4KUfwZOOpyYLnnk8rs+62g==
X-Google-Smtp-Source: ABdhPJwwIKJMx2tZ4n5Rkg/lublCZPSSofsVCjPpMXpK7qqonz7mCPT8/2jpCBOSuH3f1XenfIILCGTQZAoK6gp0L0g=
X-Received: by 2002:a50:f41a:: with SMTP id r26mr666265edm.251.1603917112827; 
 Wed, 28 Oct 2020 13:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201028085918.14580-1-maxim.uvarov@linaro.org>
In-Reply-To: <20201028085918.14580-1-maxim.uvarov@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 20:31:41 +0000
Message-ID: <CAFEAcA8_1w=4qdE_AJxUP-uPoFL=Fsg9hy62Lw7bLDjKzL9Vvg@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/virt: use sbsa-ec for reboot and poweroff in
 secure mode
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, QEMU Developers <qemu-devel@nongnu.org>,
 tf-a@lists.trustedfirmware.org, qemu-arm <qemu-arm@nongnu.org>,
 Leif Lindholm <leif@nuviainc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 at 08:59, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> If we're emulating EL3 then the EL3 guest firmware is responsible for
> providing the PSCI ABI, including reboot, core power down, etc.
> sbsa-ref machine has an embedded controller to do reboot, poweroff. Machine
> virt,secure=on can reuse this code to do reboot inside ATF.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>

(I've cc'd the sbsa-ref machine maintainers.)

> ---
>  Hello,
>
>  This patch implements reboot for the secure machine inside ATF firmware. I.e. current qemu
>  patch should be used with [1] ATF patch. It looks like that Embedded Controller qemu
>  driver (sbsa-ec) can be common and widely used for other emulated machines. While if
>  there are plans to extend sbsa-ec then we might find some other solution.
>
>  So for the long term it looks like machine virt was used as an initial playground for secure
>  firmware.  While the original intent was a runner for kvm guests. Relation between kvm guest
>  and firmware  is not very clear now. If everyone agree it might be good solution to move secure
>  firmware things from virt machine to bsa-ref and make this machine reference for secure boot,
>  firmware updates  etc.
>
>  [1] https://github.com/muvarov/arm-trusted-firmware/commit/6d3339a0081f6f2b45d99bd7e1b67bcbce8f4e0e


Thanks for this patch. It is definitely a missing
bit of functionality that we intend to allow virt to run
EL3 guest code but don't provide a trigger-shutdown/reboot
device that works in that setup.

I think the key question here is whether we want to implement
this by:
(1) providing the sbsa-ec device in the virt board
(2) some other mechanism, eg a secure-only pl061 GPIO
some of whose output pins can trigger shutdown or reboot

The sbsa-ec device has the advantage of doing the
shutdown/reboot functionality at the moment. The question
I have for the sbsa-ref board folks is: what are your future
plans for that device? If the idea is that it's going to end
up stuffed full of sbsa-ref specific functionality that we
wouldn't want to try to expose in the virt board, then we
should probably go with the pl061 approach instead. But if
it's not likely to grow new functionality then it might be
simpler...

A couple of notes on this patch if we do go down that route:
 * we would need to arrange to only add the new device for
   new versions of the virt board (that is, the "virt-5.0"
   machine must not have this device because it must look
   like the version of "virt" that shipped with QEMU 5.0)
 * the device needs to be mapped into the Secure address
   space only, because Secure firmware wants control over
   it and doesn't want to allow NS code to reboot the system
   without asking the firmware
 * it would need to be described in the DTB (and maybe also
   ACPI tables? I forget whether we need to describe Secure-only
  devices there)

But let's find out if that's the route we want to take first.

thanks
-- PMM

