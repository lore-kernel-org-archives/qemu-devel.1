Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7066EC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384AD2086A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kb6TcA9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384AD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQEDk-0001bW-BL
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 12:54:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQECn-0001Da-Rf
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQECm-0007oC-FG
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:53:37 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:32979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQECm-0007nK-4f
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:53:36 -0400
Received: by mail-ot1-x336.google.com with SMTP id 66so12445605otq.0
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Pb1B8Av39ZPvBs2RJzpF2tUcLswjPPgnNSykVdts5UI=;
	b=kb6TcA9R7yAtnFT4DHiUVUsEVZJxi1zZO6w+g+Zs8Bkg1FCNOwznDUb/p2PZN1EvGw
	Fc6Jk5p6mbke9B1tlpamDVJlDvEc5t7DUrpByyDc1P3o0DNagEebNuU5BMcqU9gbgNEI
	Bje5SdZuKQwkYc8nq8yAY/UmgX35bCNzFdcnEb1wL9pZW3d1ESsMBQwWtNMb96CQc+ud
	azLUKKXDOJsFPV93DzIf/5bFN2Ic5f8iQ/eFr4PITMcWGSoaMqw5ru0ZAfQgl1BeL1G5
	eOfwb+eVXZDPq+2jBWxagulGvh3NDeF06HTy047/i+L3/ASiT9en+q3z8tpxMeavSXk3
	i03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Pb1B8Av39ZPvBs2RJzpF2tUcLswjPPgnNSykVdts5UI=;
	b=nYT5N6fGq+g8GltDZEPPROysF5wJzS1HX6lRp6sFgWdoSTLV2t5i9O0zfqiAPLwM8t
	957CPxW6QMav/c2zT8h62JRGQKPdNMxhiHd72F3pOMLz9WMMC75m+sL6D6IPTsnSA4HO
	7pnY0Uns5pApmvMLE0WOPWJlmfsS/W8ndOUppeMUhrmpYDPunHnBbyEmaVEXAlGD2yVH
	vF1yO86n1y6oZ4xET7D+tL1uSrK+T2uydot4xPvI/XvO5fa5y1zTEwpsz500tlrFyoag
	IczmpoF3GvejMQe9GLSfEiUZcL/YAv/K7K9ejAPIzFcptBZrIc7auBic9FshW6Xw6pYA
	FdCg==
X-Gm-Message-State: APjAAAXbwlzPfadLUF26JHgRx4nT8Ksj+3/YJak4XaWNDF8kI0Is93+G
	blDoUhdUS1Les8r2c19Ts0W007vNUZxYnx07JYR8Sw==
X-Google-Smtp-Source: APXvYqyxMvFxEGibW2cZgqey9s2dBMJffDIemHLQE5CkxmJkresExMPoWNYf4eExs4oFJs1Ej4JazSHLEhEZT1B3iOI=
X-Received: by 2002:a9d:2002:: with SMTP id n2mr14169212ota.363.1557766414804; 
	Mon, 13 May 2019 09:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190513082940.30295-1-thuth@redhat.com>
In-Reply-To: <20190513082940.30295-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 17:53:23 +0100
Message-ID: <CAFEAcA-1xskd=p5kWvW=nvm+8O0H=Y55LtQSynvW-1vXRPjdFg@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::336
Subject: Re: [Qemu-devel] [PULL v3 00/29] Kconfig for Arm
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 at 09:29, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-13
>
> for you to fetch changes up to 704d9892561d3b7ac4728296240a1b3ccfa2045a:
>
>   hw/arm: Remove hard-enablement of the remaining PCI devices (2019-05-13 09:36:32 +0200)
>
> ----------------------------------------------------------------
> Kconfig settings for the Arm machines
> (v3: Added the config-devices.mak.d patch to fix the dependencies)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

