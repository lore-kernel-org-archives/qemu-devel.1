Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEDCC46460
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 13:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8563720843
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 13:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxoLRznL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8563720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQthp-00085I-Kl
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 09:12:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQtgb-0007Ra-UL
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQtgY-0000NR-WB
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:11:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQtgY-0000ME-JK
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:11:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id e15so2635198wrs.4
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=KpUQ6dAVajXBWj5SR+Opvf31V7sa2t6+9j08j0JPeBg=;
	b=dxoLRznLb14hIxE6SWb6/N8PX8YGGSn6BUNr05nhCSVBGGj3jw/LoItgZDS46J00iv
	m3yDAz7dGXWXpXtTKL+h0IixlH4SKUsBBGdc3FsoQAtx4tysixaRwXZusUoZb8GOj5eP
	AMfrx270bwf/w9sxx22IyWIDmCQWq3r4y8nDIGw7Jh0GJZFoeKjSXMbkLaa98u00fdLG
	EYajy6kKzGajTiuGL8S7rQ/3yDvses4jciXSUe63REW4awl6PMdD33AcX/XAT0VgRpcH
	FgU952llEb5YKmbMg1JCpJoUnVS0j1oaaHokeRdL43PaaY7nHgl/IOPkC05K2fRMYe9J
	muQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=KpUQ6dAVajXBWj5SR+Opvf31V7sa2t6+9j08j0JPeBg=;
	b=cmkhI1ATOoCnPZcfl91oCEBf3AgOXwigOHYR5AuXR9oxSn8HDOWYXt0pBTh5nI3PZV
	wX1NZT8ovUUOOtUYTHGZKx+5mufjvWeRS8gAVovRFQSnMs7HtuLIA9AD2sZTbdzV5at6
	EQiZu0kZikRJVtyWwrmvWDxk89f3AaeLNz8TruAKW7g44SpGEuhJ3WCTeEkKXydSz0u0
	LMfg6ikDk58luMFtrYYHF3pYGmZtGJeDemNJoHw0QddJ288hmSciYAbM09/r07sEO9O6
	6bT+FnHa0KXYxP/N2xzQn2M217Cj5mR7FVSsnBmYs+x5NWSx8pe6vU2tLwTc23zrE+Zv
	BLLg==
X-Gm-Message-State: APjAAAXynTXsUSNQfOxgkTww3q9H0Z/XN9tE7WbX1GgfINIaWXMLkTUR
	UVDtuWXoU0JzKIX9tYNRKDJn5w==
X-Google-Smtp-Source: APXvYqxne1RhEatTp0aplRvOZYvEGAylzV5ntRlKvf6cUj4BR0JXBCSTglr3EHrSne7Vr6rhhTgoKg==
X-Received: by 2002:a05:6000:1203:: with SMTP id
	e3mr26125708wrx.300.1557925864954; 
	Wed, 15 May 2019 06:11:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id x22sm2670420wmi.4.2019.05.15.06.11.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 06:11:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7A3431FF87;
	Wed, 15 May 2019 14:11:03 +0100 (BST)
References: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
Date: Wed, 15 May 2019 14:11:03 +0100
Message-ID: <87tvdvn9qw.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 1/1] target/arm: Fix vector
 operation segfault
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alistair Francis <Alistair.Francis@wdc.com> writes:

> Commit 89e68b575 "target/arm: Use vector operations for saturation"
> causes this abort() when booting QEMU ARM with a Cortex-A15:

You may want to check your email settings because when I tried to apply
this patch it failed because the message is base64 encoded which choked git=
-am:

  Content-Type: text/plain; charset=3D"utf-8"
  Content-Transfer-Encoding: base64

--
Alex Benn=C3=A9e

