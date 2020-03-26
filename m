Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EC5C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B589F20719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQEU2NIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B589F20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaP8-0000Or-UX
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaO3-00083A-VE
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaO2-0007GZ-U5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:50:03 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:37546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHaO2-0007Ex-KM
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:50:02 -0400
Received: by mail-ot1-x334.google.com with SMTP id g23so7662630otq.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vmLYY/rJrxioBTJ6A3rg5gqalSw/omoc/qj0U0fRPSE=;
 b=yQEU2NIUaXHDdBFNz4pgJz1tMyrv9l34vb3Y0c+nuVoIB8ExwwDNBGsdtn7yywEcQ0
 l4vCc+i0qgYX13ySmSuu65Jq5cAbOdxybDYd+5u39WLfd1UH70wwU4rDHyFoyGwA3/42
 CTew5CcCEVqDh6eWLETY+5yoNv1cHj1HSLExV7XFbWt70WbXLXG5h9OQKCYohoApY2aO
 cO0S4hzl1jI8K+hx5O7wkZAIfE/4vVF+hbPQuJbRPuOdPa3zoF1zC5o4eOHSqDRZymTD
 F50uKR8yfaIyuk+dYy9VoGj+j9NmGNb/w/X6B4wUpJfysTCgwGeLMRaTVUKXYTPGp9t1
 ngvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vmLYY/rJrxioBTJ6A3rg5gqalSw/omoc/qj0U0fRPSE=;
 b=cHoXkeCg6+sW85QBxEbvs8fpCiTCHZINzztIPTRUMdPJKmqew6W3UuzvRfjRDR6dLM
 brNBclmTO09cgHey4MzjqYvVLU3mo2BhHHhyCohHA7hKozIwhhgjtfig9cUMxE5nCQha
 1GFVsrGRZdrE4YFU/6SahXljGMGgSgN7mN2MzwTx0i/MYstiG40k7hlKrmcoInB8BAc2
 ggjJKkjpMJ3JpsAktWj3BejID+c3JSE2Vyf9L0psl91LrSYteF+327Y+qDy2ViibepMy
 pXqY8lcKp+oiM4QUO+dTocM89hsz3qxGLJGV3QEuRP2u01UvJAeBuoz6qUJqfl50d9TY
 Z5qg==
X-Gm-Message-State: ANhLgQ0jKsGLJEEreMqf0qTyavpO9tj7OILMcFydpKzVyOfYBl470RDU
 36wqmlz1lKvW0j1EuXDf6VvPMQx58Jlo/G5dTmAvKw==
X-Google-Smtp-Source: ADFU+vvd8j43oFEZ/E67eihVOeE7Xj+C4BcmTyGRpJ+MwNVrcYS6RfZXUAY/ZqJt3I7OjcuVqt+kEp/MeeMIgiWxtr0=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr8151827oth.135.1585259401764; 
 Thu, 26 Mar 2020 14:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-10-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-10-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:49:50 +0000
Message-ID: <CAFEAcA-2FNSxHaZUuogdmFXSc7DqKHPSVD6f-Vkpnh_pTmXHQg@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 09/12] hw/mips/mips_malta: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

On Wed, 25 Mar 2020 at 19:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --dir hw
>
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_int() hw/mips/mips_malta.c:1193:4]]
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_str() hw/mips/mips_malta.c:1192:4]]
>
> Add the missing error_propagate() after manual review by adding
> a Error* parameter to create_cps().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/mips_malta.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

