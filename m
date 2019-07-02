Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B548FC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F9E2082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlPfKOKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F9E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiMQd-0007vF-RJ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42124)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiL8k-0004dB-Kv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiL8j-0004Qb-OJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:56:18 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiL8j-0004Q7-Gz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:56:17 -0400
Received: by mail-oi1-x242.google.com with SMTP id e189so13410818oib.11
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EclnfeMCC4Vy2ZH4pD0IeuHhx63jHxsyQhxDc8MAMr4=;
 b=NlPfKOKDQEbHhmGQz4Dcw4HwRJ2tO24I+dRUmLRNNIdiuHjg1sX6NMZwTuiQn3XNE7
 n5cLOew12fuRIYxR+xx4qdr+GnHP55GAO7Ez5Vvv1KQ4uEzibWXQY83D5RjAa/kEnMRv
 R0IwNX8nBOsRi8l+OaBK4V7m1SGLMoqnKnwkF21UfuBxMlDQhdGeW6lcRJFDA3mVV+J3
 a4IG5AovaKPPRpoOU5vBNRLT/moPFXAhzuYQNFJCQFzqHqd5gdohdHPg8LQu9ok3JLPQ
 dbcySCKiDNzxN0FB9pTA46DAml6DoWwpWE/PbzU0FZ6zJY4Vfv5clLMvV1KmtXseJFIp
 nGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EclnfeMCC4Vy2ZH4pD0IeuHhx63jHxsyQhxDc8MAMr4=;
 b=QtUDY1mb/JBwob5Jdd2nB/HHWcFT9UWoz5VC277gIy3s8XBeYBNonOATvPgXaFfiEY
 ONwV/AkzmEnFtiBr+bd9sgplwnJr5t6wkvh8K88RWXKYC8BDQhX5KpnPPDTt8lNqADwU
 z5Ym4sRXYXsMo6vyWlKmfAJqgktf2MN8nEepUHSZOyO75PgeSRz4E6isAGP8DNFOlu6Z
 xRmcocCtsplza/WB2yf1Y7t8q3hIXOl7lcOjP1qp3QMVPmLuJX5amnSnBOiLDjzfAQyY
 2hDt603n8ye3WNTydv2TgB9sAow0IH2+fpKarUK+/a9YMUBp0pbDWj+JlZiI0eBohapO
 queg==
X-Gm-Message-State: APjAAAXiUVbo/enj3EullOwP7VjNV+o1kVXzKNur4sej8p1GB7FEfAdG
 PnyESmWjSaKekBhZ1wIcjiPmxGWsXOL30dxMmqskNg==
X-Google-Smtp-Source: APXvYqxYeDskdNOntWzSE7MYn2WT8GNOn1BBe44hn0v/lAnqo2bB33wL8ncLxf0X4M6aCQQN6KUkE0Teso4nnOg10Wo=
X-Received: by 2002:aca:6185:: with SMTP id v127mr3603699oib.163.1562082976071; 
 Tue, 02 Jul 2019 08:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150606.24851-1-mst@redhat.com>
In-Reply-To: <20190702150606.24851-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 16:56:05 +0100
Message-ID: <CAFEAcA-Qcq1ZmfDO_dkh_H9-aeQVU83ceLKU1NXM3VpW8g5sPQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 00/22] virtio, pc, pci: features, fixes,
 cleanups
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

On Tue, 2 Jul 2019 at 16:06, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 7fec76a02267598a4e437ddfdaeaeb6de09b92f3:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-06-24' into staging (2019-07-01 11:28:28 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to a360cd11de5ae59db55e128fd209290c777eb177:
>
>   docs: avoid vhost-user-net specifics in multiqueue section (2019-07-01 10:39:35 -0400)
>
> ----------------------------------------------------------------
> virtio, pc, pci: features, fixes, cleanups
>
> virtio-pmem support.
> libvhost user mq support.
> A bunch of fixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

> Pankaj Gupta (3):
>       virtio-pmem: sync linux headers

Hi. This header sync doesn't look like it was a proper
sync made with the update-headers script against some
upstream kernel -- at least the commit message doesn't
say what the sync was against and the fact that it only
changes the virtio-pmem headers looks suspicious.

Can you respin with a proper header sync against upstream
mainline, please?

thanks
-- PMM

