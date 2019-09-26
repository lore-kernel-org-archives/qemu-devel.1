Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FECEC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C523207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4tvI2rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C523207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDSnv-0003UE-AF
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDSkY-0000F0-PP
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDSkQ-0002jT-LI
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:19:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDSkQ-0002hd-BO
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:19:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so1872574oie.4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+LIyjU/fauJ/2YVhwqNXeTLPr70F0EfwiLzSh4gvJM8=;
 b=Z4tvI2rb2gKi9t5hWp3PF/3Q8qxZS8TIXGafQmj+/aU0o2zxrOXv/JHac4mSIyrb9k
 F77gCAhJgjUWa3g4EajxRyY+KccYUlH3LF6IY55vXRkaLyxEwbWWp0oYR+3GTfQGaBne
 ia+ODevbLxdNW4NohEAMR8ABMyGzRamIF0cEjvvcjr/t7To6xmayn3TRVP+KbXb7Gydq
 LRa1iG66WPWZ0EJYrt/dFxe5b48YXYna1XCp9xjJl8gK/WvcvPW2/mDd00avcgPpJDJx
 L42WSvIzMPZAmxHzCO0flSzOQ7QZh4jGG4Hghfp/hS/vqFROJR4zubmHN0CqvD2qy/yP
 OniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+LIyjU/fauJ/2YVhwqNXeTLPr70F0EfwiLzSh4gvJM8=;
 b=maBaJzs3d9NAnEU1XRi2gX6W/tHzBfYX3f/ucH5TcIpZhpehXg0HEmBa6e5PHmuNrh
 uMv+pqDEJiQzcvaY9+Vz/p9jpETX4037aYihg2b1t9Xmh5TXtfFzXtwEx8n5rrv7K0HI
 1ZsN6cnt+HgSqW3rgo5mb48CR/l/rPi11woZN1q9wD0/R/BC5Di6/gLhKR0qcld57GPM
 cB1xmHc9q27OqhqYAocaAItvR5VK8nTv5Yy2361hk523q21i+KdJYWEijOO3qsOdgNi6
 JAylvTtSgG6U1mL5CU5Vf9VwYvNRgYYS7RUleJ7ImBzJ7MOX78DwwWhlNK0ttp+zdcCY
 pm3Q==
X-Gm-Message-State: APjAAAXsxGuWsUcJW8VfxPdRI8jp4s486lVAfk87ODRqfZGhcjp8AIJT
 zbn32uf6kK8ihKx3LvT2bvVvkBYGl2PH8gYSd5C9/g==
X-Google-Smtp-Source: APXvYqy/TfkSFNksF9bLe+Smx1n3gSMFIuBWui4YvW6bXweSiiNFihEzuDBxlbd0DKItex7vCIp8zYDKGhqp65ccz3k=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr2246798oib.48.1569500326916; 
 Thu, 26 Sep 2019 05:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190920200049.27216-1-jsnow@redhat.com>
 <20190923145057.GC9445@dhcp-17-179.bos.redhat.com>
 <6ac39e69-4982-dc35-d853-fedbb1c12e1a@redhat.com>
 <20190923190533.GR5035@habkost.net>
 <20190924073513.GA2106@redhat.com> <20190925200440.GO8144@habkost.net>
 <20190926115829.GA18782@redhat.com>
In-Reply-To: <20190926115829.GA18782@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Sep 2019 13:18:35 +0100
Message-ID: <CAFEAcA8Jn=er6mRZX+EYTePruTcHpLzVpqpydkERMVA9DdUOag@mail.gmail.com>
Subject: Re: Debian support lifetime (was Re: [PATCH] docker: move tests from
 python2 to python3)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.194
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 at 12:58, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> When first wording the lifetimes, I tried to strike a balance between
> limiting what we have to support, while also not negatively impacting
> a large number of QEMU developers or users. Since we had never had
> such support lifetimes declared for QEMU before, I was fairly generous,
> hence picking the 2 year overlap for LTS distros (Ubuntu, RHEL and
> SLES).
>
> It is easier to come to a decision when considering a real world tech
> problem related to the lifetime.
>
> The start of this thread was debating Debian / Python support. If we
> fix the doc to put debian under the short life distro category, we'll
> have solved the Python problem IIUC.

I don't think Debian counts as a distro "with frequent, short-lifetime
releases", though.

Stating overall that we don't intend to support distro versions
that the distro themselves doesn't support ought to be sufficient,
shouldn't it?

In general, my view is that if we bump up against any of these
support-lifetime limits then we're being too eager to drop
support for something from QEMU and we should prefer to retain
support for a while longer. I like and think that it's important
that QEMU as a project does not live on the bleeding-edge and
require latest-and-greatest versions of its dependencies to build.

thanks
-- PMM

