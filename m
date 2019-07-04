Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46B1C06515
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 07:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B322133F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 07:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2jg1Z3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B322133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiwSJ-000614-TS
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 03:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48825)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiwR4-0005NG-5N
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiwQx-0003nO-3C
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:45:37 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiwQh-0003Yl-Ih
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:45:25 -0400
Received: by mail-oi1-x244.google.com with SMTP id e189so4215029oib.11
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yj/wqOyMlGUJwp8JA4jIUocuQCeMk2Fc0Qfp9w7cHtM=;
 b=x2jg1Z3vCK5Tm6J6v8ljuj8/JWPg+C1XNrhu7W+e8GnbM22MzxCV2D4e0kw2rLGsfo
 bwGytGFY2P2WONysFgDM9wR2CK45sCny7mGJvaN5GgSGXq7E1+bj2zQ7o5q3ziCz9FF8
 sBVrZwuMZnHmhfkDuir8MovFjmGb4MdmX66+jHjiPyapuLreDf5IPCoD6UhK5kHOqkL/
 2PefNw9DckphE+AuR3bxq6gWr27/Rx0SKyMskp/6U7L5hnds4Rp0qN5uAbEMWs2zgAl2
 BnVxURuXFt71X+tbJNEhcGRkn/3iR+MhpnEsB20A6/7jtjWgVGmNFu4IY3DK/eQ03aIV
 +8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yj/wqOyMlGUJwp8JA4jIUocuQCeMk2Fc0Qfp9w7cHtM=;
 b=StidPnghmsSuUB46CKG5ufhIl2FcAXQSWeYo4SsznChKh3Ihnd7+kR10qICtQC2DHl
 Qr+8+a4mvNJghxIGs8yJffwRKIvYYxl4nnfWGyAnQ3fd8dP+BSZSexxE2O+YG+LFlu1u
 Dzu6KIXJoI7UH0mHf/i1ABhrDCpy7dhSv1++bI8tIqKkkS1xXQI8VTozLAO0X3FmM7ge
 MisRxM0B8x1me9LGeNL1+a8tPvfSX3YqNwxki217HolH0wE/VYKees4ANDta1GyuXel/
 YVMV5vKowpoDpxFjr8SiHYFeEHjpIsHrXhgr/gY2ZhYGLe1F1ruihtPzMPWuvIFVSjlJ
 oviQ==
X-Gm-Message-State: APjAAAVz/puqePjfd0DCJgM4AU1/7rn6ky7feSTuxL7J8j9PkMXzJM8g
 dncHsZt4hEE4oSUo/81MZQN4C5FJ91TRQMbnSrqUgQ==
X-Google-Smtp-Source: APXvYqyjF6iyO4Lquhk7gXpe3I8g3a4iBJffsKaEJ22JhJORGXiqp5fYdIfGJApFXHnUgcqRGaihyWKXSTNtoSw/ITw=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr1047974oie.48.1562226314374; 
 Thu, 04 Jul 2019 00:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190703085416.21837-1-kraxel@redhat.com>
In-Reply-To: <20190703085416.21837-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 08:45:03 +0100
Message-ID: <CAFEAcA_Me140dWhdXrnroJdTRwKmtbZGSbcY_OPwP8N3ELU+7Q@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 0/4] Vga 20190703 patches
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jul 2019 at 09:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 506179e42112be77bfd071f050b15762d3b2cd43:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190702' into staging (2019-07-02 18:56:44 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20190703-pull-request
>
> for you to fetch changes up to 0a87fd693d4e955a6877a2166b65bb7b7192aaaa:
>
>   Add ati vgabios to INSTALL_BLOBS. (2019-07-03 10:52:15 +0200)
>
> ----------------------------------------------------------------
> vga: virtio fixes, bitbang i2c asan fix, install ati vgabios.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

