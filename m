Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DEAC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 19:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27DD206F0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 19:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APeXcqhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27DD206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jf7Va-0000ty-7L
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 15:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jf7UT-0008QJ-6u
 for qemu-devel@nongnu.org; Sat, 30 May 2020 15:49:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jf7US-0007pX-BW
 for qemu-devel@nongnu.org; Sat, 30 May 2020 15:49:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id j198so9152181wmj.0
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D881Q4VgfP1dIasnveG6AwX+Jl9WlfnSXwgz8u/snRA=;
 b=APeXcqhCrzR7Pq72DQCROa9ZWeTaWACF1lDvXhn5eyY6k9yrKMLRi9xIh6RTLP7mS/
 fZwPMmgen+RSGkUh0Y4sWxYWYNbwIlGrJBapJieONQeVcl+Ux3Zwm4cKHSUPTbxVxN7P
 QoSalaN3tJSQ3jJzOTmTz9zkVt6tFpR955pzowiLoAHpmJKOnu3bLGkpE+ZtnwB1T/ba
 ubNfB/wvTXkzkfwUH93xtbVpw/vogva0mpQjW31f7CKMRXmlGkIEbFVT5g3mykpzxOUi
 uSbIRxQk13dyz/YyMYF/TI668nFC1IK2Wd8i6WnFfY2brjTSgihIaIRwuqmzgwzCJzW7
 c/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D881Q4VgfP1dIasnveG6AwX+Jl9WlfnSXwgz8u/snRA=;
 b=pb9xCnWVtAe+l+BRVMYYvJ7E38z9KZRZO0g4bP4Sr+VL0oblj/B/jEIXdSlENa0pn0
 2wTCJmCnBZxGY56yjAgWjBCEmo/JBt8D+h4dr8Adlh5Pq8nRgFL4njAtmg5JZDu8HyCd
 gmKvk+Lc4BeE9hIwIew/gZ4XW3zCKVp79Ll9oNp3XFzThoVgkZLGJ8J8GkZodOaQkDIW
 6Jt8eagUjirNGMb7PY8umQU7rbMVccUPPpJUkUjXKJX6MKxe2lbnouSmNh+jnd7+DZNU
 f6W+iQHrlNMo/gMNGZqxWX4fgC54fGZizVavXqKC2DCrBRaSgnniraoov0pepj6jqTZP
 adMw==
X-Gm-Message-State: AOAM531QHN5vhLlonbpgMGj78JAhB7KC0UwDiy4yxeFQ8A8ZtrGLn5ZT
 sm6Rw7yGMc8rx1p5k8zi7QQsvmT9uTwNxnpAonc=
X-Google-Smtp-Source: ABdhPJySGFsX25/TObzX9DMZlIyNYADHUUVjXRTIuT2z1lTIr5OQNJZ0+HY4bYYMIr+MC9zDssyqvnEIC8Jiy7fOwPE=
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr6723545wmj.159.1590868194672; 
 Sat, 30 May 2020 12:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200515164337.4899-1-thuth@redhat.com>
 <CAHiYmc72cA9Va_JCbzq+E0M3wUuxedH2=BdE-YqAqWF8DBD_kA@mail.gmail.com>
 <658ce012-150d-40ee-0689-0262971e20b4@redhat.com>
In-Reply-To: <658ce012-150d-40ee-0689-0262971e20b4@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 30 May 2020 21:49:42 +0200
Message-ID: <CAHiYmc4R5QE=r7--BE+XGFh_j2bfSANou=GdUPJq1FOfa_mQrg@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: Add boot tests for sh4 QEMU advent
 calendar image
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=83=D0=B1, 30. =D0=BC=D0=B0=D1=98 2020. =D1=83 19:25 Thomas Huth <=
thuth@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> On 30/05/2020 10.54, Aleksandar Markovic wrote:
> > 18:44 Pet, 15.05.2020. Thomas Huth <thuth@redhat.com
> > <mailto:thuth@redhat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> Now that we can select the second serial console in the acceptance tes=
ts
> >> (see commit 746f244d9720 "Allow to use other serial consoles than
> > default"),
> >> we can also test the sh4 image from the QEMU advent calendar 2018.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>=
>
> >> ---
> >>  I've split my original patch that also added yet another mips64 test.=
..
> >>  I hope it's easier to review/ack/merge this way this only addresses
> > sh4 here.
> >>
> >
> > It makes sense to me, Thomas. If I were you, I would do the same.
> >
> > But, sorry, do you intend to send mips64 counterpart in future, or it i=
s
> > already sent, but I somehow missed it?
>
>  Hi Aleksandar,
>
> I was planning to send a separate patch, but then I noticed that there
> are already quite a lot of tests for the various flavors of the
> mips-malta machine in tests/acceptance/boot_linux_console.py ... so I
> currently doubt that the malta advent calendar image will add much value
> here?
>

I'm fine with your judgement.

Glad to see sh4 advent calendar.

Best wishes,
Aleksandar


>  Thomas
>

