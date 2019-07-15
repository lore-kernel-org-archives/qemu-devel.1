Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB17C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF54121530
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmI7jgqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF54121530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1Ly-0003kg-NW
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53188)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1Le-0002oa-7e
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1Ld-0001i5-3S
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:48:58 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1Lc-0001e7-Sg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:48:57 -0400
Received: by mail-oi1-x242.google.com with SMTP id u15so12705123oiv.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KhkyjNmkbBt2TNHskueMzItP+CrD8zBwY2BmKGOgg24=;
 b=lmI7jgqwe/klpYvHZkRxhikM1BoM6wJfMh+JrykXLTcrQbog2aDqRwp25mzdsRqDig
 qEAagZuqq1sGl+epF5tcN+vcB+pIyfRLI269AvgeAsIOu+4UvMu76dVtldMfmQBgVoMo
 +vOXZq1n8y/eh70MGI83416zfyEhbBvY8cZii5YzXTapEakgID/bS3K/zM8jh5AzTPeS
 bPlYnbBpPe7UuYYfE/h7djLWag761E1+LpGxPrSUrxycnfkKP0eZ4tPqhL/sK4vAGqrF
 b5Td2iJ2+OhsIb4sjS/XYvJLQuMXNaLqohdbIRIoaidrSpkESo0eM7hEOkpMyYevJwpg
 grQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KhkyjNmkbBt2TNHskueMzItP+CrD8zBwY2BmKGOgg24=;
 b=Jr5jOl2ip1bMQ1tq0tu1Al05JOG0ojRgCXRqxxgWQ4V/Db4WlHDuaRAwSuBldG5u0n
 C/Fgs6YZsMl1go2jimsu/OwX5+DmkaSGcNGsagFQ9T4BcpLy4UypuRNzAcaoVioUGu3R
 FO3lC2jZ0ttl/Jinr+i2ZdGakR6/HoEmV7jNW1Cf5DZ0f4TwMNTtI/IU56BvD0gezVmk
 Ejw/IZCL+0k0Ws+pYV0ffoGJIRWZ0kDun9eoK7IY4p53z6s7ugsdmVaqQU8njUZiutVm
 gGqsisC8X4+YrCmTjLGy3k9sbF/uJumD3PKo9l5R4ectn0+GHcJNj1KQTZRCNuNSVhg7
 qQEw==
X-Gm-Message-State: APjAAAUDB0UmcLVAGT+rGazexLjYJAsOo97rJ2k5/y6sJ9sCqmyz8j4P
 HLmMyIjySbLCX1gGsawURg5Rq1+ynTWM1cHQNEOgpw==
X-Google-Smtp-Source: APXvYqxeCSv7UUCXqxX+f+jUbGXXh8dmymO3S+I1HW0faMk34f4/TcgmuVMDIIt3tGibA09eGd/lfrl/Am80fyL7O5Y=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr12743117oie.48.1563198533124; 
 Mon, 15 Jul 2019 06:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190712143207.4214-1-quintela@redhat.com>
 <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
 <CAFEAcA9ncjtGdc8CZOJBDBRtzEU8oL7YicVg5PtyiiO2O4z51w@mail.gmail.com>
 <87zhlf76pk.fsf@trasno.org>
In-Reply-To: <87zhlf76pk.fsf@trasno.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 14:48:42 +0100
Message-ID: <CAFEAcA_9tVQht7bp9_yrFEhQ74ye6LBNjEYK_nftCWsKMrOohw@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019 at 14:44, Juan Quintela <quintela@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > On Fri, 12 Jul 2019 at 17:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> Still fails on aarch32 host, I'm afraid:
>
> Hi
>
> dropping the multifd test patch from now.  For "some" reason, having a
> packed struct and 32bits is getting ugly, not sure yet _why_.

IMHO 'packed' structs are usually a bad idea. They have a bunch
of behaviours you may not be expecting (for instance they're
also not naturally aligned, and arrays of them won't be the
size you expect).

thanks
-- PMM

