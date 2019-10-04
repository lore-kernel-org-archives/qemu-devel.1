Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD23C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5382084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoGDbG//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5382084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGSkh-0001BC-CG
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 14:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iGSaS-0005Dw-Gp
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iGSaR-0004Zx-Eh
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:45:56 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iGSaQ-0004Ua-Fd; Fri, 04 Oct 2019 14:45:55 -0400
Received: by mail-oi1-x244.google.com with SMTP id w6so6602196oie.11;
 Fri, 04 Oct 2019 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k8d1E5mr2/5/aLpC4Q9/O9VsIHNrRvEIdRReSf/BG7o=;
 b=JoGDbG//2xInBL3c4S7FV9tUIYrq0uREr7D2pgmrRtaRZPrFEbls1IMjf7X1W1DYng
 JO1VSN35ItTYIkj5ZnFO9QIOGNgz33LPkYjsvxvezrCwCy+508HcxLdwIfahzquahTGX
 JWf90yGIwUwMiHo9HEffRUXP12rRfW77NrEkszCvySZFLwLnVfhM8TNNM79LjaU7icfn
 c+8vkr0G9/3Joa4dMJ/WWmX51NYGCRLKWCdChp1wuvreh+n4GnU5/os3bpQa5HI83hIb
 VeSXoPV2pZy7zHyYOLu1beGwMfPPWW5ydhBBBd+0p/eUjA2IZASmITjxlokRwwbU6xCu
 Z2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k8d1E5mr2/5/aLpC4Q9/O9VsIHNrRvEIdRReSf/BG7o=;
 b=Dz61E226rSR7d/kAeSnc0esIq12xqrec3DhOfqgGLQuzNVa1kAIMRQU2h+XLPh7hsU
 5P03jmN2jyVxOiLr2P2AAq9CEmYUuELLDOi15POZkz+8skLTRrgfkvQZf/vwfHyuLWhW
 fPdqSDB34OVfUkzqLD2xDOl8RY9wLiQ8mwms0MvxtQkkAIvAfmtyiC3yyCV3rMVyPSVQ
 mlcpqCaehdN/DtmOLJyObXpHFLXgajmyS9r7+tu4v24p6145q0R0yEkX0CnbBjhQG2OJ
 UD6TokVwkAYWKfYVNEt+hPddfDtl/2WJ+5IrFLyTnOuSvTpkZYT/0BHTq1Myfp/b7zOq
 3t2g==
X-Gm-Message-State: APjAAAU2l7RW98Vvd20P59TtrDt/ieI1ikG0ZnqBNMMzA+KdksPqEC6l
 T6qbchdD5r2tCFwX6ANEEZnNR0EfwZEyszO+g7w=
X-Google-Smtp-Source: APXvYqzzNRWyMZBoQ3SsxgB98/hh3mUptlqwsyyneQ/Qw02SDHpWMpobwzp+d4h79Tug1auA+iCctIO2oGvAKn82NXQ=
X-Received: by 2002:aca:f002:: with SMTP id o2mr8444266oih.62.1570214744577;
 Fri, 04 Oct 2019 11:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <1570196639-7025-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1570196639-7025-2-git-send-email-stefan.brankovic@rt-rk.com>
In-Reply-To: <1570196639-7025-2-git-send-email-stefan.brankovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 4 Oct 2019 20:45:33 +0200
Message-ID: <CAL1e-=ih85afhTMGU8ig9GhXWFGNc3zL95L1mgxeujmWO56O-Q@mail.gmail.com>
Subject: Re: [PATCH v2] target/ppc: Fix for optimized vsl/vsr instructions
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>
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
Cc: richard.hendreson@linaro.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:ppc4xx" <qemu-ppc@nongnu.org>, "Paul A. Clarke" <pc@us.ibm.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Reported-by: Paul Clark <pc@us.ibm.com>

Stefan,

Paul's full name is Paul A. Clarke.

Thanks for the fix!

Aleksandar

