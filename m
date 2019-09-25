Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655DBC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB6D20673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8T7gBIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB6D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD6TB-0001Pr-A0
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iD6Rs-0000qQ-Va
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iD6Rr-0004WD-Gt
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:31:12 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:37230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iD6Rr-0004W0-Bn
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:31:11 -0400
Received: by mail-oi1-x232.google.com with SMTP id i16so4720971oie.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JD/G3xyu7ck667XKg07CJ2MCor9MMFPsSPUFz2++nd4=;
 b=l8T7gBIF6T6gDbN7Efpwk2MhPX8xBNoQaMs+Kx7yGh7BRbR3/ETxzZlek7HxAshiae
 iKYzCbrQkocw8W4eC7ynIjS1Hvflg8jgJ/kHvZ7tMKtHgOrezit0xpKDKGcRWCIBinkS
 eyfQY2/MZ9l/d2jr7Q9+1H2zlAOy5oKW6SBsvIOQKG6HWJGKci5o3IQIb6Kj57RQlDXu
 ZuMPQdCt/mICE7TPEkli8WVqsQPN3yO9vg+xy4a+qZxP4mXHHmFdnqWwOyhBJYR7ydv5
 BRan9rVlgN0ODIyu+spjx8dLdUDWtw6WzarGVPICzVy1FN3Jqn4JZI5+9L9cagKSEdFl
 x3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JD/G3xyu7ck667XKg07CJ2MCor9MMFPsSPUFz2++nd4=;
 b=jN6e1n1PpKwR+fk5HHtntgK40uJF92YZtp/DIBcJVb5Lg4s/2lrhfMUyxsNJOuriDc
 ndTHJYf2870//Ad6mKlQ3agqlZvLwN2yZEK4cmcaOqf7h4nCgO0q4LHFi+AqbvAjMKzs
 KX45T569rqsZdaYy3K/VXkRIqkBFtMSsI1C9xbt/ngNJ2VIzFh0C75LVHdPGCziKcdCe
 /jNad5yQ/EHPYyeUGNK1kXPHpEc18v4LKUSEuM1C+9Sz7tDnVYisWR9Kmh2cNg+PqMbN
 fIK1CpCB3nMJ3ZS3ewOiJbXz0wbQ4PUNW96m9g/tZ1hZrC6nBCeH+SNfYZAqwnYYauBm
 eKHg==
X-Gm-Message-State: APjAAAXEv+HA6vJczd/uZfjnAVw8g+I1ZOMVTuBT0cHNZ3b5s/3nBFQJ
 B23rLEGmCmB8YkRjyHI7icZvbrEIzp/H6j9nzXkxcHySuQo=
X-Google-Smtp-Source: APXvYqwBAjRHS/4aO/LZF0ot3ssMAJZDYhPggKfwmwAHh8NIK2B7omgoaBkf0xJo2bYXEpeqC8+iyo/RfszczFx5quk=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr4482949oif.98.1569414670073; 
 Wed, 25 Sep 2019 05:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190924113026.255634-1-anthony.perard@citrix.com>
In-Reply-To: <20190924113026.255634-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Sep 2019 13:30:58 +0100
Message-ID: <CAFEAcA8PXEHRV6Wbh2rSEGKACgNw3tT1TnD=y4eF1yYGzx7j5A@mail.gmail.com>
Subject: Re: [PULL 0/7] xen queue 2019-09-24
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: "open list:X86" <xen-devel@lists.xenproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 12:31, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit 2f93a3ecdd3bb060bd04f698ccafe66efd98563a:
>
>   Merge remote-tracking branch 'remotes/davidhildenbrand/tags/s390x-tcg-2019-09-23' into staging (2019-09-23 15:44:52 +0100)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190924
>
> for you to fetch changes up to 6bd6b955c0b2666263700d39db153ab43c5e0c9e:
>
>   xen-bus: only set the xen device frontend state if it is missing (2019-09-24 12:21:29 +0100)
>
> ----------------------------------------------------------------
> Xen queue
>
> * Update of maintainer email address
> * Fixes for xen-bus and xen-block
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

