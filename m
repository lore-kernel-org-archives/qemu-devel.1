Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5842C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BC72051A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSWQzkH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BC72051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dOF-0005Km-PJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6dN5-0004mr-8f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6dN3-0000FJ-7t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:47:46 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:40598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6dN2-0000EZ-8m
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:47:45 -0500
Received: by mail-oi1-x231.google.com with SMTP id a142so13174709oii.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 08:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4dwWK4Oalew9sPO1oZm+RBYn/JD+GNzYLFg7/WbPqOk=;
 b=QSWQzkH9hFzr7lo6ybQ+iBqFyiwNTeWofg6D1rih3PKgNPAE7yOerRbJzBKrYw8iSd
 T5YvWkQDpRgBTsjX0yA5HrUXdKLHXH1RYkKtri+3hMABfLeOa9fNApM6p+WC21+cx6dr
 iW4owLVr5vZU5Hhn5A90FycIb7PiSckjuGxPJS6bL20370Z/sdm4xZlQARu8OeOjUye/
 xGpkrWUOOMCOEPBwZboLLVLzEwEza1G5ez/eLX1IU7USFv/vMbiz87c69Fp7EvVjjFJz
 2Qw2dHaJbLga/4aPpqFZxPmp79MvVz+3dAERu3ClhdtJkUh0qsgWSbb/XTYOsR+3gAeR
 QkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4dwWK4Oalew9sPO1oZm+RBYn/JD+GNzYLFg7/WbPqOk=;
 b=lsKQbi4tfzUQvwGHsgNBMhogX0Hu1rFNhuM0OVVibLBx2fQe5bN4ho9BrRYKozgAYY
 W5mmNrhZtWLY9LW3f3YkViZGF0hgkhi6ZONQjdkc26OE9dLUpRkxhVBHpBdfPHN7459f
 ghJmS9Tm9ouvufIDNigK6LTpaxKC/lcs0hDQ05m5lq3A4yu02FcZqXLjB7+BX1LAD5bH
 xcozMb6O5rahAW7oQbCf8rdMJI9XWQKlMv28W7f1Cqj6eYZKQQV7N9t7JDHo+kw5P7kM
 IjXj0pyLdTHEm1EpBpdTqkI8pRhaElN5QmOOv78SIro05tGBlClkPjPRvTI0yf4GXSUU
 x7dA==
X-Gm-Message-State: APjAAAV+X93Rk35Cp6tyXniyN0zh6DOOYgzl2PtUPSS/ASBcIo982Ulr
 JFxvtLh0SocvnLDHCgX2Y9UNZPuu6hYr5beAP9H9Dw==
X-Google-Smtp-Source: APXvYqyydfibYTAShjicrHJH3QVAoim7v2QcAs+SANUiLOXVC8M+CsKiVfQoOtUUWM1GsZiePLPfxJ8mZrhHho1dLv4=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr4284993oif.163.1582649262896; 
 Tue, 25 Feb 2020 08:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20200225151210.647797-1-mst@redhat.com>
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 16:47:31 +0000
Message-ID: <CAFEAcA-eDYoyD-Hs6i7b3J+nt92DNUpFo9J+UZJtoxQ49R3i1w@mail.gmail.com>
Subject: Re: [PULL 00/32] virtio, pc: fixes, features
To: "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, 25 Feb 2020 at 15:12, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 9a8abceb5f01d1066d3a1ac5a33aabcbaeec1860:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200225' into staging (2020-02-25 11:03:47 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to afc37debf27ecf34d6bc1d4b52fa0918d0bd3f3c:
>
>   Fixed assert in vhost_user_set_mem_table_postcopy (2020-02-25 08:47:47 -0500)
>
> ----------------------------------------------------------------
> virtio, pc: fixes, features
>
> New virtio iommu.
> Unrealize memory leaks.
> In-band kick/call support.
> Bugfixes, documentation all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi; this fails to build on OSX:

  CC      contrib/libvhost-user/libvhost-user.o
/Users/pm215/src/qemu-for-merges/contrib/libvhost-user/libvhost-user.c:27:10:
fatal error: 'sys/eventfd.h' file not found
#include <sys/eventfd.h>
         ^~~~~~~~~~~~~~~
In file included from
/Users/pm215/src/qemu-for-merges/contrib/vhost-user-bridge/main.c:37:
/Users/pm215/src/qemu-for-merges/contrib/libvhost-user/libvhost-user.h:21:10:
fatal error: 'linux/vhost.h' file not found
#include <linux/vhost.h>
         ^~~~~~~~~~~~~~~
1 error generated.

thanks
-- PMM

