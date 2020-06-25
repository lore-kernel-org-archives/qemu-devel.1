Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D96C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C44720702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QM9dVuZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C44720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOjQ-0007Fd-Kv
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOiV-0006Bq-Aw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:02:48 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOiT-0001Hq-0b
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:02:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id u23so4691038otq.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Exz6aPsYoru1iE9XY77uXTMscZc4FZwRIdoc1GW/alU=;
 b=QM9dVuZ2WlLxyWkLjfsLs5BrME11RLrbShJufXwY/jvM6ThICJOqFkeB5ZzeUR1coZ
 LCeIi3Oa1pyjTPCC5/9kJNKILB21q1eHh+9IoqnnvYA1K9YlH955rGOv+nXN1qdMq8B0
 oZzbpaS6k4WKGqNHYmfF9OzErHZHO28T1Niv4shpevZYKtbvHPXYEj8vUA6LT0HHTt0H
 /ZeEqva467qNW60AlwdL90g3yky5a9Fzn1OeZqnQHUgDwo57AHTv9or5rF9L+crS3cl2
 hfuy3jG9X38NViYKY2rZ6rEDd3y5+ejC7Ni/TcelfU1w0pIHdfOJlX0gqaXCf2gBFTrR
 9t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Exz6aPsYoru1iE9XY77uXTMscZc4FZwRIdoc1GW/alU=;
 b=IF5bJLW5DdGu73o5iLBJYSmIOY6dyiSvMKMb9zOO0ZNMzmOZfHcKR3q782SPvDz404
 xg7ux/6flokteiWQcG9084IDLRvqweM4mhqRFoS7t8bt594eY7LbC4khcSNzzLOCvfL5
 fvv89ivoQaLVGiqHihKAErjgTjbXsX4njXdWw1Xbi4fGFkG8t6Qj7FGrpuy7jKxtlVBr
 WV9vNz1iD+0No+fE+tr/ObVlzCahVbJYs2N9GVeFx9EvmOK6s3/76IjQCGaihJp7pPtH
 MA1mgQWJVPsbrz4aVjycCNuDvNwPUkn0rfAmnr+ZtjedKjONWAotr0pXvkU14mjRPGxC
 83JA==
X-Gm-Message-State: AOAM530YEXqvq0Kt/XJ8xhfBXtoqgwSrVxyquBlt2gckca6WAJcIPbyy
 Ww7tZrvBG/gJ+j7G5/Ty3TZoDm/CFP8TyGDjid2gYg==
X-Google-Smtp-Source: ABdhPJyO36ZMJbCux2T/cLiK41h25Zyzb9LAF8BDrUVTpHhTl2Fjy6rmAACDbKvDYaDrDyI7Vvvu3jFZ0dOcrjjes7o=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr26828970ooi.85.1593079359797; 
 Thu, 25 Jun 2020 03:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200624132625.27453-1-eric.auger@redhat.com>
 <20200624111624-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200624111624-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 11:02:28 +0100
Message-ID: <CAFEAcA-io6LX4uUvHat2oBE-C_0JLRew_L8r8ej28UNPvhQFRA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] VIRTIO-IOMMU probe request support and MSI bypass
 on ARM
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 bbhushan2@marvell.com, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 at 16:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> Virtio bits look OK:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I can take it via the arm tree once it's ready. I had a
comment on patch 5 and it looks like Markus had a question
about patch 2, though.

thanks
-- PMM

