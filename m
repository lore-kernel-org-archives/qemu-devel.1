Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A907BC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71614206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGz95uB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71614206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY60O-0008H0-V9
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5zH-00072j-Nz
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:48:43 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5zG-0000lU-RK
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:48:43 -0400
Received: by mail-oi1-x243.google.com with SMTP id o24so14697439oic.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jLHPBC0H4IGlejcDmPFNjwEn4/1nzZJ4WYBrN4gYvxI=;
 b=bGz95uB4d5Eh2741D+h4Mu+83Zkz22IaLbmGFzQ1NGvrFEm0wy21qluAigCqmb485m
 WS0hwWCDZmE0e/2itT16IlGrIOxU2T6EkQMqNnks4diUT6EvKrXxfCOCOh4fSNF19JFn
 RwJNC5DSgVMqpz7zQrcAirryLN0JSL98v1X3Zygtg59PvEhU7Ysg1PTPfPnVJ+rscP9K
 B/oWUlaK6M5hjOC4ZbEfOurEHNtafJG0nk03m8eQd79hRsNNskUczetvg+9UFcL/+CDY
 XVcVgUnm7g68iK7OnasGMlcshYIwG6xzuVV1h6UF34ZCePrJykvWdB2WfTKNn4e5KSO+
 L7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jLHPBC0H4IGlejcDmPFNjwEn4/1nzZJ4WYBrN4gYvxI=;
 b=DDDKyqek5Hr9LHXTgVskWMdsR+V+XbQb1LAQvdakm3GA8syH90vhn5afsL0dEJrYb7
 256mTFACh9OiaLHz0mN2z+fv2JtgJDnPiqUf+gb1lEHSCM+jJynaD+honQ4J35sWu0J3
 lINSCZCjxTkcVsUgSC19HiB0VBtn0v+/4XkB2RWY5dAKZvQRWVHn+j5mHPGjA35F3xzN
 d7ovB9il+bJ3pOfE7GwLFMmRa15xZ1gAZrKhxYYtbqqlsQkf0l2uQowrrVhCt/PU2EnN
 RD1cm3b6sQXYQ21dARagGMUzEf0SX+gOSUb8zKTHVOH8HOkulNC9mGt1UTYrOWYixXHK
 VGkw==
X-Gm-Message-State: AGi0PuYxqq/i+27nalV2fW46jk7Dd9ink6olrp0EuNs2sbrsRhCS2Phm
 gZEI7/zKf2ofYQPumkvy6nryaY8HDCSNYfjor2R9hQ==
X-Google-Smtp-Source: APiQypLR8o4xaAqmxYdmaQXwZocTYHMvGVYPRIc/hM9kNZGXXyzCoY2/LQXA67XGCBb6p+vUgOsfzl3mZg2bFnq/Uy4=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr17938204oia.48.1589194121552; 
 Mon, 11 May 2020 03:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200504172448.9402-1-philmd@redhat.com>
In-Reply-To: <20200504172448.9402-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 11:48:30 +0100
Message-ID: <CAFEAcA_kV8HzHv3xuPRPMKC4JwH8BDfskWqwtDJ=tHMVt0i_Gg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] target/arm: Restrict TCG cpus to TCG accel
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 18:24, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> These are the uncontroversial patches from "Support disabling
> TCG on ARM (part 2)"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg689168.html
>
> The other patches are blocked by the "accel: Allow targets to
> use Kconfig" series:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg689024.html
>
> Patch #4 is new "Restrict v8M IDAU interface to Aarch32 CPUs".
>
> Since v2:
> - Fixed set_feature() clash trying to KISS
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg697523.html
> - Fixed aarch64-linux-user build failure reported by Peter:
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg699319.html
>
> Since v1:
> - Dropped 'Make set_feature() available for other files' patch
>   which fails to build with KVM only, see:
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03843.html
>
> Many thanks to Richard Henderson for his patience (again...)!



Applied to target-arm.next, thanks.

-- PMM

