Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C9FC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77647206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0Qd9pPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77647206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56RE-0005m8-LH
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j56QT-0005HI-4r
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j56QR-0001KS-Ub
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:24:56 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:43062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j56QR-0001KF-ON
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:24:55 -0500
Received: by mail-oi1-x235.google.com with SMTP id p125so1221458oif.10
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 03:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EgAZycLEfx+7C1qQmiAFZYVbrmB8ARjrjq7Lxb2iX3k=;
 b=x0Qd9pPOiV3lvghklEE2SE531bdHZJoXHmwOUXAjx4z3Se3CNJv/ePzskOOEJygrZ8
 OP26gLJQYnX/9d4QZGGtOYrRwHl1Fk71HZFbNwr5Fx5ERSADcm19DKrTyLHflbg/BHZn
 zH1ZircOOO0RE0kj81hv64IdK5Y/cgp2WprQd2Zy4U/EKZaGwV8eINeHrbbmqgwz4ZI+
 oquUnpl1NW31KFnt/D9NJV7E9vpc//ELlChd1N29Yh+GUbv4lVQoKjL97CPz4b0etn58
 5Y3ImfCeX+zRYiM7KmzNy4D9oZsuMTYLrChsjAlPN0S/HPTkFjuOgQ6PHUKzuPqvrhpa
 pv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EgAZycLEfx+7C1qQmiAFZYVbrmB8ARjrjq7Lxb2iX3k=;
 b=NbYgICFGUnRHjWmAJJ3s607TLoGSsXodf5IBQ1KU7Bl2yfTAOPpYegqExU1SMIgnvQ
 NGpZj8CJ9yHz9FCRAeCZvcVeWm+dW3CxTaEh0uDTU+c5vIr3wozM6mugHdPxx/qMsLVV
 sFEjRp0yQnp2WPlSqg8aQZutNySkWszl4dtpYHszP8BVGQcto7FH4TAN1CWN0bIo/SoX
 TYDSlaE/vy3A/pCjAYkIMh8O4M2dRVAg7jIQ40jZZ+KTcBqaPCOtBY6YAq2drv47J1wb
 B2z1oG2DKAFAmeafGwRZ9I4vZwFQUxnEyT6nJt1V6pLUwOR9Z9unwoG0fEceRh6x/rcl
 TchQ==
X-Gm-Message-State: APjAAAXoe2jocCqEerHrXonS/bsKiyE4W0JyKAO5rTiRV1OyKJbbExB4
 7rm2tNaGQWig2sIn6eu9u6+BSDF479F+duxpgCHwJw==
X-Google-Smtp-Source: APXvYqxm02MR2fwggAEV1c2gr2BWFt6oRDZ44GeNNPgVSNvfX17EuhVamqpQZIFdMl+nZ5apqcnfKITpJxE1J0K1Xog=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr1585193oid.98.1582284294772;
 Fri, 21 Feb 2020 03:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20200220092053.1510215-1-laurent@vivier.eu>
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 11:24:44 +0000
Message-ID: <CAFEAcA9rSYLv4ojpf02t9_oYLXBJp=1iRkPV-Fz2-p9zZ4zgOg@mail.gmail.com>
Subject: Re: [PULL 00/13] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 09:22, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 6c599282f8ab382fe59f03a6cae755b89561a7b3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2020-02-15-v2' into staging (2020-02-17 13:32:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>
> for you to fetch changes up to 045823a98c30fbcafa6d6b61a28b284de7038f07:
>
>   linux-user: Add support for selected alsa timer instructions using ioctls (2020-02-19 11:17:40 +0100)
>
> ----------------------------------------------------------------
> Implement membarrier, SO_RCVTIMEO and SO_SNDTIMEO
> Disable by default build of fdt, slirp and tools with linux-user
> Improve strace and use qemu_log to send trace to a file
> Add partial ALSA ioctl supports


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

