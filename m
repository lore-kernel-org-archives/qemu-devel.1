Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDACC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC17722D2A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDT9S+D+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC17722D2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc8eU-0000gi-UM
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc8di-0008Fp-RX
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:27:12 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:41105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc8dh-0000d6-R7
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:27:10 -0400
Received: by mail-ot1-x336.google.com with SMTP id 63so8356624oto.8
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bpe6ofdN8R/N2YPL1RJvm54mWt7nQU0TCAdkiBP34bI=;
 b=nDT9S+D+EwhygeHQjdidiFHo02Bdm+WqsoZxaGlMDSn16reV+fAxHJE4XfFpoLRMTo
 +7Usc0I6GrfI4A5DEvoxkZaCjioxrGmbGR0M3esIiEutosm41TCl6rUzqX79DKX2GtOK
 o2vHl1byT46vd3HfGEwGxADOpV/L1EcWHToG6H55AeZi3Pvr20WLS9QqiLOrUMmoakR/
 K9oEOZ3knX07qrMhfXgjhCJWmVFp1jGGuJNbfY/DE/9sfpLnFVt3Ncn7oG/mClCptR1W
 Yt0v+bP4VKXkkVCuOMqX0QE8Hakmm/OO1IJLXjTa71UlQB+Q0L/qNWFAd7puAilXByzL
 EyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bpe6ofdN8R/N2YPL1RJvm54mWt7nQU0TCAdkiBP34bI=;
 b=bXDb94GgTTo3nyMD+acLVeKbEFfllirc6c8c8mL9U5g7C7viHll1KxORoQSn4+OW4z
 Cb/pYo7Oo3bD7KNrhQ/O6mrPM6ypq/82xFgfNM6Mo0g1zTlaNFz7b/+GSBmJ/392BRX7
 M8YjAZaYxFLV18hm5wpicGMSyYkBpM8BWAxSDS+JcWGr3LS0M5J+zRmwBDYCDyHu2sTr
 WPQrS8qUAfxNPTjxyhqHWyRkb8h1LHe3EzpN1xdi9qT1hIRbyc4fLItFq77mHAlJtj+5
 /5gqRSDFeXmJg3RdUFM+ll0h3d13YbEMP3EpgFUn2bgkfcH/tiyppynVABesO/4+AbAq
 7hXg==
X-Gm-Message-State: AOAM5305YYXwOr9RMbp6NRnfP4Ti0//X3eKmz0MwXdRsDF33ON0ocUVr
 K9F2wWam6hDotyMSnCblRHTCFJFpi9zPJVOhNXNhxMxN
X-Google-Smtp-Source: ABdhPJwgxdC33Prqq5u1fUSYi8DMtrbUULIwoGUX4/Q9Z5b3qjijWbLsUXntCL/UAmVWTQtxae05ATO9eRU3AiPW3Ys=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr10954852otb.91.1590157628171; 
 Fri, 22 May 2020 07:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200521200707.13826-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20200521200707.13826-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 May 2020 15:26:57 +0100
Message-ID: <CAFEAcA9SdmLzuTPXZX56ejPtkd6U1ac6M=FPCLRzaLri7fvxcA@mail.gmail.com>
Subject: Re: [PULL 0/1] qemu-openbios queue 20200521
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x336.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 at 21:07, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit ae3aa5da96f4ccf0c2a28851449d92db9fcfad71:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/socket-next-pull-request' into staging (2020-05-21 16:47:28 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-openbios-20200521
>
> for you to fetch changes up to e70626551ac64446b15350574d9422af2e0cff9d:
>
>   Update OpenBIOS images to 4704d9eb built from submodule. (2020-05-21 21:00:39 +0100)
>
> ----------------------------------------------------------------
> qemu-openbios queue
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

