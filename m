Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BE8C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F9F2072C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIlo52aG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F9F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFk6p-0000w1-8J
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 15:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFk63-0000K7-ON
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFk62-0005Ko-Th
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:47:51 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:44149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFk62-0005KY-LC
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:47:50 -0400
Received: by mail-ot1-x32c.google.com with SMTP id a49so9464100otc.11
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X+2sTSl6/HGgz0AttJNlhj5F4o3+tmJ8IPqA52c9ei8=;
 b=XIlo52aGC0iYlE52AOU1fW6znEd9WpfKBePPI3L3g1iIitutYkySeL8GlB0vLOxSuR
 gZv+wdvH6ikRwssfCyr81Wj0/YHkj0fK2zN2Lx00njUljgT84MM7m/RDILu59JZiVgLe
 oUm4JmHEs9iHqJ/8EIf+GO5oGBQGgzS9BLQ2Oi9YITtzuxt+TWxMkLofK2lg2cMNKmeA
 nsq1P28bEbj3tVMPlmK4IN7OcGxP20s2qINVdYnlC4/f6RJWeH+F+VYFntInZ4wpOFdF
 HeiyAUgkAe0aSzlE66mwCvTy3Wb2HjxEIFdzgfXxt7Wu0tzb3syNg54OhufUAaDPPnjJ
 JP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X+2sTSl6/HGgz0AttJNlhj5F4o3+tmJ8IPqA52c9ei8=;
 b=bv+aXX0l97yEtWcziV1/E608IDsbX10L9HzjThk/ulP5W3jW5pIIT4zZ2GIy+GsJ1H
 k2fRTeH3xHRLlnX7fcT3BkWp8e+PpTlzd3sHreWi121kUbBVFqzyaCxeXw2F5xE0ueBa
 HBjI+HfvAQdSKH5hWswMVTXNhVbNMs5rAkWv0EMYikfrYh7kGHZ1MFiN8HwLud06fbUq
 uEjUS+I2+HjMoO5IQXGnZJlxSo7NGChknn81Oxki4rqL8bD6HOXMPEDbGwOc7DLumleg
 Y2UXMs0grq9q9PAiuQnL1xdzwaHcHwu8jVy+MqAwb18LC2OMxHq2R7JlFlmkskU5kEzE
 opvA==
X-Gm-Message-State: ANhLgQ2f32iqJb5LofaurnqJtMvrmSlHemGDpaoro7bnNKlaXWqedlzW
 95p3nRyZhOtLHZqkgFTtiFFeTFbNEKJZoXSWwNbasyV8WlM=
X-Google-Smtp-Source: ADFU+vud3bSS+vvAABzU8Ydp3EyoGsb3QFClX68g9uZeqhbd095vKDi/vBUSNNkXTw7zrYlJdrg/+1/0TY7cbueufLw=
X-Received: by 2002:a05:6830:20c8:: with SMTP id
 z8mr12123083otq.135.1584820069752; 
 Sat, 21 Mar 2020 12:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200312164459.25924-1-peter.maydell@linaro.org>
 <20200312164459.25924-22-peter.maydell@linaro.org>
 <CAFEAcA-F85aJ4yigDdEMd4=kAEaPV+f4zn9cuyhyoO-xhEcAng@mail.gmail.com>
 <CAPan3WrW=YwnjiGnhQ1Wdyj7jwcsLXiVy0eQv-K_LhRfAZvyQg@mail.gmail.com>
In-Reply-To: <CAPan3WrW=YwnjiGnhQ1Wdyj7jwcsLXiVy0eQv-K_LhRfAZvyQg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Mar 2020 19:47:37 +0000
Message-ID: <CAFEAcA_+UPTtsVhgnXY1bo1JFaL=rd=caxWXkd7OFVXyXipbVA@mail.gmail.com>
Subject: Re: [PULL 21/36] hw/arm/allwinner-h3: add Boot ROM support
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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

On Sat, 21 Mar 2020 at 17:17, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
> By the way, I do not have the coverity tool unfortunately. So I can't really check myself
> if any of the other Allwinner H3 files also have warnings that can be fixed..
> But if coverity finds more, just let me know, and I'll look into it.

Yeah, we only have Coverity as an online tool, so it
just runs once code gets into master, and then we
fix stuff after the fact. Either I or somebody else
will usually go through the reported new issues when
we get a new run and alert relevant people.

thanks
-- PMM

