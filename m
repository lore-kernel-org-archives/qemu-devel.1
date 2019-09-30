Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF34C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB30B20842
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nq8irpzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB30B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEva3-0003XY-TT
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iEvWk-0001mW-EH
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iEvWj-00017L-1X
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:15:46 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iEvWi-000158-R7
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:15:44 -0400
Received: by mail-oi1-x243.google.com with SMTP id w6so11010740oie.11
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jVVEvUCK/emC3iUCb0l7K7+9YIBMzhWZQM52MAW23W0=;
 b=Nq8irpzkOOU/Qk+FAEiw7mFJD3ED6x3p7RuFi3tcphxcKOTzPLv1rLkbm2e+p0opFz
 0UEW0u32jfZzOUrbWh7ydkm94WJv0uuQzjFwAZrAYAfHa4BcvIXQbG8wzssg1Wn+V9un
 5/Ls5khPQVF728b7aVK8k8i4+cX7AXRrKLpgq7i7uYatXGLbyH2K5LuLFeFrEb7JU0Jf
 ru05sDSWcbXopIAvYSzdORMVbxEvtThAiCDRA7uPHKSD6ACGCANYwf4lwbwx802aIrHI
 2Z2UWOgHCOIeV/nBlEQ3NQhTTdKCLVo8wWA3Digito5OsA120xeodDO9NfrEAlc7SnI+
 yv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jVVEvUCK/emC3iUCb0l7K7+9YIBMzhWZQM52MAW23W0=;
 b=ikjyFn0myNcD1r20BYYJVc4zPs9AiFI+xtblfwOAWdbTfMk0sg2I4X7gaMfCPN2ss4
 ykm50ug/R7A+y4FO93q82L0avMIwqsTl8k9hTjf3I/xLN2jCVJ8dwQe+1srsVPrBCcXX
 OrQrqVIL6U/eyMq1YR8GKgmMZd2m4VYp+J66CiA2pPxnM3lIZip6AjG//P7lu9bY9BKI
 T25qAh+6acwsgzRM/+MrSCYHNIRH20wrDqF+GvPQmhht66eKRmaRE6F1LuC3PZNOk6ue
 RMtfC84W9hDXfsIHefrxGgCZk5RVO6cilgg12dw95ugW3IzrnAvUKrBdKNfwE9m9S6A4
 X2Ow==
X-Gm-Message-State: APjAAAVEcw2s7eKAcK6+hK7tYE9/vaS1ZdUlXd3ig3p+BX33DmBVSycC
 LrYMWq0W/0KPX+yJI7KuW/mspF0yN2aJHvxEfsp05g==
X-Google-Smtp-Source: APXvYqwR/uvkoTEDQ6kjF9B5yRo9oWxbFNBjwD4EdIfTijDBaNwNgNDAKLYvIDj2ndcXMo57HW8oLx6+SCdOlzvOr+o=
X-Received: by 2002:aca:53d4:: with SMTP id
 h203mr17266374oib.146.1569849344040; 
 Mon, 30 Sep 2019 06:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
In-Reply-To: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 14:15:33 +0100
Message-ID: <CAFEAcA_ztr0_Bu9d__dSr9oH75s2DSd5=6NZvVMrxuDTxf31mw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] Add SDEI support for arm64
To: Heyi Guo <guoheyi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Dave Martin <Dave.Martin@arm.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 16:23, Heyi Guo <guoheyi@huawei.com> wrote:
>
> As promised, this is the first RFC patch set for arm64 SDEI support.

Hi; for the benefit of possible reviewers who aren't familiar
with every corner of the arm ecosystem, could you provide a
summary of:
 * what is SDEI ?
 * what do KVM and QEMU want/need to do with it ?
 * what is this patchset trying to solve ?

That would provide some useful context for trying to
review the patchset.

thanks
-- PMM

