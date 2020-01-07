Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6695C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D63A222D9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eol04kd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D63A222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopvM-0005QP-E4
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iopsA-0001oP-V9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iops9-00087s-Mw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:30:18 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:40715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iops9-00087T-IK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:30:17 -0500
Received: by mail-oi1-x234.google.com with SMTP id c77so17377926oib.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0r4EeqIFNcJaYUfmKTNLb5Cc5ORQ6dUfd20+fFY6GqQ=;
 b=eol04kd2hAqurD3Lm74/B66imoArADiusEH+RX6AXEEqVcyEnsvYyoTchnSU2D5kbq
 j2LFyZCHYVSuUc+uB7YaSe6dJ9ZAq/wJT70PPCXTyC8vYkgdgXo9XDe20sOUYkeXJ5Z2
 o1/KPv/9cVbhFkwW7haQhZ9XcyabgxnGhIkyNGytHReP95PjuyL+r+N5D8AFlXsxbYeW
 6/yJLrzdcVt8i/q0DGTCIqUN4f1d8Z1SlCJ7xlup1f3qjQwSE6LEnJg5gZVKpqj14JxK
 CncKmyf9o9Tx9eETAoRLOpFnWDRvWSqggPKW4gIoAZTqmFTse0x/FW2NK8IlqMlEOSh+
 5kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0r4EeqIFNcJaYUfmKTNLb5Cc5ORQ6dUfd20+fFY6GqQ=;
 b=IDrMJdwyrOJPu/YQ1BlrP2sKJyJnqevEvbLxPZGdULdIZYSx+QlQmUKCR0Y1ha/UlF
 wyUGP878WfcuHsY5+hjdlPDkPzMzVXUVW36KhqF6TcDesZqkPWJ8/CS6mnna7mfds3O1
 cfCh8OKe6AbsVhnR+NynjURXQtB02cQRlggf3lQt/XM7tMo081CnjdUEWAKfgll2HZnv
 dOxnGISu6eAhK5JOgEOcreiUJpmF7C0FgZCnt34lUVpaYc30SQ3nHt2YdUEeK3Xt0SKp
 F+THFjbOGChpX4755oFKRdPjCJTXKKjS5bvCBwop5iKXeE+FbAyTOH0M0oYcqlOcwImJ
 1Z4Q==
X-Gm-Message-State: APjAAAWF83SSs2jy0xJutPrkPJLj5moMTOJKiIep8qxGODr/PwRUMhcL
 dOpP8tFNns44nuX+tnzJzXGXBDZwJx99aqlsTepEhG9IDv4=
X-Google-Smtp-Source: APXvYqzb2frSu9CXPqOEM6vUxrIOXIRaNrxm/+3FWzI/b2J9w4Y6RZZBgai5dXLJVAe00NA7fwcdiJf/UqK/HFd3Hno=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr24688oid.98.1578407416731;
 Tue, 07 Jan 2020 06:30:16 -0800 (PST)
MIME-Version: 1.0
References: <157834844263.18456.7231217269341794728.stgit@gimli.home>
In-Reply-To: <157834844263.18456.7231217269341794728.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 14:30:05 +0000
Message-ID: <CAFEAcA8tEOE7b0gXXitvOn_a84_cuM1m-X1oB3FOJjX4_7vmog@mail.gmail.com>
Subject: Re: [PULL 0/1] VFIO fixes 2020-01-06
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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

On Mon, 6 Jan 2020 at 22:11, Alex Williamson <alex.williamson@redhat.com> wrote:
>
> The following changes since commit 48008198270e3ebcc9394401d676c54ed5ac139c:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-12-20 11:20:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20200106.0
>
> for you to fetch changes up to 0446f8121723b134ca1d1ed0b73e96d4a0a8689d:
>
>   vfio/pci: Don't remove irqchip notifier if not registered (2020-01-06 14:19:42 -0700)
>
> ----------------------------------------------------------------
> VFIO fixes 2020-01-06
>
>  - Fix irqchip notifier de-registration if not registered (Peter Xu)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

