Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBC9C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDC02166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yykln24A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDC02166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSgPi-00036g-P9
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 06:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSgOe-00029p-J5
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSgOd-0000dP-B4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:56:16 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:44230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSgOd-0000d7-5L
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:56:15 -0500
Received: by mail-oi1-x231.google.com with SMTP id s71so1674128oih.11
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 03:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h/RFSiOoZIXnOLwxgmqA8lnvIBK82wgvF3pldT9PXrk=;
 b=yykln24ARkwlp4kldJ5Zim7cPq9GoEOPdKuDiZ4VgbKP3vBX1EmJtIzSuA2vaNepcR
 QqSDpzo12pkMQ8cFPrhMKEx0RzRxUQp/2UJRCWhvbq7OzRY70RshzWimnFdJzwhVIdqo
 viVmO0raiDF+vW36E58MSbXxIfnQdzGYrrg4Hk//hLBFGEVjNKftx1u08CQLqFJs+I1L
 SrZt3M+EIzmPvgmeg2o3CCHv4UFr2qBUZMRBy4xS6+OmFe9yHhrv2NBIdYPoASSslWhb
 li+4EvsXWPhG1fUUVTPdJ53xUezjBbVikiaqWS7Axg5MJ9USM+KmJjNBRgB6pkxcFq4O
 4HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h/RFSiOoZIXnOLwxgmqA8lnvIBK82wgvF3pldT9PXrk=;
 b=JnTzyj1HEDUExLq3A8Lcfcz//uRbBiXUp8iEGp1KxUOoLCX+vA1vkPeW/p/CwAmDBy
 tK+QTGxnwyW/S4Us4hMxkfS+2XNu0rJySU4h4hZTAUCwvCgYXGAYl8vCpWNBxgJ2nzwG
 Eh5NejimCz0wnUoR9IY+Hoq+CDyGwWAgWX56YOBK1KLrfHQp79kipW2GG7Y6OKmHso8R
 qBwcKAUA+aKrMRA33QmWsPQRDJY6OY0GvvFx/Ic5g1JrL7wujCSJ+KeRHB12ARPmCrVQ
 cYZnKZQQvV3SzVf2oTGLFYquKd4VNe+sxLOZddxkSufxzpuYsZ6OtDzHvOfHsW/suQYI
 Xlpw==
X-Gm-Message-State: APjAAAXL5YBKz71GOXG17hzYXzOGNukvnl/FVeoNifePIXMoxIOP9NyU
 YIJcTsa45dv6crQYqnjUacJUYKoTcGyWFW2bSiNrGw==
X-Google-Smtp-Source: APXvYqz9NT3KfkXudDLLyqkjIMSiaQF8tAU3j+/ge88xbLwTFiPs57glEG2w0EzM29eL6HVW8ohNSfzDynWRuUBai/E=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr3210402oij.163.1573127774201; 
 Thu, 07 Nov 2019 03:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20191106122524.5537-1-kraxel@redhat.com>
In-Reply-To: <20191106122524.5537-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 11:56:03 +0000
Message-ID: <CAFEAcA8uHQUvWm2H_=Y46qtdpNLBtcYRHWsvvWf+CyjYdFdLag@mail.gmail.com>
Subject: Re: [PULL 0/1] Seabios 20191106 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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

On Wed, 6 Nov 2019 at 12:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-20191106-pull-request
>
> for you to fetch changes up to 58b16e57ded751e2e8be626124aad1d46a408a33:
>
>   seabios: update to pre-1.13 snapshot (2019-11-06 13:23:02 +0100)
>
> ----------------------------------------------------------------
> seabios: update to pre-1.13 snapshot
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   seabios: update to pre-1.13 snapshot

Hi; this fails 'make check' on at least
aarch64, aarch32, FreeBSD, NetBSD, s390:

ERROR:/home/linux1/qemu/tests/boot-sector.c:161:boot_sector_test:
assertion failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
ERROR - Bail out!
ERROR:/home/linux1/qemu/tests/boot-sector.c:161:boot_sector_test:
assertion failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
PASS 9 bios-tables-test /x86_64/acpi/q35/bridge
Aborted (core dumped)
/home/linux1/qemu/tests/Makefile.include:916: recipe for target
'check-qtest-i386' failed
make: *** [check-qtest-i386] Error 1

the x86-64 bootsector tests seem to fail similarly.

thanks
-- PMM

