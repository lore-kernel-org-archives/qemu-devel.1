Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC07ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F4820854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMyasfcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F4820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3h9-0007Yy-2X
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2u1-0001Q0-M4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2u0-0001iB-HT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:08:57 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2u0-0001hq-Ck
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:08:56 -0400
Received: by mail-ot1-x341.google.com with SMTP id c10so14254452otd.9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4em2LLOJ6aqTPyQlYNBUx6Ow2uXrQsyozzIKZSY4Ybo=;
 b=RMyasfcZQy2Hokkw6nRi/oWmtL7bO2hmG6YdKSdQwCq6UUp7Djj7uGxPBdHNHteEsd
 XhBPQ/yyMQs17L12EfKOq5zi6wwvNmuc7EwrJwVkRsVX4B6FHojTu+7VwDS9wje6Ua5O
 Hd8cPhiL+hry0/GMr1Xl2pk/rD1NDEbvpnJ+gobD9+Mfih4Ji872kOL87qXRUreIhdUo
 zwS0Zqu6TGkubZAh3dMWyTZm7yoUK9uiGx9lvNYX4cfcm2ABPyw2SjMOvnLLVGJxe8X9
 3fvaMZiwzpnbV1GgyBLsjU8tU92YM7aThJDCoVzzkzGSD0/a713OZoKVhQyqcVNDSGCs
 xrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4em2LLOJ6aqTPyQlYNBUx6Ow2uXrQsyozzIKZSY4Ybo=;
 b=siSCkUXQGx++BlfnrxeXmMVWceMM+Cz80R1uMcgnMU7wrqA1QDOHOW1ACjxh5EUjej
 hWFbmNH6KVkdJ3V8O5ka1J1823XE3Om0sLXwGZzBYreR1A683VabmqR9Gch39pxfap06
 jBErhxtVtBkk3TFZkGX8taqDA1Ws55IN+KVA3CI4lmo2wz4PAce7a8aVtJgrV539o1O7
 QiH2qZDU05yb94ySjVqTZjPyXq8OomdWbossFawRzNC/+HVS8zlBMs0+BsudFGxHineF
 SGpaPqkf/IoE0QbXC9FANiFJoSJ5CqIaYXy7qj5o6on6iRBW/5v/JTAd5TeJyUdW2bKb
 /mBQ==
X-Gm-Message-State: APjAAAVsXYS3slY/yy87q15bnLWe2HAHyuwUE1Ec1BACdDrloaR3gWLH
 GBbso5csBHn2eUxtWM77fuzDe52RYdal0jlS6OSIbw==
X-Google-Smtp-Source: APXvYqzGmpo/uZZIuCGhgUpoQN6GGulx/cX0HAqCb2mQq6VyyeNNZBKuqT1NWpOCA5QvmEVqrgoMGzgZmgtqDetHalg=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr25359913otg.91.1571069335567; 
 Mon, 14 Oct 2019 09:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191011191646.226814-1-dgilbert@redhat.com>
In-Reply-To: <20191011191646.226814-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 17:08:44 +0100
Message-ID: <CAFEAcA-zu2pKkQWJshJEv-B-fAJ3NwJFYh-0sCy-aeQNZj8iFg@mail.gmail.com>
Subject: Re: [PULL 00/21] migration queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 20:19, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-08 16:08:35 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20191011a
>
> for you to fetch changes up to 9a85e4b8f672016adbf7b7d5beaab2a99b9b5615:
>
>   migration: Support gtree migration (2019-10-11 17:52:31 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2019-10-11
>
> Mostly cleanups and minor fixes
>
> [Note I'm seeing a hang on the aarch64 hosted x86-64 tcg migration
> test in xbzrle; but I'm seeing that on current head as well]
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

