Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE0CC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BFA222BF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PYW7e5U6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BFA222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPJi-0007Ke-Jt
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iDPBN-0008Tt-8q
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iDPBL-0004sC-LD
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:31:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iDPBF-0004nB-R1; Thu, 26 Sep 2019 04:31:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id w14so1791858qto.9;
 Thu, 26 Sep 2019 01:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=O0m0+ASv5bNMX1fJC0A3etI6ESjZ/QMosSeHzHEHeY0=;
 b=PYW7e5U6NoenapiFpeWUOzzoxXeHJw6IGNl8mSY2pow7acd71exAF0iFwgIvV9tPl8
 olYcMU3nJPoLDtf3JPjkcaPnT3P/NdZejbxj7FTvqwhnvYQVzacbkfUxLSoQjEw0MRAa
 Rvm4ZiAsJy5p1nomkDCQvag6L9AQCLe0EDqSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O0m0+ASv5bNMX1fJC0A3etI6ESjZ/QMosSeHzHEHeY0=;
 b=NDyCCaYD/AgPhCp+tYApo2G6qpERgYngW1HIiGwdbqmcmMxBlhyxkmq08JoNAUrfg0
 gva+FRerX8FNuXthcTaWfvWIhFWfyujOCn8VkVa+AkuYknsxpI9Ub9ZEJgT0eOd5dTX5
 v4p34LYDKa3nhIl+6yBHdz1waCIhx32xLtMeCCv0VMp0/eaqxikouqE8J+QPa7Ll3hxi
 4riAsOrpNAeJD7schzmiU+wBJsRH0foFSAuCGYPkeuM7pAiV7tmO/nQfWxxt2czJnW8L
 1rxvkj4hTyr7/gTKOjoAqaZjlIyEZ8eSx/6rUTpeTtVU4cVrJChB0MpB5XxIdLQID6L4
 Plww==
X-Gm-Message-State: APjAAAUGvUkVllA12MhL/sdpNh21Gati7OrMphelnMd9rz9/yjKsHet+
 +TEfTU/CzBnyFnEI5JySCoL8c/ddmmgKQhw5MVU=
X-Google-Smtp-Source: APXvYqw6314t47RDx2H6ysh6MPLntiWoFSMln2TAg/STNvnlMZqyfuts1bz/NUZXdRloakDuRL/gkWGwoE+4EEKvGu8=
X-Received: by 2002:ac8:2f81:: with SMTP id l1mr2670640qta.269.1569486614145; 
 Thu, 26 Sep 2019 01:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190925143248.10000-1-clg@kaod.org>
 <20190925143248.10000-6-clg@kaod.org>
In-Reply-To: <20190925143248.10000-6-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Sep 2019 08:30:02 +0000
Message-ID: <CACPK8Xeg6ELCnLNbS1W+ZLRFdaA4efd+d+j=aJBMgQX8VNLssg@mail.gmail.com>
Subject: Re: [PATCH v2 05/23] aspeed/timer: Add support for control register 3
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
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

On Wed, 25 Sep 2019 at 14:33, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The AST2500 timer has a third control register that is used to
> implement a set-to-clear feature for the main control register.
>
> This models the behaviour expected by the AST2500 while maintaining
> the same behaviour for the AST2400.
>
> The vmstate version is not increased yet because the structure is
> modified again in the following patches.
>
> Based on previous work from Joel Stanley.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

