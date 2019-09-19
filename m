Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE5AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93F221907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GigOSWm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93F221907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtWt-00084V-1p
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAtRv-0004J5-Rc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAtRu-0003So-HE
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:14:07 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAtRu-0003SZ-C4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:14:06 -0400
Received: by mail-ot1-x343.google.com with SMTP id m19so737219otp.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HWd4EgdIZ9PR027Le8RmBtLaPSPzr3iLhqzc8GiPJMg=;
 b=GigOSWm89Z4/aDC+7uS9B7JdTbUkkPKeVgBbB5tEvYrdNgxGRovhFhK1Lu81qnQ2F6
 QSrKS4gzG8J3wYDz9+OmuVYZHQ6fwfZqD/NeDSef15DRKGI6LWb6WAwywhCSQa4KMjzX
 bWKLCEGlSyZhSUc5Ie0WQwwnmkqv6z7961C9jqTtRSORDHpuS/HoDsHVwLZoMMwj7Cm9
 iF/8dGFbKtwyaM02ltmeRGwMzhZdmBnhMAwdLu+4SedXJaU1WkuEg82E/bIq3D6llJm8
 z0BIZhikMksjzwF1YBg/iY4TQVksWbjVeLa2XKCN1vhII4ZBwkd2ZbMnT1a/3zdj5w71
 d7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HWd4EgdIZ9PR027Le8RmBtLaPSPzr3iLhqzc8GiPJMg=;
 b=ZzM1KQ14py7udHz2GqL0zmcUndpksdTj6ppJ0NoC4Bx6Sna9qSOMFC6dM0zwnxKCv7
 k+WBMQluiLz50aPsxzGLR4XwPFLJR4TVQUz5JwSjiNmn1HjXu3DoYIRr2yqo1U4FpuB8
 TTmRLZlM33YKwQKOpX1L2JR2GYZJ4NDZ7XSZo5Jax0uEd+reGZ75CoHdtN+lybLRd1rw
 t2MJYn9wL9fdxj4s9V4phbJtB8N7/ktHz2ydP7k6Px3Zfbl89gUkQbqleu6brvPyGTw/
 HzcJlmKuKDutdqexR+zTC6F0+lftfM9UefvTCMYckiMe2LIklv8oXOhRWaYuiBUpd+Gw
 8m8Q==
X-Gm-Message-State: APjAAAVN6r2xtELc1nctnpLI/diNtScuDO5H4RjaWTaJJTmNQQjPQOwP
 bccg3Sdz/xH34wH0vl5NubxYJDP7DFri7viXymUOyw==
X-Google-Smtp-Source: APXvYqygKN+Asnjz87rmLpCEBzTmLzkBsHcM3oRaoriSm/dY9WJhsfWq8LL0eKawpIQnwVLZdzPbz3208X4enm4DEyM=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr6259149oti.135.1568888045700; 
 Thu, 19 Sep 2019 03:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190917151011.24588-1-mst@redhat.com>
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 11:13:54 +0100
Message-ID: <CAFEAcA-GSdBxVzA3FgNWhGULr5Njb3PVN=cEONS+Vm9B2N_b_Q@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 00/10] virtio, vhost, pc: features, fixes,
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

On Tue, 17 Sep 2019 at 16:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 138985c1ef8b66e4e5b383354e133e05d01d0b5f:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-sep-12-2019' into staging (2019-09-13 16:04:46 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 44e687a4d9ab327761e221844ced7dc9c23350a5:
>
>   virtio-mmio: implement modern (v2) personality (virtio-1) (2019-09-16 11:17:06 -0400)
>
> ----------------------------------------------------------------
> virtio,vhost,pc: features, fixes, cleanups.
>
> Virtio 1.0 support for virtio-mmio.
> Misc fixes, cleanups.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Laurent Vivier (1):
>       MAINTAINERS: update virtio-rng and virtio-serial maintainer
>
> Pankaj Gupta (1):
>       virtio pmem: user document
>
> Peter Xu (4):
>       intel_iommu: Sanity check vfio-pci config on machine init done
>       qdev/machine: Introduce hotplug_allowed hook
>       pc/q35: Disallow vfio-pci hotplug without VT-d caching mode
>       intel_iommu: Remove the caching-mode check during flag change
>
> Raphael Norwitz (2):
>       vhost-user-blk: prevent using uninitialized vqs
>       backends/vhost-user.c: prevent using uninitialized vqs
>
> Sergio Lopez (1):
>       virtio-mmio: implement modern (v2) personality (virtio-1)
>
> Wei Yang (1):
>       docs/nvdimm: add example on persistent backend setup



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

