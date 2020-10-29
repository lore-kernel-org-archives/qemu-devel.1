Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DEBC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3102076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yB2J31kR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3102076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8j5-00072X-It
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY8iF-0006Xv-64
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:15:35 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:43251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY8iD-0004cj-B5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:15:34 -0400
Received: by mail-ed1-x532.google.com with SMTP id dn5so3158002edb.10
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=De2cWuk8PqE/bkDjGw3MHxT1XsENrHHqN7QpOclEUPM=;
 b=yB2J31kRdmRtuvgkubZooU+4YU3dWbi+n3vqC89PSzd6NISnFkrLmefn5up6BZxXfi
 cHoKfthpegOjmVwhv7ALktZHtBbMp8tQ6I6RPVwkwASOgL+qJS/Xsawg3kv6OmJh3024
 dBLrlfoiUGCtKylXx4JxTRMPXUJuNvVj3C5fTUUvH29Cy7dz+BaEDkRzR5teOoWp4JuZ
 Qur6faVhqGUg4NW53foBjwdj5s/gdpTB7gjAEB+/WYzvno7pbOYiUcOVZouMGdp0L73e
 AblxXouCjQjZkO1AoPXiGFiG4A+rJZqWWrBkkPi3OtiMTiDoWXSDaiTWilhh/rC0CyNx
 NXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=De2cWuk8PqE/bkDjGw3MHxT1XsENrHHqN7QpOclEUPM=;
 b=iNxXuLqSAVRQ67Dk2GMzZFvv+dK+kxaX6dATswKaaYJtF7DklxmzXjqMidxeUeA0CX
 3NnUjp7tkTaktL3hdLtCQ3Y4a50t33mwj6fvN4Fqy0Bk9blpx1R8LY2eyLTkM6quKtIC
 oIs7Syr4EwLsmVO2bPMoRNT3cFwwFmC62zK2OeE0HSihxhN6Gr+tgvUJd/lpnIhy7184
 iWdrKpYsZqlcHjDcYPvkqPud7NgZYngT4IpHj7ITcTlJPHP7DXfSNSCU+UZkyeCGq2bJ
 zb+AyPY3jZCfFbBR/I4SDJv1LYJzZtiLRYEfdBxkSnv9Ps8FcpUWDVusqss0+V8dzZoR
 /bIA==
X-Gm-Message-State: AOAM530tFVltTKVtoy3TdZF/y6X2AJiAKZ/x54k1r2Hg/i+mcaNQg3vO
 cgMjBtADd4ZKMAYau1PpdJEq1HdkhURfxhQa1lpSoQ==
X-Google-Smtp-Source: ABdhPJzQxYthCh5GuwVqQn0ART+C9BNNkpBMRY9r7jH+FbvSrJVCuXRBmR6eWrfSzKal8wiPaG502rSk8CiApgQqLLA=
X-Received: by 2002:a05:6402:b35:: with SMTP id
 bo21mr4389713edb.52.1603980931001; 
 Thu, 29 Oct 2020 07:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <3097828.JvSkC2jeLF@silver>
 <CAFEAcA-q0AVF-GMu1VLKPKmPAURV9j+YoC3g-C15F2Jy5nTUVQ@mail.gmail.com>
 <5649161.sut93UlCx4@silver>
In-Reply-To: <5649161.sut93UlCx4@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 14:15:19 +0000
Message-ID: <CAFEAcA-+4Ac7tGyXxDjkPrsJw7NmH3bijkuXLY9gF=Vr7p1LWQ@mail.gmail.com>
Subject: Re: [PULL 00/13] 9p queue 2020-10-23
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 14:06, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
> Ok, I'll use mkdtemp() instead, that avoids other potential parallel config
> colissions that I may not have considered yet.
>
> The original motivation against mkdtemp() was that /tmp is isually a ramfs,
> hence very limited regarding large file tests. But that's not an issue right
> now.

How large is "large" here ?

thanks
-- PMM

