Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BCFC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 20:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517D82189E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 20:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wi1+8jl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517D82189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiPTg-0003VP-Ci
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 16:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55677)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiOL9-0000wP-7e
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiOL7-0006vr-VA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:21:19 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiOL7-0006tL-MS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:21:17 -0400
Received: by mail-oi1-x241.google.com with SMTP id a127so14043106oii.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wX1sjLxhvdDqt5XThtF7o9QBIvPcKLmH+8Oc2Q+7xf8=;
 b=wi1+8jl4sODEkP4hw6QlvLDb11ayO+oyShrExVZaAOaATkN6PiCCciA3bMGvxDkV4z
 m5ApgK44mEW77PcBC4CWCbBPvnaC+R8ueA6t3ClkUv6BnNO60sWFzFAjHBGGOtCf65wS
 nVwSixRr9N3DDbmU//seicEcUjwNFtTIAvEu5tuzdSpDoRJKzfcoy/wLsf/5mQesWicb
 TvFpOu198fd21iyRafffeQaWSpfQV+8jpGmPyDlDUGqokF99JMa11lYsPEOFq9jjuTWi
 13ySLsk5k8AraZvTOr683/9/1TgBbpv6icNwe/qATPsQChRg+gPxulNXL4bQ5RryaODf
 LxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wX1sjLxhvdDqt5XThtF7o9QBIvPcKLmH+8Oc2Q+7xf8=;
 b=EW542M9A0wJzttlNtemBMQa7J9LErH1ZP39E9u60kHIYeNnpJAlXjXkKMlv8CYYiu6
 o6TDf+sX+Ha/krfDA26iOu162QbaaXco/U/QDlSRap36tRO/fhxgWRbY6dKJnNWTg3ps
 DzFZmFaYb+DXCeWgy8QSSUK/F93TQBIMpTAAUogylCsTx8CdIk2APJ4piYYzu3GZGZYD
 pZrK0chbpvRWGg6K88diVCYI3M7n1x6j64klDaufM1vMGJKhzNGTkz3e8rtuk0xk4Owz
 wsa8Tm3KlQGU7jEysf66DdhS1s7ZCfbZksdqCm4TtIgLq15jJUDX4vY3f/arAX4v+Ij9
 JcqQ==
X-Gm-Message-State: APjAAAWyJ//7NW+4LQ0FPZKYqemRhlBdXNqJj8fbN/i5fC2go1OnvSuQ
 5rzdJIr3RtxQizRaHwFs1zMi89/B8+rBZwzdCg1HkQ==
X-Google-Smtp-Source: APXvYqzWnxI/T/CCYfM/mdXnueI8V/U7vX5wQRsMyFrgOPP7s6ehiroLAM+/UZ5YqVmL71CQxpCJFPIXDl/AKuoEB2M=
X-Received: by 2002:aca:6185:: with SMTP id v127mr4296622oib.163.1562095276639; 
 Tue, 02 Jul 2019 12:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 20:21:05 +0100
Message-ID: <CAFEAcA-xpDCVHapUGHBKu9Ppza0ShsQFPD07Ee2=EGgGXd2aFg@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 00/49] ppc-for-4.1 queue 20190702
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 07:09, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190702
>
> for you to fetch changes up to 1c3d4a8f4b4f24baa9dae31db0599925abc7d2a2:
>
>   spapr/xive: Add proper rollback to kvmppc_xive_connect() (2019-07-02 10:11:44 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-07-2
>
> Here's my next pull request for qemu-4.1.  I'm not sure if this will
> squeak in just before the soft freeze, or just after.  I don't think
> it really matters - most of this is bugfixes anyway.  There's some
> cleanups which aren't stictly bugfixes, but which I think are safe
> enough improvements to go in the soft freeze.  There's no true feature
> work.
>
> Unfortunately, I wasn't able to complete a few of my standard battery
> of pre-pull tests, due to some failures that appear to also be in
> master.  I'm hoping that hasn't missed anything important in here.
>
> Highlights are:
>   * A number of fixe and cleanups for the XIVE implementation
>   * Cleanups to the XICS interrupt controller to fit better with the new
>     XIVE code
>   * Numerous fixes and improvements to TCG handling of ppc vector
>     instructions
>   * Remove a number of unnnecessary #ifdef CONFIG_KVM guards
>   * Fix some errors in the PCI hotplug paths
>   * Assorted other fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

