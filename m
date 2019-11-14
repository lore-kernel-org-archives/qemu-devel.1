Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FC3C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512C62070E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0lh7Jpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512C62070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFsb-0003PQ-EG
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 09:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVFre-0002Ti-5N
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVFrc-0003Xx-NC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:12:49 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:33073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVFra-0003X4-Vu
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:12:48 -0500
Received: by mail-oi1-x233.google.com with SMTP id m193so5383726oig.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 06:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OS+6uvsUt/UkzNZHFNyjVUrxiK4cIAWaNyZ8P22cX+g=;
 b=r0lh7JpiyE8DMnVyvudVlPsH5tAez+4UT+VuOhGHGoJXRylWyt4oCOXtCl9qZBqMyn
 zULixM77TgN9yWosHMpj5+4fUE2I71pRl18i8IAwANcvUb6T0KCb8hiIXpMK8RvQjp++
 nQwxTYP0YE3qbKeJNpu5UTtXGtK874L5KwKyBRtjTxX+V+K8SZfdkYa+Aq217w4P1Uz3
 SV+M9VPMct471uPUG5p3kzBAwSiBd0Xg2j18/SB9o9F+LJ2UVWFh/zAfHQSwdtKcedU+
 9MAmrZn7Hu1S3s5aay4paLkPOtAJossfzPrgagmqmAuY3Z71S+BZQZSYf0tLlCow5LVw
 3CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OS+6uvsUt/UkzNZHFNyjVUrxiK4cIAWaNyZ8P22cX+g=;
 b=k4mmfT/80gE3qm9bCXKlv/dOESzLeMx6PjBzFxrtotHh1DxxS6ksP5W9YrF3C7mgic
 HmU3zHEQ+Y+qkWGCqzfDw4pcYgVO5EGFULxh6wz9jeh57c/Hvst5jzrqV7ZsZFds9sah
 WytTVy72PXAlbRmv+w0gxTrHybiBQP9Jg8gXznjvHhIA3aBd3u2nV0dQ6jJiK4kdGwGL
 1S5u17/m35engyK0p3YovUoPyDQu2lc05PVUGlNnbCIUBThWKxNE/aFcOPINATpk7wht
 MnUtpDYCUzXrrxWljBaZ1T1hWhrZkuIIeTaqd0UtlGNKpORTyH9vgQcWig9rTR3HGIJB
 nk5w==
X-Gm-Message-State: APjAAAV4lgwNUsOIwbv5jWeX2gzKhbdYeyOXr7MvATv8jkQwjvLpmJeV
 8pDzpW19apHBW+FS2v9pcHukVtLhIY66Gzzadkjf5w==
X-Google-Smtp-Source: APXvYqzsZchpwdKvW1AIDmdFxGOle1/CLaJfI9c9ftsIY3ie+1x4gK9dQ7P/HCsHEvcuAVMfob18T56hVUQTgJ7i3gY=
X-Received: by 2002:a05:6808:b04:: with SMTP id
 s4mr3711030oij.163.1573740765372; 
 Thu, 14 Nov 2019 06:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20191113140341.27977-1-kraxel@redhat.com>
In-Reply-To: <20191113140341.27977-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2019 14:12:34 +0000
Message-ID: <CAFEAcA_SkJjoVynteSo0=oUOPgC2bprQyN7Dm2xRqm-PyXLB6Q@mail.gmail.com>
Subject: Re: [PULL 0/1] Seabios 20191113 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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

On Wed, 13 Nov 2019 at 14:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 9f2ce35dfa4ea4a31dbb765dd02bed2500891887:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20191111' into staging (2019-11-11 16:54:16 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-20191113-pull-request
>
> for you to fetch changes up to 0221d73ce6a8e075adaa0a35a6ef853d2652b855:
>
>   seabios: update to pre-1.13 snapshot (2019-11-13 15:02:21 +0100)
>
> ----------------------------------------------------------------
> seabios: update to pre-1.13 snapshot (with ahci fix included).
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

