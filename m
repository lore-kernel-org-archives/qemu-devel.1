Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E709FC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30B5207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADhBfrWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30B5207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrCF-00056g-Pg
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itrBV-0004Mu-AG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itrBT-00061b-Uj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:55:00 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:37039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itrBT-00061A-Ne
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:54:59 -0500
Received: by mail-ot1-x330.google.com with SMTP id k14so2532479otn.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 02:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EFaoHd04qAX1jO4UM/c10NQDOVkPLXy3j4LLYKGUJXE=;
 b=ADhBfrWhdDECyPnnk5uaUV210NKnmjgaOtQvmvUG1RyqxgsVOIetOUE8wtDC6mZ9LA
 EC5U8bm03t/XjVya18L9LtsjUk/QXI/nOAq/9qbZMqKn62C2Sn4ZbBkwFJYJplBT09Ex
 x4oUIUfTUP6r+a5DCy7VRL7ZXdkjubG+PY/NsKcWxPz9hU3Eabd2z+f/jhEyQQf5YoR/
 ty4r+HE9OwidB825Swoo/SzSX05ETk3AUi1v2Y0TlYpkpImKeT7dH5rh6ebQ/U5NJwAv
 xeHCHKHCiVP2myLyMVD7MeTp/kIp6QLfuByY2bPSgOArIXnDLwqUr068N407tq+Dholm
 qIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EFaoHd04qAX1jO4UM/c10NQDOVkPLXy3j4LLYKGUJXE=;
 b=UCzUE/TZvLR+e21Ki66ziREz9KbpLuzh3tsp3kHH42GT7+8ud5NklaE/y+QWIEgnSN
 g+9YD2+bQFfjvjd9pcsPFGlhavXgRv45oLRNGGSMGS8WEE3U29X5H6BitgwsT+ni1TvX
 QPht3u8je/x3bqgCWJj1kpUtA2P9y6ijj0UY1jgbTx4GlT7viNmniUuxkktjFMqjI6Mb
 eHUHw+jmNcjJ6NRrCLESY9zDQz/wGRaQ5q1aiKbfvFvT+2MltJxUy9hw29FMI4eDmFke
 TatP+YGXD7JLdwdpKNYsQF6ekB5MDuwU36zg+nJXURKM3JJAE9DMB8gBhQtxELlhEMAT
 ze1Q==
X-Gm-Message-State: APjAAAVShAMnfVRlVNrpEhpxEZanuHgws7YUEv+p7S1T+dljhXJOdx/H
 TJxaPuw41JfIp8d1/pWR+/LxQSh/A9lSsIgPwL+Qu9Gd5TI=
X-Google-Smtp-Source: APXvYqzSEM837QmGIqbLRoxq9WnHt2A4h7p3hBz3mnNKjhFlHU+9o7qlSyD+aYsoyxYacP5dNcaHhE78G4zrtZ0Mgwg=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr3070404otq.135.1579604098138; 
 Tue, 21 Jan 2020 02:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20200120170640.524184-1-groug@kaod.org>
In-Reply-To: <20200120170640.524184-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jan 2020 10:54:46 +0000
Message-ID: <CAFEAcA9ZbZ+=P1Y6zQ+XiMfo8Srcu0WPrn4UyhABj1+orra-PA@mail.gmail.com>
Subject: Re: [PULL 0/5] 9p patches 2020-01-20
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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

On Mon, 20 Jan 2020 at 17:06, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit 43d1455cf84283466e5c22a217db5ef4b8197b14:
>
>   qapi: Fix code generation with Python 3.5 (2020-01-20 12:17:38 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/9p-next-2020-01-20
>
> for you to fetch changes up to b858e80a02ca64b9208499155f4dab4ef298b523:
>
>   9pfs/9p.c: remove unneeded labels (2020-01-20 15:11:39 +0100)
>
> ----------------------------------------------------------------
> Assorted fixes and cleanups.
> v2: - fix 32-bit build
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

