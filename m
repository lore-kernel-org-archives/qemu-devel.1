Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA4C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 21:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A922064B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 21:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGbUj/So"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A922064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZiix-0002r0-5H
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 16:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZihk-0002Oy-6j
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 16:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZihh-000189-VP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 16:49:03 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:41395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZihg-00015o-3I
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 16:49:01 -0500
Received: by mail-ot1-x32e.google.com with SMTP id r27so2733078otc.8
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AVcSWgHOlpu9hECbPuuEo/2cQiNhDl0V+ZvShNhArSw=;
 b=XGbUj/SoaMpQPdew2Fo8+ZmqoCbgdcGrfdOxHbwhLSvxkHXmayRH0+Hd8up/qEVsAA
 gc1srq+ijDdqtCbc4X57z0WUMrWUltagSfNs+iTwcXH7YOnvfMGNGPFUNfrgXHrXLDjS
 1BNUPoRn847P0PzIRq9D/ji3BRDxyPCYfVQ9ReLzi2zOSeUwD0YFfiClb0H9HDzAocNM
 tgVIUAhXvoUuqAznUNhjGIE7774FTeELxYgvmciRBrpI/xwhpzhE49RwL6GLyWPyNKgc
 iW2yFlkQ0pudp8mCpKMt+EiSFq6fsqRuVO4NSa2Nws5uVdynZW3AosHmLDOsCVQcraJJ
 12Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AVcSWgHOlpu9hECbPuuEo/2cQiNhDl0V+ZvShNhArSw=;
 b=svaYIqWYLGl+EUJrOem5E0+zK5sNOfbKKs5zTjmjhUQKu15l2FBZKjKtaAWFVO97r7
 Mve6ZkQms1wiue2/h2PEMm7SEmaXOqg7SZKUJnDKdt7AZ2EgbCMaxP//GTk5Ol4Ocf9T
 ZOvHB03yMXiI1jnzIgpEwcNqd6eFJCeZc5FQ6J2tjtZqjnZBCG8CdPHN8jmPeNopNd/5
 GfJv94wokbG7gVvKsfuHgC8+kySC8EQP62LnONj1b78/x81YgltZwDtHbxSx8AUcFqJV
 Ek4gFqHdW+vBdmEh9ym4LAnBvByii29t9nZmNj10sQgU5wTaxyNnbVw/BYNfE6G1bBYo
 tp2A==
X-Gm-Message-State: APjAAAVAnPFk44yt3QbTVqF+lAId4uw2LLw97jeDPaUHoKwGORZHnrAB
 7de4P9+qFvdRodhqXWhLcpE6JnaLQiAV6NEP5aAaug==
X-Google-Smtp-Source: APXvYqy/LG5Z77nwBdP8YTv8yR8KIslxaTubJQ+omSWqetF24vo77WBHveOIS2t9qTJ+HYYA2fOc7up6siyOvYqVX/4=
X-Received: by 2002:a05:6830:1583:: with SMTP id
 i3mr877948otr.221.1574804937358; 
 Tue, 26 Nov 2019 13:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20191126120339.18059-1-alex.bennee@linaro.org>
In-Reply-To: <20191126120339.18059-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 21:48:46 +0000
Message-ID: <CAFEAcA__Dtonw10DkHVHMEGg5TrL0du=Wj15tvujTXdt=Ui+Dg@mail.gmail.com>
Subject: Re: [PULL for 4.2 0/3] a few vm-test fixes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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

On Tue, 26 Nov 2019 at 12:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 65e05c82bdc6d348155e301c9d87dba7a08a57=
01:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-11-25 15:47:44 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-rc3-testing-261119-1
>
> for you to fetch changes up to b3b9a433b0691b73c96d9ea4de67fe9c8ea293e8:
>
>   tests/vm/ubuntu: update i386 image to 18.04 (2019-11-26 11:28:23 +0000)
>
> ----------------------------------------------------------------
> A few vm-test updates
>
>   - use Ubuntu 18.04 for i386 image
>   - python3 for centos and docker
>   - install locales for ubuntu
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

