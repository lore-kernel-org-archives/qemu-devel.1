Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9217EC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E70421BF6
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSMAvPJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E70421BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprRX-0002ss-NC
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hprRM-0002Tn-VV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hprRM-0001IE-2o
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:50:36 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hprRL-0001Hr-SB
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:50:36 -0400
Received: by mail-oi1-x242.google.com with SMTP id m206so31836856oib.12
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7G2rW9mX4JjSjfDb2TZc8qUcmgSFHaKc79K3qyw+0II=;
 b=cSMAvPJK8Xd0ud+MoFM5JlZajzkgxmfcu3lkMze464zPOAWOn2vVffyG8ACWS0I3st
 T1GaJEVn6cEVz4izZD/u1tXqgvKglz0XxbIL2VMOMj+uCoQVk7ATb9/eL4WaYc2UzHJk
 H+SyExmHf1t2up175YrgC6CTNpGRpWwUFFWwr4RAl4R4r/qquGxNxDS3AdnHMa2Mi4yU
 5N0+upFgbuPnNn30kwn+Tfic12SkDaU7SbEUZNG/Poi/BVba0wVbKgbyyO0ta2Pip3Pg
 wkKY00y3TkrLF83qm60RJAc2xRGlydLo00gUE+ln9pil1foNIJQFhXt7QO2EZ3j+qVhT
 Kqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7G2rW9mX4JjSjfDb2TZc8qUcmgSFHaKc79K3qyw+0II=;
 b=aQ78WfsIBiatKhqZQCH7hrkQs0LWmb8hpQA8MyR+/EXIxM9hPgFiDi2e0I720KJGLR
 AekasLdrfcE1yd3SCyOfRWaY0Xa7F3Q14qEAX/eUrTmpGSjJ3JhGZvw/6QxArV78W2wE
 dj1TMZ+6x5cauiD3QsuVf7yIA8iiwa8MuZOweS0ifaGSqWNyh2xKte1Xkg6P5hlwIAOU
 JGdqdUfDHytTPccUSELhis0oLPNG45h5s0/8+pN58gd9m6996qQWaAbpQvron7IiP23v
 g1YekSapVtzsROe983TTsoVq4DNpLOcQCBnCV8b0UdWEJzJU2VqRRQIE8OSvrR+vdjQc
 dFig==
X-Gm-Message-State: APjAAAWTxlpmF8dD54o+FByv2240LifFIJCuiHIgDxyc2rNcfI2s4PVS
 VvMXG06J/DuMezlieAyrZeERKVoFvv2L+auL92s4vg==
X-Google-Smtp-Source: APXvYqw+Kx27etY1RlAe5+yfp4QX2pKYgabj9jmd1QJ4b5QshHR7Mj3HGQKXdEsPf0ZA66K4CEf4jKLGCJUh3n/B3m4=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr33546394oib.146.1563875434840; 
 Tue, 23 Jul 2019 02:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190723090718.14590-1-sgarzare@redhat.com>
 <20190723090718.14590-2-sgarzare@redhat.com>
 <CAFEAcA_KspUxk75hR4YV444tj8-bQKOJ_4eq+aPD-idZ12Lzwg@mail.gmail.com>
 <20190723094241.7znxmk3wa6gti6tr@steredhat>
In-Reply-To: <20190723094241.7znxmk3wa6gti6tr@steredhat>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 10:50:24 +0100
Message-ID: <CAFEAcA90Atw2KC-9zc5fM8oY8ikPDms1+UKtaj=YJcpq48PMSg@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 1/2] elf-ops.h: Map into memory the ELF to
 load
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jul 2019 at 10:42, Stefano Garzarella <sgarzare@redhat.com> wrote:
> Reading the 'g_mapped_file_new_from_fd()' docs [1]:
> "If writable is TRUE, the mapped buffer may be modified, otherwise it is an
> error to modify the mapped buffer. Modifications to the buffer are not visible
> to other processes mapping the same file, and are not written back to the file."
>
> I don't know what "error" means, but reading the second part I thought
> the changes in that case were only visible at the current process.

Ah, I misread the docs here (and thought the following paragraph
which talks about changes to the underlying file becoming visible
to the mapping process was talking about changes in the mapping
process becoming visible to the file).

So I think the answer is that we do want to pass writable=true.

Looking at the implementation, we always use mmap()'s MAP_PRIVATE,
so we get a copy-on-write mapping that doesn't change the underlying
file. The effect of the 'writable' flag is that we use PROT_READ|PROT_WRITE,
so if we don't pass writable=true we're liable to get a segfault.

thanks
-- PMM

