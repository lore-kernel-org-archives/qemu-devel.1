Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1883BC10F13
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 02:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23CD2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 02:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="SDat+BxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23CD2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57639 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hElnm-00015X-5U
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 22:20:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hElmV-0000S8-KM
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hElmU-0001qa-RK
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:19:07 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:40783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hElmS-0001pc-VY; Thu, 11 Apr 2019 22:19:05 -0400
Received: by mail-qk1-x741.google.com with SMTP id w20so4769302qka.7;
	Thu, 11 Apr 2019 19:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=h97nWi3+85KRZVmwmBh08erEhytlaUh5C0xoa7AcHhc=;
	b=SDat+BxH+VfxEV2bupoDS4eEqA47FuoDRqaaHYE+K5QdulutALrDIPepb5ZfqpBy4p
	JTxgBQDd1w1CiGzqrgycuDhJ1p4czMiZSjJsfUkkcNm6Ug4bKk/vJy8plnRA/kyc/Xe8
	HAx2WPUQHB/CnqXgCqBnki89M8+nIOdBnxm2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=h97nWi3+85KRZVmwmBh08erEhytlaUh5C0xoa7AcHhc=;
	b=Evv5g0YUZ3LRjJQ5N80mJLn70yW24L9WTfKwlJ2qvyTxEF0QhhrgRObB1w0OYwP2eV
	Y+3o435Zsh4i6Ig7eRzdLL1GQeOTcqNAK3bspEhNoI+wcZRNAaxfsPRfqdKus8D/5/bx
	2YJODWJVdU/8+TtT10AEhkSGiljGzOb5zJFTkMkTlyZvq/aUx+/GymlIGQReZWUGngcc
	iK6/dP5/kTIUo3VnlKV61qQixb7jYqx21TpOX/DYVvMW7q9c/U+QrJjPEGALlrdSS7VA
	SWvhT2/XK9Qgoy3ExxMy4CNcjTVkOv2QjzXiYLKuavjMZaZ/WDauJ6ZI8hMCIrsWGDof
	o5JA==
X-Gm-Message-State: APjAAAWsaOKSH2GoOSHoC1dtwqvRHP6biEikUZlKG2ZrCPeaRjmEY40F
	U4b+txN5gG6RPlqfEwCz44DPC3nU/iURy3b8Ljc=
X-Google-Smtp-Source: APXvYqxDBROWo3nwj/NtQBcauf09RDHMIBvahQ4FECl0JuRokt3lQOrCFK2uCkqDByipzUSvxgnRuaP0WVc27IpUVsc=
X-Received: by 2002:a05:620a:16aa:: with SMTP id
	s10mr40824787qkj.305.1555035544383; 
	Thu, 11 Apr 2019 19:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-4-clg@kaod.org>
In-Reply-To: <20190411161013.4514-4-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 Apr 2019 02:18:53 +0000
Message-ID:
 <CACPK8Xfk7KP8SqsWHkBeuoxzDUJTtNAAdKsz79KHHHHtD8jUpg@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: Re: [Qemu-devel] [PATCH 3/3] aspeed: use sysbus_init_child_obj() to
 initialize children
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
	Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412021853.HXwvVvEe8oqfSXavajTNxLq5YRWx-Uyv4iRPSRAHrsY@z>

On Thu, 11 Apr 2019 at 16:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

