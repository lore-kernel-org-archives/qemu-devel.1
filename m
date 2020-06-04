Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7256DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 15:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2E22065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 15:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7S8v43K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2E22065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgs1D-0005xm-CW
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 11:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgs0F-0005Kz-Dh
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 11:41:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgs0D-0006wd-Qk
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 11:41:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id q25so6171132wmj.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=A5TCKNVzmtVX6NbHSQmg5LXS+9IaNtr4f8P9E2l5TAk=;
 b=S7S8v43KxETmFDl94pod2cmmCgtjhUy9upyK8bb1aCACRlNyuOMHryKTxg8AF0KuyN
 2r2WsqDitgp4wQ7q8wsHB1pGH+uerQfdauwvzEdZl+iZp4aCCDssMKi5m1oyHkM0Upkh
 u0uBUVugs01vZsPG5BNFV1sNm5+PnoGjw2F0nTx8CN59Iac4zMc+BPI8lZPz0BPTcqXR
 LxXTcXMgTWwV/pbDe4uzqAmIMzFmXBpvLD2Kcmz235a7WSdMqKGykSdr2SNu2VSn5aws
 sQg0bFtyMXzuT2EwMcKlX2sxR/o4fltLq4z8Hwjn5vcoA61Q25HEqxbdP74Chl8NTv58
 PumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=A5TCKNVzmtVX6NbHSQmg5LXS+9IaNtr4f8P9E2l5TAk=;
 b=aTWMtVpMtntMFdpK7FWERCiMWfSE7IsUGP0KeRhJS3SICje+fveXhgsHneGNVVwDHi
 1otBfcm4hIB1pv0i/tQB7H/tfBaTUaGHPawI5DJMBkRS47GE2oOyqwxWBL+elXKozKx+
 LtqIIha2MEALmXBorS0bfe8pEFfReGPibfJ8+7+qIGZLaZdJ31Ec0Tjee3BXbqSovX9q
 8gN76nNZ3yIZe19biVobc6yim9ByIOVeqEXjsp76qr76lbVbwhAcFscU1lnsQTWnPfkI
 ruehtIH28Oa4sECN9IpZ5pBPo3oFapq2Tv5CboQv5yOBFi8CuSMIvU52nAjzjOegCwiJ
 hAqQ==
X-Gm-Message-State: AOAM532fSuM7+2m/K1S+l32GiQk34S3rZ76o7XQD/GaUSxtObDr5zD+j
 p4lKI2RPvFQ7ZwRaaaU582KKgGxZb2I=
X-Google-Smtp-Source: ABdhPJwFY2TUUteqRZ0ibdGC0nWlpMxEK8ZawfJPZhcWfOfcvSC59D6PdsAxhlqwWAisr/9JLqVcJA==
X-Received: by 2002:a1c:a74d:: with SMTP id q74mr4553526wme.177.1591285315979; 
 Thu, 04 Jun 2020 08:41:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u4sm8261119wmb.48.2020.06.04.08.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 08:41:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A64CD1FF7E;
 Thu,  4 Jun 2020 16:41:53 +0100 (BST)
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
 <20200604085441.103087-2-kbastian@mail.uni-paderborn.de>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: [PATCH v2 01/15] docker/tricore: Use stretch-slim as a base image
In-reply-to: <20200604085441.103087-2-kbastian@mail.uni-paderborn.de>
Date: Thu, 04 Jun 2020 16:41:53 +0100
Message-ID: <87367a6doe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> we get an authentication errror when trying to pull qemu:debian9. Thus
> just start from a plain debian image.

Ahh I see a breakage in tests/docker/Makefile.include where the line
should be:

docker-image-debian-tricore-cross: docker-image-debian9

to ensure qemu:debian9 is built before this one.

>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  .../dockerfiles/debian-tricore-cross.docker      | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests=
/docker/dockerfiles/debian-tricore-cross.docker
> index 4a0f7706a3..544d7814f8 100644
> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> @@ -7,10 +7,22 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -FROM qemu:debian9
> -
> +FROM debian:stretch-slim

Any reason not to up the base to debian10 to stay ahead of the
deprecation curve?

--=20
Alex Benn=C3=A9e

