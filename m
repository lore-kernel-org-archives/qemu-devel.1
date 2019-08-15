Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A73DC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1554E2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8kuiqad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1554E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyBBr-0003PO-5O
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 04:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyBAs-0002sy-5L
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyBAn-0002kT-CX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:31:55 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyBAi-0002gU-EK
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:31:49 -0400
Received: by mail-ot1-x343.google.com with SMTP id q20so3495877otl.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rdgu4khboK/PEIYNJv3Ay/3DVdC2zV7k910eXnLQ8J8=;
 b=c8kuiqadEIWEgX8dJ5e6YVYvCyrGXKu4eUixVD8S+eKqaX8FideyXVgwirL6pa4bw6
 sPJgIC5urqkPR4Fem2+Xscb/zGUrwgcNZr25TNZcZJ4t72e8KQDAgTR4UO7taQG6c7+s
 mVbHm9CWvANIj3UaffAqNOBZeWS0dTdVKqk3cHhrHKxlxLtCFrZPWEjg6x7AwZvEAvfg
 00Qlf2pkJQsN+lEDq6MWsJ+8VQFLhTzWq6w0JGvA4y9Nn0PZ8ygWPGHXevd/4mIu5uwo
 wz5NrRpEc2k5drqv0Wtggs68F9DA8GXC4xqAMcOxG0lynaLdt6hwb7iBZ+X3DwMoYtV4
 su0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rdgu4khboK/PEIYNJv3Ay/3DVdC2zV7k910eXnLQ8J8=;
 b=lE+ojasWZv/JsCW6G511Xcr4aFVuz2z2R9RYQelLD/Z/U032fB8VMkqENxqC7o9TLv
 sjjDz+PP2+NP0HXwOiae2xSB44ajyD4do1p11efQdTafQq9tMlwawNQ+412wqWdeSsNR
 JvMg6vrPQCGH5AHkZzP3ZglwYg6tYMm40dTYDJSDRCScIFzFxXiwSxC1BJ1YPaPGP2rM
 HOd6/2BEfXb5WfPzSgIAaoml452De72s11XnurYqcme4er2zdAShVfRoJ32Fj00FQarW
 PJO3HQY7lTUtJ+nXGVlFdh0xMSkDK2Q+acGBIpspL9FSQgdxFFIQbhKcC280gHXQR5o2
 /LLw==
X-Gm-Message-State: APjAAAXUyZ0zLnDU7Xq3ZRDB0CtH4bWrLUPq+Gf3EkxxuGpXEJtD8S08
 lbe/5JC5eyBy2UVB4ak+YveKD5KtDg7/1A0QZSg4qQ==
X-Google-Smtp-Source: APXvYqx/GJHWgvbPx/ffXlExl0umDTzIeN44CnsEzUH9S8rQDsTzsZofixl8s/dJsGOwxqwPLnN3ZiOhhpLemITi1rg=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr2729831otr.232.1565857906406; 
 Thu, 15 Aug 2019 01:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190802122540.26385-1-drjones@redhat.com>
In-Reply-To: <20190802122540.26385-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2019 09:31:35 +0100
Message-ID: <CAFEAcA_Tq-DLQuH2-+NtYOE0m4ki_CfEfWpHG+UM4rGhdK3q-w@mail.gmail.com>
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 00/15] target/arm/kvm: enable SVE in
 guests
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Aug 2019 at 13:25, Andrew Jones <drjones@redhat.com> wrote:
>
> Since Linux kernel v5.2-rc1 KVM has support for enabling SVE in guests.
> This series provides the QEMU bits for that enablement. First, we
> select existing CPU properties representing features we want to
> advertise in addition to the SVE vector lengths and prepare
> them for a qmp query. Then we introduce the qmp query, applying
> it immediately to those selected features. We also document ARM CPU
> features at this time. We next add a qtest for the selected CPU
> features that uses the qmp query for its tests - and we continue to
> add tests as we add CPU features with the following patches. So then,
> once we have the support we need for CPU feature querying and testing,
> we add our first SVE CPU feature property, 'sve', which just allows
> SVE to be completely enabled/disabled. Following that feature property,
> we add all 16 vector length properties along with the input validation
> they need and tests to prove the validation works. At this point the
> SVE features are still only for TCG, so we provide some patches to
> prepare for KVM and then a patch that allows the 'max' CPU type to
> enable SVE with KVM, but at first without vector length properties.
> After a bit more preparation we add the SVE vector length properties
> to the KVM-enabled 'max' CPU type along with the additional input
> validation and tests that that needs.  Finally we allow the 'host'
> CPU type to also enjoy these properties by simply sharing them with it.

Hi -- I see there have been some review comments on these patches
that mean there'll be a v4. In the meantime, patches 1, 2, 5, 6, 9, 10
seem to me to be independent bugfixes/cleanups that have been reviewed.
Would you like me to take those into target-arm.next to reduce the
size of the patchset for v4, or is that going to make rebasing
painful on your end?

thanks
-- PMM

