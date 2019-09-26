Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92240C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D169222BF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="T91wRr4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D169222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPF8-0002DH-AO
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iDPB3-0007zQ-5k
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iDPB2-0004eG-5f
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:31:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iDPAy-0004ax-HG; Thu, 26 Sep 2019 04:31:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so1039775qkg.8;
 Thu, 26 Sep 2019 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cg2ut29QP6u7q8oVmEl3m422EvhLFg+tMxF6PP1oBiY=;
 b=T91wRr4AEZJFUe4X88uhzhUp8VeYkVsoSFegtWzltCWPMaXi7jl3KuMY+MqAfMuHh+
 hANp+0XE23eEpYl0Km4xSWTeVHAeLF2OWiXEGroUpOntlbyNx/96TnBD4DIFo5Gs8Kd6
 5SGoD8bcxZlgF9h/ERHsvERIgLJBtLA+Qiu6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cg2ut29QP6u7q8oVmEl3m422EvhLFg+tMxF6PP1oBiY=;
 b=a171S9rvpvVSAQHd9qJQ/gTM8P8Rm/LPs+SuQhhv3xuStHjGm4dYlyYbC6W0qG4k8G
 Lq/ddCre8uFZinHVUgRnurkrSp8oFA/IMapCxwvDz/FRsH4+Xp12ONHiItWd/z9d3RkN
 839Y3NvojXnLKkml4PrOxIc2gieWZbE3/25mBrLUcR4a77Maa2e72JZdCrDGN6k1y4fR
 GeB9o5T596N5vaEjIMW4HNVUR319x4f9Aat7hBi8koWPqD3nM7rVLywk8zGBjJoR5dfO
 LqX8V38y2S9oifco6ZkqsH3zqNmoj8Z2cBcVpXrElhii3KIOWqN+LWLMx99JKshPG03d
 gEjA==
X-Gm-Message-State: APjAAAXCprS5fa12z65f4uJHjusJW0SE7UPswXuI+uXg2+Av7LzWD5QT
 77MUvHj6dzdjh0/uwXkI/Ox1Ji623xClRA0ZkuY=
X-Google-Smtp-Source: APXvYqzcHZrSrHvGD93jGxOvUS62g4Qf16uNfuqo6DrCGHl9QKJkfipwvFKKVce+Ybo7zCxkhMCCWQr6hUVBQMStuhs=
X-Received: by 2002:a37:f61e:: with SMTP id y30mr2064158qkj.208.1569486597084; 
 Thu, 26 Sep 2019 01:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190925143248.10000-1-clg@kaod.org>
 <20190925143248.10000-5-clg@kaod.org>
In-Reply-To: <20190925143248.10000-5-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Sep 2019 08:29:45 +0000
Message-ID: <CACPK8Xet=D0bu1w_AxdGoK90LuDF9CU=GJjDy6Zu4SC24068ZA@mail.gmail.com>
Subject: Re: [PATCH v2 04/23] aspeed/timer: Introduce an object class per SoC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.194
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
> The most important changes will be on the register range 0x34 - 0x3C
> memops. Introduce class read/write operations to handle the
> differences between SoCs.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

