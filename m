Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFC7C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B632087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="seLRh/vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B632087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59835 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQGk-0005f0-Ql
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsQFm-0004MR-ES
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsQFl-0006zD-I5
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:25:14 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsQFl-0006yY-9r
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:25:13 -0400
Received: by mail-ot1-x341.google.com with SMTP id x21so398766otq.12
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 04:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F3oDi/Zmrw26OuLdHHb6A44/8O2jhczV1bJOF/8qPXI=;
 b=seLRh/vGzNNneByODUJEF49lMB33bs3N7QjW6DW/+Xf+DFwLPf32wZuy7SHCepCQL8
 /Tk7n6PRMbTuOGbXWW0px52/xKBW51qzJbrfJg13tlRfKLdIVr+D7r3ZKS/PMMmvyMUL
 PBH+sjNHSAvbQV/WhmN3HrieBc0cU9gcDYt5BkseB+TUtaFv7gKzjTf0Zs2jmqubP8Ef
 elHGzOY6kGopcrOad6+ilhMB1E4jKVU+4dWSnmdV58WUPI2vnpVLZBumZJ2PN1XRTHZt
 u9Qv5u5RFEigMG7KWFAjCcoX13co6ujZsC9o3HN+TUq22Xp52cVyzNnMUDga9wczTDr+
 e+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F3oDi/Zmrw26OuLdHHb6A44/8O2jhczV1bJOF/8qPXI=;
 b=Xs8PnTu8LKbTh+/RE/w+PK5xJ5dFLOI19/xtX9aOGS2kXW09r13wBe1CfM4feIYC0v
 zzlAsnOA2NyLnUZzF97QjcWA9QURxQAzxS18/5AG9CNW4Jb5kpt8ks2rhyXCOSXVFF3q
 y0TnZOpdy32C9hrZcP2/IO+w1TaWda3U9R4mLT4exKB+JVZJwSDLXxxQzxL6dhMlRlOB
 vOpnMJ1zp6uO9zARgSwx5rOHYbIbnThOGwduqzFrgkkxtOAno9KxZEZAtFLD6zNUKDiD
 fF6XyE2RMT36TqRFsK+5bUkn0alL4/5N3CTJwsJvmi1/XmfsdwlJnevbMGhsH54s40hN
 ZDmA==
X-Gm-Message-State: APjAAAUL7NF50A/T21HzIXCs2MepdCvIZPb9Gw5WeRM9GfJip2TAPCxT
 BC1HORH8otoWbTTshFxyOOmmfpGvz9GiDuLgohFPTNCn
X-Google-Smtp-Source: APXvYqyE3+HH6v7c+9F5GeB8tXFS5K5nmMWCnLVdwZIaHUf3R2hxydTDk1wfpH4zApAtM+FdF7/jBckw2IaDJUyUqHw=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr26924575oti.91.1564485912245; 
 Tue, 30 Jul 2019 04:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190714134028.315-1-laurent@vivier.eu>
 <20190714134028.315-2-laurent@vivier.eu>
 <1F76A574-2A97-4070-8EE0-0EE83A4241E9@physik.fu-berlin.de>
 <13f6aa89-e3f3-61e8-fa05-cde20b55daa0@vivier.eu>
In-Reply-To: <13f6aa89-e3f3-61e8-fa05-cde20b55daa0@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 12:25:01 +0100
Message-ID: <CAFEAcA9AM=uJ0evZgthd9kebhGMYNzG_HKz=VYRCMmDj4D_=zw@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: manage binfmt-misc
 preserve-arg[0] flag
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jul 2019 at 11:07, Laurent Vivier <laurent@vivier.eu> wrote:
> QEMU is not able to detect if it has been started by binfmt_misc with
> the preserve-arg[0] enabled or not, so it can't adapt the args analysis
> to get the correct list.

If the kernel provided a more useful interface (for instance
telling us what it was doing via the ELF auxv so we knew how
to interpret the command line arguments) this would help.
Of course you still have to wait until that kernel change actually
gets into the hands of users...

thanks
-- PMM

