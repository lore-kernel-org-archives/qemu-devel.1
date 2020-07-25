Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7872FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 19:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADB820674
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 19:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhL1f1zH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADB820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzPtu-00039j-Bs
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 15:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzPsp-0002eI-Vv
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 15:31:00 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:37391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzPsm-0003CI-GQ
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 15:30:59 -0400
Received: by mail-ot1-x334.google.com with SMTP id w17so9527646otl.4
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n5SvYSseLzFzfeOfav1aBIEEejp//4PJOzpkdi432WM=;
 b=VhL1f1zHE8aQQzjN1CgwnfBl/EoyvIta2zMjDwctIygDuk4iCjtJT/X0vvs/r/nnbE
 Y/86a6bsgGeEOSVYamQ7Vsk+SVzBM+YVLOU+gG7XcfiCl2y8xmpA5Jmovh5ycc/xfs2w
 HGCjPM3VhgXL9q3Dv7V06F+cH7hgnbKfEt90bw+ZiljmCWWFvJUvSeC6H8ZYaVRd8kV7
 +ODZ3shW8Ba6oSiTwqxG6LnNJQ7QD7+V4XKOI7MRNIvMTyKgCZphyeMep7VWZHnAmqVC
 KVa6EuJKXC1UjpMEFZuKkiNqOOXOQvDjZsmTv5MEgTSE7r/8v5MVvT4tWd+iOYhvlYNc
 1ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n5SvYSseLzFzfeOfav1aBIEEejp//4PJOzpkdi432WM=;
 b=AuFSVWg4L4JNAJULFk0+TS/r2ToRBg7Tf4ySbOp32f1UfaOpYI9R+i7jL2xJItqEfM
 GzfudwX3m/1YiaytTtex8TIflQj3yZswYWX0XeyVc4qdEXc4WUY4j30YRD8xIfoYLmwb
 8b8q8fyj4/Kq1o5e0jOmPsIapw8RveIMFQgj7uGzhPNCQnbZN79Oykh5tl+37Wux9og3
 jh5ffue9yvAdpz6UR6UA21I4PH/8AYDUiJ1YePeQrxyOoLCmqsf3qdW1m+BSMBj+5vGF
 DmZpZdLzzZNH9nGJptqahY9s4KJt7rhgQgLRrZRCiqqvTHAMPMBBISQWuIMXo4qkMJIX
 tz4w==
X-Gm-Message-State: AOAM532kPRpXumPKL5tosLlyXAYDEGSutV6a10R/wMMPH1TKIZqK29Ar
 LOPiRyJkXYmw7J5kUCFgp3y3It/Qpb2GrIJHOXHCKg==
X-Google-Smtp-Source: ABdhPJy40cokDsshzRUP7nO3q+9g4jVumICwOG4IRnRZStfjHK5wQahcHQfSkzgU7QstDiUj3TRml1Pz+2aoYSHMchs=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr13636726otk.221.1595705455145; 
 Sat, 25 Jul 2020 12:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200724164258.24886-1-kraxel@redhat.com>
In-Reply-To: <20200724164258.24886-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Jul 2020 20:30:44 +0100
Message-ID: <CAFEAcA_VFgmzxW9q1qD5cgaqW5ifQmGH4jgL-xkfgMe7Y1rZiA@mail.gmail.com>
Subject: Re: [PULL 0/3] Fixes 20200724 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 at 17:43, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 09e0cd773723219d21655587954da2769f64ba01:
>
>   Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200722-1' into staging (2020-07-23 19:00:42 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-20200724-pull-request
>
> for you to fetch changes up to 9b52b17ba5e96cec182537715e87308108b47117:
>
>   configure: Allow to build tools without pixman (2020-07-24 17:36:03 +0200)
>
> ----------------------------------------------------------------
> bugfixes: virtio-input, usb-dwc2, pixman.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

