Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF423C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B047223E4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGvloTBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B047223E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZKK-0000Qk-3O
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIZJN-0007xQ-CS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:25:35 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:40982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIZJJ-0006WE-S6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:25:33 -0400
Received: by mail-ej1-x635.google.com with SMTP id lo4so10916226ejb.8
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ppm9q28Vz2KwjW+qPAh6rN14WopKJOI8E/r8dfHdhYU=;
 b=gGvloTBKXjpP+/vju3Mag60eOr2SblOXeWg86FIaVCQlmotf9aqPkqUsYnyQzh1Nli
 a9V8j1XBIX1z7mQV3IEbn7iZc7q3s5VFRpK7pi/rQiA0kHNhiyoRjTRGq4ECYdws9k9K
 xf3lyitBFLs7YI9KJfq/helNkvPdL1haIrsZKjplfEWdGbfv3kfRjyT3Lg8wIyBeP4pD
 FqMxBWgWaBbKZz4mnsAwHZcDHE+l5VdCYB6qtapNRxpzzPJGDxeCynO0l5VJ+CjQtwIz
 HSK4nL3BM8JSrUBQyMNvvpbj6qvsucQpdSRTNudNeO762/GJp2VdOwp5T8jKAnlnCa7U
 E4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ppm9q28Vz2KwjW+qPAh6rN14WopKJOI8E/r8dfHdhYU=;
 b=JehMltIyJ/LEf+u6KM5V2LXq8lUFTyAsW/DXB21WgQjMIhrGsCEAOUaKXDwch2UjLe
 bxRKIaHWLN2yZy+F8yM6+4lEIb9LF1BpgluSZAb+fn/yDeVOrl9H5FTYP05+m7CgEGj/
 GsZiY/xw4kHVicwaTYu4zQsDKOyNIVLe5o5FdXSZVbOvW0+FdZSFkBe4d5uvWy6evyXt
 8dY/8KTTOlsUNMQ57XYcNRJaig5e8I/IR1THlN6P3U8L+vOTiWi2+h1ucTW5X97T1C5l
 6WBuhtaYhP1rZGPku5mv9PY4MwvuldjmtR7SqY7VYjn7ANItXNwIfdWuYp5F8QlKHn96
 3weQ==
X-Gm-Message-State: AOAM533F2M+A7zLYK+i2fbtdYJjN0Dh4D6URTo22YGnoV5zJXimRNYHL
 USUCbGVRhs/O0AEgA/P6+W07+0RR6zcmhrKRxCadMA==
X-Google-Smtp-Source: ABdhPJwkF+2CNoyqXpfzmDjRIGcgpRrF+sh01HbGMJGWZR5BTpRjRob4vgHY5JniRyM1PwqZnwethgcbsSQIfv8Syl4=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr25381756ejb.85.1600269927639; 
 Wed, 16 Sep 2020 08:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600166281.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1600166281.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 Sep 2020 16:25:16 +0100
Message-ID: <CAFEAcA-awt=bm0yhk6_My5tcLzwODipYBbVsxVcdKihXiV6Spg@mail.gmail.com>
Subject: Re: [PULL 0/2] 9p queue
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 10:20, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit 2d2c73d0e3d504a61f868e46e6abd5643f38091b:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200914-1' into staging (2020-09-14 16:03:08 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20200915
>
> for you to fetch changes up to c418f935ac6aed9aa1dc0ceb4b19044a9b7b7968:
>
>   9pfs: disable msize warning for synth driver (2020-09-15 12:12:03 +0200)
>
> ----------------------------------------------------------------
> The intention of the following two patches is making users aware about
> the negative file I/O performance impact when using a very low value
> for 9P client parameter 'msize', which especially is the case if no
> 'msize' parameter was supplied by the user with a 9P Linux client at all.
>
> All it does is logging a performance warning on host side (once) in
> that case. By setting 'msize' on client side to any value larger than
> 8192 the performance warning will disappear.
>
> See https://wiki.qemu.org/Documentation/9psetup#msize for details.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

