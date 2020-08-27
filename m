Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1452422B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="WhGjmAyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1452422B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGfv-0005Le-65
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@walle.cc>) id 1kBGbx-0002Jv-3l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:02:33 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:57833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@walle.cc>) id 1kBGbp-00012E-TI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:02:31 -0400
Received: from [192.168.180.155] (p50998fbe.dip0.t-ipconnect.de
 [80.153.143.190])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id 29E7B22F53;
 Thu, 27 Aug 2020 14:02:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1598529738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UE8WhxeuQL2BJBpDscg3qP5GoRovosWz3UqAS9nwlnY=;
 b=WhGjmAyUAlX1ULz2zGMmY4NJhw15b+qUeohetKfCuwIoet5p+XiOF8UhBuM8i9M9Bw00Hh
 /hqtNz3nlZ/6bvSZIIaUHTaZ6nEqvC/h9qrND49p8Be7+w656aMqPnlBk1k0ZQ7NvqYXR4
 zWLbPJAEV8bbOP6HzGZ85F3Z4jsISMo=
Date: Thu, 27 Aug 2020 14:02:14 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20200827113259.25064-1-peter.maydell@linaro.org>
References: <20200827113259.25064-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Deprecate lm32 port
To: Peter Maydell <peter.maydell@linaro.org>,qemu-devel@nongnu.org
From: Michael Walle <michael@walle.cc>
Message-ID: <AC5F071F-2965-4401-858C-2E4373C052E4@walle.cc>
Received-SPF: pass client-ip=176.9.125.105; envelope-from=michael@walle.cc;
 helo=ssl.serverraum.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:02:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27=2E August 2020 13:32:59 MESZ schrieb Peter Maydell <peter=2Emaydell@l=
inaro=2Eorg>:
>Deprecate our lm32 target support=2E Michael Walle (former lm32
>maintainer)
>suggested that we do this in 2019:
> https://www=2Email-archive=2Ecom/qemu-devel@nongnu=2Eorg/msg605024=2Ehtm=
l
>because the only public user of the architecture is the many-years-dead
>milkymist project=2E (The Linux port to lm32 was never merged upstream=2E=
)
>
>In commit 4b4d96c776f552e (March 2020) we marked it as 'orphan' in
>the MAINTAINERS file, but didn't officially deprecate it=2E Mark it
>deprecated now, with the intention of removing it from QEMU in
>mid-2021 before the 6=2E1 release=2E
>
>Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>

Acked-by: Michael Walle <michael@walle=2Ecc>

Thanks,=20
-michael=20


