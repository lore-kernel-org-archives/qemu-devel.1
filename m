Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF50CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 19:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99D421928
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 19:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xo4IUTG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99D421928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMHD3-0003KE-0E
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 15:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMHC1-0002Xh-GW
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 15:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMHBz-00005w-L3
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 15:48:45 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMHBz-0008Vx-6Y
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 15:48:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id z6so9240852otb.2
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R2Bq3tlfbnelSqJhWs7UyXcyGdgQO9bYY7OG2FFeqtc=;
 b=Xo4IUTG2Yov1L4zyv2+RMQ9WSHm9W1pjeksjmUDr4jgmNZI1rvEeU5oWHseSu0Ql7w
 x+9H9Jn2oAhc50JiLTYNj9s8Nv9KOM+XfH0HL2RqYHQRVavT2IVyYqFAnQ9pUoSNZ4tz
 ZKlD/ViUHuplLEqcOk1k3oajfImtKgc3mak6Mh/6mcZZyPIzxY+v2k2JAczrFkS04NIt
 L30HVAO0/+p4kTUScAUmM4kr+oGGFjdZqu3VqodNSEAQU5tscPkmlzNpk6mhRkbMdfZj
 xxp/8aXHjCWWhMvhGQ9Zxcpyfe8WtjZ8oDDqGCNfsYxStyeuxoiE6cO0//Qu9bxu9tDS
 z+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R2Bq3tlfbnelSqJhWs7UyXcyGdgQO9bYY7OG2FFeqtc=;
 b=f+2bno0cBGhjawYFDZa4EElTZkcDoyWVchgLpqiXVBqb77Q2piVAvJEGFnKPn/wZbk
 hppxn4uiwrjnP1QGugkMgK/DCymXkw1tumRivBUt/Ib8FIjt2I6fWEowGfnno891bmNn
 LWoOuvXHeFVUsrZnINsIa7Fs+19ski/4LsZivefm+OFdsbkJ3qZQvZ2NwmX5ub9qK4YE
 Ck/F1KfFonLSRrLK3dmKKSGj2mhF2IRP3ALR0MyHJzsJGHOr+EiwhRLD/MzESYWqPvH0
 8tAq4Q3T/G56lo2qOlEnwXcQUYwO2NEmFNE6PKJPhq6qN6xnG7M7Iq3BkKIxxEnrqEGE
 C05g==
X-Gm-Message-State: APjAAAWq6KcriwaCydaEgKcltwCXjW70xWerNv9Z9h8/aYYQZg8PGK4s
 u3+5cVQwuKS3oyIc5++cCEmSzxsXEvEQ7K3rwRK6dA==
X-Google-Smtp-Source: APXvYqxBRuNGvxZOh9TQ+PlnL0qrXakquz5pX/K8s50+4aFGONTnArS7rEKDhlocjz3hX3fxBqK3K2uZCr6fbITM+74=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr16156161otg.91.1571600920543; 
 Sun, 20 Oct 2019 12:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
 <20191019192315.c3jzj3nbvpfjydsw@proprietary-killer>
In-Reply-To: <20191019192315.c3jzj3nbvpfjydsw@proprietary-killer>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 20 Oct 2019 20:48:29 +0100
Message-ID: <CAFEAcA-LuxBA1m9dTqNxx_gi74E=MR=-M7sOFGddFxttgfvPiA@mail.gmail.com>
Subject: Re: qemu/powernv: coreboot support?
To: "Marty E. Plummer" <hanetzer@startmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 19 Oct 2019 at 20:24, Marty E. Plummer <hanetzer@startmail.com> wrote:
> Turns out the 'not text' warning came from lists.sr.ht, I wonder why
> that mailed me.

It's just an individual subscribed address that complains,
not the qemu mailing list itself.

Philippe, did you say it was you that had subscribed
a lists.sr.ht address ? Could you configure it not
to complain to individual list senders? Failing that,
would it be too annoying to unsubscribe it? At the moment
it mostly seems to confuse people.

The other alternative here is I could turn back on the
qemu-devel list facility that turns HTML emails into plain
text. I sort of didn't want to do that, though, as editing
emails means we end up with from-header mangling if the
sender has a strict dmarc/dkim setup...

thanks
-- PMM

