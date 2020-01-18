Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F20C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 20:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F9124690
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 20:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDtL90A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F9124690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isuJS-00074Q-80
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 15:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isuIX-0006Hh-N6
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:02:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isuIV-00084a-RT
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:02:21 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isuIV-00081b-LK
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:02:19 -0500
Received: by mail-oi1-x244.google.com with SMTP id c16so25335653oic.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 12:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wguOEihUd+VI4+Vn19DhpQntYTdCBaRAm/KrPXqPGF8=;
 b=CDtL90A9z7Nza0eqxTD4PMXXVVu/U8oTfgIteMallKEWYzHRRmfDDPH3nwtUg0Y0uV
 dOFhKZqbIWCxj5unRAkIlDevAtviacQnfnI4KMDj55IedUlG3phUkY2xeCraeSl1GenY
 7nDTrWnoozAk0jVjQCmh6bFFUMb5saA3vZJu4yPe67kyTGptdsNy3/3SoBVJojiAhl/3
 FzSIfdusNj9WOq2H8uSjlS06iiPhFIw9OVPBcgpdsosaaI0ocb+ddD58w+jMb3C9b2yo
 JmcYVtNudug1r7zeEtTFsmNf6CF9cQw88TWYkqGK6J2jccmcmte8L6sELv1MlzWOIoSe
 2A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wguOEihUd+VI4+Vn19DhpQntYTdCBaRAm/KrPXqPGF8=;
 b=p/FkNJox2o20XHSRCJqe7ocmiaHPVXoxZ4MDaWwHbIqQwOkPlpuNdMdZ81FLp5g2lO
 rBDhwUSPMOiEeXYXhy/tf0j058NA+LnJIi0G7nzhpYqw+dHVBoF08CHXkhosJvpy+IKV
 mn7i6+LhpyYV3Gmk+kxBljNUWSjehmwyiVTU8g9r45NgLlOOAbGCrdOBj3sdOwMZYiut
 hUwwI3nYsrYzD+tzko0c5RbmmHEk7XSRSARTuzFiLm7RZTk3ql2XLd3BDzO3UnHRD3u9
 LPJp1+nHTu8H10m+c9liH+zY9Rdh6XdvhmK2g9WmlFMBsYvdqcy8k7VBSJ9Ix1hRKRY1
 AS3Q==
X-Gm-Message-State: APjAAAVdeWC3YnclIDiBiDmPh3Q9xjahy8mkbIe+o98say8YuhiUYQjm
 ywGjrCNrH2w3A6DOBcsQQiX3ZOIgfSBvKrzIch8CCvGr4T8=
X-Google-Smtp-Source: APXvYqyIV/O1/VfhncEJrn9ytqf2wH1CACo59V156pO5ZXXV+AmK0I3lI+5oSL6ueou6HWJmwWgjeW9UgR+nLuW6xKs=
X-Received: by 2002:aca:f484:: with SMTP id s126mr7758304oih.48.1579377737376; 
 Sat, 18 Jan 2020 12:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-7-linux@roeck-us.net>
 <CAFEAcA_v98GcR06PWfm+=VnteQN_Q7iKK4wobAg6NrVSP1AyDg@mail.gmail.com>
 <20200117182939.GC13396@roeck-us.net>
 <CAFEAcA9zWeW1k-K7qVzCSOA70BmOCa9onT2z_QUQK-=0AJ+NjQ@mail.gmail.com>
 <7a9967c6-a370-9137-10fd-095113dd9852@roeck-us.net>
In-Reply-To: <7a9967c6-a370-9137-10fd-095113dd9852@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Jan 2020 20:02:06 +0000
Message-ID: <CAFEAcA99CgreMMeTH+nmnY+6OU2xY3A-db6MfBuU8i_MCA+y3w@mail.gmail.com>
Subject: Re: [PATCH 6/6] hw/arm/exynos4210: Connect serial port DMA busy
 signals with pl330
To: Guenter Roeck <linux@roeck-us.net>
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 Jan 2020 at 15:08, Guenter Roeck <linux@roeck-us.net> wrote:
> Do only the pointers have to be in Exynos4210State, or the entire
> data structures ? In the armsse code it looks like it is the complete
> data structures.

Either works. Embedding the entire data structure is the more
"modern" approach, but we don't generally go to the effort of
converting from the older style to the newer.

> Also, it seems to me that this means that not only pl330 and uart states
> are affected, but everything created with qdev_create(). If so, the entire
> file needs a serious rework, not just its pl330 / uart initialization.
> Am I missing something ?

Yeah, all that stuff is broken, but don't feel you need to fix it.
You just brought the pl330 pointers to my attention specifically
by declaring locals in this patch, at which point it's just
as easy to put those pointers in the state struct where they
should be.

thanks
-- PMM

