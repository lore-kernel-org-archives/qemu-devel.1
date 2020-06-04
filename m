Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CF4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18632207D8
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhEJr4nH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18632207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgsPS-0003ug-Dg
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgsL2-00089a-Dm
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:03:28 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgsL0-00036E-B4
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:03:28 -0400
Received: by mail-oi1-x243.google.com with SMTP id m67so5528619oif.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ji4mwbA3IEGhjBH2ywLvoDTGP4V7LwGVjrK1NgCXW08=;
 b=AhEJr4nHV86Z3lFmRpurlsD+pb5F1oT58bAg83f0J1+y9b0EGo907K4Yb7KXh9ZI9S
 8OWJuIFu7KS8iPKKU9mxkc5hG4UnNK1dxu8aPBfjGvXcet3nibLDKwNWs1zMVXG4KMIa
 bA8axG3NCRUULY8M4TS0YW4eg4iSvkxco28OKOoT/GMr52R2Hr4x1+SMdbZm7LzuhyEW
 5I5kWAEpKfvC4josRObrrOe/P3AxxVQRUHSqbNAVNs/vR17efm5NfnPX3h+2FVDZq5ZQ
 Ro7dixBno216qi4TmvKLPruof5YdiNk761fojCMAQTrt7puYKFWaccO39ayGYlCWmbpD
 F30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ji4mwbA3IEGhjBH2ywLvoDTGP4V7LwGVjrK1NgCXW08=;
 b=tNPZCaZCx+YwbVPGLIMPzv9PLy/k6ofTFXltXggia1jFRAcs7RUL00p8hekcQx6vhf
 ggPxy8m1C2uttNYE8DxkFNLpdKFYfB6f5h6fh3ets2qUMxccIssruWF2DwhnTCbl8H4w
 yFQBUZXNLiaTy4YDqOzyEy3CQybFPPh1HpgtRMQG9VTVwPb6t1VFU7o7refEy688dnzk
 unIRw6bv59sAkj5+3FQ7Mo0ck9CTHO+J4W2Ulwh+A62n2/dNYaM9nQYJVcRvI0TEuete
 ucYmk4FclGmDTDi16SzsJWlQlMcz9c8w+ix5TpuK2TMmGlE9gXeh1JhUmE8PStH4LCD1
 +GQg==
X-Gm-Message-State: AOAM5338VYYyfxhA1NgNnHeIqPv9bx8u+TDv1fi+dqjpEF3Aa9p4Q7Pr
 yn52KSL9Wnl2mbFrLVIqzz8moXjY2WffPLW2YzHGK3ee3oA=
X-Google-Smtp-Source: ABdhPJxmSUk4FvgSll3KJNFgMXL3u6ya37QbPOw5g9lyTRlSzp81AeeObObABNncXwatKAifwS3e03QWqaGB2yjVOLU=
X-Received: by 2002:a54:469a:: with SMTP id k26mr3596933oic.163.1591286604828; 
 Thu, 04 Jun 2020 09:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200525155826.11333-1-philmd@redhat.com>
 <CAFEAcA8UGjx5S+zVHX_Oon-ELaCRuLpXEDrjs0VoAwqJ7uPn3g@mail.gmail.com>
 <5dbecc86-f9df-249d-7439-36c358dc5aba@redhat.com>
 <CAFEAcA9qVBdLZMO4e+oSaL6kwpF9WS+RdeL3DxBNKVMPwnQ=TQ@mail.gmail.com>
 <918fedda-6966-9d67-b58e-a005cd28a2d1@redhat.com>
In-Reply-To: <918fedda-6966-9d67-b58e-a005cd28a2d1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 17:03:13 +0100
Message-ID: <CAFEAcA_CyMf8=Z3sKZinMWJzXNuvqTxQydb-U4xiy+sCXvFOuQ@mail.gmail.com>
Subject: Re: [PATCH] hw/block/pflash_cfi01: Limit maximum flash size to 256 MiB
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>,
 Tanmay Jagdale <tanmay.jagdale@linaro.org>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Radoslaw Biernacki <radoslaw.biernacki@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Leif Lindholm <leif@nuviainc.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 at 16:55, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 6/4/20 5:30 PM, Peter Maydell wrote:
> > Not really; I think we should know what we're limiting against.
> > Currently you're checking total_len, but this is just sector_len * nb_b=
locs,
> > so if there's a problem with silly large values then it's probably
> > actually a problem with one of those being over-sized which would
> > still show up even if the total_len was less than 256MB.
> > (I suspect the underlying limit here is what the cfi_table entries
> > 0x2D..0x30 impose on blocks_per_device and sector_len_per_device.)
>
> What I'm working on is a whitelist of the few models our machines really
> use, but it is taking time. Meanwhile I wanted to at least limit the
> total size.

I don't see what we would be whitelisting, though. The only way
to create a flash device is from hand-written C code in the board
model. If a new board model does something weird we can catch that
in code review. Sanity checks on whether the properties supplied
by the board code make sense might be useful; randomly saying
"you can't have a flash device unless it's one we've seen before"
makes less sense to me, because it just means we'll end up adding
to the whitelist every time.

thanks
-- PMM

