Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21279C10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47C221655
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JIQmljnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47C221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0eh-0004Za-3f
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jC0c7-0007f9-2I
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jC0c5-0007y6-Sp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:37:30 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jC0c5-0007ta-EQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:37:29 -0400
Received: by mail-oi1-x242.google.com with SMTP id d62so1674392oia.11
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gNxkOlpJbvYvxXqAD62d8wzVbReClJQF9KUEhb3hPfA=;
 b=JIQmljnkdwKr0ZRVCoHcC19Tl2pl9n+IjcfWvEnx/vFe8h1a2w54wSGeW9826kIexj
 6h3HVXkfx12WuybtSQkynXoBvZ2F82pNN3qxGolN606Qa/0OdWQV7EwP4c2c6/SkQ3ED
 qsZIKqSq+7LcA1Qb0IICXCb/6a2rxkNQM8nvXKJZWZOHkAXdEnMmI59G5mkM+4EjWC/k
 2DzxjUnXZixN0zVyjRHcXdot1VA6hiIvPEHmmgJS0hHEkDQP3OCTti93B11jcm2Vi3XF
 8vO7NFZBivXDiA01Om9aZpOz1k+b8d9xnF2tUBfxi7tQy8TA/DGhqbWPtHIZuB3G9CS4
 wuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gNxkOlpJbvYvxXqAD62d8wzVbReClJQF9KUEhb3hPfA=;
 b=KhmtpHSN+y3xLwOcdw97bSPDEvJe5Ncu1DCaiob74YPBi1NNQSpQX/ftEfi1Z040vD
 OXUjl4qUsG2d/nDBHWXL8KlAa5zHHOBW24PDn2rV4fHySkzOufhMulkUQ/Np7FDfJIyy
 /eunXbT6OH6lLtlPznnhgpRf3Oy1KzEBw54M4nyb26ohYvBl1OnCs3XG9yNyImGPfEsX
 dnAMa9ivz3TmOhnR65Eo5e54qRPvYvz2NKsb+puWY72BSm1UFoKYZvtihqxX/jdUqa92
 3LkQLvkDe36AiEWb6+0QR+wW9pblFG3EXWuyDXx/Xgrp/1QGmLZFr2F1wvmDoTH0zzOf
 ghgw==
X-Gm-Message-State: ANhLgQ09fVSN+cCIVmvb2fUHAH1p2bKitaz92Vmb0bRUsOv2oHwBGoVX
 MWUCTEzS8o1UAoo5Vpcs2rL3aA7g1aKUXNfygUoBpA==
X-Google-Smtp-Source: ADFU+vuqNOrfAMsElcyrU4AJxX2SuFlRUM2xVsE3890OsWcxFpae4LdwtSP8Wi8HarvYgVE4hvr7q2G+uAyGANLVd80=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr1721549oic.48.1583930248560; 
 Wed, 11 Mar 2020 05:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200305154142.63070-1-jingqi.liu@intel.com>
 <20200305161047.GB3627464@lpt>
 <CAFEAcA-OQncMrU_-DJJ9g5rEcrJvbhTOjOVs0YqO3NS_Y413OQ@mail.gmail.com>
 <f774652b-5145-1e47-62c4-99a69a037506@intel.com>
 <CAFEAcA8HMSg8nS27YGPEQsPeGW2UicWRxeJDQf3oKbyHH2TY6Q@mail.gmail.com>
 <a57d479a-c9d5-0acc-b808-fe4e5a20ae80@intel.com>
 <20200310051003-mutt-send-email-mst@kernel.org>
 <16328974-3c7f-0e69-9614-a085c5841a2e@intel.com>
In-Reply-To: <16328974-3c7f-0e69-9614-a085c5841a2e@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2020 12:37:17 +0000
Message-ID: <CAFEAcA_B7FYboWR3L=X32ssyKxz2HXD3jxsQXeTinP-oXSBf6Q@mail.gmail.com>
Subject: Re: [PATCH] util: fix to get configuration macros in util/mmap-alloc.c
To: "Liu, Jingqi" <jingqi.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 00:43, Liu, Jingqi <jingqi.liu@intel.com> wrote:
> 1) If '#include <linux/mman.h>' first then '#include qemu/osdep.h', it
> should be fine.
>
> 2) Peter mentioned osdep.h should go first.
>
> It will  cause redefinitions of other MAP_* macros after '#include
> <linux/mman.h>'.
>
> This is where the conflict lies.

osdep.h first, always. Other uses of linux-headers headers
have presumably already dealt with this issue...

thanks
-- PMM

