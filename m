Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEFAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C96A2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCrTOJub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C96A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtGl-0006gE-Ev
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAtFo-0005Ql-A4; Wed, 26 Aug 2020 07:06:08 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:38245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAtDy-00035y-KS; Wed, 26 Aug 2020 07:06:07 -0400
Received: by mail-oo1-xc41.google.com with SMTP id z11so347163oon.5;
 Wed, 26 Aug 2020 04:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fgSZbO7M5TnMgI+6Y7mF/x3aurPUq0c8aQSVxmuMyQw=;
 b=jCrTOJublfGs2Lm6BT0NPoocEPhGnVrjbjGTK5/LOEqVlgnQhwGnAv4KrOGriGp54w
 mGn7dvzVHAUZtXr4gouEHyNhVZU5SDCdBNfIJVqtP+nTJS1Q3UcUhjYO70s5nYq1N6Lv
 8xGSGpdvWzsM4ZIWOYFyrOUqNiB0VCSzPAX1sFWfUtfOPPvcxGnKi2rhKWKmkn/byQHw
 JmGdBgrwCbSvK707nj77vBpOQ7UErOTmA1YBVVZwQBL2wkXcbG8bjkDRtC2zEuN3wEeW
 ocF4qNMxVBR5qv2kVRI2MaeJqrhbBQkk4TsLT2dJyO1vHZd3/TnA5wVGycfMnVOY+usV
 C9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fgSZbO7M5TnMgI+6Y7mF/x3aurPUq0c8aQSVxmuMyQw=;
 b=sMIKEKJR0G2L15KT8+DTImN7FtQBR7YgWs74hvfFK1YDoaE1zgXZafi2c3dga9qE6D
 6PKwLbixxMl7KkYSRF7EkqaVwHLwjPRIv15DCAJQErGPaUn8SfU535c0qjC0polR8eE3
 I4OnvX4iKi3ywgQcw0Nsesk6bdoifP1Rmy5Ckg0XQO5/qSK75N7XeK6IYTY7tKK0R499
 6HKueX1m+AgbN5J5msLSuT0qOHWq4shhcLhMHkfPp7vJhHT5XjsF4qLS6A/1uWTo5IKd
 D/5yMOUdWf9YjrEXXKzuX72F6h2kPFDuvT8q0LcMK+zClJ80/9rx5TeNzTHXp4+bDwf+
 7jYg==
X-Gm-Message-State: AOAM532aLixNjiuD3E4Vh0UmDPK/b+ARARw/Pi4lFplorZBh5yxqyDSe
 M4TnFPmgWPw/OwU7+qSMjNHFfW7dSSCrR1r/0iE=
X-Google-Smtp-Source: ABdhPJzt3GPwy88oK2cLOEI2uScIoMZryU0aW2Zx6BwyvUpZyWSnYqoPXWhKQLGkgXA2/PJuN6xYjthZ0551MFLs1ls=
X-Received: by 2002:a4a:4201:: with SMTP id h1mr10171742ooj.1.1598439852987;
 Wed, 26 Aug 2020 04:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-3-pannengyuan@huawei.com>
In-Reply-To: <20200814160241.7915-3-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 19:03:37 +0800
Message-ID: <CAKXe6S+MV3fyCoyDbDV01CbuGoR8JO3e1=VAh4OFP5bKUVMXkA@mail.gmail.com>
Subject: Re: [PATCH 02/12] hw/vfio/ap: Plug memleak in vfio_ap_get_group()
To: Pan Nengyuan <pannengyuan@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Missing g_error_free() in vfio_ap_get_group() error path. Fix that.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

I see Cornelia Huck has merged this in his tree.
Don't know whether this series will go separate maintainer's tree or
as go only one maintainer's tree(maybe Paolo's misc tree?).


Thanks,
Li Qiang

> ---
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Pierre Morel <pmorel@linux.ibm.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: qemu-s390x@nongnu.org
> ---
>  hw/vfio/ap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index b9330a8e6f..cec6fe1599 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -71,6 +71,7 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapde=
v, Error **errp)
>      if (!group_path) {
>          error_setg(errp, "%s: no iommu_group found for %s: %s",
>                     VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev, gerror->m=
essage);
> +        g_error_free(gerror);
>          return NULL;
>      }
>
> --
> 2.18.2
>
>

