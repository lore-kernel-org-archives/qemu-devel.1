Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238E5C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15DA20B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7CtjVII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15DA20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htCFk-0008G5-4r
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 10:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56455)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htCDx-0007Jm-Dp
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htCDw-00059Z-D6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:38:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htCDw-00058c-2X
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:38:32 -0400
Received: by mail-oi1-x243.google.com with SMTP id v186so54111475oie.5
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sd+kBTIn1vxtV46hDUciCkeOpwmQ7MLQs/Y6E4lbOlk=;
 b=d7CtjVIIujX5QmgM5Ti0tRBBdy0ZQzCYhliixl+F16Pzx/MQ/RmKMu7Qf4ySFCD6P3
 2uffV2HASIJJ99YdpouXvfipmgwhYhQOn7M7h7wrOFBMOOo9y3wc9we19BwbiEO9B3jn
 O5KNm9Mh5Vir9sOso1xlz3/BrdTq6KnMmLfIY+lvAZPSslH3L79yUsgyu8sSnGe1lfns
 xDcDX+GkYkD+2zDBVaGDtrOe/QQtZax7zjgBjZY/KY4ILXO9WYe7ZOtUkf7HF/lBNNHh
 pLZWH6s9lmfGOINGYem7TeUlijjTcLgpeHgeHMs/H8R3B46AQmUKitsyPf7daCySu65U
 VVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sd+kBTIn1vxtV46hDUciCkeOpwmQ7MLQs/Y6E4lbOlk=;
 b=LC9udbfUH6lFbR05/vV1NTw3EUsQyd6Zq61KXC6E2CUqPINNMbSPuSDAmhxerl8TDv
 Kj+jyJ7RSi+lnmPt4UA9DOobEmeEPFtvWM8w513qdLjnwMVt6Ue2QREutW1mSEzi+v4S
 yeYBHxYZ3pgWM9punXyW8zOcU19hNrWnYfe+zOrKGWhKA0ZNNnl1o3Ku+XJycE3sG7kM
 erw4gMdEpN+f0Z8acTcUV1r8iGUV/lddGngPaxlhTtl9cx0X7/6qS3mNA1EIGZ+Wel/v
 VuGrEIrFwS7N/Wo+RqSComT0ZCi3P1BEd0HVhGG1nzobMqqVtO5yX8GHXl03PMtOFVfM
 YF/w==
X-Gm-Message-State: APjAAAU8/Us6qwxd/2qAo5HC12z2VNuW1R9TFpDzJ9pFO+aWmK479qmK
 TPoqBzypF5fii9GjmQNTYdAH/XvzNvIv3077wnZN2A==
X-Google-Smtp-Source: APXvYqzEvIY2nh0q0cKiIHdSiiMs6cqXWwr34dME9fJZdqYM9hLJKBGevw35/foXDbD/d/dqnkXolnBCX8h0qYWZOXM=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr61800073oij.98.1564670309823; 
 Thu, 01 Aug 2019 07:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190801105742.20036-1-peter.maydell@linaro.org>
 <af347b17-b524-1075-d462-2b0e6eef41a5@greensocs.com>
In-Reply-To: <af347b17-b524-1075-d462-2b0e6eef41a5@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Aug 2019 15:38:18 +0100
Message-ID: <CAFEAcA87XdDJH5TO-AiDfSqudmwzuY0yoa0H60objxXp3Bh9LA@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/arm: Avoid bogus NSACR
 traps on M-profile without Security Extension
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Aug 2019 at 15:20, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
>
> On 8/1/19 12:57 PM, Peter Maydell wrote:
> > In Arm v8.0 M-profile CPUs without the Security Extension and also in
> > v7M CPUs, there is no NSACR register. However, the code we have to handle
> > the FPU does not always check whether the ARM_FEATURE_M_SECURITY bit
> > is set before testing whether env->v7m.nsacr permits access to the
> > FPU. This means that for a CPU with an FPU but without the Security
> > Extension we would always take a bogus fault when trying to stack
> > the FPU registers on an exception entry.
> >
> > We could fix this by adding extra feature bit checks for all uses,
> > but it is simpler to just make the internal value of nsacr 0x3ff
>
> s/0x3ff/0xcff/ I think, given you put 0xcff after and in the code

Yes, 0xcff is correct and the commit message is wrong. (Bits 8 and 9
of the NSACR are RES0 in all situations.)

thanks
-- PMM

