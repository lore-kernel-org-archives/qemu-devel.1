Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F8C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39AC20663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKSQ7PlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39AC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Pof-0002eN-5y
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Po7-0002DU-0Y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:38:15 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Po4-0002Ky-UE
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:38:14 -0400
Received: by mail-oi1-x242.google.com with SMTP id j11so17443206oiw.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/UNJwj3d7plJrOhPXj88bpJnpjd/Eh3Inh+D5POVh3I=;
 b=DKSQ7PlFWuqAvQ5Ne10Jdvij0ks80RvS9QSpmxu6Gvtx2lYbcnp7XXqlfhrF5J5DCH
 QiucPGqLJaBFzFnLkvxeTPR1DGH+jkJjBqqScktVLTAfe0hJgXliB55KNd1EolIFD/ro
 M1gEbdLPVf+lUSlnE9oZwVTJyk+jquJLACIyUg/ya/Jcjs6L0Z6pLnDKk2RdJfE63CU6
 YlsN7mfCGEcMU4VCOOhNlmrTB/jFWziqRv7WX1RaVD8FxOVgM/QHFWq8HptjHtRWgs64
 GgaqAFBbcPkMA2GY/2Pif++EfaaO1zw0tRuPTLZAkkK9O8lrTqt/vgDfyRzriNm0S8Wb
 Bhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/UNJwj3d7plJrOhPXj88bpJnpjd/Eh3Inh+D5POVh3I=;
 b=OCWU0CLm8W80s7U94d7/qJd8BNm4NSwboOBXgaAMsHso5yWve4bcQW1zXY8CDkFXZh
 n2VDQLnoYCHPnTymjW9oKa7UlXxEvCU7aFxxcxesAbr+m+nAroTmslLLJ8j52dfhqUmL
 nODoAks+T3JnaFNni470B05VZjqt6Uo65WJd5ZDim4/SKUXfydt3X7VbqfzmrzpTznt2
 bVSpOxk3YBY4FRevBBLZ/GVWYUKHRqqrBIAuliOFoTorw6yMplloTC31AyVVn1B+LYZL
 r8hjZMUL1rOyQo/HuOMdodRTgMRY85Ez9kJqaQTWeWaOgnC63GqJ2x7WlhR3HX49QZo7
 PlcA==
X-Gm-Message-State: AOAM530A1a2wVbZEXkWVrT1zx2EHE5nK8BAF9tL4P5dw3EuDa47CBa8b
 tga49LaxAXIQa8p3SUJ6swciWQq1WUtzWalraiLZCqCr
X-Google-Smtp-Source: ABdhPJym+luRQIo13L2g6iQPy+c5EoKxcMsKJp8ImeQqnAmWB+fUueYoD593N5C4YWfwBTzlGMZgFBTdzMn1SqIcvKw=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr3458241oia.163.1595943491712; 
 Tue, 28 Jul 2020 06:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200727152820.26661-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20200727152820.26661-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 14:38:00 +0100
Message-ID: <CAFEAcA9VGE5-Xcws4V85qGoJEafAx=RvsXx1YmTX_k+N89dJOA@mail.gmail.com>
Subject: Re: [PULL 0/1] qemu-openbios queue 20200727
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 16:28, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> (I know this is late in the release cycle, however the recent switch of Debian ports
> powerpc images from yaboot to grub exposes a bug which breaks Linux boot in the
> latest builds. Adding a CC to qemu-stable as there have only been minor fixes to
> OpenBIOS since v5.0 and as a plus it will also fix virtio-blk-pci boot)
>
>
> The following changes since commit 4215d3413272ad6d1c6c9d0234450b602e46a74c:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.1-20200727' into staging (2020-07-27 09:33:04 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-openbios-20200727
>
> for you to fetch changes up to 54414d0fb11314ede939ec80238787c5b2079f4e:
>
>   Update OpenBIOS images to 7f28286f built from submodule. (2020-07-27 16:08:24 +0100)
>
> ----------------------------------------------------------------
> qemu-openbios queue
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

