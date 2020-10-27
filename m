Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E2C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9514421707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="feOiEfPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9514421707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSJy-0002nW-Ib
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXSIw-0002Cq-JU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:58:38 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:44537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXSIu-0005Vd-II
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:58:38 -0400
Received: by mail-ej1-x629.google.com with SMTP id d6so3211650ejb.11
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TacXGm0yUALIKf0NNmUteMlWj7hp0bwcpOLuk6Yh51w=;
 b=feOiEfPTL68eZ6di6nyd30J7mDG5CrL+czwXWQf8kZffdC5NEg+p1UAkmWF012Nepb
 cS9CLUm+GBPHfUR1Sp2U88KM4xi5F1Pnm8kPKByryi1ZDTGdm78G+lDNLo77JEsTaEnc
 2qvk/xTnGERMiOpilW9iHLw9vSzuv2y7Mv6RlZ4lEoBNB9M8wIcP4AvKr28ZGFCK4c5R
 rb/RgmB9HUExqpKf2tVXxgAoU5k5KIpHkOghQKNn+Xr6MREwPTts9bZjVhKVMCQ/+8U6
 lTqpSm2g+lHCs05FllE/AqHrV0rRx4zq69Vpaol9Au5+oNJ+pYailc514mEEc3VoWDxW
 Zubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TacXGm0yUALIKf0NNmUteMlWj7hp0bwcpOLuk6Yh51w=;
 b=OEPEEe1Kj05Dd382yggALwJNmNDUZfm9hk/mU2ht2y43PzA0bH0jB5jQYbubaWqoKs
 y5yhxXFqnegiWiYCBG32Q+W/j/IfYT44DtPPsVSiv8xKHBB5Z/ZorHH3cXY/RyR1um8W
 pFRiIp3561sopdaZ+IEVvPurBHM7EJp/Xm4O6AwdJL5EOrjVfYlJWnNlN2EGCmtj1te+
 4BMdbYWL6tTvatMK3X1XltUsUWGHtdXN/mqj/z8hIVbfIjL/S/JR0rhYsNWxvPqdKlni
 yoXGTxX/0xY+jzoo2BAm4ZCoyRNn3SNDw3FqPz6hghR/Xa1Edu28PmHGIVkOMnnI6tuA
 +wLA==
X-Gm-Message-State: AOAM5313xhDPUEuA0XHTOKZbgoX1vconbQ6f3b5OnLhTfjgxS17hVdaU
 sfTxRSCyZ6/yl+PV+jqJdZOvXjvzp7qjC5vVBhp5Xg==
X-Google-Smtp-Source: ABdhPJyOaXpv28hRyIjKiQnxKgkwdO0k9v/WJjLyGIRwg4KJhzodO1cvfHJPIn5Odmm6gWNOKOauNXSjIby8iJCnxHA=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr3549892ejf.56.1603817914590; 
 Tue, 27 Oct 2020 09:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201026184331.272953-1-dgilbert@redhat.com>
In-Reply-To: <20201026184331.272953-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2020 16:58:23 +0000
Message-ID: <CAFEAcA8mcgk2ansZGStesf+Whdg8swkS466rVYvXuFMUWDzVAQ@mail.gmail.com>
Subject: Re: [PULL 00/16] virtiofs queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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
Cc: misono.tomohiro@jp.fujitsu.com, QEMU Developers <qemu-devel@nongnu.org>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 18:51, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit a95e0396c805735c491a049b01de6f5a713fb91b:
>
>   Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-26 15:49:11 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/dagrh/qemu.git tags/pull-virtiofs-20201026
>
> for you to fetch changes up to c93a656f7b6585d9b6f8639d1fbb74dd944be239:
>
>   tests/acceptance: Add virtiofs_submounts.py (2020-10-26 18:35:32 +0000)
>
> ----------------------------------------------------------------
> virtiofsd pull 2020-10-26
>
> Misono
>    Set default log level to info
>    Explicit build option for virtiofsd
>
> Me
>    xattr name mapping
>
> Stefan
>   Alternative chroot sandbox method
>
> Max
>   Submount mechanism
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

