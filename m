Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C176BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 21:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835882070B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 21:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntGQrUmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835882070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i20GM-0002kp-MG
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 17:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i20FS-0002LN-Tm
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 17:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i20FR-00029q-UN
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 17:40:30 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33399)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i20FR-000294-E6
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 17:40:29 -0400
Received: by mail-ot1-x344.google.com with SMTP id p23so9256377oto.0
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 14:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5M/BENE3g3wpEqpY8tHw1eyLzNCYuKDcT9VPdpaRDr0=;
 b=ntGQrUmneX5sgH/YLR5NpkUySmwdjPbwUn4PamiTsvZzeDoh+4am2acKXXWbZigFlP
 7eiX6bbVBxQU14CdxkjXSNawcFqPw/L4hq4VhPg2aT9B8MFy1QPiqIVi9wK4EKqBVnc6
 Pe7OxQ2fsc9IupXiQ10JVtGl9Hf5Pck2tGDXyfD+qWTVmCloJIOu/VMifqAyxn0Sa6zs
 R559ixl7eznBWeOBxd+E1iLq+N19eVBRMNzxsWOf+doSWzUzCKEZwU4HXgCAl7/BkMm9
 I9UVEoHtBjgHPZfgkmCBfAKre5ZzTvXUH745ICLdIYbC/pGuCDnhHE7YSi6la/NXnRnB
 eDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5M/BENE3g3wpEqpY8tHw1eyLzNCYuKDcT9VPdpaRDr0=;
 b=QLNFprtsT6o2RNtR0/MIBUf1ZNi5g4b+i/ATF0yxMCgZHLSw+2XAKXgnKbcvjElevq
 smnSytK4j+b+gJ50zNSXk5JMCOI8A/UH2ubE9xrcMi1nbfnUVD5IJ9Z143PDrqvalLnM
 2BR6OVumLumcLQQYvHn4kbUVoR67qKpKl6hCwN5fACQwCkbPHeaeHddOSeInW2tgPVeX
 5xYZKMeJbjklxkZYysOg9R2tHWgkHZ2173WiOPrbBXQ1TJvkk9GS+7NmwOxwcuckiin9
 uvIZt9yWM77u9yWSX2nx4BD4jjOr2UWf8iPzza+b7EtMTqQTuEYEmzvvJsMhIB2hT+kz
 qNxQ==
X-Gm-Message-State: APjAAAXnDXZlJCZ92tlxBjHnlpUoZruHgeNtZzzNUuHfAuEr8Q2bTsjG
 9mNecpO9ijeW/tCd2ePeY2w6ldDYhdYm4hrWvGQghg==
X-Google-Smtp-Source: APXvYqxYhGm2TqVCHjZuuq08h/dMw/vswPJEP38aDigSxfqTHnv5S/zmd5f3MYeIlxW52//TpWWX0iW53CJMjw81Gxo=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr2164163oti.91.1566769228503; 
 Sun, 25 Aug 2019 14:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-53-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-53-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2019 22:40:17 +0100
Message-ID: <CAFEAcA-5PNFBar-KoHS2xaP_vZFJR3QzBh1Enwwjh4CdaSOA4w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 52/68] target/arm: Convert T16 branch
 and exchange
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

