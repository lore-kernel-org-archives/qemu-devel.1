Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0067C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B7F2388B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXvoXDD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B7F2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJI8R-0001eT-Ff
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJI0M-0001po-TF
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:08:54 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:40567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJI0K-0000pj-Ph
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:08:54 -0400
Received: by mail-ej1-x632.google.com with SMTP id z22so8560486ejl.7
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A6F4AOaYsTVofnBTqobtwzR8N/+qT5lFC7eEzpsUKuQ=;
 b=rXvoXDD/PIyLxX4Gm6FjkU43G0EYNCXNQYV/6yl1vWPkEh3gI2MSf39eKxxmDa++Br
 dFAZbLi+2PvvDGWvqQn7FB7kINAyndbhSd5m0Vuv2EKVqiOuTfOMmLhTaRQLbazubnJe
 X4L9/7Mhi7pSmQDeq3kCpEwV0HzFlIgiFuyt37RLfr/fbWK4mSfEMXEkjCm0vpFx+ND7
 osIBc8aLehm8m8vE8PdFVtgQqexcc7fuB+e3pvqiugkdbeadejfQgbE2ttol4K1MstQD
 ueQj3n2jWW7eEBIC2fxMGi2HymCK7ctC6UuNBknsjh9FFoJZcX4hWRX4fe1qZY/cNyAJ
 tUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A6F4AOaYsTVofnBTqobtwzR8N/+qT5lFC7eEzpsUKuQ=;
 b=aftbKVYOJjBSi7lBzAPMithl7YixhEyVEDiIvtBdHbKAFjsGG1cBoiJgRnmx9oGSic
 HC+NH6TYTpYy1jpTI0GD+waUS2JsSinTFwz83VJhQNBBpaC+VULHGFrQFYX0TONVd2/P
 ZDq//mJdC37ef3qMaEcSEGNUVLF45wO75FU+B5JTLML/Q4/LToH/Cx7AJOWl01xQ9puu
 3pcUOriPEukGzS+ZcdUIHF1bltAJ8Hh5bTWxEwLy/wW8TzFaTsB+LnSq1TkcoKFfdy5Q
 bs+XdVmQqFi2SVOQnHlbJgA0j91WjwAlD6zmcBeFDNpTzuQIrASwPSZDfQDvumh2sCRl
 aCIA==
X-Gm-Message-State: AOAM532Qya5ythjiawruRb3Ik6X7Pmn5qgj4LSE45fyzMzomAAREXOXh
 iHHzJuh6EAblart6R6IqgKiLxyGbl6xQGbSPJMYaNOx9jOOgAA==
X-Google-Smtp-Source: ABdhPJwRyGo3hJZ1y6Ko2fhLjnhlL9tYXK1+L8/1/tiRm5ATrosKJFpUS/k2mCeL0z3A7LwV19oxR799NgmBtMgWh5g=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr35631836ejb.85.1600441730668; 
 Fri, 18 Sep 2020 08:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAFP0Ok82wY26BfVToT7K_0CCngr9N27UV3iaou_5QOE-Nmw1BQ@mail.gmail.com>
In-Reply-To: <CAFP0Ok82wY26BfVToT7K_0CCngr9N27UV3iaou_5QOE-Nmw1BQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Sep 2020 16:08:39 +0100
Message-ID: <CAFEAcA__4v60WjXsTzq3aXY8MReZ+Oreqs-zqUKTObefJQe2jw@mail.gmail.com>
Subject: Re: Heterogeneous/AMP example in mainline?
To: karthik poduval <karthik.poduval@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Fri, 18 Sep 2020 at 14:15, karthik poduval <karthik.poduval@gmail.com> wrote:
> Was sifting through the heterogeneous QEMU effort in archives here
> https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg06256.html
>
> Did this effort make it to the mainline ? Are there any examples of
> AMP SoC's in the mainline ?

In upstream we can handle having asymmetric configurations
as long as all the CPUs are the same basic architecture:
so you can have for instance an Arm Cortex-M and a Cortex-A
in the same board model (there's a xilinx board model
with a mix of cortex-a53 and cortex-r5 cores in the tree).
But we can't handle having multiple different architectures (eg
Arm and x86) in the same board at once. It would be nice to be
able to do that, but it would require a lot of untangling of
things which currently assume various parameters that are
guest-architecture-specific are compile-time fixed things.
So far nobody has been sufficiently interested in having
asymmetric configs to put in that work.

thanks
-- PMM

