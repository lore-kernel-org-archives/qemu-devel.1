Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8DC55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56B422264
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8xSO8/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56B422264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMC0-0006U7-Ig
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXMAi-0005gq-0N
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:25:44 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:43869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXMAf-0001Lu-OI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:25:43 -0400
Received: by mail-ej1-x630.google.com with SMTP id k3so1407076ejj.10
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=opd9WAv1jdFW+m+IYfYgFZ8uDeuUnTw7+/ZfR4lv1jo=;
 b=Q8xSO8/xdRooEN7ENsxua3UUi0Pvfj7o8xRu/c0xn+jyenyjFvhV8y/f5FGAHGNkI1
 IzFhL9n+GhslrPUf7X/AQzIRRX79Ehi0sPTPWF38CX5BNdLXcwjAeDEcV6Gdq1zmK4ze
 ijgkcFtbojbZBtFduaiHYDyaqr8FjhTrX2qTrEl0+di88W8iBOgGlWHd8ZymD63UssNM
 TouFcHDCzAwFbMjU3lk4Sn0TrsiGLVHTpE6JNloHUViEEIRjvq9v5qxyj5PleLGyIVF6
 UpXK3azjUzhUYE6pE4IpzrOmDQ7lRhizJjfsPR+Q1xC7HQlFWynfw1s+EhVOFAIxdJ3+
 jGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=opd9WAv1jdFW+m+IYfYgFZ8uDeuUnTw7+/ZfR4lv1jo=;
 b=DQvodWbkSoSzBelDOOcA0zqj+IQ2JahjrfkJwgO3dUDHJpHhzNIS82fktckcUUvvzS
 LZdHWnVKeRE8hrSQlzXjqJEfswTqtf+wuut2iFS17ACCgEh7pR1Uct5ZnPaT4LCBIoRd
 XUsz08jV76QvNGGYlv1SgpMtbXfUefr8Hnk/TH+SrZw5oY2yi1nm6/ny0FlqF1whpBWb
 biGcWggrq8fVMLQ+Q6N3hU/HctAmPjxaxiael7bnK+MwGubK16/NenMxh8Ae6m/C48L8
 Omqz3bDhoOrVdPY4R1QOnlgSDA1mHGghfsw3GxF6mJqFz8qF3DFfX1v8A+06LqZtveIP
 EGcQ==
X-Gm-Message-State: AOAM531ti6aSkiVvAjtk0RPHZgHUQRX2cMj0qvfqjiL3+95Y4MnbJQKA
 5zM5IMMFxFatxIeczohlRhMfAsL0cqtfpmIKzRurbev5ZpE=
X-Google-Smtp-Source: ABdhPJyKCfMUWUlbjOI/pTYM3Zpe88TkuO7IjnfoKP9szND2w96z0BObfvNpv4ViDyMfOZ4A8MUCFsO/nsESUsFi/dw=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr1592948ejk.407.1603794339734; 
 Tue, 27 Oct 2020 03:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201026120245.25024-1-eblake@redhat.com>
In-Reply-To: <20201026120245.25024-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2020 10:25:28 +0000
Message-ID: <CAFEAcA9tJ7RUtBNdFGy0O4AwBXLKU=Gkxr_cBeoSU4-44F_Gmg@mail.gmail.com>
Subject: Re: [PULL 0/2] bitmaps patches for 2020-10-26
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 12:05, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-10-26
>
> for you to fetch changes up to a024890a64085d3d37ad7eda164775251285c14c:
>
>   migration/block-dirty-bitmap: fix uninitialized variable warning (2020-10-26 06:56:24 -0500)
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-10-26
>
> - fix infloop on large bitmap granularity
> - silence compiler warning


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

