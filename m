Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53D1C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 23:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE042073A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 23:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y35PGLsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE042073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kap7X-000284-BS
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 18:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kap6Z-0001go-Vd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 18:55:47 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:46523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kap6Y-0006x5-0q
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 18:55:47 -0500
Received: by mail-ed1-x532.google.com with SMTP id t11so3397706edj.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 15:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O0Dlt8CM4EYpIMNatoTVPCeMUB3jUyU17bTKDOYgOb0=;
 b=y35PGLsZbRSK5lP1Eeqs9DOKLAhCu/fuHK+ks98HkT99T5TKMiMMlrUgdykejimZIK
 f22naBWWoEcoL43q4/1HNrLzamT/ZT674W4MGsrUdKT9eATHr0Zr+yb2k3xLFJ/mIeBk
 q87VfBbcc60/VD4Wz84tEF+SkjXfH8ir61c/tYYWGK1eF7Ldwi8ZNci8qQ5xyHZQ781z
 QwYITlSbziJUpCTlgGn1u3+97+i04myRBKw4rGESExm9RmsWx7ISXzg3oQwaxMO6ZC5b
 zUrY/JqliXQDDl8JZI1D6/AZkn4wCEwU9rSyN+4bhB7p8Qb+y6gcp441vO4WRop7Mwdk
 7qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O0Dlt8CM4EYpIMNatoTVPCeMUB3jUyU17bTKDOYgOb0=;
 b=HP6YfxOk30c1TLBdXH5FdmXqdeLemDZY+8uYBo5+aYagSLSpW5JyRM+enTPqbchj9G
 DKhwe/yziXbFGGSniq1JCL2Yiyuv3uB3Sky5oph6SsbHqng6Zb6iIslMfeLtISY/85e5
 xM8SrW6JDHZ8tTbBaVip+BXMggZ/ipzMgnAuxtpQzSJciIKc8WS+sKMIbZO7dL2mJU4F
 iFcbYES2EALrK80d2E7KWL/CUMkRWj+qG9fYMyp0PuN6wBcFAHz9QmvZ+uIKw6RDHINx
 g6BecAcFjGvnUOQMAIvCpXw/umE6H/X6EKlM2nE6hfjL5gwHk7m9BD37zCVqlXFxk7Y7
 FmNA==
X-Gm-Message-State: AOAM533wDrJA1NQFIxuM9r7NjVUDOG5IA8Hrv1aqzipGX5mYVO3a1K0K
 lOzF1qbSPx39qsU8gnKgOVX4n5t7+r+qaYGzlcy/Jg==
X-Google-Smtp-Source: ABdhPJzdgU6zGkGOS6vZAArv8gXHLmnrHDHocCR3w7wTrZXr9v0Wc09Tc3/fvFZyTYwYO9dj1UZJiRVJ0UcDwgSYtfg=
X-Received: by 2002:a05:6402:30b5:: with SMTP id
 df21mr5227790edb.146.1604620544312; 
 Thu, 05 Nov 2020 15:55:44 -0800 (PST)
MIME-Version: 1.0
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
 <160426438011.24886.10899498493892012350.stgit@gimli.home>
In-Reply-To: <160426438011.24886.10899498493892012350.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2020 23:55:32 +0000
Message-ID: <CAFEAcA_g2gurj2FcKqTbEK7QTMu8yDFc+SZQF1scVOAAQ1d4pA@mail.gmail.com>
Subject: Re: [PULL v3 04/32] vfio: Add migration region initialization and
 finalize function
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Cornelia Huck <cohuck@redhat.com>,
 Neo Jia <cjia@nvidia.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Nov 2020 at 21:02, Alex Williamson <alex.williamson@redhat.com> wrote:
>
> From: Kirti Wankhede <kwankhede@nvidia.com>
>
> Whether the VFIO device supports migration or not is decided based of
> migration region query. If migration region query is successful and migration
> region initialization is successful then migration is supported else
> migration is blocked.
>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Hi; Coverity points out (CID 1436126) that this code has a
use-after-free:


> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
> +{
> +    struct vfio_region_info *info = NULL;
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
> +                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
> +    if (ret) {
> +        goto add_blocker;
> +    }
> +
> +    ret = vfio_migration_init(vbasedev, info);
> +    if (ret) {
> +        goto add_blocker;
> +    }
> +
> +    g_free(info);
> +    trace_vfio_migration_probe(vbasedev->name, info->index);

We free info, and then access info->index. Switching the
order of the g_free() and the tracepoint seems the obvious fix.

thanks
-- PMM

