Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3A9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E9F21872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoFZlt9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E9F21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO3Gl-0002ty-Qw
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO2rU-0004X0-AW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO2rT-0006iY-8B
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:54:52 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO2rT-0006iN-40
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:54:51 -0400
Received: by mail-oi1-x244.google.com with SMTP id b25so2048950oib.7
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MwMm8mGLLLuejez2hldv+kl+dc2ONZykUPcOiO33cWU=;
 b=ZoFZlt9pU7e/z4dK+sIvOhZFyHXA/RNfct9r9+sky9Cfop87Z3alnwnWIZMBn36XV8
 nQfJPA6S07yi8xrf0pzs3uIsYWoVPnf+ybAa0mv7ZSWhPg+YckLwwfmebdjE9vZBpgLP
 1ZPxpM9VIyXkjqOfxE9V5Uz1YwBY6NhGgU4exPvyFgGiMYvksVW2YYnP4rZi9Pl1y9lF
 kgDJ3js32IwY2s1d5Dl5mi8cLNXAidqU0esTIObUBueN0KFhhcCev2UI8R1ppIqqZEXJ
 x6xPqk8JIAWXLZNBIa4B8VJnx2FfihOCggWyQ+TnPkl49z7zfYz6l9owOovoLtfLtZmr
 81yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MwMm8mGLLLuejez2hldv+kl+dc2ONZykUPcOiO33cWU=;
 b=Ne2uRYGTge0VedgfLfRJ1wIwvl0G5sCwzp/JJ83LYuflA1+SdIPGk1oLD05V81QGT1
 UEOrY5SuhM+3OPXKiuJSDut1wmpWQ0XkEAtSpxB4MUtXczblWyVLCYk8mWfU/xgmSF2s
 469VHsrS9ZMVI1+k3nVa0qT/ftsBJkTCN/rn2YSzFFTQnMoHdur71Evgwxo38O43h5Ch
 cyUcPf/1j1uLSaJJoFAHPypjCjVcxvkKgF3d+uSPdUZGF+uIcqin3OqsmnsZTHCnZClK
 eL2p06z5uXmBt7ZaraFeLGZlRC2WJuBzyQf40ux5Y1X2P7Tou/n0sJFOScoEOPueRPob
 8sUg==
X-Gm-Message-State: APjAAAX6y9sqarCc+ngDwoKCLaJRczI3IJu/sBHxoqsYDbRzxnUAx6jx
 q2U1OzO4soOeFOnhqMZefz78qT+IdzimaOOt4QE1RQ==
X-Google-Smtp-Source: APXvYqzx/ggp+eWjhaOhyoAjHu14hpWAJ9egCTi3i6VN6Bc4SXf2YRM0OEpl0MFI+uws29IxUUMTXDj+3OlF4nxa3/M=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr3741003oia.48.1572022490509; 
 Fri, 25 Oct 2019 09:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191025155848.17362-1-peter.maydell@linaro.org>
 <20191025155848.17362-2-peter.maydell@linaro.org> <87imoclqh7.fsf@linaro.org>
In-Reply-To: <87imoclqh7.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 17:54:39 +0100
Message-ID: <CAFEAcA_pLOh+XGzM7bxDLdTV96v7x=OquRpdOhvsQAJ9X4tynA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tcg/aarch64/tcg-target.opc.h: Add copyright/license
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 17:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Add the copyright/license boilerplate for target/aarch64/tcg-target.opc=
.h.
> > This file has only had two commits: 14e4c1e2355473ccb29
> > and 79525dfd08262d8, both by Linaro engineers.
>
> Both in fact by the same Linaro engineer - I only reviewed them.

Oops, yes, I misread the git commit logs.

thanks
-- PMM

