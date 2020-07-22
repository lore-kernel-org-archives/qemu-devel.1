Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0A6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3C320717
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8WJw50e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3C320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9lX-0007nj-Ct
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jy9kh-0006af-VL
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:05:24 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33]:36335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jy9kf-0003xZ-U2
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:05:23 -0400
Received: by mail-oo1-xc33.google.com with SMTP id z127so250310ooa.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+uefHjHTl9whndTKp/BqtMTk7Hk7fys1q/6bzcfD87E=;
 b=g8WJw50eaUMGk3ZjM1DnVrCpkNezfUz5dHHEW4TjD5cQeDdj7ziPnwfn4xGQG81IS7
 huyJNGcE1gsNmnaq7esE5PG2aJjS+5asuQ/bpLjtXI5k1hUMxDz9F6+L+tFY0wzwgzLE
 hehiqQ0cfNMsk3MnolcF6rxtWasBT8JHK9F8atfnwVP1RngelDGVKlb6K9twM746vvzt
 c7mOt1bDMYcYzmFbryWksGUKpCTxaTQes30vlwsTn5c70/U2+H4FQQsnwK/TyllNzTpV
 77R0VaOnQgodF0fp2cfqk/I/q7P0stPSvBZNycqrKBOoG8grSO7KeLMyogB6Iia74NOw
 +F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+uefHjHTl9whndTKp/BqtMTk7Hk7fys1q/6bzcfD87E=;
 b=dPrA1GobzGnur4v6/DAMc/I+hu3g4kjVzzlpYcfT5GWU3HDBnDlb4Jj+SKzGV/OeN2
 tv0Z+rIIckBKmuEhrtu2MpGsWkWJxdoMZ5eQ6FIkG15mJaD5a2ixuPoqxMyVjGWFFrCc
 euxSSekRTlXor/CzznIGamoRcgvvKzccy+qlM+2YLo26mHEWgQuMGeGbNFEIJkylVc70
 /He/OJ8pz3rTm9YZEBPVTqiThQJnenRAAFnuc3+JaEO9LQndvPy+7yR52YOwof3O4IWY
 NAOrfruta9Hf+fXi38+qIALDHRP6d14T5H5h4StwFJLOnZsGgsEjJJZfDv6Q2iB7Z/Vn
 12qw==
X-Gm-Message-State: AOAM533eS/cPL3Cxa0FcB9s29PmmbarHROGiFpDNm05/zgdSyxIsQu+y
 EpnLmNpQzbq1O/WTEpVUbHSSuzmoUSKZ4GZrFJlbqQ==
X-Google-Smtp-Source: ABdhPJz9QxdfI+gnQb+juaffqCQfCmjux8dwUEdGoBE8QKJcoJdjsEBqJKubBxeauLe6VGIgPEZgCubDGRXR5kI8BkM=
X-Received: by 2002:a4a:8784:: with SMTP id b4mr27394848ooi.69.1595405120102; 
 Wed, 22 Jul 2020 01:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA9+9ZQY2CxZ9V4bZrkAGR5eUapbwSk6sNyFGyyd39Y=1Q@mail.gmail.com>
 <20200721211626.3kepsmdi2n6tkigw@sirius.home.kraxel.org>
In-Reply-To: <20200721211626.3kepsmdi2n6tkigw@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Jul 2020 09:05:09 +0100
Message-ID: <CAFEAcA_WVaAesKiwf8cuGOgG5=RXjjB7obKLfrQVXbAxXRnDMw@mail.gmail.com>
Subject: Re: please try to avoid sending pullreqs late on release-candidate day
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc33.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 22:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Speaking of testing:  What is the state of gitlab ci?  How much of the
> testing has been migrated over?  I've noticed I can push branches and
> tags to a qemu fork @ gitlab.com and gitlab ci runs a bunch of tests.

I still need to look at Cleber's most recent patchset which
has the scripting for this.

> What is the best way to indicate that the tag did pass gitlab ci
> already?

There's no need to indicate anything, it wouldn't alter my testing
process.

thanks
-- PMM

