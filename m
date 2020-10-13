Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C145C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77071214DB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKW4A69z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77071214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIKa-00069D-EC
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSI8a-0000xl-8Q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 07:06:36 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:35272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSI8X-0007Qe-ST
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 07:06:35 -0400
Received: by mail-ej1-x635.google.com with SMTP id u21so27664604eja.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 04:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/C126p7BpyaMEvADAJEjb+nfleY5q/1Dy/V1iZCjhgc=;
 b=NKW4A69zb5D/Tg3iY4dd3p35TIzs+jf4xN8ZdljBEC8s2rct/SMTYDY6FdErSQsTKw
 J2ocStDK1joJVn1klDjoLnjxVTejdpNX+XFGrN4r5zCv5q8Jda6twNr9L3sMhnJFPKoL
 Vrr+BpLKY4sTCx1JXST9DsPDIsaWu3GI+fbE5GvJ2QYGZbywzule2bkZZpytXmb5V4Cg
 D8XtzPBWNeVRMEOQUJdDsAcipRsYVTTOmOLsNFIyYX6aSEKyDqro+tIux+jJRvWBRlej
 h58jkxkHlBp57yLzAEndt13KwON0mdRfSxjaOw8K3CBBBDt/tnf4uo2dwnJfBjc8Cv/A
 VnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/C126p7BpyaMEvADAJEjb+nfleY5q/1Dy/V1iZCjhgc=;
 b=tkFyVZ0NGmxQYExJWLB195Gs8tMKkXYKjM2ujQ96UfrQdvBwlGVEk/bmfAAIKy8YHz
 bjkJshdFVju5NaeLKLRH08wJKqd3am0saOez0MBb3UD/tHqxr15DoFgmqX/TydEu5mkf
 60UjloRXrO3KKK0tUf7yd4BUz5QEffCcQnzME0qFI+LOabh4J8qCQIaKkzCnvq0U71po
 gEdt/3y3uvp6dQD5Wn55smhzKSNd7Srq45gXadvDY9UhMbQNvhJ14INoaLg6zQ5hSkVb
 Lgq3BeluqQz31xGCHD7cSalpcirpLfpp7ZM9vVOKnajn+WPM54srwK3AEuNKYlFBQc+O
 +RXw==
X-Gm-Message-State: AOAM5325YZ3XtRbvWCHQFBgvUkt3V1RhCVuOSuAPIsVE8EQrkedauyGc
 17SpwDKmqPE3LVtpuu3zVjA1jzwKbChdWuVUIAj56Q==
X-Google-Smtp-Source: ABdhPJyxZbZn4hFA7PFB0IeloYL0WNDTzzHRPJmSnwMoVuyxkFVLlYBRts6qwJ8K3xASjqNkGk0RFf6GPkchVCjC+5U=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr32156139ejb.482.1602587191266; 
 Tue, 13 Oct 2020 04:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201013065313.7349-1-laurent@vivier.eu>
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2020 12:06:20 +0100
Message-ID: <CAFEAcA81HdRLh25MoC+=ZS7TERAzbZt_Ns+-Lp=oZFL69nMsoA@mail.gmail.com>
Subject: Re: [PULL 00/15] Trivial branch for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Oct 2020 at 07:56, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 2387df497b4b4bcf754eb7398edca82889e2ef=
54:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-10-10'=
 int=3D
> o staging (2020-10-12 11:29:42 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-reque=
st
>
> for you to fetch changes up to ef3a1d9fc36140f8933fbced70ee21fd9740b33c:
>
>   meson.build: drop duplicate 'sparc64' entry (2020-10-12 23:11:32 +0200)
>
> ----------------------------------------------------------------
> Trivial Patches Pull request 20201013
>
> ----------------------------------------------------------------

Compile failure on ppc64be:

../../hw/rtc/twl92230.c: In function =E2=80=98menelaus_rx=E2=80=99:
../../hw/rtc/twl92230.c:289:23: error: array subscript is above array
bounds [-Werror=3Darray-bounds]
         return s->dcdc[addr - MENELAUS_VCORE_CTRL1];
                       ^
cc1: all warnings being treated as errors

thanks
-- PMM

