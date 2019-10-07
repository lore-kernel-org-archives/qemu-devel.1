Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D2BC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4ED2084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4ED2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHOt8-00008T-Kp
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 05:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.kozlowski.k@gmail.com>) id 1iHOrh-0007u5-Ed
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.kozlowski.k@gmail.com>) id 1iHOrf-00037q-Vb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:59:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <k.kozlowski.k@gmail.com>)
 id 1iHOrf-00037g-Pp; Mon, 07 Oct 2019 04:59:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so13427340wrq.10;
 Mon, 07 Oct 2019 01:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=utwvcIpWoCf4fLYtGad1B4OrN11KTAkB3AP1bTyt7PQ=;
 b=HOmrljLX8QaJ3gZlRUZ2IzOeRa66JbzbLaZonyzIKoVdsYSnzybVjf3+qXi1fX8CaV
 seKZdZpWG6/9m5ySyqI7LEwOUlaxCkNnwTJTFwCC/UaQO4HkFb5qnskrkCOEuVwafecH
 YulAuEz+iG+dTB0uweq8ILDq5Rqi796/fmcmPASvjhiBDEiBVOfdHhtakXHz1l8aNTsD
 p0YlAQsIaXt/JoeoanXIFZbkJlogMOiW1DEyI21Ah7sDM4H1K0PZ0GaFUE/M4HfeL3UA
 waoj7WGb2OxUgLtK64DzekP1W1CLQDV5x6J1ommuNf+1gUppl5O+sk03Ne8UDU5Sc0BT
 2qyw==
X-Gm-Message-State: APjAAAXgzBEQ45IuESbHpvSogDGfydiyPPW7FCjSJACjvslCg+xT6ZmE
 1EKIFFknlsfV3K7QcAYZvwo=
X-Google-Smtp-Source: APXvYqx+pYtDBfq77StySFbOlL/TxSS94tnS3HgqEwqlT3ehwcV5WckpH4hmEalZZMvEXzV53jIURw==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr23288468wrv.68.1570438774311; 
 Mon, 07 Oct 2019 01:59:34 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id r13sm24744576wrn.0.2019.10.07.01.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 01:59:33 -0700 (PDT)
Date: Mon, 7 Oct 2019 10:59:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 3/5] hw/sd/sdhci: Add dummy Samsung SDHCI controller
Message-ID: <20191007085931.GA541@pi3>
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191005154748.21718-4-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Basse <contact@fredericb.info>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Cleber Rosa <crosa@redhat.com>,
 Maksim Kozlov <m.kozlov@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 05, 2019 at 05:47:46PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> The Linux kernel access few S3C-specific registers [1] to set some
> clock. We don't care about this part for device emulation [2]. Add
> a dummy device to properly ignore these accesses, so we can focus
> on the important registers missing.

The CONTROL2  has also few other settings, not clock related, but they
can be skipped as well.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/mmc/host/sdhci-s3c-regs.h?h=3Dcc014f3
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/mmc/host/sdhci-s3c.c?h=3Dv5.3#n263
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Eventually we should add the ADMA changes Igor sent in this patch:
> https://patchwork.ozlabs.org/patch/181854/
> They might solve the boot timing issues when using SD cards.
> ---
>  hw/sd/sdhci.c         | 65 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/sd/sdhci.h |  2 ++
>  2 files changed, 67 insertions(+)
>=20

