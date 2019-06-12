Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8826C31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FF82080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="UhAPANXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FF82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hasXm-0004yL-1g
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 21:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hasOS-0004M9-5K
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hasAq-0000yO-F0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:35:39 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:44171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hasAQ-0000nF-Dc; Tue, 11 Jun 2019 21:35:12 -0400
Received: by mail-qt1-x844.google.com with SMTP id x47so16925799qtk.11;
 Tue, 11 Jun 2019 18:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=W0+NQ+4OO+2QlPMDsc+O/0jbvTE7j85tz2i3FJAsi3c=;
 b=UhAPANXpXT3N6DqLpRXeljLmnKicY4n84J6va7SS4poBDkKUviKKtDVTYSDQ+caSoL
 cWY2SxdoIKT4UngXjVnV16BhLalBhH0nYHKTxY3nH9PnvLxzqz7tAhjLY9Q0mzgflQGk
 3zGCPiOWP/RYaZfJdyP14sjQXKXj4G4xydmMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=W0+NQ+4OO+2QlPMDsc+O/0jbvTE7j85tz2i3FJAsi3c=;
 b=qyf3tnUkbsgWv6kCqoUkZP09f7hda61lp2J29VXqS7NUxhhesSeNHnp/toT+GsyQ5R
 PeeGr481ophhyxlGQtPojjOvRiEHJK08uQMFHtdDlyyq2Q2z9uzLTw6JsSKdO6N2DoLU
 qR3C4WrIVm+egjvz4ArDeCI85SfJl+WXvnIknRr7S3qAB6agiysFbCXxMOCTSTAJ71WG
 eXMBXZY6FlVvn8bjIdPU0nPGrt9MfD63se6O7t72iwnzg6FOhPfZFb8zuY2+blki6u4Z
 zwACFROlbPayQmpYad6c576DIay6FbGFa2vwYFHbTOwqicLA6BjgbJszfpv349wzaTEW
 DKfw==
X-Gm-Message-State: APjAAAU4bxHWWe6qfH7D8IIqSqmJ7+/QNqkAhYPXugG9J4vEchzuUofX
 aMG16l4ffZnj0+Mu0hm/dxBpt31CFAo7+n/+jvo=
X-Google-Smtp-Source: APXvYqyZKvX8jI2KOtkzlBK52t33KCram72WQ4S/rFvuAL6sQ0XcTBg4QhI6YxSHxeh5NyyvmGycp9B0KahxX8SdbNs=
X-Received: by 2002:ac8:2493:: with SMTP id s19mr47149532qts.220.1560303301344; 
 Tue, 11 Jun 2019 18:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-14-clg@kaod.org>
In-Reply-To: <20190525151241.5017-14-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 12 Jun 2019 01:34:50 +0000
Message-ID: <CACPK8Xd3VJALoxsDOmN7Z4aUk8ifj7YCfdm9CXPAPT+UMEaW1A@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH 13/19] aspeed/smc: add a 'sdram_base'
 propertie
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

On Sat, 25 May 2019 at 15:14, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The DRAM address of a DMA transaction depends on the DRAM base address
> of the SoC. Inform the SMC controller model of this value.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Nit: s/propertie/property/ in the patch subject.

