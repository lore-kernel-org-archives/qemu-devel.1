Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A2BC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 12:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF30C20830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 12:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EvSMq3F0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF30C20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8kwe-0007xH-V4
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 08:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8kvN-00076b-G8
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8kvM-000172-Dm
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:43:41 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:42249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8kvM-00016i-8F
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:43:40 -0400
Received: by mail-ot1-x32b.google.com with SMTP id c10so29247994otd.9
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GN4/H3B2YE5d1eTWMOfWDENMvzx2ShwB9PJOOKMS10E=;
 b=EvSMq3F0NmYShwnmwcT+CZjal+/+rCtE0zd+obc8XTLk5JbbJRfZEe73oyNjEJnFAe
 4B61q6VML8dgLP0ioVisjMt3Xq1sUtxMMQyMgPTtEfsvlXe0LvUXdILDczbj/1oOBANu
 +a13DpRaUw+K+7GuCCFPoiVDRlYc+H6inpluiD6u5CwMP9rCoZw/ZCB8HcGetGZ0bMCW
 MFIoQVjs9zSc1Unu7jcv7gQkXq6NSMpsFr/5/rTnY7h9TL9nFrjNo1v3UStiDktIVsn/
 gMpHLkKsOkEd31YJF9+Q137BY+g1DIp7C+vrRbvl3oAdLY4NQJBvMMinaNxx9umSBzpJ
 Rm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GN4/H3B2YE5d1eTWMOfWDENMvzx2ShwB9PJOOKMS10E=;
 b=ksqhUkrdQ226Gk6rP5e424/RzsBDRs57GLnQqxd2afPWoCtSb0qJB5bmRqJA4+H+9X
 IJx8raqMe3UzFZo2e+6LtKXUeau0ofrS0UWZ1p4PuuGCYgmCwhhbXHyBRTyv9NIlDUm7
 Xu4sQ6d3pwK9nwihKOAtg9zf4PTMUbvRc1VNUDhF2OENE/SqFlLKe4JCPM+IFiah6Ojg
 iTcz6iqyeHVP8px/WtRNN1TruK7rNhSF4WwdeshBVoiEw/KrC9AWufMbkasPu9mCsXEs
 RFQXyRNpFhmM31OLytKMHStYZbLL7o5Vod6ssr+5BVTZq0Mda/9uuTZC0DqbMek8Vejk
 rPhA==
X-Gm-Message-State: APjAAAWGqRTwX4Bg8ZGKXHrzgOomggtL8UBGX3r2WL/gKQ0LSr/yvz0Q
 grlkbqlpMhL/F3jgtbhobEgwt+2Onmq2bU/Nudbu3w==
X-Google-Smtp-Source: APXvYqwyLzHrohmZ72q+wB1fJ21s+1v3JzLpA93BArSfq+z8i3deHRBSa1nYjLQeTkQ1oPcDs6YTw91i9ZSyfUel71s=
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr31888417oto.232.1568378619340; 
 Fri, 13 Sep 2019 05:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190911143612.17881-1-stefanha@redhat.com>
In-Reply-To: <20190911143612.17881-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 13:43:28 +0100
Message-ID: <CAFEAcA8otyJ9VpcNf1mO+A2sp9wDfvUsdTMKVn0SRZODEkBOqA@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 at 15:36, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit cc6613e244e86c66f83467eab5284825d7057c=
ea:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2019-09-03 11:06:09 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to ebb6ff25cd888a52a64a9adc3692541c6d1d9a42:
>
>   virtio-blk: Cancel the pending BH when the dataplane is reset (2019-09-=
03 16:11:18 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   virtio-blk: Cancel the pending BH when the dataplane is reset
>
>  hw/block/dataplane/virtio-blk.c | 3 +++
>  1 file changed, 3 insertions(+)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

