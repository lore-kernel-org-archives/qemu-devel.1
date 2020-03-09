Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD386C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 22:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963C22253D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 22:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ry/FyWth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963C22253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBQVH-0001hk-R7
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 18:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBQT9-0007jW-0M
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 18:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBQT7-0007XH-QN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 18:01:50 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBQT7-0007Wn-M0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 18:01:49 -0400
Received: by mail-ot1-x343.google.com with SMTP id s15so2988059otq.8
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3D5R0ByUMwnpIn847TV33cL0I9HbhgiAN2Aan/suScM=;
 b=ry/FyWthWse39bybxdnEG99rkuMhdOLa5GMlrOblPoLE9hjofdNwoLojVN6/T3xg2D
 DWx3ssd2rjPJ10A5dVGQszGfoXTbsuyNC4tPxEQtcYwUvsmBJ8E18CZ8ntaJdNNBOZ5s
 rwVN6tu71h4xyR0LtRPO78mL1cjmaBWTNqHypIZIiIK+AOEWA6DSThT+bU87QmjdvZMn
 jttkiDvSczzmWEoWGS5/F0KFPwSCFC7MlBoPi6AVxnexcs5jcjX5ldsSb4qcY8vJxnYG
 5g8t1el57eJUu5ZWfSq4HdSGP3fMnXDINDVFqxtIqLV81q5JvuptiHO3feHlRlgrR2TX
 0p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3D5R0ByUMwnpIn847TV33cL0I9HbhgiAN2Aan/suScM=;
 b=qs/S7ZG7MymAiMApO/NxwW/2hLDaS6mTfMXrVqOu2qlmQmr3hsP2t68rDGD8pz2PXW
 tUePMhr9gr+fYxjwTGBZhpGA4mNQEvUiMKQRYbDmJlMrMQkShf7VCznSxmzDug90kzE3
 1GL1Q/SL17dX9WO1iHqmQ/lb1XOUrqfTjFRv0L/E7OQaRm/Og0XulVrA/e4O+Ci1oGlB
 7FwLVznI1IXuepEFj1lfHDJHAc6qH4ZZxFa/LJihTOfKj9u4499ZGPzqgB5Tg9oIn+nw
 dsHuPmV1GTYbmpHbd0SQ9ULYiwJ68rJmibPOswPKk/D18fXIVKv0KYOkBluwzBkemmIp
 GuTQ==
X-Gm-Message-State: ANhLgQ0qxwcPFKw+4Vb8ZQ7VRtkP6+pgMqFErfiW0hTuanK17NGOG4WX
 ShvrisAzr/zo/2VCdFDw1n5ZnVjGEJazr7BsiH/jcw==
X-Google-Smtp-Source: ADFU+vsOPsYBcEuBVILDzLeVArfQdLdefbUjXFSF0jilPRltyA4UBnMuIW45MdPVbg4LnuXXVSWM4s00rfXvCCOvqjo=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr5938639ota.221.1583791308605; 
 Mon, 09 Mar 2020 15:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
 <CAFEAcA_6Lm-JwbXFLWeetc7+fhnrc5m2+YU28ymFw0MSoKOhwg@mail.gmail.com>
 <CAPan3Wo2Nf_d4AxsV5=sfOxv66rmQNfN==rpMn9=FtM5cZG9rw@mail.gmail.com>
 <CAFEAcA-2-tz7F1vmbggpLnc1SSX+_W5pij-w8Vgjx+vqr-LRUA@mail.gmail.com>
 <CAPan3Wr-oS-QRxmCDPXLRBG81yqjnp56B2WNuxtBMOxr2b9D6A@mail.gmail.com>
 <CAFEAcA_rY1hXNbzsj6EJvKzODX_EWdTOK1Gfxi2Jbv+UsYxRtQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_rY1hXNbzsj6EJvKzODX_EWdTOK1Gfxi2Jbv+UsYxRtQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 22:01:37 +0000
Message-ID: <CAFEAcA-m2GJ01=-aEW0VLrY-nJgOpAMFOBF8+0jXeW+H7wkM-A@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 20:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> If you're ready to send out the next version before that,
> then leave it with the include:: directive and we can
> fix it up to the new structure later.

PS: in case you weren't aware, softfreeze for the 5.0 release
is 17th March, so if this series is going to go in for 5.0
then (a) people interested in reviewing it should hurry up
and review patches 9..18 and (b) the final version would
need to be on the list sometime this week so it can go into
a pull request by the 17th.

It's no big deal if it goes into 5.1 instead I guess,
but it feels like the series is nearly ready so I figured
I'd set out the timeline if people want to push to get it
into 5.0.

thanks
-- PMM

