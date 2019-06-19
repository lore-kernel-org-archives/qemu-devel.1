Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1645C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 02:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5C12147A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 02:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="jIzTfLDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5C12147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdQ6K-0001ip-9G
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 22:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34471)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hdQ5l-00016a-Ak
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 22:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hdQ5k-0004Ix-Gp
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 22:12:53 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:36270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hdQ5i-0004HV-Hn; Tue, 18 Jun 2019 22:12:50 -0400
Received: by mail-qt1-x844.google.com with SMTP id p15so18072663qtl.3;
 Tue, 18 Jun 2019 19:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JmFYrZ/2pNkhlZXI38OKDocoPb+MDSF3p7Zqlsji8kI=;
 b=jIzTfLDF1e3DXw9edY1FZdbuo2J83P/RhlOwqZxvVmxmHlYoi35pfCPWmL8F6wuAh7
 pf1wsk8IL0KxMUu66LArJSd6xUIegJEK6zdFDirMfbMw37jzbm2B5yffrgteF2K21Ksv
 bQX/P3fLshx1LDRpMBMQwt4A7Barfp5Kmch/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JmFYrZ/2pNkhlZXI38OKDocoPb+MDSF3p7Zqlsji8kI=;
 b=s3LZSBCorux5Ko3OgryZRkVUaXMSDo+B8tNLHoc4RokbUWYzJWKGGt5uCplw5aT1ql
 ztrZhVPB8Va3T9QmW5Df9x/h5reSRvr2aYfDL4/ATa23zGM33exdKOpiGGaXKdHjMCbb
 9Q+zS7USnAgDjMX595bHv7/7nTkhVXShPgIzjnS8LYQmaB4jtoc7eIsoOPRiuA+pE6ku
 fc23qqSPMXcPnC9ohMnRWXKRv0xrqOMXImoANkDFRvrlCzdsOJRBkukQ2dueqgOKp2qQ
 ZLUTfQxbGf1KbmGENoUeuhJ8eRDhZIDLqcoAKyqNhjjorW3fuBhkcs4ssh6ewIeUs7ke
 9QCg==
X-Gm-Message-State: APjAAAXZZbkhX5EjgOQOjOmg3HdI/8N8uak2wVoBAfTWpgFnazANlzQF
 ZCe3XILmp1WnJiySguHjK+OrISQGOrIOgHKXl80=
X-Google-Smtp-Source: APXvYqxWwfcmGTDl+DuC+1fhSWoIMNHIvnFf80kc1/OMrvPJ8J03NdvpTRjTK2e4pBc/73wQ2BT1X0Drawy8cKlnwzE=
X-Received: by 2002:ac8:7545:: with SMTP id b5mr94541008qtr.234.1560910369972; 
 Tue, 18 Jun 2019 19:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-9-clg@kaod.org>
In-Reply-To: <20190618165311.27066-9-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 19 Jun 2019 02:12:38 +0000
Message-ID: <CACPK8Xc80XFjJ_o9X4i_LtpCqL8c00rmLKJ_Tio5XP=XEOhTow@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH v2 08/21] aspeed/timer: Status register
 contains reload for stopped timer
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
> From: Andrew Jeffery <andrew@aj.id.au>
>
> From the datasheet:
>
>   This register stores the current status of counter #N. When timer
>   enable bit TMC30[N * b] is disabled, the reload register will be
>   loaded into this counter. When timer bit TMC30[N * b] is set, the
>   counter will start to decrement. CPU can update this register value
>   when enable bit is set.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

