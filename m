Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1385C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4274820714
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1F5tojF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4274820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkeJ-000747-Hp
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXkcV-0005jG-Og
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXkcT-0002EA-Ab
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:27:31 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXkcR-0002CQ-FC
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:27:28 -0500
Received: by mail-ot1-x343.google.com with SMTP id c19so2556460otr.11
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WT61vLqDi37qfMew5p48rIsH07x+1bzrWw8p7LYeX2I=;
 b=c1F5tojF5gpmFtJhaxnqRe8BHd7ckr5P5Y+NHnwSiGwjQzWfxQgNG2o+Gbh5zOsPaB
 m8v/XDgyT8907dr3pQgLA+TLjgLRV7XtmK/pzj3eEEjawksvCBKzBm3GgDWrsgXhkobc
 xjROph7NyndRqw8Pv/zDOvG1VDSXoNO0G1fRjfziDhGc5rPR2gffDeDkqqt7+bb1poMD
 IcXGaoPYiIOp1ozEMmqUWmyQNkklXlTbOqbsP/hLV9jeoBt6EXIsRcLmfjr9KlIf4GGX
 Zt8S1qRpXfbnLohqQdBDL8dUNZzGyBpYEqB1xiFif7rQn59f5l7hpnOhdI7F0QjaU3mq
 MMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WT61vLqDi37qfMew5p48rIsH07x+1bzrWw8p7LYeX2I=;
 b=EGnHxYmMJN3/IhewumCFRxwlC5MUyWk8bB+qHIbD/utn1jLNV0h08QPZ9SRsw7xAT7
 /mNopE5VDV367NKRPoUPxcr7rOV/mpKjS61OvvdFnLc/+iHGrySu8K3yV/JU5xAWx/kw
 ZeuM6+/6U6VrNJeROxXT0WDkSwLMJ+QnOMGSRcAoLxzDzXDLz97ThrWI+rNJ41PLB1xz
 uD2PL+IhRWGYWe8C1+6cACmPKpqx2fwue2SAEA4krv6kk+JBB5CUAlK8bezprfSWNDlw
 54HMAAQquAsZ+KmBbWG+Kcc+UmA68pm/QpCI5j7+GF8CwXxgXUfcM/qmLXNTinB0Bek6
 8Rrg==
X-Gm-Message-State: APjAAAVBPBvqjllD351qPIKFqGTMbNm5xQ7CH1wSGar3XZ1F8Ft5ePFQ
 SlDXNCBIb2nSQpntULJwHq4NSAWnVpjhxpA05yrowA==
X-Google-Smtp-Source: APXvYqwUFUrNlk5v+vuRhsD7GwgbpKmHyzcYqlbHAPrhn033Mb7yDpU8gLdme5YM/MtZTqAwuVXc38Cx1tWS4kelLFw=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr6083767otk.91.1574335645416; 
 Thu, 21 Nov 2019 03:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20191120095904.11384-1-mst@redhat.com>
In-Reply-To: <20191120095904.11384-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2019 11:27:14 +0000
Message-ID: <CAFEAcA_zQaKHQg8r=Ln+cUFzpv=TN8RO6n-mP6W8erZcc8P1Kw@mail.gmail.com>
Subject: Re: [PULL 0/3] virtio, acpi: fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Wed, 20 Nov 2019 at 09:59, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 39e2821077e6dcf788b7c2a9ef50970ec7995437:
>
>   Update version for v4.2.0-rc2 release (2019-11-19 19:34:10 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 6c77aa909e0eec6531e2398d0e9e60ec6a9339c6:
>
>   tests: acpi: always retain dumped ACPI tables in case of error (2019-11-20 04:57:22 -0500)
>
> ----------------------------------------------------------------
> virtio, acpi: fixes
>
> A couple of bugfixes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Igor Mammedov (1):
>       tests: acpi: always retain dumped ACPI tables in case of error
>
> Stefan Hajnoczi (1):
>       vhost-user-input: use free(elem) instead of g_free(elem)
>
> Xie Yongji (1):
>       libvhost-user: Zero memory allocated for VuVirtqInflightDesc


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

