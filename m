Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D12BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A9020706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLzmiXO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A9020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kABcv-00013L-E6
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 08:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kABbo-0000KK-Bw
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:29:56 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:42258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kABbm-0001mj-2d
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:29:56 -0400
Received: by mail-ej1-x641.google.com with SMTP id j25so2467487ejk.9
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 05:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BM1LYZDoCM12HJ4LW4k76cjBfkOwdrUd/38fFmKjOf0=;
 b=MLzmiXO3aLO5KpNX35PQNfIfy69hz21gfjPWhY6CIcCOLuIRW4wtwMOnCyCfZCF8rt
 5mbmsqKBCzCsVvuqDHxGbcdxVQOH3LIP6cKGSs3QRhUG6pPCYU8fEyGtWNA1X+J2BD5A
 Ou3akA1dEV+FbxazuHjsVkjRUNfUhR3WzdVw8RW8arqhABimkUUpCzWq03kdTsFAf9N+
 LViPUuioD61c/4ltJ1zemjV7dQ7Xi/dUmw7oY+Wb/hufnyQ/fSsOA10UMg3P84wtnspA
 fd4ukjvseNs8iyM96GFhTmR2gzBW0jOqTXkAmwRKMl+/8NsgqTwSfMda5nIBzdBWpBRZ
 Xx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BM1LYZDoCM12HJ4LW4k76cjBfkOwdrUd/38fFmKjOf0=;
 b=FvNNVbKovxSKir/u4TGFozG2fbPb/3pX/oymU79ZFRqbLE64KRJmUpdy7aeGdG5wPl
 Czyr/twN1zgxlLmJ41HZuxhyq1+OetNxNdupb983pDKaOdP/RZh+hfVIBBhRYkl6pXod
 ZNbmhPWwOaXvE0yi6Q7A6q0hIgblGkfC6MLv1dtXM/fMjyKFIwnoB9yuuIiyBO5gT5Ng
 q2wx/utRthF6PXnoG2+/KaNDdaSGDBcdDFV4mUx2GNQnxiDKJw2taD/wBiz3W2CtgrYf
 ANuAn2x3NEZ2tkiJtpooGMiSPcyOSTzq3KUecNbxLFj0rMatrvo27H0BRDPqgOaha6nF
 8eVg==
X-Gm-Message-State: AOAM532Q4TZ/uvo1VqkT6xssnxxNBLqOAzAchc8Wl2JFBITMHvj0IVfG
 KGIOkQ1S36AAWiVhcEOCHoXRW30YDdzSK4DkDQxSZapMjkBSjQ==
X-Google-Smtp-Source: ABdhPJxbjf35YoIdlSGeh29MCqaVFFjjZ2u2bxZSPvKyT39StJrDKEzWJOQEkDajvmpgDEIEf0fF2azFOhTp33pZqSs=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr5159219ejb.407.1598272192670; 
 Mon, 24 Aug 2020 05:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200812101500.2066-1-zhaolichang@huawei.com>
 <20200812101500.2066-9-zhaolichang@huawei.com>
In-Reply-To: <20200812101500.2066-9-zhaolichang@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 13:29:41 +0100
Message-ID: <CAFEAcA9EAnbCtovwxARkz=E=Ob-KQ1HvrmwzoxrdDTNcsEw3pQ@mail.gmail.com>
Subject: Re: [PATCH RFC 08/10] disas/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Aug 2020 at 14:43, zhaolichang <zhaolichang@huawei.com> wrote:
>
> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the disas folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> ---
>  disas/hppa.c                              | 2 +-
>  disas/libvixl/vixl/a64/constants-a64.h    | 2 +-
>  disas/libvixl/vixl/a64/decoder-a64.h      | 2 +-
>  disas/libvixl/vixl/a64/instructions-a64.h | 2 +-
>  disas/libvixl/vixl/globals.h              | 2 +-

libvixl is third-party code, so it's not worth making local changes
to it just for fixing spelling issues (it just makes it trickier
to update to a newer version of the upstream code in future).

thanks
-- PMM

