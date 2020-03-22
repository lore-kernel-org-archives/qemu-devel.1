Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C397EC54FD0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F97A20735
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QF++NsVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F97A20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG7zb-0001kD-MF
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 17:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jG7yv-0001E5-6o
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jG7yu-0002FO-7x
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:18:05 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:37908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jG7yt-0002Eq-Qj
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:18:04 -0400
Received: by mail-ot1-x32b.google.com with SMTP id t28so11470926ott.5
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K/p3eVrG75FIEZPGNTu0fE5Le474Hr8k/amo72Vcex8=;
 b=QF++NsVhxtSF17A1nm7fgQzACAsW3JgL4AsKFt9nBN3wLT4dEjPUxhBJYOubr6iTRC
 mR6NeJNdXj3xY8Qc0ipGo918tbAWwByor5JLmdPoaZeqkoU/NZnQ3nHCXmGBNlWZQe74
 45oWfJFB6WIivpfiPG2hFhPTnzbRtE8EmYQutr32NjWtM14muPvsMCYVA13TPJgWmF/J
 1Q8iNDbY6biZRJPTwBiqdkDjlKPxJPCowajWLYw1Zyk93mU3luWrcXd+pdQSYKBfib6B
 cWj5SWs/RFn55/3ASyYufypmnaXFajFNQWptZKBx8H2N+p6xfqGnYv6oZPRoSGbFi/Ij
 x1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K/p3eVrG75FIEZPGNTu0fE5Le474Hr8k/amo72Vcex8=;
 b=iRHGaS42HTmf6o9vqX9tSRX9jZJ2LXD3gTMcVsr9p1i7uBK68YzLCO3khiCrh4olHA
 7MJ79E5gPedKNFUByhNEeQ0ijbJTZOjwSSRFOgi3/qOlHmKMQ9gol0rrosON7kSjwnHm
 6v9pe6yX9O8ycQUrFJQn0sHAO9ROZtXlegYX0qesFwpJ2b27FygrTISgoePxZvZnw/oG
 ccThOv4w+Iet2Z3Ank6UXuHzyL+xDrvGxYLEB760xEDrV66GyfJVPfCa+VPZzXgCHQ2O
 Dg4Bf6W0vCnrvIq7ZJ5FShESqhMjOALf3UmDj5mKlmzO9OTheqV3+tyMP2q++NNXWJrN
 TCFg==
X-Gm-Message-State: ANhLgQ2JpqN5gOrffLIf/wAgENw3t+Vd6hV54JcTXa16suYRjWbCOkQM
 8ggHmSXS2JDvOPr6Ot+QDTL6kgvLLuaGyNwwtoXOMA==
X-Google-Smtp-Source: ADFU+vv843ADn5R6slBZO72jmVGk/oxczdFQLtklESmJBeCWW6M7d8K1nSYrn+PlkzglvYNdwtroePfyZq444rC7qjE=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr14750567ota.221.1584911882700; 
 Sun, 22 Mar 2020 14:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200312164459.25924-1-peter.maydell@linaro.org>
 <20200312164459.25924-23-peter.maydell@linaro.org>
 <CAFEAcA8zWZO_eqQRq+=NRKfohmRUPOkE_4uHBDRbu-tO=mxB=w@mail.gmail.com>
 <CAPan3WpS=ixityrUsDUqpuuzWo3JYLFRM+tJXmVdGwaom9nLbg@mail.gmail.com>
In-Reply-To: <CAPan3WpS=ixityrUsDUqpuuzWo3JYLFRM+tJXmVdGwaom9nLbg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Mar 2020 21:17:50 +0000
Message-ID: <CAFEAcA8TkEx+tPNa_no7oC4fDQ0QhTe0sgvwwzYR8tfofiUyhw@mail.gmail.com>
Subject: Re: [PULL 22/36] hw/arm/allwinner-h3: add SDRAM controller device
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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

On Sun, 22 Mar 2020 at 20:23, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
> On Fri, Mar 20, 2020 at 4:46 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>> In this calculation we do the multiply as a signed 32-bit operation,
>> which then gets sign-extended to 64 bits for the addition; that
>> means that if the multiply result is greater than 0x7fffffff then
>> the upper bits of the result will all be 1s. Is this a "can't happen"
>> situation, or should we be using "1ULL" to force a 64-bit multiply?

> However in theory, the Control register can indeed be written with larger page_size values.
> So to be safe, I'll just make a small patch to replace the 1 with 1UL, thanks!

"1ULL", not "1UL". The former guarantees you a 64-bit constant,
the latter does not: it depends on the size of 'long' on the host.
(Usually using "UL" suffixes in QEMU is a bug, because either 32
bits was fine, in which case "U" or no suffix would have done,
or you really needed 64 bits, in which case you need "ULL". There
are some exceptions where the code really is working with "long"
values.)

thanks
-- PMM

