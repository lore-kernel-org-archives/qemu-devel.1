Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4C5C11D0D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FD6206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7k0rRNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FD6206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nML-0005l1-Fc
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4nLk-0005Jq-WB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4nLj-0001p4-Uf
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:02:48 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4nLj-0001o6-Oj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:02:47 -0500
Received: by mail-oi1-x243.google.com with SMTP id i1so27784538oie.8
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wUhH9nHFE9TWS2AdMFHpUMe/aTzanCMzASm4MxSxrQU=;
 b=O7k0rRNBOHYDfh182sjYDB4Rr9fDPP4O1b/jhI4IJG5u+IB3ae8jHo36Ap1KRr6SVu
 jSE/QQEYMVeOjNSB/fLGf5jFC9crKq5LiublzMmrUTuci9uSzfyuFgP2xziw1WnVeH7+
 TTYSeOp3uKCNJMEasbsJi7xestvogIX0CZ2A/+qiteC1VMYOoHTt8Hql0lq3bFoC+ehe
 fQ9mXSYVS+UaoPEK+iXiqzHydPr2XP+nGjidIn4bitglqcuquOslemJzNCvVG1u5O2jp
 79sSomyemopq8WXXF01OG76pKVeOZenAeVyH/FS2Fciw+rPrivliXx+bfFdi/oQHqnKp
 TSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wUhH9nHFE9TWS2AdMFHpUMe/aTzanCMzASm4MxSxrQU=;
 b=GKdGucaabrWRVaK/xNGtbTPjuWj/bERKtJ5gqGilTSeEyPBdz/HLB9v5J+YjFoIOGZ
 MsOBDbfYtzytiKVqBmHUPgYS4zhHFBVY7Fybe9TEe5ZuI53w5UEOGSmlhV4iUIvdjwxO
 q0kmkbg+ulHo/tCv4f+9hA1t35Snt7dlYS4OUlz0t6pYyLg85czgRTNkgGsBEYxZNGBd
 ULSTb9Td2JxC8ixuyRhao+EtS9Q0Q3gjhLy9c+oSN8PBoMzSvq+OAoVrtvyAOXTs0FEl
 j6g8gxaVjJ/f6RFJVNA4lqN5J+fXMlGRnL/GXYDaXZig+XG4c4ySqyCP1vmPMBNMRrqQ
 IkSQ==
X-Gm-Message-State: APjAAAWius2EjNvhyCuQMz6pLFmi/gSdDhSGlTBvX5EHXR/m9ZtnfEtz
 RQxIhoFX0XTt4pVt09msOsTO0Dmm7xP0Wj2/T4lhsw==
X-Google-Smtp-Source: APXvYqyBw/xbsXQcbg6ejk2lqsBwpdOYEVPwRJMu1ySe0oNO+NQmi4+922gdDahaS8HhsOzIJrlqY2itdiX0RG65CcE=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2277314oie.146.1582210966466; 
 Thu, 20 Feb 2020 07:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20200218113350.6090-1-frasse.iglesias@gmail.com>
 <20200216160413.GF22292@toto>
In-Reply-To: <20200216160413.GF22292@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 15:02:35 +0000
Message-ID: <CAFEAcA-oHPq97w_eaBnU_L+fa1VvhUPLtKhmbd9rSGifoognWA@mail.gmail.com>
Subject: Re: [PATCH] xilinx_spips: Correct the number of dummy cycles for the
 FAST_READ_4 cmd
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Feb 2020 at 01:12, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
>
> On Tue, Feb 18, 2020 at 12:33:50PM +0100, Francisco Iglesias wrote:
> > From: Francisco Iglesias <francisco.iglesias@xilinx.com>
> >
> > Correct the number of dummy cycles required by the FAST_READ_4 command =
(to
> > be eight, one dummy byte).
> >
> > Fixes: ef06ca3946 ("xilinx_spips: Add support for RX discard and RX dra=
in")
> > Suggested-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



Applied to target-arm.next, thanks.

-- PMM

