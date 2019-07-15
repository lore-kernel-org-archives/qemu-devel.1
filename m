Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75EEC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E8F2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNFsKvo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E8F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35969 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmwcR-0001m0-DI
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 04:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hmwcD-0001Ge-Ss
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hmwcB-0004HQ-M0
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:45:45 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hmwc8-0004GB-Tm
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:45:41 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so16103145ote.13
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ad1daU+mbhzBv6ri/xPkhbDznTHG6noyNYUr+gz/KJo=;
 b=NNFsKvo59FPOMw5j4AyOuRQaIWT7JEq55GzMuHrGyy3J34ZCrLFVDpHU0Y2xi8ZvwF
 jskQmCd0qAiukrll5ZyqLBfO669icahI/Cd3vZ2ENHrtgdAQ/eyO9zKTagwI//KRMb4d
 9rWh2Xe9b+QIY9xriGxfOooVleGs6R210c6vYEnsrQdGVPI6IzTSUigu2nHNT8rwO6Qz
 NSdoME3mVhZ87LyPbe+CRqiJdJAs43u9B9hHjyprjR7v3es1driDTqsROnDSHx0yYsJr
 UaeBRnBnI4G2CQQIRodC6IMHgypo7xbp89ou3SJvIOrsU/3W530R+duuhFEvA1wmiCDT
 x17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ad1daU+mbhzBv6ri/xPkhbDznTHG6noyNYUr+gz/KJo=;
 b=TiG2jZsqhRIFqMfjZLOELfNvEJEfylG8SnOPux1N+73rH8Dz86xmQH8N0h/WTMgv+R
 4+6WrJBWr8bvATxSStRv7izzvJCd2Jd4fSBMCGgyN4jSRFg22SE4BUAYfky+kyehZ1Qv
 KHtTdjhxRbe0fitELgcpr5FJLn2HmkjnBWjonDVCzJsJVU/TmlRmDTfJTeo9K+YB3+1I
 XwU1EA91m3WqEYTG9FuZoFps9+x2XJ9GSK7UQhKya8fFWcP0tf0gNuLO0LhO1HFrAt78
 8Gmq+t3S9WwUtEVO5bP5nUApculzsnNgw1v0lnghoSSpa/wcUts/CX1tBQRKSc6OZdRU
 BBEA==
X-Gm-Message-State: APjAAAXALENZLI1q8TzAFPfnLrCDJ3VEUEf+ewM/jxDhnxuRgkp52+fw
 ux99VlV9ABQhet9XCwzZ5XQQfQYO8oXT4fDOv4DZZA==
X-Google-Smtp-Source: APXvYqyZet0H0/UMq+VKJ2g2AEG9chSgM3eBvlVUBdk1uT8jopOIBuabgyhULJ/rtcVyKmpymen/P/Lo/K3n/ToqpFA=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr18082429otk.221.1563180338601; 
 Mon, 15 Jul 2019 01:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190712153504.14937-1-mst@redhat.com>
In-Reply-To: <20190712153504.14937-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 09:45:27 +0100
Message-ID: <CAFEAcA8O+7DhMFsR0ROq5cUCS40apR9gWWgOF89qkAAXpVK7qg@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 0/8] virtio, pc, pci: fixes, cleanups, tests
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jul 2019 at 16:36, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit a2a9d4adabe340617a24eb73a8b2a116d28a6b38:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190712' into staging (2019-07-12 11:06:48 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 207efa18ac9eb7085a44cad24489d0da54bc5f65:
>
>   virtio pmem: remove transitional names (2019-07-12 10:57:27 -0400)
>
> ----------------------------------------------------------------
> virtio, pc, pci: fixes, cleanups, tests
>
> A bunch of fixes all over the place.
> ACPI tests will now run on more systems: might
> introduce new failure reports but that's for
> the best, isn't it?
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

