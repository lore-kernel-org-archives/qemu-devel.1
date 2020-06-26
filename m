Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE931C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9896420768
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6jJtroT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9896420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jooPw-00038j-Tg
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jooPI-0002bN-3t
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:28:40 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jooPF-0005NN-N4
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:28:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id d4so8605029otk.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H2QHeSHD9C3n4Syy5xXTjoAoH2PcRolR/kv/jb7C4q8=;
 b=T6jJtroThTGfyQoRuN/FV73LPe3SVv7GUJ5B18yy1KaFKswDOiChXWliVXUDdlhR2N
 OBJcusyPML2j9g5xB2ge8szbaI7i3FCr0+TzxuStPNW1S2xy+gWDcyqTotyX8IwczRvj
 3r6Cg52h/bcayxtgznmHTqt+77ppriwerlVXp1q1XtrkmgoVx58f6wcQWqFGL9LFyCjz
 iTNwXPz1EffPtp71kJQBLq4f9/oQM2Yt5APljK7hacn8a51YYPJnzjwEVh78x2PEek02
 h4uLA1gOP5h7rl46BGL5aylYm6v3/rlXRLSXn2lu2UQ2Oc6rrE/VqblS6QhmGexGIpMm
 ZXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H2QHeSHD9C3n4Syy5xXTjoAoH2PcRolR/kv/jb7C4q8=;
 b=RiaqLKWhOfoIY/KhCEGZxDEHDH4SFPInfu0lx/JzrbgHrxbK0l3g4nSULYTY2u6PbX
 B65aRaTkbRijqoqHSmw20F7NZin74mLU35RArE3lSCTVxvPjNLEPHghzinlFu/HOSkBj
 aaUqf5pH4M2bO9Yl6BHWKsveZbkMpb2rzSbXmYXQl3zoOU/Iv+CD2RNOhUiWfWLXGUdY
 ZzdnqIqfa8mQzUqgX77f0v85gapBoM2jaM0niBXYORll2dOOqKgtwcVLHuyjydK9AAwQ
 3ZMFmHI3UzQzf4q9zDFFpm7ZnciXLAapSYQB77xWsiW7RAvrytLQLDgA8K3ZnPQbEvwr
 BeCg==
X-Gm-Message-State: AOAM533bNXW9l45AGfJ0r+NpGM2W3DQ8Xu1BoRBnn5KNKx6DmAQe2aut
 MZRT9xKjTo3nlVE1iGtsKSgpwp/Ld4LDvfyqMs3JfA==
X-Google-Smtp-Source: ABdhPJzsbgWTl4JrPvKISvtREW/MO8xZXqhmWQRc4Q3UU+fOdEJCsCy42h/0bkZXZB7qwZU0WLdE7mL0ghnLfK8x/x8=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr2251363otn.221.1593178116317; 
 Fri, 26 Jun 2020 06:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200626033144.790098-1-richard.henderson@linaro.org>
 <20200626033144.790098-47-richard.henderson@linaro.org>
In-Reply-To: <20200626033144.790098-47-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 14:28:25 +0100
Message-ID: <CAFEAcA92JB5oV02qjdq-T4B3czfXAQw6HORX2V+jUFn4AMFbsw@mail.gmail.com>
Subject: Re: [PATCH v9 46/46] target/arm: Add arm,armv8.5-memtag to dtb
To: Richard Henderson <richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Spickett <david.spickett@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 04:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The mte-v4 linux arm kernel development branch requires these tags.
> It is still an open question as to whether they will be required
> for the final commit.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v9: Split from patch creating the tag memory; sort to the end
>     since it's not yet certain that it's a requirement.

Not going to bother reviewing this one for now since I'm pretty
sure it's moot :-)

thanks
-- PMM

