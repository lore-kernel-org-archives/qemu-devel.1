Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02542C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6D1205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9pEIJZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6D1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7yF-0001OW-14
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:13:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7xJ-0000uN-IX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7xI-0002ha-J6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:12:33 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7xI-0002cF-E4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:12:32 -0400
Received: by mail-ot1-x342.google.com with SMTP id f23so8895982otl.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=GEwlfRSjRRkr2AjxP0uQtHdyBXB+sJ3xZrCovizd7N8=;
	b=V9pEIJZ6S24E1rIqbC2GKXSzSk5P+vveuFov+B8huflobZrAEbYB5B4k3NhJJ6B/EF
	O20hoxcl0fX++w56YoRfvvMUTVCqtvzSZFtVrkVs642V3q3axEHUXoHq2uZOooNTAXgW
	kv5UY2ClaNL6rebDfaJuuvZ//QO1Og/n49GZGx5ewaP93WEUnt4/sWkMy2njBSeV9FW6
	zTzYbq3B4YypPYAi0yN8xhsHlaTi6geloV+1M0AA5AtRX6D1Piafza2sbuXcDNP9n1+H
	uak0iI8Fo6bSYgzti2so/hP9tOgqcJ3jZAeEeXPdHmASPhJ9pjOLZEyj70xpdBwISZVy
	kVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=GEwlfRSjRRkr2AjxP0uQtHdyBXB+sJ3xZrCovizd7N8=;
	b=GcpDBTVbGPFrjfUOrsCp61Bz2dmasMybSROo+9e6oLIuKy/Ysm0QdL+qmAqlft6fNt
	jBX7HCpsYYDuy/RJlVHctMQRONoV45gzD/wPsYcLiRP0eofIyl6Al93rWeRZOz3g1nIH
	Ae21Wkr/qxE5ZC5WjbLtKnN3C8ZgvM4tAjryTFKqB2cDyoih2cIeYCSOrOST14X/SRbj
	SuKkFcDEslTQk6IB2rPsiZPpceLk6UyW3nIFL9wy43jd6MHtaMYk93iyGeBXSga1yaAX
	uQZ+XdGezwx9p52Ulm9dZYYe39wp9DMsU1JsgawrAaAoVgO0VV2E9b4tTKyWVBDsgdFD
	l3iQ==
X-Gm-Message-State: APjAAAXb2MGF0po1FxPiusoaGN7d+lShI9Ga1YKeE65F0tNYHcp/22e0
	TsaGpeRh+0nFAO+dNaL6mqS2PDINbMVbD1u4v7L4QCyS9rI=
X-Google-Smtp-Source: APXvYqyTvzfckyuG6qK3F1PEViuTmrfAtTs5hsL/tn/bKEvbXcpc8v7nTaxg8RM8RdlOFSjrnBJv7oImGLJ/ojFM1/4=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr12413208otb.238.1556550751288;
	Mon, 29 Apr 2019 08:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<155381739615.24.12240723664123883584@76452e4e88f2>
In-Reply-To: <155381739615.24.12240723664123883584@76452e4e88f2>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:12:20 +0100
Message-ID:
 <CAFEAcA9cyZAHj9DRgq6dXsFXGNLKcEOXCndLYTpf9b+EGHnr0g@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 00/36] tcg: Move the softmmu tlb
 to CPUNegativeOffsetState
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
Cc: Fam Zheng <fam@euphon.net>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429151220.p94ignuBQ6e4K0i7ekfaRVPPUK2NGTunxxrO4ufnUno@z>

On Fri, 29 Mar 2019 at 00:44, <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/20190328230404.12909-1-richard.henderson@linaro.org/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:

Richard -- at least some of these checkpatch nits look like
they're real rather than false positives: could you have a look
through them and fold in fixes where appropriate?

thanks
-- PMM

