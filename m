Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF465C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6B12067B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tl3dl84N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6B12067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVxj-0007Zt-63
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHVvJ-000627-2l
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHVvH-0002R9-UK
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:31:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHVvH-0002Qc-PL
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:31:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id o44so11497546ota.10
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hYJ5OWkLm6syvPnRSwa5taioeuKW9/Wqijomrn2bowE=;
 b=Tl3dl84NuUccNvpAfjD08n5mhT4dMrMUYyFG7xd3BI59YduhBNngt3wI/9U/4g7Ef0
 g76l/yX0w+pHo814ZfQDB38foRQc8iQ8dBf8ZbmAzADuexQ1W4nkTz7sEB0EN1kRXkvF
 kjRJP9ut/k3RFHX03Ayh7nmEVusgsVQVNic5Zxcmu0+AYck54RTbsx9dKuEnm8Z9uiP8
 M2CGT4PUMvLSjyTcVi0YVbP940yWzW+vn/Z4dbAOuQylyhPZeCpZjSHtFwGEiiiXG2Fw
 XjKqYzamL8aKdGAbhL7SWjSxZeeTho63p8XGaSSe3Dxup0IEHUw7z6pAB4XELDuRgiwe
 1YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hYJ5OWkLm6syvPnRSwa5taioeuKW9/Wqijomrn2bowE=;
 b=pyyv61jzBA+HOJr8uDwPKMOkhRxx0mOq2T36KGRNx6RpheHSCbvXEzEEL7ME2+qeHi
 AsKUJggS0qtbI0yEs/caSw0D975RmwenyYOqdSekJcXHM0f53umTGz2xMzoERW+/XXil
 yPG2zpmjmY09K20qstB4R3JBqn89ZazYNURaqIQfRfPHnLvsNMXdvjBizJrbDJsFjY7q
 QITO5y+kirCAp73vCCqunaZo7gtR6cDFxjCIhGGvEYmCXgPPKDvpWDgd4sBqqjc8M47U
 kGqCUhwsoWH1rX5HUoRwuZjDe4RCsLkkAvBNqGtIv/GN17v9haA+O45dvYesftLW0y77
 jcNw==
X-Gm-Message-State: APjAAAUN8hsoiOarsQmxDznncU5719o2c/S/1CPdCNk24/TVeWlIFVp2
 5DP94Ip5q1IR9BvsfnzLLNokO/Ag2CIMa5gcV3E63Q==
X-Google-Smtp-Source: APXvYqyLgoJLNR4SYVRZdljXKzJQFctehlUZQYcpPZRgYIMPUfZTGoWpwuwG4f/lgEk3dzROJIlVqgIUYHSs48bFLU8=
X-Received: by 2002:a9d:562:: with SMTP id 89mr22334724otw.232.1570465904638; 
 Mon, 07 Oct 2019 09:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191005215508.28754-1-mst@redhat.com>
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2019 17:31:32 +0100
Message-ID: <CAFEAcA96HPyqqCr5C4Ymtoji8srsaC0W=8t+Q-Xf=XGwt5mW=A@mail.gmail.com>
Subject: Re: [PULL 00/19] virtio, vhost, acpi: features, fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Sat, 5 Oct 2019 at 22:58, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> A couple of tweaks to the bios table test weren't
> reviewed yet but as they are really helpful to
> the arm tests I'm pushing, and affecting only the
> test so fairly benign (dropped assert + a comment),
> I cut a corner and pushed them straight away.
> Will be easy to tweak with a patch on top or revert.
>
> The following changes since commit 4f59102571fce49af180cfc6d4cdd2b5df7bdb14:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-oct-01-2019' into staging (2019-10-01 16:21:42 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 9d59bed1da5e5815987879346cf708344060ea63:
>
>   virtio: add vhost-user-fs-pci device (2019-10-05 17:43:55 -0400)
>
> ----------------------------------------------------------------
> virtio, vhost, acpi: features, fixes, tests
>
> Tests for arm/virt ACPI tables.
> Virtio fs support (no migration).
> A vhost-user reconnect bugfix.

Hi -- this summary of the changes just says it has
updates to the test code, but the patches include:

> Shameer Kolothum (8):
>       hw/arm/virt: Enable device memory cold/hot plug with ACPI boot

which is to say actually enabling the hotplug memory feature,
not just tweaking tests. Did you mean to put the whole feature
in this pullreq? (If you did, that's fine, it just doesn't
match up with the cover letter so maybe it was an accident?)

thanks
-- PMM

