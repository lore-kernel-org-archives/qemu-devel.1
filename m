Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03ECC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866B6206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="0CwTBIm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866B6206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYRMj-0007dE-L0
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jYRLn-0006Lq-Fp
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:37:23 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jYRLl-0006va-Vt
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:37:23 -0400
Received: by mail-wr1-x429.google.com with SMTP id y3so14499720wrt.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 02:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Wxqz5SCEQnuBpgXZtyTTd5WBFjuCs1DQnIieqGAw1kU=;
 b=0CwTBIm7QAgJAuIB18DQmWEcbTrbJ96PE06Tazt5YgggNTOo0kRo3plRVIwfA0QiEY
 h1fwH2ZpfBL8FH0pHShBLQg4MNFfw/zuceub4R5dEawDWbQNnTjkHxXIWL3klem3+SYf
 lXerFvts4SzTua4XBXsnawB1ChOHKC4gdZ84vY/JgTGcvAOvdZ58+BSITMO49KHEL8ZH
 wauf+dJ5rK6e0KKkf8OALmHY0fUPKCz/ZEapEsNaf/GAxVkGNfxqoCFCsa4QgV9yDctq
 Co+TGsQWeDfzNsUdkzWqxctu5XE9tFaEsH4+QW95/+SDfQMAvd0IZI1xerB7HuOGe9mP
 Qe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Wxqz5SCEQnuBpgXZtyTTd5WBFjuCs1DQnIieqGAw1kU=;
 b=Ek84PPielrsKNh8C1HosBsIDigERaNal343lkwtbwM5f4xk8MzIeUr1BmZQi5z5fYA
 levEj3APRFzX0Wcqu70DJk9/n4guOoXEIm+GPaD0Ga2Ka8z1jJHNVmp2IMTvtk1Ezp91
 T0OGw9FZ0relLUPXT1wWVXhRPPofNVhMOgowLYPs3Z7Fuu6oyuDvBypLSPR3OfbObe0R
 bCthZWqbQ4H7ksDSwxJ44hPKZYhoql0DzPQu6hFaBvsVBZHkZBA04Cnf1r2UG4XeFbtz
 y0LiZGFhnlJHiili1J5CfIu9xAcPHj4Db5G5rUR7KHhLG8ojOarbOy12mdnrMBShhXrJ
 6/MA==
X-Gm-Message-State: AGi0PuYDKRfX4MFlOogZE3yorJrrjbf8mR7FTdis4UjlW6OOhCRyJ05F
 vJRulqsJGQ7vYHvMkI3kQ/ZPGg==
X-Google-Smtp-Source: APiQypJ3p8JisKRivVJefDB3Fo65o0F4zWoqN1da0tuuDE5mT0HXiO+t7QAzkgLcEC/FczAlol8I/A==
X-Received: by 2002:adf:e489:: with SMTP id i9mr16033293wrm.373.1589276240073; 
 Tue, 12 May 2020 02:37:20 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
 by smtp.gmail.com with ESMTPSA id c7sm8217756wro.80.2020.05.12.02.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 02:37:19 -0700 (PDT)
Date: Tue, 12 May 2020 10:37:17 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: SBSA-REF maintainer email bouncing
Message-ID: <20200512093717.GZ21486@vanye>
References: <dcb8d325-a2af-0c68-ad64-87f41521d4bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcb8d325-a2af-0c68-ad64-87f41521d4bb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 radoslaw.biernacki@gmail.com, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 12, 2020 at 08:34:13 +0200, Philippe Mathieu-Daudé wrote:
> Hello,
> 
> Radoslaw Biernacki is listed as maintainer for the SBSA-REF board.
> 
> His radoslaw.biernacki@linaro.org email address no longer works,
> apparently "Radoslaw Biernacki no longer works for Linaro".

That was probably technically the case already when the patches went
in, but Radek was given an "associate account" for continuity.

I'm digging into what happened (although as _I_ don't work for Linaro
anymore, that might take a bit longer than it otherwise would have).

/
    Leif

>   SBSA-REF
>   M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
>   M: Peter Maydell <peter.maydell@linaro.org>
>   R: Leif Lindholm <leif@nuviainc.com>
>   L: qemu-arm@nongnu.org
>   S: Maintained
>   F: hw/arm/sbsa-ref.c
> 

