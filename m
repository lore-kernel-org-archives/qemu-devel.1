Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10686C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB4620738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvvSlvvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB4620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YZI-0001YH-Qi
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YXH-0008C9-Qm
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:21:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YXG-0005KB-2d
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:21:43 -0400
Received: by mail-ot1-x343.google.com with SMTP id z18so7146361otk.6
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8tlGDgWzoBi3BSYs54SaH34L1weOCD7w8E7Mp7h18dA=;
 b=fvvSlvvCaLm5awwDrBj44V1wofxfdq2D0LLLJUlWTZZxr5qKSRlDQWiiusiTrPrnlx
 zB5qXAqOtB3dyf1Sw53PKbuaorGsns6GRxzL+RZs1TSfqbxf4yL/FygYDcqBJ4iB8KDl
 m+auOO9C/zvHXVS/yC/0su+0gW2EPmobJxYj7q0n9gwR9eQ0kRK5vbqSBZktXgHQfit0
 yW7vUG+tyIoe8j0gEKpBaBIaSKhwRqXchz74fZqGxwlzDO1c7Cd+ueipi6BhMOyKrQwj
 YNp4zM6yHtxp2tSWKvqKg9kNqYUVIykh4s9Q3jHwTVRdewLWUH5g13oDwRp4nvs1N+Yp
 sAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8tlGDgWzoBi3BSYs54SaH34L1weOCD7w8E7Mp7h18dA=;
 b=k0hVbYy08HfgfqNalQrcbODBxfhAVUciI/MJn0LI3qXemp+riqvniE2TORXDofY0gb
 eSxXGJ0IuGjcvRkUuBybcBfXGd6p/oksINAnKoSp6BrVa+d8yNMOk6UfjDqfFXQSi6tw
 epqsunCX5C5GPgyPevwnrBY0cfpp27e88ZDReDnvd1MMyTWmAbbW6rDYEghjdMo1OzzS
 Gk3Nb0sRyu1eC7UXgIhJUT2zwrmcxaQFrIZ3WgyaZZdM+BSE0H/ACVzu9B2vSxqjBfWb
 7UqP2sQjLh+olZsbFXHVCBqegLbqofRX0onmX5IN8idV/xrea3gYGRZ4Go/zrnhP7G74
 uhyQ==
X-Gm-Message-State: AOAM532ievu7p1ObIsmfpANxwPd8bKl3GcKFuKb6jvP5tDaN1B5CWowk
 A3PS6nH85lne+YZWhkNSG6AtaJlYi+NaoN8o5zPKEkF5qog=
X-Google-Smtp-Source: ABdhPJzFE1Qx0gIgu+FomqmrCHU8ZWUjTa302gC440ptCDt9WmTDA/b5vUSRbUoYFAK4ZH0i4L9VyF2V6QQpCshl/VU=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr13134162otb.91.1596453700770; 
 Mon, 03 Aug 2020 04:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200803052437.11030-1-kraxel@redhat.com>
In-Reply-To: <20200803052437.11030-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Aug 2020 12:21:29 +0100
Message-ID: <CAFEAcA_LYPYmVNNvHdRoE71vFC9NPrFCfFZK83JPaK03P9H_Ng@mail.gmail.com>
Subject: Re: [PULL 0/1] Seabios 20200803 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Mon, 3 Aug 2020 at 06:25, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit d74824cf7c8b352f9045e949dc636c7207a41eee:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200731' into staging (2020-07-31 10:28:13 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-20200803-pull-request
>
> for you to fetch changes up to 1f42e246995a99890f6af4e42329f184ee14b0e7:
>
>   seabios: update to master snapshot (2020-08-03 07:01:02 +0200)
>
> ----------------------------------------------------------------
> seabios: update to master snapshot
>
> seabios master branch got a few bugfixes, so update
> to a newer snapshot to pick them up for 5.1-rc3.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

