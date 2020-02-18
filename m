Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F327DC34045
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C4521D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByPbfQUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C4521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j45Tl-0006X2-0X
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j45Rt-0004n6-92
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j45Rs-0000xq-6M
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:10:13 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j45Rs-0000xO-16
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:10:12 -0500
Received: by mail-ot1-x343.google.com with SMTP id z9so20020590oth.5
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t7p2AL800g0tA9mPCX0eHjCpMAO5vYg4IbIyHr0cdy0=;
 b=ByPbfQUP3lgO5vT8Jz9QW6W91b91T9clri4jKv0neji9tEQ9X38q4vIaxNdbLRJ0lU
 /rofGgLJmBkL5eYRVIM3TyQqJnMnxhbtTrlLrEa++k+WOqevRczOsiacXkxueHUXqz+Y
 3LuGHuilad5X2kohuWbYf0sEP6abTgv07FAZl24zvkuEeKyC8buvA6XTXNDAwDPULrqn
 IJsRVGnqB6VFHhihEhCJh5nBvdzSZueVJ5CDilvpCDRl4srLXR21YRObu24XnXqZLwYO
 VdwvbuRLegk+esdf+mzTHuc4KDmfA8d+xOCfCINBYwA/HgVD3XoA1MeiVJ2K/aqHR6tH
 xfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t7p2AL800g0tA9mPCX0eHjCpMAO5vYg4IbIyHr0cdy0=;
 b=QeiIHvjCpWJuKiV4pE+cxAPN6q5TzUqOXltVuEQlOeepudECE2XQcVRXv+8j+26zTq
 +t2tKIMxl1lIBT8fohDSPTsvzu1gGRLtsMc03pHjExWIuokUS6y4gP5CniNit2uYX+Xy
 FAF6V5VLRBLiJj0jM38YEONJF5uPWl4vLklfKizus1X7gph9+VWFa21TM0j/tEam2jDs
 i05On8RpKG9O+WAuQRwadzTBL5ySzobgD236XQxdGfY8ppQGCUmP4hRZuortKtvhhFoT
 kDghzeFfzhxop9Nq7P9YiXtuKm1SXGR17JT4MWP4zBT3ZWuQdyPxBn5kjPW5gmoaPEL2
 KRAA==
X-Gm-Message-State: APjAAAWak2fmRm2Q1g9EBIDt8yfNfN5AeLcDfxVHv0CMGmZtAOL6d91C
 sIxcuRBvTTsfLPa0QKy8gtpDbZfohhE7rrcd63g+BA==
X-Google-Smtp-Source: APXvYqwjATfNFj4bOWZz8ri2qFKwZTDi1nZRVMq8Wf1fQTtowABJ9FAV39WyJiJrU6k4MFg97neSTmE9e6ywoWb0eZc=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr15564957otq.221.1582042210952; 
 Tue, 18 Feb 2020 08:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20200217132922.24607-1-f4bug@amsat.org>
In-Reply-To: <20200217132922.24607-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 16:09:59 +0000
Message-ID: <CAFEAcA9OtE-S5HX1_HB3+Y1Sf6idFDipsCp_oz4y-G10xXBzgQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt
 Clear' register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 13:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Fix warning reported by Clang static code analyzer:
>
>     CC      hw/misc/iotkit-secctl.o
>   hw/misc/iotkit-secctl.c:343:9: warning: Value stored to 'value' is neve=
r read
>           value &=3D 0x00f000f3;
>           ^        ~~~~~~~~~~
>
> Fixes: b3717c23e1c
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v3: AND the register... (pm215)
> v2: Corrected bitwise-not precedence (pm215)
> ---
>  hw/misc/iotkit-secctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

