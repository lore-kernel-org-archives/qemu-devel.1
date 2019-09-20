Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD8EC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524C520717
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Am4ZSFzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524C520717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBB1V-0002U9-0h
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iBAwf-0006pC-FA
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iBApL-0007Ux-MQ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:47:29 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iBApJ-0007SJ-S5; Fri, 20 Sep 2019 00:47:25 -0400
Received: by mail-qt1-x842.google.com with SMTP id x4so7192535qtq.8;
 Thu, 19 Sep 2019 21:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SGI5ruWsSFpsMLLBU0QfsgY3oUihUxgZdf+94AkfPSc=;
 b=Am4ZSFzJWYV/fGQ2qitFkVSdvU4D+4y949Yw522yufJgYpO9zpgAeZAUn76RbNpmwL
 87Adm5detDnw42+bdL/o/Axj7GQ58wfd+5LyVcc0zOwTGZHsPb7CYkyVwCXvcjlYpek6
 Vwrf7Tc86srhq6795QmjN+2vrpFHbwwLQ2BE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SGI5ruWsSFpsMLLBU0QfsgY3oUihUxgZdf+94AkfPSc=;
 b=FWgV6hzsvrFluCss7pApgDYocvEEN60mEFWr642B3i2pPKr7UblIk28EwAVLBleiFr
 DwSVFLyKHDQiXFW3KWkjGiArOHtxi7ZbJb+cHdQfdGEQGbJXk6w+Pop+pW8Dh44eFvDu
 35PhfQOvvGDROhNEkQ+gnuEY7IOkAGX9atitf0Jk/p8srmws2zNRU/JzEh4Wt70/G0Qu
 QgmNwNn+4AcJOtRN4wypjJQquWWZNbGm6EZ7PKnxPMD64kHyDNEXlq34548jmuMFcKTb
 iwbtz6JtaE+4Jqf9+dxGingHgnTi6H36RPgbkEe09ohNJXUDPasDtfYSsA6AR/kbnbfx
 Ma+w==
X-Gm-Message-State: APjAAAXetEgwpAUzzHgs232i4gyUjOzsyuz62i9ArXO48NGfPW13V/iL
 GqQYsUo9RhptqbFTXFDJL8o/ukbk1rVywT9chtQ=
X-Google-Smtp-Source: APXvYqxIsyfxOCt6Sf2z2YpXN8BLujmtAyyVaBoiLO0A2ux217/2J5AJF12cDpsjCnETpttGkjMdmjGGEqN01ef38tI=
X-Received: by 2002:aed:2ce7:: with SMTP id g94mr1207553qtd.255.1568954845006; 
 Thu, 19 Sep 2019 21:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-15-clg@kaod.org>
In-Reply-To: <20190919055002.6729-15-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Sep 2019 04:47:13 +0000
Message-ID: <CACPK8XdbprvDGcYwhA=twT1osJ1EaUj8cveSZZkMPxfvtn42ew@mail.gmail.com>
Subject: Re: [PATCH 14/21] aspeed/i2c: Introduce an object class per SoC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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

On Thu, 19 Sep 2019 at 05:51, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> It prepares ground for register differences between SoCs.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

