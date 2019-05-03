Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAFEC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5B6206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQop3VqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5B6206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMUds-00028U-HX
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 05:38:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMUd5-0001qi-T9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMUd4-0004sJ-MF
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:37:19 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMUd4-0004rW-Af
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:37:18 -0400
Received: by mail-ot1-x332.google.com with SMTP id g24so4753510otq.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=EuSHcKmMA8pKSxaWuamHASVhhYkc0aRiaERnYJX+LgI=;
	b=hQop3VqHSVffSqEWatBV0GC+F23GeMb/06sJHPq74cDj3TgcSM7GpYbwd0n/4jGcaN
	WHDLm0Clqo74CAXoV7nECxAKw9O4kaxGrPKVir7BxL3uXUcKM7z0RZGeCEirpdZIRF5f
	+zuCN4JERk/DBugJNk1nixm2dRgZU0cKqW76ILso5hynmBXimrna1XE6VU7V04sfjiOP
	cdLROWXLDxwhvPP3eiRzIAJKVdRq9TbYX04MBVzR5oG5ylZ9ZrOduxSi7h0hrxbpzR1P
	epxp5LBIyqt+dITJG/uz6KevlDjE6KCUTvy1wciJGrnbBuqAU6kQuXf7Qx01TH+iRISd
	KubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EuSHcKmMA8pKSxaWuamHASVhhYkc0aRiaERnYJX+LgI=;
	b=dW94PYEEXsW+JZTW7Zq6kWKg83QwxW+F5/Dlmc6AYbPNlSmjYQuv25OI7KBNnFE8Sk
	+HKOYYL37NbzdfpzZlsK3IDK9Ezoely4xcnTiGMXTusLkLDKaIhgr181KKvrOUgzCQ2j
	cMRPhSZjHgmLAAIHWp94f46jYQQiuQV/rtMKVcNSTOPGuu9Sy7eZwJoGgimeGnSaLHs3
	UEjePr6Hcp61UgmLQdhlgOlhAd+4wihp9wlcjLNXeq3qmFCh67IXjphiqbvhyvoF4T/K
	9H5rIo5xeesruCIPtuu5GyBc1W3Pbuir9gdmqDSaT3vx3yTuAApEsmzcAC/GNezyvfu3
	BPyA==
X-Gm-Message-State: APjAAAU6AsKbapZVE4w2wnOfudfBCMPU5fV3A1T6ykKDmbeZpR2Mn1od
	Hf/JhCCv/7rpK1y1sQ0Tt2SgEzlUP5/Mt/BlHobccQ==
X-Google-Smtp-Source: APXvYqyYzoewXaSfcOq/OzVVekZbC9zawDtJG3Hv6fXqr7409NeojecTNqLjMfIHhQaTmfcXeg1NT3LSDWix0wWqigM=
X-Received: by 2002:a9d:6d19:: with SMTP id o25mr5340292otp.151.1556876236547; 
	Fri, 03 May 2019 02:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190502161310.15624-1-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 10:37:05 +0100
Message-ID:
 <CAFEAcA_yHdQrEQaee2+gcdhGS8XYm7srrh2y43aGwgFtdrdzXA@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::332
Subject: Re: [Qemu-devel] [PULL 0/8] qtest and misc patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Otubo <otubo@redhat.com>, Helge Deller <deller@gmx.de>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503093705.J6gcxdEXemRfl-pYxBZWEhCF6uxMcf7P0V5f4ff8rUU@z>

On Thu, 2 May 2019 at 17:13, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41df:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-05-02 12:04:51 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-02
>
> for you to fetch changes up to aff39be0ed9753c9c323f64a14f5533dd5c43525:
>
>   hw/pci-host: Use object_initialize_child for correct reference counting (2019-05-02 16:56:33 +0200)
>
> ----------------------------------------------------------------
> - Move qtest accel code to accel/qtest.c, get rid of AccelClass->available
> - Test TCG interpreter in gitlab-ci
> - Small improvements to the configure script
> - Use object_initialize_child in hw/pci-host
> ----------------------------------------------------------------
>
> Eduardo Habkost (3):
>       qtest: Move accel code to accel/qtest.c
>       qtest: Don't compile qtest accel on non-POSIX systems
>       accel: Remove unused AccelClass::available field
>
> Helge Deller (1):
>       configure: Relax check for libseccomp
>
> Thomas Huth (4):
>       gitlab-ci.yml: Test the TCG interpreter in a CI pipeline
>       configure: Add -Wno-typedef-redefinition to CFLAGS (for Clang)
>       configure: Remove old *-config-devices.mak.d files when running configure
>       hw/pci-host: Use object_initialize_child for correct reference counting


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

