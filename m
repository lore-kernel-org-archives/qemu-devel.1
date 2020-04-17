Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FECC352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757882137B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foIApmw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757882137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPMPA-000067-LX
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 04:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPMOJ-0007m2-4x
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPMOI-0008OE-2m
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:30:27 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:38364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPMOH-0008Ne-Un
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:30:26 -0400
Received: by mail-oi1-x22c.google.com with SMTP id r66so1440576oie.5
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sfhJTgSwj+/KbMdjRpAGh+olc5UKTAi60OPHokqgWVQ=;
 b=foIApmw1V7DqVZ4Qk1skZqsKR0M6m6p2k/tNCH/wMC0lczsUHeBIf/nr+3NrsLXi5A
 myhuSdu6V2xM47zylkiQbUP/1L+r6oCDjWfPACUOQ06tr9gTD4iqzXLdwyOqQfUMtSyg
 2VTm99yLSLLEUQ1razA7aEravwKUDBa2OxnaTrUA5U2G/kzfsOiOzCCwd/z7QU/Q3w+1
 ZbLDXL+kfxoGjiAS3h1ncRJXDAZq4yTbJFvdCe85CtSpQAKUnWQ6ScD86yKv3vtr8Uwp
 jtpta5gssN2R4kxbRZwUJu4YuElCMe4UF+hg+ncs6fU+Iht4ITVQFocnU2ygxUJccS+6
 QSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sfhJTgSwj+/KbMdjRpAGh+olc5UKTAi60OPHokqgWVQ=;
 b=dyTk4aM/ZX0eP62zoSr9Vydd8b87HZx2zKVJmjM5zHMRGxNmYMj9RPyan3IRNRCtsS
 o4v/uDvQEZ6W9FuBjunY6NCV+s7ExBSabbaDAYTbolChJz9tMRkyH66JqhpTaFRHBLPO
 l+Cv65XMYVXzKX1lkTtnxxlHgZZsBU+fswwjO0loE1AZ/uyQS8YoJMcv/bQSnHD1MwM5
 ex6kYlGtA+xeFoUxLpan03u0TzjUOQcQkhiLBTorcfq4C4iGGJeynR7449Wb0WGhVFl0
 28sB63oB8/KdSy5Ch5b0YZXx0DQBs95mUWTjmbfzAzc+k/Ec41mOQlTg5uankF7FRwE6
 6hyA==
X-Gm-Message-State: AGi0PualqViM9rPfA8dZ04MlDBjAhH79uEYgnU0sFwXCkdjFRUGm+vIF
 +7SsCg1c6fy8RwFcPJmrjL9EMzvhtxcfQ7ki/SgIMQ==
X-Google-Smtp-Source: APiQypLphAfVfboOMuOELUT71F1B9y482I9iyYPyqvc7/po/eKt2dhLn4tfzJx4LbcmpKH1RBqPgCcgmSAz28dO2FAQ=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr1312833oia.146.1587112225046; 
 Fri, 17 Apr 2020 01:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200414133052.13712-1-philmd@redhat.com>
 <20200417024020-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200417024020-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 09:30:13 +0100
Message-ID: <CAFEAcA-9XTQ25gQm18+s1AExFoSR5bQFR9ryEEaEaOGPiCosEA@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 00/12] various bugfixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 07:40, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 14, 2020 at 03:30:40PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Collection of bugfixes for 5.0.
> >
> > Only vhost-user-gpu/grlib_ahb_apb_pnp patches are reviewed.
> >
> > As 5.0-rc3 is tomorrow, I thought it could help to gather
> > them and resend altogether.
>
>
> So who's applying all this stuff? Peter?

I talked to Philippe about this on irc; I cherry picked the
one bug that we thought was critical for 5.0 (the vhost-user-gpu
free/g_free mismatch bugfix) and the rest will be for 5.1.

thanks
-- PMM

