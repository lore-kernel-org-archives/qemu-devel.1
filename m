Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5672DC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20037208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEuv6GA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20037208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j59It-0002cR-AM
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j59HL-0001NF-W0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j59HL-0006p8-3V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:27:43 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j59HK-0006oZ-VL
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:27:43 -0500
Received: by mail-oi1-x244.google.com with SMTP id q84so1730811oic.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 06:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gOOjDSokGK2bCgDj0ql5Xh2E0DCjU6rwL/YmDNbmj4Q=;
 b=cEuv6GA66jmFY/oRWZz1IMvzPhVIvmW5rdQUYcYd+b+m5Gap27PWHu53eBTsfC6t5K
 eLePIBpZny3d+boV7iwyMpHmE0hRRtGD5ujkGtSE4i2CTHcY1XDVm+Qg3JzYhHnBi/fO
 JEORDSkCC6KWhpKu/yeQSZtGx+A+SJgwkw+dSO1V56VUX5i7to6Aw8purWEUocoDd6rL
 6Ta66jZHDBYG7OYXOQUWJE2lYuA7nhwBwUMIV6Zc1cOmNfy0Qes9HY4oSi/0LYkizcT3
 rLAaXnAGQLRZdZ0RAGwe/5uRli5j4QdW8w9CbCQLKo+dKKMzngUecw0B2vANA3wvvDJT
 9apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gOOjDSokGK2bCgDj0ql5Xh2E0DCjU6rwL/YmDNbmj4Q=;
 b=Y5Mo7eygDUitOneOZjgNGvnO/BuvukdeMwo4tiEQt7Rv62uxLnM2Q8T2AxqYoIY/4Z
 TQUxoXjcu28m5vlVXI9gnefexMArspIGqITE7IDnNiIVVx9ZZxJX71kou8LecL5OTxVc
 CS6M19z0inSz6HmhgbDEocNphFGHkCkWX6pXzRekOitbhBHbNokUFYctWqeTJSdYiCTm
 5WKF1K2nqsAMjpxBUB7GcmhREkgy+SG52i8EZc0iEwwSqiyPW6m17FlxlwaXLS66y6cY
 j5K3FxpX90V2JOBJ/S/PHEyjV2lVRnXDT1c6JNk9OGmCT1ary4dgCHJGE2Mkmgcczo85
 jcfQ==
X-Gm-Message-State: APjAAAWY+PI/gSWdCXlvszbwq4qJdentYLWyTh6BEXGnxX5lgQZ43H64
 Qmr8wNCfnfjS8oxwF0hhjEITgju3UDQq41Dxz/LXhQ==
X-Google-Smtp-Source: APXvYqzvjQFSwgwgrcMVvZElH4qAYaiKC7sOn0gYUUMn2TTs0wv+dQn6TYa+P0fA69RR3Fsjib0vsRteBtpGuYjGID4=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2259550oiy.170.1582295261855; 
 Fri, 21 Feb 2020 06:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20200214132745.23392-1-eric.auger@redhat.com>
In-Reply-To: <20200214132745.23392-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 14:27:30 +0000
Message-ID: <CAFEAcA-U9b7GVXOd0QDw526JChoD3gRhVBzLcSy++PQzHbVzFg@mail.gmail.com>
Subject: Re: [PATCH v16 00/10] VIRTIO-IOMMU device
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, tnowicki@marvell.com,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, bharatb.linux@gmail.com,
 qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 13:28, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series implements the QEMU virtio-iommu device.
>
> This matches the v0.12 spec (voted) and the corresponding
> virtio-iommu driver upstreamed in 5.3. All kernel dependencies
> are resolved for DT integration. The virtio-iommu can be
> instantiated in ARM virt using:
>
> "-device virtio-iommu-pci".
>
> Non DT mode is not yet supported as it has non resolved kernel
> dependencies [1].
>
> This feature targets 5.0.
>
> Integration with vhost devices and vfio devices is not part
> of this series. Please follow Bharat's respins [2].

I think everything here has reviewed-by tags now -- does
anybody still want more time to review it, and what
is the preference for how it goes into master?

thanks
-- PMM

