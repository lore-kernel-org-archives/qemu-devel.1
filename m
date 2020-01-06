Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E595C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A47720731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PabWmIWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A47720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioT3s-0003qX-Cx
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 09:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioT35-0003OJ-4p
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioT33-0007PX-Pk
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:08:02 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:37900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioT33-0007Ow-KX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:08:01 -0500
Received: by mail-oi1-x233.google.com with SMTP id l9so13192986oii.5
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 06:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TS5z4xVQUZrVQ+v6+agx5Uw8rcl7kqEIJvTkIHd7n0A=;
 b=PabWmIWPsl6iv/pFOTQ5tqwesjnR4S9CzBQbGLOUcZAuiuX0WTzS/ypsqmL/b6oITP
 qjpLc5W1SH8ERRwZdU3gfsp2Chi/h7yZd6pjVVAlNmtwcnVLHkJKc+Hj8GNh79bNWGNd
 Rq1ZNxU/RuTrUKSR5odlLj0y9p0EsPLJ/MbbshbDDvrppeCqBapzc74oMu9DJ+FUMj7c
 P5/+S8Wmc7QyB+lupbNrtKJiiaK76ROUD5C6IVVza3tlOWEasFkB4wZBBf2C1doM8MVa
 ZQiw4uWquAx6fvcGYpGiaa6EjhC9meiDcNCEiZFsbJb0eQH0+bxT8OXnaAA5p7Wac/hX
 7Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TS5z4xVQUZrVQ+v6+agx5Uw8rcl7kqEIJvTkIHd7n0A=;
 b=lkUoeqOir//CbR5+qiIxnndKYUkrNNfCZYzRtZzdbGVu4rM2eMXgEF+Xruoeh9DvY7
 tUnJrxfBWp7lfvrKyljbGcfZZvSOoYQlOtvSXsZpR/+uiCOnL0LVjQVCaFOs+ZAz/rEe
 R1niPDBkQ5QcNdtA8miFfBo6QdlMKgnViRGeMupezBA4GfQcGn428Kl0/y2eaXvSZFiP
 RK8Dk+B76KlugOi00cnR/7ycQr4DJnhGtoEIjI8vUV24GUfAoLhUwyutXG4QKNxpQgRl
 MwXX5TSs54Hrzw86ap0ACkLpCSlAMohSpWMZ48iwZ/NM6MBaiYXv9m0DiZG0kUhcG1+p
 z37w==
X-Gm-Message-State: APjAAAUnMwN6p38FPAe8hGJR150Ifs3o/EGYPNw2M/PKa2HzpV5hlJ+3
 0BvP0NlCLCI3ET5/cWaD0QnSQCBcpFcEe02eDgmxIA==
X-Google-Smtp-Source: APXvYqxL+bU2d+xn6yPORiDZn6mXgSnV1D4RUa3sv7cUsnGt8rReBnGBZlbSTU/PkCFgIVx3QXAU4wYXvomWtY7HVHg=
X-Received: by 2002:aca:3182:: with SMTP id x124mr5671813oix.170.1578319680229; 
 Mon, 06 Jan 2020 06:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20191220165141.2207058-1-ehabkost@redhat.com>
In-Reply-To: <20191220165141.2207058-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 14:07:49 +0000
Message-ID: <CAFEAcA_5D76r+n5Eg6t9d3KNGJw60iF20QPgp3Fkc5fGgM5e-Q@mail.gmail.com>
Subject: Re: [PULL 0/2] Require Python >= 3.5 to build QEMU
To: Eduardo Habkost <ehabkost@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 at 16:51, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Differences from the previous Python 3.5 pull request
> that was rejected:
>
> * Now tests/vm/netbsd was fixed
> * .travis.yml is being updated to replace Python 3.4 job with 3.5
>
> The following changes since commit f59b31e6d0c69792b5d817c5aa0a6ed64fba42e0:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-tesing-and-misc-191219-1' into staging (2019-12-20 14:00:49 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to ddf90699631db53c981b6a5a63d31c08e0eaeec7:
>
>   configure: Require Python >= 3.5 (2019-12-20 13:45:59 -0300)
>
> ----------------------------------------------------------------
> Require Python >= 3.5 to build QEMU
>
> Python 2 EOL is 11 days away, we will stop supporting
> it in QEMU 5.0.
>
> ---------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

