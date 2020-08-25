Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97792C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7E220715
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vze62H1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7E220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAX2l-0001zV-Kc
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 07:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAWwc-0007AC-1V
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:16:50 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:34444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAWwY-00055u-Ei
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:16:49 -0400
Received: by mail-ej1-x641.google.com with SMTP id d26so5914783ejr.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 04:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sUIMXYwJP2HULavNS93h8h6YzD62khk5hmGWbRWUEg4=;
 b=vze62H1Gbf5a6XU/gi6r1HB+0KIcUHvyxwC4mEDzCWSw5rI/bKwEWvcxePc9j7euae
 xFc2qziuCVERHR+Bu0ZBzYbaV9JV+vD8KoN68UbSNktSGuABldi7lEk2sQJXk08RH2PD
 cq3XqPt6s1QRaNqooJbb6oRi1vtuvM7gqO6qrPw6ihT/TB99hKXw0JnMWzQUM5QW9bjt
 E4E284XS6fyCIE2PsV1Hgh33npwY1fPut2byx++Y5cQboScjfpGex37ZG/qeM8IS56mh
 t0X6wEM4ZNuBrOYwNIlPenv/DoqkXixwW5UE11g5l9CwwdTwljSJUM8b78K+kCKzVs8E
 lgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sUIMXYwJP2HULavNS93h8h6YzD62khk5hmGWbRWUEg4=;
 b=ZqdYXxtaSxFSHzHnu3cAE3wFaFgYAhz1WLmj6iLvWvLrrvcOZ8mn//rbR344tybgZg
 Fw2KxdfQRV+LmbGTJ44uFx4RfpgMQ6Ll09eoQjST6rYk+8fBPePL0CPV4mRZSV/yE2Pp
 tVEWnnkfBbn66g7JzhC/SKOmjv5ns1dBwHKRJKa3qh2Et8ZdxCiYQzv50n+pasOuWf0t
 xEAqUNmdMtP3stFjfTyc2XlBnQOGtmYiLzcbQyexGWwZybZ3qBtDO9x2jl2ULj+UM/AD
 Ashd0zMbN7ikegkp2tpkHgAgasmYsVmhBnsJ3InAN1bPWQ+7p6ZZ91L88QLPaEoDTN0i
 t8Xw==
X-Gm-Message-State: AOAM5338nn9Jb+Dp88raRf1uhhEoquEPSRaeftotCGZJAx3xu+KksWEe
 UoTPKmiEji/0YNORWS9x2JzjKqjaErQwtM3Z3ljaBQ==
X-Google-Smtp-Source: ABdhPJzh+2ASQZAnZMkkTuUtw+I88ItNTT7zAMwxHG425vkb3aB2cKk25ubBYruyENvkStS8EBnQv2f+Knop2mrE2hs=
X-Received: by 2002:a17:907:2066:: with SMTP id
 qp6mr922687ejb.85.1598354204260; 
 Tue, 25 Aug 2020 04:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-10-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 12:16:33 +0100
Message-ID: <CAFEAcA9-zL_bBFHJdhP8QednVDe1_5H8CzQU1=LZB+dWdrH_Fg@mail.gmail.com>
Subject: Re: [PATCH 09/20] target/arm: Merge helper_sve_clr_* and
 helper_sve_movz_*
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Aug 2020 at 02:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The existing clr functions have only one vector argument, and so
> can only clear in place.  The existing movz functions have two
> vector arguments, and so can clear while moving.  Merge them, with
> a flag that controls the sense of active vs inactive elements
> being cleared.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

