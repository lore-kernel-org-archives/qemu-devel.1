Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587EBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CC822CBB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeX8J55+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CC822CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHZk-0000Ia-DV
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBHYs-0007Vx-0V
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:03:26 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:46803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBHYq-0001Uc-38
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:03:25 -0400
Received: by mail-ej1-x644.google.com with SMTP id d11so7471943ejt.13
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2nkNBtrpucYVQes4Y0fhh4VWSin2uT6R7jqyVo0LoO0=;
 b=UeX8J55+DWMItHrkW9m/5XXsVAMzRGOeAKRGxc6CyHS/Fx9vgJs5hQaS2mx+QR+Ys+
 yGFANnybN7e6X28H7f7+TLf6f5ionkNeRKNyN+xSp0FBc7fsOVSiAO/5Gl+oKFEdkW96
 NS0PrXkTAd3a+ce4yrdX+wGANfHJwgCkCYSUbxz2J8KyJYdWnBv2xJWC6/CGq5bDPHdf
 8imJFeJ3Qp2vvlVBdyAt/3n3mtjGlcvPHyMEXVWnsVOGkuYNDK16I5LUCeO4Omhs/UwC
 W6VSWAmy8EmTdLv813dGwNQoDXaFU5mJTjG2A5nWBnNhaVCobnVJ/ZSEvUnzzMmneZZp
 bvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2nkNBtrpucYVQes4Y0fhh4VWSin2uT6R7jqyVo0LoO0=;
 b=K/cOABVrAdxXz/fVU4zIcINK7SqrepsPhrWGLAgSpTFkSbM7CBDOeUdn6Gdum42zzw
 g+C08ISi2WCkkp8SBYggqvIW3crJI5mAGgCNEkn0lPnZZop8KibcAuGh9Kn6dLtuz1fQ
 GOy9w7SidqDaLU7XklxlkgUny6+y8mJuusWhdtRHtjHNGB+EVUMGZWbXZDvmomfmShSJ
 KVdwXt71p99XarKY09r+miztJ8+wJr77NAdCHMPEYlEDjadmyhVyFODjPNv9Vl330j4y
 KG9q7OySUiVpV81qnz9szvzzGod37jJvQAcAn/4L17yfbrHYG92KjpjC7Rw409tnR6Cn
 xREQ==
X-Gm-Message-State: AOAM530yakevW17ptkWSff2ykNhH9n1mZFgAS+VdmW8kyaKpKljbibbw
 zQUyyu2R42KqVX+hN1ZzHb0rh1iNiY+nWqFteEoz3Q==
X-Google-Smtp-Source: ABdhPJx0x/hr0eepOZsbG+2H07E0iwsgBJcvEbTGDHuv4Q9FamjYEzvUE1k/lV6GwujNzN8i3LT2nY1LIXd2V1DcUr8=
X-Received: by 2002:a17:907:728e:: with SMTP id
 dt14mr8265175ejc.4.1598533402211; 
 Thu, 27 Aug 2020 06:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200727045925.29375-1-tianjia.zhang@linux.alibaba.com>
 <20200727054335-mutt-send-email-mst@kernel.org>
 <cb08fa85-e7d3-09af-d702-036fd165a46d@linux.alibaba.com>
In-Reply-To: <cb08fa85-e7d3-09af-d702-036fd165a46d@linux.alibaba.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 14:03:11 +0100
Message-ID: <CAFEAcA8iK-J3NKA=QxFV5uswBSXLNNQDbx1NnFzhz3ppWVEVkQ@mail.gmail.com>
Subject: Re: [PATCH] qemu-options.hx: Fix typo for netdev documentation
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 14:00, Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
> Other opinions needed?

No, the patch just got lost by accident; sorry.

Jason, could you take this via your net tree, please?

thanks
-- PMM

>
> On 7/27/20 5:44 PM, Michael S. Tsirkin wrote:
> > On Mon, Jul 27, 2020 at 12:59:25PM +0800, Tianjia Zhang wrote:
> >> This patch fixes the netdev document description typo in qemu-option.hx.
> >>
> >> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Trivial tree? Jason's ?
> >
> >> ---
> >>   qemu-options.hx | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/qemu-options.hx b/qemu-options.hx
> >> index 708583b4ce..92556ed96d 100644
> >> --- a/qemu-options.hx
> >> +++ b/qemu-options.hx
> >> @@ -2684,7 +2684,7 @@ SRST
> >>       disable script execution.
> >>
> >>       If running QEMU as an unprivileged user, use the network helper
> >> -    helper to configure the TAP interface and attach it to the bridge.
> >> +    to configure the TAP interface and attach it to the bridge.
> >>       The default network helper executable is
> >>       ``/path/to/qemu-bridge-helper`` and the default bridge device is
> >>       ``br0``.
> >> --
> >> 2.17.1

