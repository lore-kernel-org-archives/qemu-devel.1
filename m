Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215ACC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E5720719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsWHG52B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E5720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaKj-0004Br-2i
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaJR-0002tt-Sv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaJQ-0001H0-Q0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:45:17 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:44887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHaJQ-0001FM-Iw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:45:16 -0400
Received: by mail-ot1-x32e.google.com with SMTP id a49so7594483otc.11
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iIJml/paGDft77iresLwu7OhLTxm+EOldnil3k1PySI=;
 b=RsWHG52B29eyg8Pi3JaQftoGk+yqSXnN4SiIAjTlpSpVDEfJ3SiF03f4swlCr/tpvw
 uIkPGoFOwrJXKE9wRopdMz+h9sefM3mG7nPP4DS+t77b4gbMkTxE0M1b6jL3kVJB26Wt
 gImMG0M02OZ/pzbhyGN+RM8dvVydQnmmO0ELke6JSaccOE3TDU0BCLXko0FiWOB7SqQ+
 So5T1eoEWBERec4c5kbSHY93O7XIVwOKS0Fuj8rdeOJHLeWYnbazADfWzGh7w3yLTjqk
 kPDf9t9WoGRn1bbRJJ6gtemb7LLHYKvIWkljWaqaBO9I3lRVBWiyFiJKYdOFnJufvLHL
 8a8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iIJml/paGDft77iresLwu7OhLTxm+EOldnil3k1PySI=;
 b=ekCM8c6R7jd61WaxCZPDaNHPH18qLnviELhOj8puNrF2yxgZahNSNRc4MGeh2SAAS/
 kqB4nJt+Dv/Q3hCkUF1HZifTik1RMuVoPxpkcVmIo51VusdjYBkHI7y9GssWLtfr7oSL
 5aOb8GvOqSWVryDiOVjoYQ8SjWo6edz913Z7vgNpUHhtXHKQ0k626YXJjIGxxzPGQP5Y
 ZXHt6bjeUkgTLbj6+Ougo56HbPLQYUDR4cLm5Ncfkowp6ho4pU0uFYfnCBGZDx6WCOmR
 Qhj0jZKSQlxoSDQkQ23grj1I5hCTmtP89gBE3w+jZoswnSwgc1kgKr6FsFWHbVzcIzdS
 QpPw==
X-Gm-Message-State: ANhLgQ2TyHszBpG8LywsZBg8L8rWWkUHaVJ5Bh1VCT3UcgVpVRbT3EDe
 qg5aukf4j6U8FREbWKIXjUdg1DjZSOnawuLOwpZRrA==
X-Google-Smtp-Source: ADFU+vsZOKy89PpOxSXvQfJ28qeu8o83Grx1B9VLfGc9Splkvxu67PczFwZDjz23f/xm7P5Gha3y4W3uQsHKoV1hWxA=
X-Received: by 2002:a05:6830:18f4:: with SMTP id
 d20mr5418119otf.91.1585259115314; 
 Thu, 26 Mar 2020 14:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-5-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:45:03 +0000
Message-ID: <CAFEAcA9e8weisrD+2zHsOjGAP0UR513V1mN0RH5VJnd9m5hFqQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 04/12] hw/arm/stm32fx05_soc: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 19:18, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Patch created mechanically by running:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --in-place --dir hw
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/stm32f205_soc.c | 4 ++++
>  hw/arm/stm32f405_soc.c | 4 ++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

