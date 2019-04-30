Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4189C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B832075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCoKr8Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B832075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42483 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPaO-0006x8-Hd
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:02:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPYv-0005xR-MG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPYu-00082Q-2C
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:00:33 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:35857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPYt-00081h-QQ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:00:32 -0400
Received: by mail-oi1-x22c.google.com with SMTP id l203so10766918oia.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=1amBxHWYeyjf2TTxMgKsHlw6zt8kc/0nGjMrnEpK1pc=;
	b=kCoKr8FzTga0enzLVuPEc4qmlJZI4I7HbmLYZU/Vt04l03hOMmLEMWdUapB84Gl8TZ
	T6Rh94SerDHKDD6CaOgBdwOR+SNWHrWWDoeiTSkSDk7CvKnuSG2oWwZklCwOM+iRRcTI
	lBVYp4ipyN0pTGHXP7AuJU3mgGL6N0FABnio5d30NYqdzXopiz12XVqF4ZWszaYfQs0e
	Pocqjo8/gbJvSqRJYhIFa97X6AmrbBgl8lcLzyYvWYwXrUnIhHYFtMnEYzPpZe8jXhth
	s+ksCb6K/8qJiCwSjS9ws+//NXVsHLGLAmrovn7+sfHN8HFSfbHGN9MoohY/AuCIvmmO
	3d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1amBxHWYeyjf2TTxMgKsHlw6zt8kc/0nGjMrnEpK1pc=;
	b=Onv6hKSmYnyUby6g/DQlcSv7FFU6SCf09Gfxj45/aL36ehgkiPwbii5JHd0goJihZU
	rlhxCWb7ZisEZIt0HPACAjEpltK237XUs12zcuvCgDJToY6UE1W0l+Y8goW747YZKOnu
	3pBkcOgPx3unktXQ940BvzdFGn+pb7NevvGBgbvq1ehf807c9grLIU2+n/Yqzdq7Mxje
	IQK6uG9hP6UTDqnMO9PciZ/k/MOiAhnXIL21mhR4bmv3xnavcrsqPiWDXkImXDlBXLlC
	1k883EOM+I79HA4qeJgg4CXJwyx3ec3CJqco59gHfRHee9Do8FD733LtMXr1zc/Ui9ma
	oMOw==
X-Gm-Message-State: APjAAAV2K7umI5+5PgK+PiB4xhFzt31XuEzbuO8rjmytXx0U7J7gr3W1
	K23aKf2OSM6JyNhHmQGfXMxgnkAl0Dd8sUHxQQmU+A==
X-Google-Smtp-Source: APXvYqwOW6IR0y4Rk9dweli57U3H3bR2PSVLL9hzukoZhiIcU9MC16R3nlMlxfo6dK21/wQBbb1RzWGBBRYXtnkXAWY=
X-Received: by 2002:a05:6808:301:: with SMTP id
	i1mr2366562oie.163.1556618430152; 
	Tue, 30 Apr 2019 03:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190429215821.10079-1-richard.henderson@linaro.org>
In-Reply-To: <20190429215821.10079-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:00:19 +0100
Message-ID:
 <CAFEAcA9S21wftfXwLV5T3bX2p=R4RnMkpWvxqTA1su4QvoZb7g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Subject: Re: [Qemu-devel] [PULL v2 0/2] target/hppa patch queue
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430100019.QgmajAXr_6RqCrIDYaIOhNY5vh5pOe_8WO3xIlZiTUI@z>

On Mon, 29 Apr 2019 at 22:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rebased for v2.
>
> The following changes since commit 82b2865e0d0ea4c1001e9e7ed7920bcc0458f6de:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190429' into staging (2019-04-29 18:05:56 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-hppa-20190429
>
> for you to fetch changes up to affdb7e6ba23f8160cb88e11f83db54a35f03d6b:
>
>   target/hppa: Always return EXCP_DMAR for protection id trap (2019-04-29 14:43:39 -0700)
>
> ----------------------------------------------------------------
> Implement fast tlb insert insns.
> Fix data tlb exception for pa 1.1.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

