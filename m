Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570CDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E3E2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUxznxSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E3E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlsXb-0007VC-6s
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsW5-0006dM-P1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:15:33 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:45400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsW4-0006zp-2G
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:15:33 -0400
Received: by mail-ot1-x330.google.com with SMTP id m2so4181668otr.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lfy+bP/6vJ3x/eThUcFMoD17ZCsLCF7U1giHYoTwtA4=;
 b=sUxznxSmchgqY2f5sYqi6xE3YfX14kI/Ag2KwH8ycZkmBoba3F+gzNOyDL+AkZm30b
 V8WrWBPR4W/AGEaGYd7o1M6CPMRS2iJi3GtlWVZdXcIl0DWvyY1w/qkhWIesrNYeva5x
 gmWhJY8Ho6jcQzf1jUHNhipod6sf0QKr/cPxpRxIVL1opWWcd8a+0+cx4Ny4zvpqUnfa
 iTt/HYuR4puUSdP0McH5kvLUdq3Fl50h18gSkxhUDa8jfYEnYaXVLeGdsJGXAHu1e7WX
 TkFo/sKLgUAf5ZMPUq79VtLepytd05CLpn7dWwwvmdNT9Zax52uL2iwrKlK8K+SgLUc2
 f/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lfy+bP/6vJ3x/eThUcFMoD17ZCsLCF7U1giHYoTwtA4=;
 b=rS2PqwN6NCPplmoCaJWwtuFQLkanAWGBrJvosyPV0QwEljldfWk7EwjTl8bokT8CC8
 y89QoNq8T1B32HapZTx3iKE295Bp03pWN85/seP5yApHAPKL7UfJextIQRDnXeuqsRKQ
 o5NjsAGhylHGfMTZJdz6cr84kp90yVlunbGThPs7chRA29oZysGbQICDjSp6eShFNGBO
 yghkS/vN/NY+kiethUle33nQXJtn9yL+ll7TTxTxrE2FmiZJZJlioBPX6J8NJe5JU27e
 vV9i9wv/sXaeZoVqazcmcRoW8yQtus1xQnH8sJLh33xf1BHBr8+1YihrDjUQ37u4Amho
 W1Sg==
X-Gm-Message-State: AOAM530qrVoPtiZlgEjQDc2twCUCWq45q83KvIJTbpyg1NtuXfw7DlOP
 KcbjRl661qBcqx1kGfSnZ3ueWqa+c/wvsbbxWJ3yag==
X-Google-Smtp-Source: ABdhPJy48JqtekoXt/q251dx9kp7Qx2YkwKld0xXxO1OsCMccwd06f7lZhP3D9H98GxoL52m/6CA5MxkhAk5hJKdiyk=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr2919781oto.91.1592478930363; 
 Thu, 18 Jun 2020 04:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200617122901.13327-1-kraxel@redhat.com>
In-Reply-To: <20200617122901.13327-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 12:15:19 +0100
Message-ID: <CAFEAcA8KhmoSsXBPOJAu6upNiQc5H26OeP=Hm1fNtS5c-We5=Q@mail.gmail.com>
Subject: Re: [PULL 0/4] Microvm 20200617 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 at 13:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 5c24bce3056ff209a1ecc50ff4b7e65b85ad8e74:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-plugin-160620-2' into staging (2020-06-16 14:57:15 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/microvm-20200617-pull-request
>
> for you to fetch changes up to c8b473594b8fbba169a6ea950493a3015d15a18d:
>
>   microvm: move virtio base to 0xfeb00000 (2020-06-17 14:24:28 +0200)
>
> ----------------------------------------------------------------
> microvm: memory config tweaks
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

