Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BEBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 15:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9119E23CD5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 15:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4YNqghe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9119E23CD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmf38-0006Kg-St
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 11:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmf2V-0005v7-V0
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 11:04:15 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmf2U-00007o-9E
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 11:04:15 -0400
Received: by mail-ot1-x342.google.com with SMTP id n5so9635520otj.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q3aPgUNgSVHPH2fw/7ZEYb9EqrY0Myt/Bj5i97rY46Y=;
 b=y4YNqghehyhsWzfoyi1FB3XQu1vEXv1vPStg+QoDEKTmUCP6t4cyCdQxtUDWVdirXu
 w3dOHONjly5/w2pgjgeaLz2+Vqd+MX94exLR8ExoxqhTVz2EtrVNJCocG572NGZQDNQv
 0wBPznvrVD40Ywb+zmkeZe/eoYMAoyVXYSQfrH7+C7/l9+E/AAB6WcaorO5X6OYNYvb+
 nEpzmilbi6Ai6zcBjcbVBoX+R2lwI/STB+qHMXvvbOu9UwyfOqcj4WOFnAvWiKG7tm8v
 iJ2xpC2UaO3WoHao93GN/cg7f/DBElBV+ZZSWZp2MhWBo+Ap4WEXDSk+6IkhW2KZDsC6
 oqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q3aPgUNgSVHPH2fw/7ZEYb9EqrY0Myt/Bj5i97rY46Y=;
 b=ZjPDOm1FaNEqUvr0Bm9NyStYgdpjhEX/Ln8lGaKkTyt7AEnP9fxkmnMSoyvsWkKWlb
 T5LbpVdbCVJVXG2W26kNIrd4grRoaMvPvUTlDKjA/8554rkLhGIUr23fOt7giNzL6zgt
 /FcuFUWuLoHtDZWP6e0XPDb2PuTyjgg4PxMJXI0v9hoSBy0E2OfDCzMd/2jIONDPoCvF
 LmvETxBGITdjm0gJg4zfe/NPXvvnm9Q8JleFkXXCLZOZwXNbOQvwyF04mrD6TgfaNCaF
 BaiKwMvQDaEoEZIqPojiKGY+pRXAcGq+oJed1HZMCX4ty9IPw50vhCbRGJMwF+AQr/GZ
 kwSA==
X-Gm-Message-State: AOAM5310g6DPVzVcmvAaY9nq8ge4l0zh0n2kRRMD+hilz4dCvtwZMWHB
 ecTXS8qxku6VAWdrDMAEv8DGlCRevZ/YlbrcOxCHQA==
X-Google-Smtp-Source: ABdhPJxzJCzX4AGS7eBJPC76IN0NEm+UPIDw6On01ImWnL26ocN+KYkW4HpjFeYwPNBjHpREsY8/r4d0dJ7NINXXTzc=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr7533251ote.135.1592665452973; 
 Sat, 20 Jun 2020 08:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
 <20200620133207.26849-3-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <20200620133207.26849-3-aleksandar.qemu.devel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 Jun 2020 16:04:01 +0100
Message-ID: <CAFEAcA9T1NGyi0g-DN+KGxpJwepWLfapDaWKVePhMEfeHvk5mA@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpatch: Change occurences of 'kernel' to 'qemu'
 in user messages
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 20 Jun 2020 at 14:33, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> It is odd that we inform user that, for example, his current working
> directory is not kernel root, when, in face, we mean qemu root.
>
> Replace that and few other similar odd user messages.
>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  scripts/checkpatch.pl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Regardless of my comments on the cover letter, for user facing
messages this makes sense, especially since it's only 3 lines.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

