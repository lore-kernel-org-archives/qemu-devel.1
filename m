Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2601C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E08C206E9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKGyzHpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E08C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jst6O-0008VM-UC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 15:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jst5o-0007sr-2g; Tue, 07 Jul 2020 15:17:24 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jst5m-0003pp-M9; Tue, 07 Jul 2020 15:17:23 -0400
Received: by mail-pl1-x642.google.com with SMTP id x9so3465974plr.2;
 Tue, 07 Jul 2020 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+aBqs9LPwOIUbBvvI+QYGmRkcw0/BUEJZ7R2yRpMXOk=;
 b=nKGyzHpbBDckSKVGAMqyszrJyyQgiio6j5kX65b5lFeklav3tSJ7ppxjMROXIbbhXs
 /8L0yZdS1+vbRUFf/ohsgR+c9MmSNwyIPqTyK4cYoQifgs5lHY7Ldk9lM1TVlhU0fv7u
 Fg0r+KPC1FkDRWv/U1WCFR9o5CCLJxQaZS3X9FGcouH7OLGt+hsqvTTecaRVCyjkC64j
 4GUFs41YfvJ9uLo7xcTD6YXmlAUKkRYuwg8QWIHLHZGZf/Ywwl9BMyU2nIa+GSs2cHrK
 WyRcCeVZ9CJEdSLTe1mqHRDDk6OsYtZKLHcbqdhcKt+lJwQeq3BkEZf0lkIXWyjQOLKv
 AvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+aBqs9LPwOIUbBvvI+QYGmRkcw0/BUEJZ7R2yRpMXOk=;
 b=Sy7A1hMOWFyVy9kqg8xpUOeMz9LSCRou7bPI3VYkQLrpTtpPlCK7a4XnvuKNkDtVUv
 wLLZ6wOIfyWGr6rPKikxJecru/fyDyOXltHgDiL4Vlu0h+ghU2NF3PIBX1lsi6Lgn0oh
 NM0YqeSG7cLhAO148nI+yTOxP67i4lXNB+ME64FWolZCrGxiOwTwgmswWWpm/4ZgfuAE
 2MvKSTAzSqHpyYTLf04VNfhHQw/RsVrZtVnQVG4mplqpQOEErp0xcSjXGpDluT/KrbxE
 LZO3pfUonzBswo2S+nUet1424GbVas6NPaFm3qAzTl0tqgo9evw1CVv3QST5MZoF/QeI
 9fqA==
X-Gm-Message-State: AOAM532qSFDl2ebcRK8qRvrP1YPnGF8H8uQ8TyIXzRb909gCL2szH7uU
 /7ZgSttMys7wDaRokTmD7DJQhJiK4BagGyKIWWE=
X-Google-Smtp-Source: ABdhPJyx/7FK3cQwBbEqj3B+eEpCZYaARPHFeZRnseKldH6YYO2wXIWbrBibJrXfYWIESsgszzgQ3wokRx8ysk1J5XY=
X-Received: by 2002:a17:90a:20e9:: with SMTP id
 f96mr5950224pjg.13.1594149440253; 
 Tue, 07 Jul 2020 12:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200705174020.BDD0174633F@zero.eik.bme.hu>
In-Reply-To: <20200705174020.BDD0174633F@zero.eik.bme.hu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 7 Jul 2020 12:17:09 -0700
Message-ID: <CAMo8Bf+0Qu=ErRveiA+V7jQhiD=pKj_t=B0dp0CkbDqzquf5jQ@mail.gmail.com>
Subject: Re: [PATCH] load_elf: Remove unused address variables from callers
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Huacai Chen <chenhc@lemote.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 qemu-arm <qemu-arm@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 5, 2020 at 10:40 AM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Several callers of load_elf() pass pointers for lowaddr and highaddr
> parameters which are then not used for anything. This may stem from a
> misunderstanding that load_elf need a value here but in fact it can
> take NULL to ignore these values. Remove such unused variables and
> pass NULL instead from callers that don't need these.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
[...]
>  hw/xtensa/sim.c        |  3 +--
>  hw/xtensa/xtfpga.c     |  3 +--

For Xtensa parts:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

