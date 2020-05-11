Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8D1C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F307E20736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHlKFmmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F307E20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8Uo-0007Bn-20
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8UB-0006kJ-5P
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:28:47 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8U9-0005HY-1F
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:28:46 -0400
Received: by mail-oi1-x242.google.com with SMTP id o7so15071769oif.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vpS04Vql6d5YH1082nRPfE6zc+hD4KP+xOMzBgfv5ok=;
 b=MHlKFmmF7p5njKwRzZ/so5gaMhuC0HGeaamqFLeqIOnp3GUj6P8M1s8L0xHCE/qJkQ
 NxgkAcb5QNilJ2PywgFRU8ix33bZqPdG42kzlYZMko/Q7F0ogc/mX8sowM/TQX0xFj5A
 Ben+UDD2bIRVf7o3yx/fxn7Xeih/Hc8qzynKNl5kf4/mKkZe4or/Ag/qhUT7Wk7kzBFG
 idRLG85sdv8Pnk5y6LKRKguBLnXZdIiZqi/fNX2Upc/e/v1yXk8EilKhtK1ADp9iJBum
 yB+ZUH22grDeja84Z/NArJr+RxK8rQLCerN4/iemAWFspc1WbZF+cnNw9O5JjqRhmJhZ
 clbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vpS04Vql6d5YH1082nRPfE6zc+hD4KP+xOMzBgfv5ok=;
 b=ncOxmwuKdkZ8fuzSExoayABzdd764wP0dyCw6VKkGUJsvpTpEjo4wVDC41jHud8qsM
 UD2cDGy/A9/q1u+e2YECz29HqKoWjF7FZmgAtUsc1iUh5PVSi3/0H8CjzYlsYbjNWHFV
 yilBSlz1t8NDuG73BM7qNJCShnW9tmg+dPGWS5wG1yyDtgn69h9zT/udxx9F7uoD0YXg
 OgJ93wJQhsjWLEKqyEXU0mHI2sBe/A1GWkutwY57wxa3S6X7JkCtOO/QPkyZYEqYM/A4
 YlrEaWPe2J/nEde0yVT3r9CaYUqwQgotSEaaPbaWNbj/33oFpxFEK6znluh8ikgHKCfi
 Q6Hw==
X-Gm-Message-State: AGi0PuZ6a/ejkQ2wqPr703QIuYWX4Dt5+ZrseL5TpzQBbkv+z6AdqYKD
 DfNrpgN3OA7bw6XQVhmwotm2uliimWlr0+rSR6JDow==
X-Google-Smtp-Source: APiQypJHZIBLvimaLk0xn/SZOvYQSCKJWxFozCQJQwVpXfXrE5Lda1ncRsV8ufbDjxWoXHfOdJC8RH3ZraY3G1ozpwU=
X-Received: by 2002:aca:895:: with SMTP id 143mr19670945oii.163.1589203723322; 
 Mon, 11 May 2020 06:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200507172352.15418-1-richard.henderson@linaro.org>
 <CAFEAcA8_=zP25c+EDGT_3Uenw9zqoa6_9AnWFZ3XFgvRqLGRPQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8_=zP25c+EDGT_3Uenw9zqoa6_9AnWFZ3XFgvRqLGRPQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 14:28:32 +0100
Message-ID: <CAFEAcA90Tc6wY+fg00SoOTRT_co=R+H7jCDFmmHz_Lh-A1_1vA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] target/arm: Misc cleanups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 at 12:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 7 May 2020 at 18:23, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Version 2 adds a fix to a just merged patch.
> >
> >
> > r~
> >
> >
> > Richard Henderson (4):
> >   target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA
> >   target/arm: Use tcg_gen_gvec_mov for clear_vec_high
> >   target/arm: Use clear_vec_high more effectively
> >   target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed)

> Applied to target-arm.next, thanks.

The 'use clear_vec_high more effectively' patch seems
to cause the 'check-acceptance' test
tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg
to time out. It looks like that happens with or without
the other clear_vec_high patch, but since they're kind
of related I've dropped both from target-arm.next (but
am keeping patches 1 and 4).

thanks
-- PMM

