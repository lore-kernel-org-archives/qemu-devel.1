Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1B9C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7512B206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2+62V3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7512B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoq7-0007vi-7m
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHonp-0006G8-1N
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHonn-0007pR-Mu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:41:20 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHonm-0007j1-G0
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:41:19 -0400
Received: by mail-oi1-x244.google.com with SMTP id w6so14577430oie.11
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F4VpDAVVA0BdbVXXiCokr3TC1MIF05PM5d0Fz4YQTxU=;
 b=F2+62V3YWK8lR+PbUFikW5KJX4gyNt7Ny7LHt59MdPMSyLzupjZj6zcd/vkO4RuqMp
 t88rizSfaS0Z6TWdXRPSB/RHHNqLrC72asSStJHFo0Ic8mAUwY4L5rJHOxLsQAXj3yFk
 N/qUXwTh2bK2vG53OwVTaCP0USeXMSj4L1qBPDB1gmBElIQnwNHJOpHEOYn3IWXhnLre
 u6s7Se03gm4tVeFIfISAdVGCq1o/B3iwVaIFa64qxhITSPyEACeCZFkhl1T7lZ38g/qe
 0kv6Krr/kz+0/4wPgrzFrzPyi/10US01yeOanNaTdPowoOZ3Xn9xhljAXfiwPBQF9N4v
 xiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F4VpDAVVA0BdbVXXiCokr3TC1MIF05PM5d0Fz4YQTxU=;
 b=unmDW7ULr+iACab9BTljjTwZe7pUdXFpwBOR//0Pf8n/A/PmHKRjv2eKqF/8ayMJ8t
 aSjSrNqF+xCeRKtmF4XZ2wjm6+8crHqhXrIiqxa/jHdSmoCydPOOdyEsSApM/TBJbRM2
 mgpc0YHQlZuCQhmPlMLi2CSTzXG9SUugz6Tq6EfH4AeDhbGDPgt2JJByWNZ3YvwhJHdx
 pAPrJCAf53jWcMALh1DcZ9TF8GYKocHX3PTEslbeiJEGiKvDFj6Ls3rGHNPpKnj1X4zJ
 GQyA2NEMi4tnGS/c3KSEV+c2UWAIVXJICOHnbt4u/ylSor8b++bgZXPePGIOMLkEXib9
 SCGA==
X-Gm-Message-State: APjAAAU7kVO3tqw74Sd+QpmOz4CrL4Suq/FHgGBnAGc+Tu6TxFmlsHGc
 sBsXf+ddbhImlvfsw11sOu/BVMc8wEYWjCdDidqysg==
X-Google-Smtp-Source: APXvYqwKsR/yv5OUIoFls/2aqqiUr3Zg70ke6psJVhdjMYzFbUoIirFeVoJLzzpDcxgO2+duzHaVZ9OyiXBqxwh4NVA=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr3781638oih.170.1570538475123; 
 Tue, 08 Oct 2019 05:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191008082815.8267-1-thuth@redhat.com>
 <CAL1e-=gYkhM99Ee0LxZJ5dCjeEdC08G4_Tm3WCZpCSWvJ=b26Q@mail.gmail.com>
 <4bfea125-eb63-f4a2-bca0-bce462f73d89@redhat.com>
In-Reply-To: <4bfea125-eb63-f4a2-bca0-bce462f73d89@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2019 13:41:04 +0100
Message-ID: <CAFEAcA_+V7SNsxPSgsd04s8f7PnP3qdyXMp6NvS2inHjE08pJw@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Remove generated files when doing
 'distclean' (and 'clean')
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Oct 2019 at 13:37, Thomas Huth <thuth@redhat.com> wrote:
>
> On 08/10/2019 14.18, Aleksandar Markovic wrote:
> > If I remember well, QAPI-related c files are generated while doing
> > 'make'. If that is true, these files should be deleted by 'make clean',
> > shouldn't they?
>
> I think that's a philosophical question. Should "make clean" delete all
> files that have been generated by a Makefile (i.e. not by "configure"),
> or rather mainly the binary files?

https://www.gnu.org/software/automake/manual/html_node/Clean.html

The autoconf manual suggests some heuristics:
 - If make built it, and it is commonly something that one would want
   to rebuild (for instance, a .o file), then mostlyclean should delete it.
 - Otherwise, if make built it, then clean should delete it.
 - If configure built it, then distclean should delete it.
 - If the maintainer built it (for instance, a .info file), then
   maintainer-clean should delete it. However maintainer-clean should
   not delete anything that needs to exist in order to run
'./configure && make'.

Not all of that applies for QEMU, but it seems like a reasonable
set of ideas.

thanks
-- PMM

