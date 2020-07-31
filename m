Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87EDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D25208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C02GibLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D25208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1REP-0005DL-SC
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1RDo-0004fy-To
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:21:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1RDm-0002UQ-6H
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:21:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id l27so15016174oti.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=p/bq1ZJ8SLs8bMKBvzOj1go2qGbYrZnb8EtXbiteBAk=;
 b=C02GibLjlOL82nBjDWyOvyZwfySCAyzA9n8x7f1ih+905rSmdjPodI3yILnbZ7Xa90
 9V2VP8s8tI5uXtBRtL1MB9tP2yihn0A5Z+IHqd4emAYWsaLQLlpPefrfFcR7fZnnVNnR
 OudbXZCbXTzjHvxntsPkC8R4YQb1zBpOA8tFYkuEM3WX9IN+tXyy92rsNj0N/CCeC287
 ZqwvNH08I3NWTlAYG28+Sui4nrVa7il06lC5OcOSnRXIBqUvh6431tAs2olnRwIvFDGZ
 G9uR3bxB7DUPRhJ/kNe62tbwfKm7ejJDlJBPswNoipddiyjrgIDWPQcwzaO5P96Jlsjv
 cPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p/bq1ZJ8SLs8bMKBvzOj1go2qGbYrZnb8EtXbiteBAk=;
 b=QydMroQzZMgoldxAfR92EEStd5OAkp1Tz9h30cOwB3w9yzRZs9MWivxzBGpH6sorE8
 z8wDZF+2cdqQiX46inHUfLj4L0GnrAFHyqhi2dV+fPmyTDk5NcX6cZo+2NbXMLqHErSJ
 viAXcMw2fbzHua+/x9J/V8FSEAKiwLywkp9aCpe2jk0JQDlzPSrvGwMlFzhdAv6z84B/
 W2Cj2Y4Sk9fcDN9ugzz8UzcgK75Rx55HtEuPKzl/XfMMw8O07IwdtiIfuxZhfz60ib/4
 WF6N1HnGjD2QHR+nAu2EhH1uvNdo0MLmDeMWT9d2vSQg9iut5mTHofK4zHgmwYQ+afQl
 9BTw==
X-Gm-Message-State: AOAM533J7oAJk6CWJixez8po1GwyPAIVZ22S0O+RTUjHMKtNv58+TyoG
 oZAixZ8f8Oq++F428Ax8C+BBTVFSzcLHsZB4x28Jbw==
X-Google-Smtp-Source: ABdhPJwapDJ3/BvoWinp7g1cpPFzBGpErvwdhDmsRbyxQatoPUO5VL1cSrMPfA75ZVsT9U2d+BP/Vlvc6X8g5k+prq8=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr2147241otb.91.1596187256519; 
 Fri, 31 Jul 2020 02:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <1596186433-17364-1-git-send-email-likaige@loongson.cn>
In-Reply-To: <1596186433-17364-1-git-send-email-likaige@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2020 10:20:45 +0100
Message-ID: <CAFEAcA-yTM7=Q0V1_8fSUa7KnsgQawcP=Jnh4J4oCrhFAt3dXg@mail.gmail.com>
Subject: Re: [PATCH v3] target/arm: Fix compile error in gcc 4.9.4.
To: Kaige Li <likaige@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 31 Jul 2020 at 10:07, Kaige Li <likaige@loongson.cn> wrote:
>
> Error log:
>
> /home/LiKaige/qemu/target/arm/translate-a64.c: In function =E2=80=98disas=
_ldst=E2=80=99:
> /home/LiKaige/qemu/target/arm/translate-a64.c:3392:5: error: =E2=80=98fn=
=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-unini=
tialized]
>      fn(cpu_reg(s, rt), clean_addr, tcg_rs, get_mem_index(s),
>      ^
> /home/LiKaige/qemu/target/arm/translate-a64.c:3318:22: note: =E2=80=98fn=
=E2=80=99 was declared here
>      AtomicThreeOpFn *fn;
>                       ^
> cc1: all warnings being treated as errors
>
> Add an initiallization value NULL for fn to fix this.

As I said, I've already applied this patch to target-arm.next,
so you don't need to do anything further. It'll get into
master probably on Monday.

thanks
-- PMM

