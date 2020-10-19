Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9304C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBD62223C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8KTrZXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBD62223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVPb-0003Wk-Rf
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 09:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUVNo-0002Xg-Ht
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 09:39:28 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUVNm-0006ga-Ix
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 09:39:28 -0400
Received: by mail-ej1-x641.google.com with SMTP id dt13so13920459ejb.12
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lvVcxQhr7xPST4cqKN9rD6sW0AGoAFZIYy/7YTajQIU=;
 b=D8KTrZXJtJWXMIRvH48ztzq62Emn6vlYVvc/+Qoez4eDRug+5BCtFq8hJqkn3KWWtT
 8ssxXvOm5IEEnS/S97EyoMuloRhCGnGzgKdNHXEs9Gc9oRF9O91Tst/sJ2SJ5WhbNQF2
 sw2PvXIQV3g+a5WN9NbSdR4/bPnTpV3EnHsTZFfHjtUQJ+YROWu1QPGcPBHSaiCK3edK
 jBlDQPSXuokrI3VrYJEjQnxmx36ECL2nB5xiVnE/V0YgM6gtNSl3eeBxY47bKLi0VQY5
 C9uJaR9pwgsaZAaWoJXiV5cEyaYSzYvrHHCkk5EdmYETN+mphvMMgxzo2+/gqXmxM4QZ
 oMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lvVcxQhr7xPST4cqKN9rD6sW0AGoAFZIYy/7YTajQIU=;
 b=q8/A9pGUGixAZqyAVVexUd3VVgWZYrQ1R+Ioj/6J3w05fOE4IbcP4Njxgb8hLlBew3
 XU3l4dNfkwjv3qygYRExxkR4NKvpC3Y/I2pc36LRxP7ErdO0An5bz2qMDtY02oDF4bXt
 lWmeHxuvHpo85r5E+2dFdbsvQFsNWZ+dfDo3GgdIhgvpbCBRNjtglE3URXjygyipTQU/
 T8xpVtTvcKxs6yB+3u+5OLvhtObT4MfLhyvvrI3rvFtXoxkZwwVzKVvdk2uUd73sJB+4
 zo5AcY99fND0NozNg5e+XJmbCv2mZcCNXYCc+bIj234FdsvN80fTHsNGIriafoSSFKvW
 VolA==
X-Gm-Message-State: AOAM530+dEIQ42Y3oDUocf748s/iafHF4cvGKhNFXgoTMl3RBXVnce/+
 EBRNfdUe9/fcNwSMv9SKGpQJYwZ24o1/QjzQUh+DXw==
X-Google-Smtp-Source: ABdhPJxRIAOpEH9BRERsOgehtPvd6SJK+TYI+9/SmvL1tuNUnRoIil5OLBm0rPsvHIxC4N48V9LHtLlhD47kXvmwC8E=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr17360658ejd.250.1603114764473; 
 Mon, 19 Oct 2020 06:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201019123326.9973-1-kraxel@redhat.com>
In-Reply-To: <20201019123326.9973-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 14:39:13 +0100
Message-ID: <CAFEAcA8zsY0FyN5XS84RBP0h5tOtC1P4ZyNau6Ji+KGZMGMocQ@mail.gmail.com>
Subject: Re: [PULL 0/3] Usb 20201019 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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

On Mon, 19 Oct 2020 at 13:36, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e12ce85b2c79d83a340953291912875c30b3af06:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-10-16 22:46:28 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20201019-pull-request
>
> for you to fetch changes up to bea2a9e3e00b275dc40cfa09c760c715b8753e03:
>
>   hw/usb/hcd-dwc2: fix divide-by-zero in dwc2_handle_packet() (2020-10-19 09:17:21 +0200)
>
> ----------------------------------------------------------------
> usb: fixes for dwc2 + ehci.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

