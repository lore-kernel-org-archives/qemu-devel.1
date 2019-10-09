Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19A3ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA1C20679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7pZTAE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA1C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGUd-0003L3-1y
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iICBJ-0004xD-4t
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iICBH-0000rk-Sy
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:39:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
 id 1iICBH-0000rF-NP
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:39:07 -0400
Received: by mail-wm1-x342.google.com with SMTP id p7so2653027wmp.4
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BeMFqSJKsyOwrvCpRyYXUCY/kZFtfdELbatv0b1GTFw=;
 b=C7pZTAE1FWJybuErEkvCbmLVkPsN+vMBitx/le4Awyw4msWS2BV7r72pbsqFq9fuvi
 QKJ0+kAxfw53YH9eaaOM8Mh44cXlBkSAUXhRU3iVQB57hgCZUKhwpTSl7e8w/smMzIBC
 o6Zn/y/luNS+mmu6mELYB5CGDHBDrtl17Pu3kHlfT2YqFx8fRmwrO2nI/i4uVdup6/hw
 ZYzG3YGQh2UdN4wnbSDOtRbFlmjQBag0SaqQ5qPslSAfduQibHuOjepOKotKFnrdLyuc
 y3ef8y0YJiDgjhwtbxUZEjttKbbsyIOZoY/cIH2HD/FMh6SuZJzjNqWNq6uO7m3VuQQC
 Z+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BeMFqSJKsyOwrvCpRyYXUCY/kZFtfdELbatv0b1GTFw=;
 b=iJHohF6siihcgoHDagLWYbti7bjPHrbyvtx3cLlRphABkTb08kHELMjBPrGFPh69YF
 oKnHNO3g8Qm1wxdasqoWBX6OtBsB6E0PMu7tr7lbMdiNZ7Lhgq969ces7o8FFAQckPm/
 lONIDHDyrhafoywwwV9M1XuI7A4IE91COE4rBrqTD4+TJD9XmiqLAjvV4d/2rlG4x0E5
 OQ1u5lwDs7n9VauiWwCOdscOuCEGIJD8tktklyy8lXpMV5Ldt+fipRwty7RhJ216Dj7g
 pzVkF318W67bj+1hg81cSgXB/IwXgjpod7uzw8KLWltaDwjFn0XTnzH/zuklRvtVD7P4
 JPPg==
X-Gm-Message-State: APjAAAWx9iC+eHxmda6xylpcV8GPqzx4Xi7xRHf3cdOzbDkGVR/QBS7Z
 8tezI16YrV4GoSThxoQ6KSwcWmWESBwxS+8zCylNQA==
X-Google-Smtp-Source: APXvYqwZyvETUix4gE5vf2RVfHW70IZjQnBTLId7B3mW5ls9JJadPcFxAMrKdmG9esEjAwqjDpPwcKV8XNCLbys83cM=
X-Received: by 2002:a1c:a651:: with SMTP id p78mr2739509wme.53.1570628346074; 
 Wed, 09 Oct 2019 06:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <21633062-b021-a8e7-0cc8-062f4c29dde5@linux.microsoft.com>
 <ca5c74db-cf5d-0c3f-eb6f-27d1092420ae@linux.microsoft.com>
 <65b49cb0-c9fb-d966-8dec-1e39d09ab8c7@redhat.com>
 <88878b22-803f-41fc-9df2-2c6eb551b98d@linux.microsoft.com>
 <CAKv+Gu8kwg_tsrH7qne3H11hUPyA6zw-J_jpUmiyJMvXo3-SNQ@mail.gmail.com>
 <5938a592-1494-ca0c-8a34-7df38dbbea0c@linux.microsoft.com>
In-Reply-To: <5938a592-1494-ca0c-8a34-7df38dbbea0c@linux.microsoft.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 9 Oct 2019 15:38:54 +0200
Message-ID: <CAKv+Gu_ADqW_LVUOy-kWK1FsgRXG+5f_gzpM5_QHP5pj8+40ag@mail.gmail.com>
Subject: Re: Is kexec supported in QEMU for ARM64 (qemu-system-aarch64) with
 arm-trusted-firmware, optee, and u-boot.
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2 Oct 2019 at 03:32, Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 10/1/19 9:30 AM, Ard Biesheuvel wrote:
>
> >
> > kexec is a linux concept, so whether it is supported should not depend
> > on the secure world firmware or the underlying host.
>
> I agree Ard.
> When I don't use ATF I am able to do kexec in QEMU and successfully boot
> into the new kernel.
> Is the following expected?
>
> When I execute kexec ("kexec -l <kernel>", followed by "kexec -e") I hit
> the following assert in ATF (in the file
> arm-trusted-firmware/plat/qemu/qemu_pm.c)
>
> /*******************************************************************************
>    * Platform handler called when a power domain is about to be turned
>    * off. The target_state encodes the power state that each level should
>    * transition to.
> ******************************************************************************/
> void qemu_pwr_domain_off(const psci_power_state_t *target_state)
> {
>       assert(0);
> }
>

Are you running with multiple CPUs?

