Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F08C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6012083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="faJCIKtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6012083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50947 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbpa-0002PK-E7
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:41:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbiL-0004v1-D3
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbiK-0004pM-G9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:34:09 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEbiK-0004oY-52
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:34:08 -0400
Received: by mail-oi1-x241.google.com with SMTP id y84so5248942oia.12
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JTtfixS6qBAl7tInZ3dcJ1/3iyn3CfPiVKIhOGBMOlo=;
	b=faJCIKtBvR4Y2J+R8Oy/MGcGkh+w8kKvSEp6GZBXESL9VuZADoWLGlt2uxXg/mST+L
	zCwsDEEI2vGQ9kBo56Wwfmto+e3vX7YVTRX+UfAF9dYYboj1BYbWiSa+zMxOzwb3oiB6
	2mR+0E7WxCaSKxpHS9tsMMKcByFpcZIrOHcOUZ1cMcPIDbUP5g/vMCBkpDRRbHNN++NA
	8rfNKDU8k1DK7qkATobONjSN2HdE2wYyi/cTyXwBRQBiprAedm8NzZB6gwSDsEOp7rF3
	xFXVUjNqbeW9AgC2wZJPvqgevP7N/1PkWCE8R5Ff8Wa/t+6VZZKazZ88JmzL3URxbL+Y
	TN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JTtfixS6qBAl7tInZ3dcJ1/3iyn3CfPiVKIhOGBMOlo=;
	b=IvpyYe88xdxc0OSPQ1vpLuh8tUGbI5U5s89+1ctmP1cra7HmSqVxVpdDZzOUoqEgi7
	poSScAyw4Gz0elyiuJAsfdt+m6Pnqb3qHnPMNvtKSwuLIjRvNiR5LkfGADc/9ACWdJut
	j5FmFy+8vjjMBuvbLcxWGMK6poe6AeKO81xDpWAOZU64/pPGgq2ZlZhrCgjV2QiU0fYx
	SDyHy3bw9lYAaJNwxoC5xbrLEn1jFvqwDU3S0xKbTzSeYP0KEU7T2QEbbWat6aXI+ikx
	ZEScvkEzuAk/dynfSiyZR71ux997mpE6IKoauhga23lameBKhJ8W6ctYnZP0wVaYqB78
	zN2Q==
X-Gm-Message-State: APjAAAWif8EUHYu93eYcw6wlDohruLLpVZ3XqOGBQajLVAdx6FcQbxxD
	fo6/moA+PiIwCjvzXAlJRIgG4ArZ8/ivenx7TvrpkA==
X-Google-Smtp-Source: APXvYqxbRaKa39uuO2sVGLcp0W47KDEVOqMSiNS1EYKO3oYBSwjUYJOHUp2g9dMB4Ud5z3mHOCB5EOqXQ6BJ5NDqGrU=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr6993342oif.98.1554996847038; 
	Thu, 11 Apr 2019 08:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190409160219.19026-1-eric.auger@redhat.com>
	<20190410001640.GA25214@xz-x1>
In-Reply-To: <20190410001640.GA25214@xz-x1>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 16:33:55 +0100
Message-ID:
 <CAFEAcA9LZ21fkGsvw_0+Pro64-JP33qKim8aRNcPnzg9mt16CA@mail.gmail.com>
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/smmuv3: Remove
 SMMUNotifierNode
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411153355.rDtzKCD1DXQF930CHMfcm4rtMGahMe9-H8rFS3Ry-1o@z>

On Wed, 10 Apr 2019 at 01:16, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 09, 2019 at 06:02:19PM +0200, Eric Auger wrote:
> > The SMMUNotifierNode struct is not necessary and brings extra
> > complexity so let's remove it. We now directly track the SMMUDevices
> > which have registered IOMMU MR notifiers.
> >
> > This is inspired from the same transformation on intel-iommu
> > done in commit b4a4ba0d68f50f218ee3957b6638dbee32a5eeef
> > ("intel-iommu: remove IntelIOMMUNotifierNode")
> >
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks; applied to target-arm.next for 4.1.

-- PMM

