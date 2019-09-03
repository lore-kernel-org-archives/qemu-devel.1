Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A042CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDEC2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTBddTOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDEC2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5471-00078u-Hy
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 04:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i546A-0006b7-8a
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5469-0007pT-7L
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:23:34 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5469-0007p0-0a
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:23:33 -0400
Received: by mail-ot1-x344.google.com with SMTP id r20so15890084ota.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 01:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pi/PZdCdGJ+rlQ9IDqkNpKakJT+tNtOHVf3SZ43tHQU=;
 b=xTBddTODmCAvn1d1CsVgwM/HUlXd2LTcWzfFwMF4bMYb0CAhN1RjAPy9teIWTWyFyi
 masWI8b+SKQ4sHr8q584E8Re4cHtqsQtBd+weh9t/eiAZ653jqasLrjXxd49lnERjmWG
 GD4SLTuN25L2gcW7Kny2iKIVdRK2YR2oKgn+Nk5QxqaD8juW00xEPTSUr+fiqY34mzbT
 T0+ymrqrW3d+M3p4eeyckEccHHmW3P4rO6oWKSZLK8c7G7/eJbXJBBP66RkPdPpac/Xe
 C2ktVm9BVDGKqnXw5U+fOXu2QHKDeNqOuB2/FOlZx32aAMPZjtfJjADfRV3GPpvBvavD
 zFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pi/PZdCdGJ+rlQ9IDqkNpKakJT+tNtOHVf3SZ43tHQU=;
 b=Qu0W6BkLsU2dec8ugiG7B2ohf13i9IG7T0oA8JYhelQ3Y7Cj5RWz1zTuM3zPmwvdh5
 iH5i9mtYQ4ae3eK8VBLA3JdZCSU6hNnKfqqbXh+81yoDSEBLUMGMKxiWy7T0BeC1m3yg
 T0Wc2TRXqqbV48W5VIj0zKUOuHkzZzy6f2Z9X/OT8XmQNiaO7xdWJMwZACnw4/WA3hTC
 AvZ+SJXHoQKFrqfPsE7vM3fyM6t14qKaO1ZhPfjyLaSEJLozni0+UUhSmeITtpH0LAqm
 SVbubzV29YHryHEq6ty9waamEdkcPHiVBp0pKKk7lpKxOT7ndYBsOVyebD0dUmfkTPGS
 5JSw==
X-Gm-Message-State: APjAAAUMuePkxWIb/WW84VQJ5mglIn/SZmdrXjlgdmMF0S5KQOccxxIA
 uONhg2tr0EDBf4llT+F3KKBcjK/aV5ytDrVNunCYJA==
X-Google-Smtp-Source: APXvYqzzL3uRhF2R5f+dZdbeZ4ZkdR6tEcpTWtHk7dPrIzII3TJ2Tbb1DCMb0sVLNN/tciicMIb//5DQeKapIAZN5Rs=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr28050474otp.232.1567499012188; 
 Tue, 03 Sep 2019 01:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-67-richard.henderson@linaro.org>
 <CAFEAcA9AbEzR97-2gvpPAbGrGHx_AxGgVhh4-BDufTQUX0gM1w@mail.gmail.com>
 <7f4eac6e-486a-3d99-b533-5fd4ac41864d@linaro.org>
In-Reply-To: <7f4eac6e-486a-3d99-b533-5fd4ac41864d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 09:23:21 +0100
Message-ID: <CAFEAcA-3eqc-85tf_6BYPGDFXyOe499xc2YiV5YoEJMiOmJi1w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 66/68] target/arm: Convert T16,
 long branches
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

On Wed, 28 Aug 2019 at 01:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/27/19 2:34 AM, Peter Maydell wrote:
> >> +    tcg_gen_andi_i32(tmp, tmp, -4);
> >
> > Minor nit, but can we use 0xfffffffc like the old code did,
> > to avoid the reader having to do 2s-complement arithmetic
> > in their head to figure out that we're clearing the low 2 bits?
>
> I always preferred "x & -c" for exactly the same reason:
> to avoid the reader having to do 2s compliment arithmetic
> in their head to figure out that we're aligning to c.

I guess this is mostly a personal thing -- I don't
have in my head any idea of what doing a logical
operation on a negative number does, so I always
have to convert it back to "what are the actual
bits here" before I understand it.

thanks
-- PMM

