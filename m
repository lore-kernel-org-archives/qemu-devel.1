Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25B1C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57110222C0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="GOgS9y1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57110222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDP7S-00045N-4a
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iDP59-0002pQ-Iw
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iDP58-00053L-P4
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:24:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iDP55-0004nh-FA; Thu, 26 Sep 2019 04:24:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id j31so1805084qta.5;
 Thu, 26 Sep 2019 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0tB7GcN89aEd7SiJdb2whDGpMrw7TcOxIWPnV3YqKVc=;
 b=GOgS9y1T0SLjHehxqZJJLPEX14NlzWQI51j1l86+wZHuXMTwtoHjT3e3rA6gAjAiqe
 rzzwh8a6AO8npV6Ix1PO7BgwwmB8kVQz3ESpY6XDvwOCaSz7nB+Es97ntJMqzNdqBJjP
 2cln28X5T3FXC7RDGAiW5PLPUhSuSF6LkADpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0tB7GcN89aEd7SiJdb2whDGpMrw7TcOxIWPnV3YqKVc=;
 b=j5iKx4KNjp1b5sw+wyzlwv7dhR0INdITtZTb9sMehECfnQoFHeHEO21DudZ8J80vfJ
 E/C7/arEBhmxZeELuy4R2RoInwn56gLyCnEnQod57Ee5ERf+MrE288ctH6bOl44mFPOD
 dyY4Oe8gNExVhmzk5x86REBYFnH+Zdgo0oNWlH88udCj1a0aBjZsvvl1YaI0GKOYZTB9
 aeTWQNiaNtKMvolR7dWqIhD6Z0twqshvUZn14RSmV7tVYI26XMG0SAh+5zT09KSJPF9c
 p2EFdymcfBG0X/a3ytPs4/H7OZ+hvufPz94mCt7Xi0lyn1GJeGtvUFe5ANCM3UsSHohL
 rlJQ==
X-Gm-Message-State: APjAAAV6SPwf2rn9DiwVK2q7TutNq1PQPpzMAkAaYwFPSciVvDhdE5cG
 UCCsDHKejw8asQoFKKf2bLsets9yKAym1C+vjbI=
X-Google-Smtp-Source: APXvYqzLNK1UBubDjjB3qxdApXcgTunlCEQ3zmi3Jy09mSi6toF6V3wd89GENOF6CqCQn2SA+UdSA/pWlugupg39jtU=
X-Received: by 2002:ad4:55b2:: with SMTP id f18mr1662866qvx.16.1569486230441; 
 Thu, 26 Sep 2019 01:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190925143248.10000-1-clg@kaod.org>
 <20190925143248.10000-13-clg@kaod.org>
In-Reply-To: <20190925143248.10000-13-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Sep 2019 08:23:38 +0000
Message-ID: <CACPK8XeYQtzQbxvRjjdWdTtGfOfL3uUxE+R9bMaAqm_Xxxgx8w@mail.gmail.com>
Subject: Re: [PATCH v2 12/23] aspeed/smc: Introduce segment operations
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.194
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 at 14:34, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> AST2600 will use a different encoding for the addresses defined in the
> Segment Register.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Acked-by: Joel Stanley <joel@jms.id.au>

