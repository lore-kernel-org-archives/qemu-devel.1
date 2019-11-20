Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE20C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A874E22429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLIB68W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A874E22429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNXm-00074R-L6
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNUu-0004kf-9W
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNUt-00071K-13
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:46:08 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXNUs-0006zO-QZ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:46:06 -0500
Received: by mail-oi1-x243.google.com with SMTP id d22so15122810oic.7
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ie8L3rDj1Y6wSodTzYXmrciTMZUQS77Rrk8qR7eS8CA=;
 b=jLIB68W8hN/FzpVBM4qTMLwhqXbfZnk/lYJBAFQjdTv0//YaLnoj2iX8x6cyDeFDPj
 vI0X0DeCwNfdurqrUDfklfXQUs8laS6Xfb5vVdYhxheqJIQ6Nd5ClPzSj5hAjwwSSCX0
 MvNvVdu2Cc+pqV8+utW9V5PG+35J+0MxMWKOtQ4RmDaNYgbbyDYfbRMqt8JhFHnGfYH0
 9vpGUqy3vm3nunkIcVIS3GiLT8t2CTwz6i+vvwuQ6T8Kd+p5FYUVuwuS14kt4y58iQm5
 loDVjevvAh/tkmF/oGtt0j/tcwiC0yG65nN6YXs+F0Ec2h/j41mrKghnnFKot7Ajes3L
 xKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ie8L3rDj1Y6wSodTzYXmrciTMZUQS77Rrk8qR7eS8CA=;
 b=TgwFwGze4WtbdbT3JkJghy2niX3JR8f6s5QV84aljM3NG4ytSByz/QFl4CTItKzQhw
 Xgd6Qv7TEDUuUvbGq/6ldf1GXNC0TpTUSwv3CJPA6VA8Aa289s03vqVAadPp2QR8pBre
 i7e1W0hKD/zWN0NT4mP/B9KBpowW5/AEIKDuBrOYyEdWR4BP0D1VVtHjNV5kZmbC6SQm
 06L1H5/LqpCIpKh7uHEjtvEy2Zpns2PUCMU1QWwRahyQp5y1xoHQ6/xUeGhNlEPU/RmI
 68FN2bT2uBq8Li+JBEfnxs+q/KTN2LqI4K4DNTioXnbqtNCw3S/k9Iazyb8BIlKxLVYA
 N+8w==
X-Gm-Message-State: APjAAAUP0zCqxWTmjTaW5ZYXNCDsKxsG0zXLWXePrRbXXFa1X6aPQtf+
 4o5PO8DwIbrQQYy0We2y2AzztDUN844HYW3WCUUdDw==
X-Google-Smtp-Source: APXvYqz7AgRUo9ENk1yRRbDXkkedk9kb6IpQfwsqFFs6IWetODSBmjfEVr5xN/VyPRvyVvG9wGy3t4uahe8nIhQwtaE=
X-Received: by 2002:aca:a9d4:: with SMTP id s203mr2133017oie.146.1574246766130; 
 Wed, 20 Nov 2019 02:46:06 -0800 (PST)
MIME-Version: 1.0
References: <1574190388-12605-1-git-send-email-tsimpson@quicinc.com>
 <CAFEAcA8AeTgY+3GaN9ZUi-5XtX5jxhqpdOhr3ixYwouWhQOQ5g@mail.gmail.com>
 <e4a52719-fc16-f94a-fb8d-1a4d9e683ce0@vivier.eu>
In-Reply-To: <e4a52719-fc16-f94a-fb8d-1a4d9e683ce0@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2019 10:45:53 +0000
Message-ID: <CAFEAcA-tVh9AMucDL4hgQ3ngFZwu4AThcGyhwjVa-LbG8o8-Lg@mail.gmail.com>
Subject: Re: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 08:10, Laurent Vivier <laurent@vivier.eu> wrote:
> For the moment we don't have a better solution, Josh Kunz tried to
> rework [1] patches from Milo=C5=A1 Stojanovi=C4=87 [2] but it doesn't see=
m to be
> an easy task.
>
> So I agree we need a generic solution to fix this problem, but in the
> meantime I told to Taylor if he doesn't care about Go on hexagon he can
> do this change specifically to his target (perhaps we can have cleaner
> approach by containing this change into linux-user/hexagon). And what I
> understand is hexagon libc (musl) doesn't work without this.

I really don't like target-specific ifdeffery that changes behaviour
that shouldn't be target specific. They reduce the chances we ever
try to go back and actually fix the underlying problem correctly,
and they can be awkward to undo without breaking things.
As far as I can tell there is nothing special about Hexagon here.

thanks
-- PMM

