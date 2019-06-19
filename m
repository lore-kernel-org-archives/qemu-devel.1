Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3541C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 02:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC84320863
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 02:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="U9Yl9mR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC84320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdQ5Y-0000k4-1A
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 22:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34162)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hdQ4X-0008HD-KR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 22:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hdQ4W-0003XB-Lb
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 22:11:37 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:39221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hdQ4U-0003VL-IA; Tue, 18 Jun 2019 22:11:34 -0400
Received: by mail-qk1-x743.google.com with SMTP id i125so9935276qkd.6;
 Tue, 18 Jun 2019 19:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZmXSnwHDh0E8tuWNW03pqMDS2oeDoYmhkZWu+MRjA6A=;
 b=U9Yl9mR1NwT+3QQTRdK6Y4WF/s69kVjlkhEZTi8uOLkMc89kbwPZW+u8RN0clz18wj
 D/Qe2r41Ku2B7OuPov7ULEL7mSU8jz0P+nZvUpxdQWdQM/MIVFIAI7qsbGXWAlDMYn32
 XX3b4J7KiLWO1POnGMqLMTKC81Q4miqUqlokE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZmXSnwHDh0E8tuWNW03pqMDS2oeDoYmhkZWu+MRjA6A=;
 b=A/EQA7fwEJ/dK/+8Cqo+XFYolj5vxpRBfiscAHtOlrY1DvWEgwklRURHRmtnKYFpMI
 BYKHO56uGw64imlEMBU6XTamg8Vl7TqVrFIs98tfy1oeasstMGaT+wkrQxE0TeBjwA7N
 1YnYkcYxKVT4e+QGeL4LXHTbnt2XXUL5w+UHc7QgMYvfll6Vr+nW6zgCfwUOeSARGtt/
 R8mzEWTQeeLhe4czQr4karWVDBCgxdKNkxAZVg3tek4UYxxuHePmDEWuks8HQDElkpXr
 sIQtCWj/04yg/ql+PgmqJqbPdZHXBcmsM0YVDHVeT63ySSFh/2T7/RSeQtjY/91sI6m6
 sNWw==
X-Gm-Message-State: APjAAAWhoVB0A5uXth5uJqPNL2j408iYMCtAxCwtWW8dk85ar5sfp8jy
 TQ6dBnkCDsFRZPa3nhXpFPWW+ktsk4HUVJ7ypnE=
X-Google-Smtp-Source: APXvYqyRiyaP0nFAJl1GI/BYXiKFYYzabPce5U7nLVJkNe8E+JpKFNpds4eKAgjFunahvDmGYxEdeOMc/XghHsTvQhQ=
X-Received: by 2002:a37:4793:: with SMTP id
 u141mr71663312qka.355.1560910293823; 
 Tue, 18 Jun 2019 19:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-7-clg@kaod.org>
In-Reply-To: <20190618165311.27066-7-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 19 Jun 2019 02:11:22 +0000
Message-ID: <CACPK8Xf1RSiixc_8vZ7AEMTxq8G+LQ9Q3+3eANnMLaVvJW3xQA@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PATCH v2 06/21] aspeed: add support for multiple
 NICs
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

On Tue, 18 Jun 2019 at 16:54, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The Aspeed SoCs have two MACs. Extend the Aspeed model to support a
> second NIC.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/arm/aspeed_soc.h |  3 ++-
>  hw/arm/aspeed_soc.c         | 33 +++++++++++++++++++--------------
>  2 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index b613b00600fc..75b557060b9b 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -25,6 +25,7 @@
>  #define ASPEED_SPIS_NUM  2
>  #define ASPEED_WDTS_NUM  3
>  #define ASPEED_CPUS_NUM  2
> +#define ASPEED_MACS_NUM  2

This will be 4 in the future. No need to change it now though.

Reviewed-by: Joel Stanley <joel@jms.id.au>

