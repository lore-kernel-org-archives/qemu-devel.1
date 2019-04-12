Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D66C10F13
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 02:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC312084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 02:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="fhqadoVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC312084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57625 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hElnM-0000pz-Ce
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 22:20:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hElmB-0000HR-SZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hElmB-0001lE-1t
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:18:47 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hElm9-0001k8-2v; Thu, 11 Apr 2019 22:18:45 -0400
Received: by mail-qt1-x842.google.com with SMTP id w5so9516026qtb.11;
	Thu, 11 Apr 2019 19:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=aL+Yylu12gi6XCiKgLJ9IpSKqK7vCbcazrVnKnO4KqI=;
	b=fhqadoVYuMYk8lfta/4r02EetdvhHQmtfR+jKFA7VYj1VKZlKuUO1UoEH2Vx2fFIbl
	Jyj2ezurzO7wuCBPXuv0dwApD/fQxH2bm3vwDBkRj50V20i22QqUxfkCqaHEkaXyU6Zr
	Ryu6M/Q24E2ooTQOnVryLdKlavsKLj0DFrjFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=aL+Yylu12gi6XCiKgLJ9IpSKqK7vCbcazrVnKnO4KqI=;
	b=nlpovfSAoPKJx1TyIx23Z2yFwwwcZReXlRCn2JfjEHr61X3T13YOxVbd2GlJ7NLzqE
	nmxvzbwXQh/o+OtbTqoBmR4IKqVboxRvutrmSP4LNxUxcLNpj4icYdcyniCmdzKbZ/l2
	eDSr0ag2PSMEpiGvTSwOpS9ASdtS+pfjgunAam9eRPSpmQndEh9DfOvtnSC2Kg2BVkuZ
	U7iZzUAonSgWPwhcJIP9Cq1mS5EQJ6D5PoZVyMdS2Bsz4TrU87XDKvdGqSxLiofM8eRm
	mT4GC/LikpiKBcRMtd6KMaoqQIIIbLff1mSln/G423/lm6ycye4A1MeEHonCHy+Rn7xe
	a5Ew==
X-Gm-Message-State: APjAAAUL70uZQRa0H5nUi5ew/fcUuHdalMOAy4LetK9AiyNdS3cpVQ1z
	nofmgpdEM5ANqYo8BzuVN8re+BuKReaeKLT/X00=
X-Google-Smtp-Source: APXvYqydVnszxhO+r68gq82lYQ+hzpGgYRCSOlCCb4HBKCgdHgoscUJwyoN0z0/MRFVtm+H+2+e6rFOHb6dnunqKsIY=
X-Received: by 2002:ac8:2f85:: with SMTP id l5mr45837720qta.269.1555035523784; 
	Thu, 11 Apr 2019 19:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-3-clg@kaod.org>
In-Reply-To: <20190411161013.4514-3-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 Apr 2019 02:18:32 +0000
Message-ID:
 <CACPK8XezRXPFFiiK7_xXLs-ipnfw9400E1dSRHN0XnF2cc4=vA@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [PATCH 2/3] aspeed: add a per SoC mapping for the
 memory space
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
Message-ID: <20190412021832.CMQvTtNwzPJZkNuLgkdevM589cvB2s89ZhF-KkuXEQ0@z>

On Thu, 11 Apr 2019 at 16:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> This will simplify the definition of new SoCs, like the AST2600 which
> should use a slightly different address space and have a different set
> of controllers.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 5bbd1fb87d18..9b601709e93c 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c

> +static const hwaddr aspeed_soc_ast2400_memmap[] =3D {

> +static const hwaddr aspeed_soc_ast2500_memmap[] =3D {

Most of these arrays is common. And some of it will stay common in the
2600. Any ideas how we could avoid duplication?

This is fine for now.

Reviewed-by: Joel Stanley <joel@jms.id.au>

