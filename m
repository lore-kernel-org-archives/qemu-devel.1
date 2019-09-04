Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C45C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951522087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5VXxHeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951522087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5ZAv-0004ja-83
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5YtY-0004Ym-VE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5YtX-0000H2-LB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:16:36 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5YtX-0000GW-Ce
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:16:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id t84so6739887oih.10
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GqjLFHty95w3E88rXM1g2m0OYNZXzk1Ys1O66a5hIKI=;
 b=W5VXxHehBKES7OUExrTlNlu3YP+Gfwa4BwOS/wUTom8WunHAEIsbG8jt+HRX5K6cts
 QxHKoOIi5aRoDKCAyQqgt5sow4Mn5dEJayrDP9UFWdQkAg2oKoj7j0In9A8q7iyMHUUb
 4UjllqqC5TSV1zmipshZJT4Sup1F+bN0zVACh7/LcHo99CCN8kCzx2unx9Elu0y30CW7
 NQ0o44e+CgAWZ0KRP+gdYv/U+WifudIJB+oXYTHPFiHnd0pAfEDfBrABA5zIaQEvEi5X
 qi3NfvbY5EdHnTN+ZZUPFE6McSvttCvzZad4DPQ8vNKeIzz7o2kVri6/rWHqt/RAtSkl
 9Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GqjLFHty95w3E88rXM1g2m0OYNZXzk1Ys1O66a5hIKI=;
 b=daXdNLIlQAH4iD5wECp7fRCfoMUs0yaFtFHUESUeU2s+XWv2thnOJrAunNqC6twDC3
 CMtLD0p+E5MgAAaAz11TP1B1X+lnyHtJQxTnTkNHd207BFXJ5IwhoQWhV734RNy4WnVB
 GqJsPOarK8eaaZ3Mwg2lOmZyT4E7C4fn0Uo8IrY6cFlrlMQPUsz9Q+nYx7GAwYcqBOK2
 IrzfH3Iksz72DetzHMF5z4ygso5LrXdTGZaDqi+xXxQi/p/UFTkTENQO89bRGlCLkIsO
 0j0qBPDk19zWQXp11XvrdT7EAlE5z7Zc62n59J1kJAkNG6N3B6Bo60NF867VKpBpTtD0
 uSkw==
X-Gm-Message-State: APjAAAUV1Lggs3796Gx77O2jvvt35Am9ERWE0D1xP5iIwE1BGfglM4nb
 zT1mvy1IJbWWG0sQ7ysWIS6a+j7jQ1es7RVZ2fdSNw==
X-Google-Smtp-Source: APXvYqxKz4w2I1rHeRefZSRYlqOaWgxOdfuMN22MUrsVWXt5H1lWjT3RoZLWmjI4QqpQqls09z4r0ryJqOnkicAfZF0=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr4075151oib.146.1567617393850; 
 Wed, 04 Sep 2019 10:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190904120026.3220-1-mst@redhat.com>
In-Reply-To: <20190904120026.3220-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 18:16:22 +0100
Message-ID: <CAFEAcA81njPTBexgyjsQ1h2M9oUjaoWNq6kLkYDWJf4djKJ_8g@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 0/6] virtio, vhost: fixes, features,
 cleanups.
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

On Wed, 4 Sep 2019 at 13:00, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 379d83f2c92879f4418aa9c57fd1fcbc3c82d384:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-aug-29-2019' into staging (2019-09-04 10:16:00 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to eeb39263aa9b05b4ac3f8d8e957958071834a7b6:
>
>   libvhost-user: introduce and use vu_has_protocol_feature() (2019-09-04 07:53:12 -0400)
>
> ----------------------------------------------------------------
> virtio,vhost: fixes, features, cleanups.
>
> FLR support.
> Misc fixes, cleanups.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

