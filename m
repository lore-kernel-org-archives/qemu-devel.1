Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BE7C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2CC2087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfmDq0rT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2CC2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLADK-0002O5-TU
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:37:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLA6R-000588-6f
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLA6Q-0006Rk-Cs
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:30:07 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLA6Q-0006RO-8L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:30:06 -0400
Received: by mail-ot1-x343.google.com with SMTP id w6so9374706otl.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=rVNgDqFtIwPC4jl9v/zGxM1VA6C5kpz++/BT4KoJZa0=;
	b=SfmDq0rTa+JK6NmWXNmiYs7l1eMyx/C3GvnX9Bay2pag2cBlqIh03Ke6XlTyvcYPRh
	gTEBTaKNYrt6ddeYUzrgP1OE3HMVweKGfrz0X9vaunTuCwo9qhhMJtkUvnQy4ZzNjVnR
	sO40ONZL1D+waaXs1cksrOzlrJMvzVpblHaIi7raWHa7iLWg679lLpl4xN5Utl5OSvcN
	BadoTxEepCIjMFQW09nJ35PSiYn3GahUWyzRxpIUPAM+QRiN+dR/qcF+UzMyH838+k7K
	VMF9ZtrxGF02X5Rdbd/qJkQxWMD1bMNFd5XhW/ePBKe5U9k3+MnsH+cAbWz2IDvjKCMq
	xfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=rVNgDqFtIwPC4jl9v/zGxM1VA6C5kpz++/BT4KoJZa0=;
	b=MPhQXRbQPWctOyoypsTOa/AsdlBhBVLmKUbp0pe+g4055yVR3VR1gHHt7nIR8GCCi9
	kVOZ/jvmxBMLfS8mFY1sZvqzImaJoEqFD4cITatnDnXYJNuk+iEtZDhMyYDv+2+fKT+n
	LCvu+qv3Fzu4SfgpAL7BwCKROfGaHKdCp5PW82fQeaECoUTAi3axxQvLwTmv7dXGrAYn
	8u1v3AcQagjLEhNhNejigOLCsigX9zmVRvbbPnVXylVtmx/xtBqDFHx2Lf1XO1LQeIdw
	Peiz/lKyEdlQZ1INAf8Dc4YRj/or1rYH7/oPbxCeMqWL3D7sgviRcLgeJJtmlv180vYw
	+kng==
X-Gm-Message-State: APjAAAXvbyaTJzUrfi/krNxKImz2PQWJLdlUHLOpR2cIL6rJ5p+8QfiF
	ReQkgqueGy6X1oZGuzVoITr1a5EgzESyqiX727CycQ==
X-Google-Smtp-Source: APXvYqxMqcf260wZKAqOL7YWJCuj/JQLUSX9jcx9LO2IaSq3COuUoITESfMo/XGRXl+3Rmz7/lxqspkPjcO2kJ8QzzA=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr12926445otb.238.1556559005160;
	Mon, 29 Apr 2019 10:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-26-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:29:53 +0100
Message-ID:
 <CAFEAcA-FYom0R+LgxHKGUJUpKyb4xFJdWzjsgh8s+aO20P3Pag@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 25/26] tcg: Remove
 CPUClass::handle_mmu_fault
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429172953.PaHOUcNYU4hroKD5gHv_bL29-mpg3CTrs0RmxteBddY@z>

On Wed, 3 Apr 2019 at 05:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This hook is now completely replaced by tlb_fill.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

