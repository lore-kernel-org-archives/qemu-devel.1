Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B22C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19F021479
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rS7iR9BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19F021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhybs-0002MS-Aj
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:52:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47240)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhyRb-0003rg-MH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhyRW-0001tl-O8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:42:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhyRW-0001n7-9j
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:42:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id l12so10325274oil.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NMAqTIq4T69gLVpMEjj3jVOxgFLDjZ/zQ0vNtEgbWVw=;
 b=rS7iR9BX+yBa+Q3mJrdoTNFqM9fnVGwWjzPnHv1IZG5ubepOCsilrL9QlWj1bRZXo/
 0U/YQfILTMQ5pbLUSJpGvAdRwzhv+KfaQ9aHTJv23tY4c20B1D2n/tCYXttJh7PL9Ul+
 oRtUHbB4UFMkZv8GpfGCwxD0a2jf1pYkAAIaF+1/Wi5xgMwOOsWROpddywlCf1R2sIBY
 eg71tADGli0Ri9AtiANf+Y/LDtN3pwaaPW9Y1vfo+ofqIQkRhOe0jYGs1wrdUa/hfs6J
 JmuFIJYWd6EPMr0zdfBc+lb/qhq+lxe8SenuIghSWBX/EdUF0o87ToeQa13foegjDXcg
 IxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NMAqTIq4T69gLVpMEjj3jVOxgFLDjZ/zQ0vNtEgbWVw=;
 b=l9S8dQrr+Ov8VlNG9PmepdkO+HEg1xvakyEFzEUFlkOigxlWAdE83kavdTG6svCj3A
 YX2KOSDVIvzHiaNVfh58e4/T1lX9YYkaV1hIsCsY9m5IPt5a5J7s1zlhh+Zw4OXupQ5F
 rrtk5jraR4lfy8GiKx/lZKJj2lshdres5tECj+EVgeh/0VWhB9O1T2AcUiDO+VGFb9uS
 aaCM9VR+pSjOQfQAIRDgTHmzNKsIpmut6WTNM0xJj5HL9MgvbfZaAtlrSGvwxtXtg0E8
 cTLXQXNnuOYh8og/HdoMYLDrOp5cyPGIa9BF8Qq5jQ7nJJtp/STXzCP75f87293gMpC4
 UO3A==
X-Gm-Message-State: APjAAAWxnrgFceU9wLlqB4SbC6mHU6XfK/iQabepJ6wv5GQhmU8v5E4H
 terZtklXqSQqgcrq5BZSWCHER3lx0kNumJTnYDQleA==
X-Google-Smtp-Source: APXvYqwY1tjjpA5v2wLi0JJJ19cIDE24eZAUIJeXVvG9EqgZmXAEZPp2DcfVBM8W8hrdlGFAsUdnh34b0UeOZu27+Q4=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr7354091oic.170.1561995728528; 
 Mon, 01 Jul 2019 08:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190701132516.26392-1-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 16:41:57 +0100
Message-ID: <CAFEAcA93x6zkbHe1hdg0c8cbo9ErSByP+g6UvwZefxn-6346zg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.193
Subject: Re: [Qemu-devel] [PATCH v3 00/27] Support disabling TCG on ARM
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
Cc: Yang Zhong <yang.zhong@intel.com>, Andrew Jones <drjones@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 14:25, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Paolo motived me to salvage this (other!) previous series fromi
> Samuel Ortiz (NEMU project).
>
> v1 cover from Samuel [1]:
>
>   This patchset allows for building and running ARM targets with TCG
>   disabled. It splits the target/arm/helper.c file into logical TCG and
>   non TCG dependent files so that one can build and run QEMU binaries wit=
h
>   or without TCG enabled.
>
>   The rationale behind this work comes from the NEMU project where we're
>   trying to only support x86 and ARM 64-bit architectures, without
>   including the TCG code base. We can only do so if we can build and run
>   ARM binaries with TCG disabled.

I have applied to target-arm.next:
 1-12
 14-17
 19-21

I had comments about 13 and 18. 22 has a conflict when I try to apply it:
I think this is just accidental because the functions it's moving are
next to changes in patch 13 so there's a minor textual conflict, so it
would be fine with a fixed-up version of patch 13.
23-27 are still RFC status so I think best left for the next release.

thanks
-- PMM

