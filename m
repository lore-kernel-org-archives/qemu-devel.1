Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34611C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DE320899
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/DbLcPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DE320899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlrj4-00019N-9Q
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlriM-0008Nk-4N
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:24:10 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlriK-00055l-Gk
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:24:09 -0400
Received: by mail-oi1-x244.google.com with SMTP id p70so4565450oic.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tGkeKFpIMT0TZNdmooxrOqJST8B+uIzbNuPp44vhAac=;
 b=c/DbLcPpFSfT7QjcQhCgVuRh+8QwLOuTX0ep1K9aNne8YlpSfjNr6KGFnlAyHRW2G5
 4XPnczun+fj6nYCWSYNsCtZM46F0DXJL6qVrRHAkj/szPgj8oxCP8iZuAwDUoFaHIV70
 VNZTn5Ze0o4t5h77n9NwG1A5zCOVBazKKzeKu+4FnNStmb86AaHtiveFKcms1J3itB/3
 Ht+Mnjl9uz53gE+9tQhRFroiu0rmeZld24TrON279PW4nSbi9yp0LvBIrYOBwtSai2Qx
 kCV+BQppWuiiS0k8kXHENi/BwtgH2j01xX6qM9Hb0Y0bf8FsAxLIHrpvzIs9K+Z2omuZ
 uQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tGkeKFpIMT0TZNdmooxrOqJST8B+uIzbNuPp44vhAac=;
 b=SWtYoDTXBGn8NTi5kHkjH1XLM8SEp7YboImQAoXAsYrx06n9I2mzAam4VGsxvzmzC2
 YK5REDECs3iBVLnfUBqi5IGTony26U3djedN7UoJ2ybBoz49vjjSUKC4UGDKEdvWUBBH
 C9cnVVIO88hocmqNWYpKjKpXGZtYMiJOPpdQsj3sFaZTdgju+0fCyhMuOLCw6DFCuhOy
 gRa5uUhBAqNVAK9kZrm9vtK50faUVLZvMqywqK0GSDGlRPlvPCrf6FDjn69rE8zkG5e/
 FjwJ4uKTpkeQFrksFyvDkubeuq98yN3l1N1BTE3e0voiuxljbfxlPVvb1FIMN9J/UI8C
 zDxQ==
X-Gm-Message-State: AOAM532wN+huJVRdWtMT/nfN3KwHAk94JV+ftaQSonbASD1+9JHVk7XJ
 QHcFzrmzgAKZMJj8ZHWl1PD7u8FWRs6BlaUhJMmNHg==
X-Google-Smtp-Source: ABdhPJzTPTmet2a12MtJ1E7AbOqCja9Jda/qR/xNAMxqxaAh5qnzwNnOlzRHTcxj7vV9SiK0DhdGfC7+QLwuMKf4rTI=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2247754oia.163.1592475847434; 
 Thu, 18 Jun 2020 03:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200615201757.16868-1-aperamak@pp1.inet.fi>
 <CAFEAcA-eKboVf3uk4iY_A9_uQ=HnGyic4fzbzJhv1gH2V+TMVw@mail.gmail.com>
 <fdb9eabf-2663-f2e4-6b40-2455261eaa46@redhat.com>
In-Reply-To: <fdb9eabf-2663-f2e4-6b40-2455261eaa46@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 11:23:56 +0100
Message-ID: <CAFEAcA9sCJ6wKdra+EBFOJfOaZbtOE0DND6S6rh5jgrDqLG57Q@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/gus: Fix registers 32-bit access
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Allan Peramaki <aperamak@pp1.inet.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 at 11:22, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 6/17/20 10:23 PM, Peter Maydell wrote:
> > On Mon, 15 Jun 2020 at 22:23, Allan Peramaki <aperamak@pp1.inet.fi> wro=
te:
> >>
> >> Fix audio on software that accesses DRAM above 64k via register peek/p=
oke
> >> and some cases when more than 16 voices are used.
> >>
> >> Fixes: 135f5ae1974c ("audio: GUSsample is int16_t")
> >> Signed-off-by: Allan Peramaki <aperamak@pp1.inet.fi>
> >
> > This patch is quite difficult to read because it mixes some
> > whitespace only changes with some actual changes of
> > behaviour.
>
> In such cases the author might add a comment in the commit
> description "this patch is easier to review with git-diff -w"
> or other options.
>
> Allan, can we get the patch with only the changed lines?

Is it worth the effort of a respin at this point?

thanks
-- PMM

