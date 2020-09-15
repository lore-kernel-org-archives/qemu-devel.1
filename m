Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D402C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BB921655
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLTeNxa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BB921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDUi-0005L5-Og
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIDNv-0007a8-Oi
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:00:48 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:33320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIDNs-0008FJ-Ku
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:00:47 -0400
Received: by mail-ej1-x62a.google.com with SMTP id j11so5907529ejk.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gYwxvWJBaZA9mjreT1l8NeV3r6zHsiff5nIij3EJA30=;
 b=wLTeNxa4l/g2bRZ11cAsg/Go0kGOQZaKma1Okpk+nB/2pontrdh9qW2J42FCJHmM3S
 101Q0YvKAWkhyrOuKkWciCvVHHGsdgtTNa369OsohqSdsC6nSWDBgiSWOcLM1X0lK6BV
 vlmF6h7oMwRCl/mIlrQSMzLNZhmQdU9u13GDHjmHcl+6nrdJd5MaTIVx2cSCc6oTWjNS
 BT8t6ARbOA6kjUBVVCyRckRrMOlkmsWki7tmrkcwRUSaZ+McdOyR68RrcyiwuvRyRBV7
 RQLV0SyIt/go1bIRjIF6F/UksCI18Y3l1B+Zs8olbMzs2o5US+e08M/7JTKbnQdawi9X
 4VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gYwxvWJBaZA9mjreT1l8NeV3r6zHsiff5nIij3EJA30=;
 b=X23R9si3wUaMdoHaVxmKQ8/VoBzrqbOTPfGAgPWcyoxJbNF+qiUAz4frVwFSttwcly
 6A0jSmG+W2KjDkgytztWL6L6Gb8b/p6OJ8zPcCQF7vZ3pJTuoMoskDmxDrauqwZd2jdX
 8+l6E02F0rgPFT691yeSWntHApfWBTs+Xn+k7Nkz0QFZN+UU3WNKcy1eGlBCDEkyygc9
 P+uqVPMPgopjBhO6uiwz6HIF9fnZ3owMyTyYxEm7K2iBwvtcUidHu7QYAjWdveblCsz9
 fqnSzP1AeX5CG5IxkfQSst8MMpw7xnHNERbw7fDPsVXaa7t+hAt1fL8G3hYb+n7Y98S8
 agmg==
X-Gm-Message-State: AOAM532Uks7HiM0URjgbldbdhhDrFMPA22Z/hxeyfxxFCr657lyIOxPC
 NG4EHD3vFCc4ABWtAaQOdD0qHPA1MOVfzP33FtnIlw==
X-Google-Smtp-Source: ABdhPJyH5XnyxO6T0RNlwV9CmzZ9KEilW/TRT4G9MXg0W7Jh5N1qg6iGt4Z4acE+ES4XzBHME3sr/4UCWbof0hQffUo=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr21034123ejb.4.1600185626118; 
 Tue, 15 Sep 2020 09:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200915130908.12808-1-kraxel@redhat.com>
In-Reply-To: <20200915130908.12808-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2020 17:00:15 +0100
Message-ID: <CAFEAcA-zd=quN0mtifZFm5E+Bd=G=_VX=Us2CZ8jcEBiqp+oGA@mail.gmail.com>
Subject: Re: [PULL 0/6] Vga 20200915 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 at 14:21, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 2d2c73d0e3d504a61f868e46e6abd5643f38091b:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200914-1' into staging (2020-09-14 16:03:08 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200915-pull-request
>
> for you to fetch changes up to 7b0de5b7969e695d6235525654a8a28a0d82a0e0:
>
>   virtio-gpu: build modular (2020-09-15 14:11:49 +0200)
>
> ----------------------------------------------------------------
> vga: fix qxl modular build.
> vga: add support for virtio-gpu modular builds.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (6):
>   meson: fix qxl dependencies
>   meson: fix module config
>   meson: remove duplicate qxl sources
>   object_initialize: try module load
>   virtio-gpu: make virtio_gpu_ops static
>   virtio-gpu: build modular


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

