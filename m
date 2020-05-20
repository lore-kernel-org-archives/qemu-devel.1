Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1429C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B3A20756
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRAfzSRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B3A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOcs-0000sL-OK
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbOc4-00008L-Qo
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:18:25 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbOc3-0008K0-T9
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:18:24 -0400
Received: by mail-oi1-x242.google.com with SMTP id o7so2884587oif.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TepDhlLU0nAXQ/3EFT4Au/LskTmn7y2T02RgQylmwCE=;
 b=eRAfzSRwgefe30hquLj+l+KcZeV47Y/dzsRlbWcu9X1s5S6dQB8VMA6DND+RJtR5Hq
 pJcy5z4wxwj2SZkNEGC0u90knOsSGly8olyKI1bt6KhYZyy0IWkQ+5eVGrz3ACBYvt41
 qjGPj7HDvOKqP+1C0XuA9MPzty5vVi8CwTvEAnWWFdT66Ac3cCbv52942NNZfgclDtLA
 Pwbjo7XWoYL3zjzQzDte7UQthvFI8tmrETHoUztvrP0Tq1ZUXjX54ajf+9nnB95SWVQ5
 QEguXpKR0xvrnpgookV+CWfv8znmGbpk1nZnEXTjFs3Ll/4FOy4T/3Nmf5ZhpMMJA3+5
 g3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TepDhlLU0nAXQ/3EFT4Au/LskTmn7y2T02RgQylmwCE=;
 b=ZbWFA3YoVzEtIFOGsjebyJZ8Snv5jxSqtjWGoEsFFCTAS5MPc5KEFZlktTzrv5F2Fd
 ExgUa55g3zlCDjSxrPcsKcNRZeeOVLQAdbajhDRk3raxZH/yUWvm4+asAWPzX2rU7eJV
 hINvTuiHNI07axYu/vi1PhqffD28444argRThiLFP8yjByBV0cvW8dBxnG3SlRQeU/zh
 sucAXyvO9XNBjUAk+aPwKNG7xwXRufUn56XPd4cO/3ZRwHHrViKKoB0XDZm/KoNEkf9X
 eE4BYqlfn5Jmo+cQHDilGwy6rUuMSWb/WQJ+e49RSgSer20XiyzgpesmUBZLDCkvjqgq
 r9TA==
X-Gm-Message-State: AOAM532umI77n5Ohpdc1xyINpR0oy8sLeG+9UPxd+ae9rhJF5y95SXxg
 vLvAO5hIbCpLSCVwCQWxeLslYbfXGtUsl3IQJwxllA==
X-Google-Smtp-Source: ABdhPJwedkIt34pH4V1HBtOut9KBzqj1lVXeNAENp8aK4A48FaZElvxDL4w3J4yfCwZw8+egK0i8FRCCJgsWdb3s5WE=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr2875647oih.48.1589980702714; 
 Wed, 20 May 2020 06:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200512064900.28554-1-pauldzim@gmail.com>
 <20200512064900.28554-5-pauldzim@gmail.com>
 <CAFEAcA8ru0DyVTvVcTjf0AH8wi+d64m=iP_qbHrsLnGt65Y0Kg@mail.gmail.com>
 <CADBGO79puzxx8dC2_kxe0eGJ34fn=DwwgNfL9xSBt=dQvEcOUw@mail.gmail.com>
In-Reply-To: <CADBGO79puzxx8dC2_kxe0eGJ34fn=DwwgNfL9xSBt=dQvEcOUw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 May 2020 14:18:11 +0100
Message-ID: <CAFEAcA_SVkgtr959SGKCgdFHX15pq-bkHXbF5RvMJXhVgBfb0Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] dwc-hsotg (dwc2) USB host controller emulation
To: Paul Zimmerman <pauldzim@gmail.com>,
 Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 at 06:49, Paul Zimmerman <pauldzim@gmail.com> wrote:
> Is there a tree somewhere that has a working example of a
> three-phase reset? I did a 'git grep' on the master branch and didn't
> find any code that is actually using it. I tried to implement it from
> the example in reset.rst, but I'm getting a segfault on the first line in
> resettable_class_set_parent_phases() that I'm having trouble figuring
> out.

Hmm, I thought we'd committed a change of a device to use the new
mechanism along with the actual implementation but I can't see it
now. Damien, what's the status with getting Xilinx devices to use the
3-phase reset API?

thanks
-- PMM

