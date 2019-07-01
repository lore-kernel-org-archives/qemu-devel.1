Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D9AC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AAD213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2tGrkEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AAD213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhsNj-0007ns-Qg
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45038)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhsKu-0004Oe-IQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhsKt-0007CH-Lj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:10:56 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhsKt-0007BC-GD
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:10:55 -0400
Received: by mail-ot1-x344.google.com with SMTP id e8so12709648otl.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 02:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6S5M/CCegDFWX1OOsyIr+oiU1qIAgowaRJSGZCEt924=;
 b=o2tGrkEn9tdEFp9Hr4UiR86M061c0M/o06rBfESgG5NcfeQRKzIfbTVFzqREUo5G5I
 TFKs+qxq34XiR8BgA7Vi57LXDaavenJV5ITBZFBmkwcuLG3+37mllr0MtpBOC2TTF8Yc
 ga4gjMMOqDny7+Lo6FXTFrnZKe5tqcpvPIv2XDBli/aSrthkZgYJHUvJdcbU3VDfSt9F
 iqdogmzad6X6B/FwoeAoyAsepigcay5n8ipeB3G9EFHwilM0xdqMAvpdsDb9yxxD44Sd
 ydEM4FxTm/xPAsax6hKwCvzEeOzcy2U+OWftJhI04CJjor6DfkXy441G+yuf7iHX2907
 geQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6S5M/CCegDFWX1OOsyIr+oiU1qIAgowaRJSGZCEt924=;
 b=IJNL4zEDfuWIz3J+l/0SJpQi+fmqIzNVwqVmpKTAp5wkPWNCNN3JDrY/nqvGAK3GVr
 Y7EAnzUgHtCdXvU/BFLa48Tr2HLnv1pHeQ01lh3PKyQ8vTElbmgcEVU9MTeHsdGMvh7J
 VZaWhyKIIjaF5sDv8PY4Oqi1LH+F0iyH4WgwBAwzVyhE6md+PbaiKRkT3OlksZog2L47
 qVtXYASesyVAqXB9JyDXQJ183wjRys+pjWcPvN54+vcltn/NkN6/gOspvNO8PzExE71r
 kfyrnOfLpUh0x2daaODIPCF/P87xtIY5OEkWJx21ZJWsrvvAMOAldMhNdjA0BbVeSbBP
 aWvg==
X-Gm-Message-State: APjAAAWRlf8xiuoZIsp85wuNoInfw2qFOYoqnX/CHisdVwB9z0/KR8cU
 j0Pv7FoeNAKmx/SdP7W7ChG/OhVWMkBOsgcP1DzOknWXb/4=
X-Google-Smtp-Source: APXvYqwmLoHMFfteaPKFypMtZvMAYdHkf9XrJr+WZQSFEl2lif5YnZsvsAHGuXL9yNLYJd78ymFvakOg7u4+XRDXbHc=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr19691659otk.232.1561972254561; 
 Mon, 01 Jul 2019 02:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
In-Reply-To: <20190629163621.GA111724@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 10:10:43 +0100
Message-ID: <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 29 Jun 2019 at 17:37, Lucien Murray-Pitts
<lucienmp.qemu@gmail.com> wrote:
> However for the m68k the do_transaction_failed function pointer field
> has not been implemented.

Er, I implemented that in commit e1aaf3a88e95ab007. Are
you working with an out-of-date version of QEMU ?

thanks
-- PMM

