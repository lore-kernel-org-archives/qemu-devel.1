Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3700BCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 17:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009562086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 17:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+x4lPsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009562086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQE0e-0005VX-Ih
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 13:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQDz3-00041b-A2
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQDz2-0002wv-0A
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:11:41 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:37188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQDz1-0002u0-R8
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:11:39 -0400
Received: by mail-ot1-x336.google.com with SMTP id 53so6049581otv.4
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n8Co4XAVbUpibt/mFlM1J1mHjCdUFrZFuVjcTSFkGfk=;
 b=f+x4lPsJCxtyb+zWjDv7C9tc37AQY2i/k79J2GLXi3BU4leprXedyABe/SHrillY2+
 J+91GT11yInfWYbAI8sfkMJ2ilhveSj4lqyXvx8jjxNa1vR1NVb9CAz6d3Xazz3wKOuV
 0PbF41nQYywxIZS7Oao7yQuDf+Zd0o8aEmzk90p7p0hz8LA7FVtq+U3VLc7Ot8wVFTwv
 pd55E8eZK6vrBWcIROTUmHN77aLkQ3TPKrIKXeX1QPi00KMpTvArZh2VAEQ/EQlwPyF8
 vQAVCJUE+ctn9vUCKMGGiLqqYOXj+chz5FB2SX/1nUYTqx5rlWlpsLBb6JJR0tcwvYIR
 C2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n8Co4XAVbUpibt/mFlM1J1mHjCdUFrZFuVjcTSFkGfk=;
 b=TW5QrWiiXA37F3zTQMi4vI4pO3caeWrNHh5J7KkmiphrbFRYvJljQaAvtZSHCOg0Ce
 HgS/Nyj+YGdqj0+/rBaXpmZ/UbEyL708L5ComapYXjWkFtKWZIbc5NWeunZnjUlO4UX6
 NLavtapc5L6Mrp916V7kTw6F7VpeAyDM6xwEDcJJ4S999vPylgkHqSXVr+EsnlT9r2jq
 Pk5gAZjYrnSaEn1gJ/FysqiY/uzzLtC/HnEPl6m2C5KYDwLZO/xDBl7yUfV/v4i7kWsO
 f1OPM4hNt3LjdHY4rRunJFJmyc5E43/I3yk4PUWS/Dwg2tfN3749QTof2RfKWnwSaSd2
 uVSw==
X-Gm-Message-State: APjAAAVCQrxGgaobOLgEz3ZBHUBz9v/aFwgqon3TyeScIRDxEtHjffx5
 oSMC1nAVcOVG+dcub8T4L4Zqha579F+ikzrLO0L0Ew==
X-Google-Smtp-Source: APXvYqz5gbERAgI1PeycreEeCZp+E4AA5CDwZwQjbAHgD71qXjU3c0tXMnCA8EFce43KoWxJHLXKW0hHctFMdKcFDTc=
X-Received: by 2002:a9d:7385:: with SMTP id j5mr5426261otk.135.1572541898543; 
 Thu, 31 Oct 2019 10:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191031155636.18589-1-jsnow@redhat.com>
In-Reply-To: <20191031155636.18589-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2019 17:11:27 +0000
Message-ID: <CAFEAcA9AFQeKDfPTUR3zm3rZ9ReAq=HWzFsK_rSG6oMnNbXsdQ@mail.gmail.com>
Subject: Re: [PULL v2 0/9] Ide patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Libvirt <libvir-list@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 31 Oct 2019 at 15:57, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 68d8ef4ec540682c3538d4963e836e43a211dd17:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-tcg-plugins-281019-4' into staging (2019-10-30 14:10:32 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to dc237c45aee52f268369dc6a485c623f1232e1d3:
>
>   hd-geo-test: Add tests for lchs override (2019-10-31 11:47:43 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

