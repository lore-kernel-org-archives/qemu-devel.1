Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0287DC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2A620720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KN9/8d/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2A620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5HI-00037f-O8
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5Fd-0001hI-R1
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:01:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5Fb-0006Mz-Ma
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:01:33 -0400
Received: by mail-oi1-x241.google.com with SMTP id j16so14564980oih.10
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/DiWneqlXuxXo6nMkYvuc7Yj2MM/2MTUcrxrR8pBB+U=;
 b=KN9/8d/J3FFYkjNlfmRPSD0fWeyNlY6gDsep9prJrlyH4yXOLe0yyyEtV5T9Tav2+G
 xPYlMO4g6h6cykBc/e+GFgYJeHVD/oZ9ElXs7PltnGOZWADg+TRxG5fSDE4xAMROd7s4
 v3bcAycE5FHXTifpCdJpqhOGyuDnhs5/g2R3DAzT6KpUa0/XC4UsPdpKO6FvPt8um1Ij
 O21hBAU8yf5SI/1YEBTIHGnJP0faMR11YkStpOPqSimIqq0xuXJxv2FjVUYwAe22ggwm
 Uh/bleQM8u2r1itcv5jrTsvck5jtuFJalfhG7SlcUbbAKYgDQ3DxQYHSVOOvUwhq2kkx
 7VPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/DiWneqlXuxXo6nMkYvuc7Yj2MM/2MTUcrxrR8pBB+U=;
 b=We3G1MLL9OeKDyBfhQtJPCRwxSu7iC8TLlqFDZCPBtJ+b19cjRZKh0xqG1J4b720nq
 ZUiz/P2UY8avhYyoBuiX7CIsiZU1Z7ztSLcvlWbbLJXog8br1z31xxTEqeY83jrENMEj
 pw9j+xUo5UWMwyjm8A1hrO9t0nMA1+3RQJ1IT9A2RAlQjaq296WREgiX42GHpwIfEZCw
 Tdq7BfvDPigN7oyt38L6ZU5qhsMU/Nk5FN7F5oLFO3dMRLugLFN59peQEFY6JofyqY/s
 vVWGN7DS2Dg7YGPpcONB7flqEVzziFWPxkQNt4rRqbKTFZQZVYxx30f76kKbBHUMqjE2
 6Psg==
X-Gm-Message-State: AGi0PuYXjO5QrFTr6BCkuIQ1I5Dv4TtQzIwuLk3hq+G5tWSEz292eEG3
 turLUAeMFyH/92bR4PKtwDaoea6tC6InTZxNktnWSA==
X-Google-Smtp-Source: APiQypK6wiuFfYiPMl8GoJZ/2r1PHkKZZVeaWj5bEhncMOgUCgfM+EMHGZYpf+l9orLlMVlPE9QbcQCzBN2G4aH1tKM=
X-Received: by 2002:a54:400c:: with SMTP id x12mr18388321oie.146.1589191289386; 
 Mon, 11 May 2020 03:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200504093703.261135-1-joel@jms.id.au>
In-Reply-To: <20200504093703.261135-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 11:01:18 +0100
Message-ID: <CAFEAcA9kGXBqdaig3g77JMLZ+pQ4WwZvpKVY-bbzKCXGch4O5A@mail.gmail.com>
Subject: Re: [PATCH] aspeed: Support AST2600A1 silicon revision
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 10:37, Joel Stanley <joel@jms.id.au> wrote:
>
> There are minimal differences from Qemu's point of view between the A0
> and A1 silicon revisions.
>
> As the A1 exercises different code paths in u-boot it is desirable to
> emulate that instead.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>



Applied to target-arm.next, thanks.

-- PMM

