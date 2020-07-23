Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1AEC433F1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1814B20737
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3qaIC7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1814B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYhv-00047Y-7K
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyYhC-0003DW-Vm
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:43:27 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:33385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyYhB-00074I-1S
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:43:26 -0400
Received: by mail-ot1-x331.google.com with SMTP id h13so4027336otr.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s4qVBJCS7glPTJE2r+uMZBOUkYaAoNzs0s3hKkw5D/U=;
 b=c3qaIC7MqZwFxOOjbA/YqNFn/+AGOR0cHt/gCPapVHSWVOuOjlfogvrZM7qP8YVBZO
 eGBMPwkJOBzZqtVKP5ZC6QojSAeL0A1qk1ecpToqeGt3otlt7SXI/UEYqevGUvtkmk/f
 tcImTExs05jsN903xHkh3nR/yQlAz6zeFNES9wpn4Y/DG7f+uPADvZ5Xt/4VcxVyaAmA
 MN9yoBssrb3cd3tw/33rIo1WOzArO0bqDHYMoq0WjC0V8vq4d8BaNrVO7XKxZnFparKn
 +B9vJ8pjeXd9PVxskEFVxnKV8SvczWyksn2yFqG5A09B+VYw4auT3me0Khij/H4UKVQh
 2hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s4qVBJCS7glPTJE2r+uMZBOUkYaAoNzs0s3hKkw5D/U=;
 b=A/hSbzm7I2b5PBVNuqualkKgOUBJojORYVfTCscrerPZCb+welVkE1EumY1Dc7ix2W
 W/kmEQEl85y1RRarkjsWqAllrfBG3ilqewWO+6eNZhVsuryK9aojY9EwAV7aojIuzB1S
 kIMexGIsKfFwDA/P5h8+iYZsLExVqfUzdh7teTD+cBXbEmk+Ws3eHMUKnryhC1ycWLTx
 6B6vrzfm6aZ0R0/1cCAFZO+CMPGeEAzt/T5F5/sO8wQgyqw+COARvNWvCScOqDX8OmoI
 RRvq/XovCPYT4SpNJm66RO6zvcIR9OIwYDwxStVa/omR6hwBwFK9NGW7UrDPR53Oa3lC
 lEtg==
X-Gm-Message-State: AOAM531/SWQ9u2EVjageptZt4uWKVUE3IEumsQ++XCd5K5h1jx/Wq2tI
 fAi1j8scIpv8J03enFFVKHDpIr2x889oi/zYruNKXw==
X-Google-Smtp-Source: ABdhPJyttiAL5tqVpryQLTfX4dTFBPJo0bbRvAlL8R6qfGyQcRxsEFhSgWk68xLvvSkS1c9ijpKi8vBs5Sev/7QYsiI=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr3546670ota.91.1595501003658; 
 Thu, 23 Jul 2020 03:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200721175326.8004-1-philmd@redhat.com>
In-Reply-To: <20200721175326.8004-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2020 11:43:12 +0100
Message-ID: <CAFEAcA-H0E-EFkbHuVOhyy1_p47dbr5uHXqzZL=jgwXVzmD1vw@mail.gmail.com>
Subject: Re: [PULL 0/2] fw_cfg patches for 2020-07-21
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x331.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 18:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit 90218a9a393c7925f330e7dcc08658e2a01d3b=
d4:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-202=
0-07=3D
> -21' into staging (2020-07-21 10:24:38 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/fw_cfg-20200721
>
> for you to fetch changes up to 077195187b47d83418e5fb521c89d7881fab3049:
>
>   hw/nvram/fw_cfg: Let fw_cfg_add_from_generator() return boolean value (=
2020=3D
> -07-21 16:47:54 +0200)
>
> ----------------------------------------------------------------
> fw_cfg patches
>
> Fixes the DEADCODE issue reported by Coverity (CID 1430396).
>
> CI jobs result:
> . https://gitlab.com/philmd/qemu/-/pipelines/169086301
>
> ----------------------------------------------------------------
>
> Philippe Mathieu-Daud=3DC3=3DA9 (2):

Something in your cover-letter creation is not handling UTF-8 right :-)

>   hw/nvram/fw_cfg: Simplify fw_cfg_add_from_generator() error
>     propagation
>   hw/nvram/fw_cfg: Let fw_cfg_add_from_generator() return boolean value


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

